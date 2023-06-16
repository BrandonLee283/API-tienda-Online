const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
const port = 3001;

app.use(bodyParser.json());


const connection = mysql.createConnection({
  host: 'carrito-compras.chx3ouukdpzl.us-east-2.rds.amazonaws.com',
  user: 'Reyesb',
  password: 'tiendaOnline2#',
  database: 'carrito-compras'
});
// const connection = mysql.createConnection({
//   host: 'localhost',
//   user: 'root',
//   password: 'brandon2001',
//   database: 'carrito-compras'
// });
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }
  console.log('Conexión exitosa a la base de datos');
});

app.get('/productos', (req, res) => {
  connection.query('SELECT * FROM productos', (err, results) => {
    if (err) {
      console.error('Error al obtener los productos:', err);
      res.status(500).json({ error: 'Error al obtener los productos' });
      return;
    }
    res.json(results);
    
  });
});
app.get('/productosAdmin', (req, res) => {
  connection.query('CALL verProductos', (err, results) => {
    if (err) {
      console.error('Error al obtener los productos:', err);
      res.status(500).json({ error: 'Error al obtener los productos' });
      return;
    }
    res.json(results);
  });
});

app.get('/productos/:id', (req, res) => {
  const productId = req.params.id;
  connection.query('SELECT * FROM productos WHERE id = ?', [productId], (err, results) => {
    if (err) {
      console.error('Error al obtener el producto:', err);
      res.status(500).json({ error: 'Error al obtener el producto' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Producto no encontrado' });
      return;
    }
    res.json(results[0]);
  });
});

app.get('/productosAdmin/:id', (req, res) => {
  const productId = req.params.id;
  connection.query('CALL verProductoUnico(?)', [productId], (err, results) => {
    if (err) {
      console.error('Error al obtener la producto:', err);
      res.status(500).json({ error: 'Error al obtener el producto' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Producto no encontrada' });
      return;
    }
    res.json(results[0]);
  });
});


app.get('/categorias', (req, res) => {
  connection.query('SELECT * FROM categorias', (err, results) => {
    if (err) {
      console.error('Error al obtener las categorias:', err);
      res.status(500).json({ error: 'Error al obtener las categorias' });
      return;
    }
    res.json(results);
  });
});
app.get('/estados', (req, res) => {
  connection.query('SELECT * FROM estados', (err, results) => {
    if (err) {
      console.error('Error al obtener los estados:', err);
      res.status(500).json({ error: 'Error al obtener los estados' });
      return;
    }
    res.json(results);
    console.log(results);
  });
});

app.get('/categorias/:id', (req, res) => {
  const categoryId = req.params.id;
  connection.query('SELECT * FROM categorias WHERE id_categoria = ?', [categoryId], (err, results) => {
    if (err) {
      console.error('Error al obtener la categoría:', err);
      res.status(500).json({ error: 'Error al obtener la categoría' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Categoría no encontrada' });
      return;
    }
    res.json(results[0]);
  });
});

app.post('/categorias', (req, res) => {
  const {nombre,descripcion} = req.body; 
  connection.query('INSERT categorias values (default,?,?,1)', [nombre,descripcion], (err, result) => {
    if (err) {
      console.error('Error al crear la categoría:', err);
      res.status(500).json({ error: 'Error al crear la categoría' });
      return;
    }
    res.status(201).json({ message: 'Categoría creada exitosamente' });
  });
});

app.put('/categorias/:id', (req, res) => {
  // console.log(req.params.id,req.body);
  const categoriaId = req.params.id;
  const {nombre, descripcion} = req.body;
  // console.log({nombre, descripcion,categoriaId});
  connection.query(`UPDATE categorias SET nombre_categoria = ?, descripcion_categoria = ? WHERE id_categoria= ?`, [nombre,descripcion,categoriaId], (err, result) => {
    if (err) {
      console.error('Error:', err);
      res.status(500).json({ error: 'Error' });
      return;
    }
    res.json({ message: 'Actualizado exitosamente' });
  });
});

app.delete('/categorias/:id', (req, res) => {
  const categoriaId = req.params.id;
  console.log(categoriaId);
  connection.query(`UPDATE categorias SET status_categoria = 0 where id_categoria= ?`, [categoriaId], (err, result) => {
    if (err) {
      console.error('Error:', err);
      res.status(500).json({ error: 'Error' });
      return;
    }
    
    res.json({ message: 'Eliminado exitosamente' });
  });
});
app.delete('/productos/:id', (req, res) => {
  const productoId = req.params.id;
  console.log(productoId);
  connection.query(`UPDATE productos SET status_producto = 0 where id_producto= ?`, [productoId], (err, result) => {
    if (err) {
      console.error('Error:', err);
      res.status(500).json({ error: 'Error' });
      return;
    }
    
    res.json({ message: 'Eliminado exitosamente' });
  });
});

app.post('/productos', (req, res) => {
  const {nombre, precio, imagen,disponibles,categoria} = req.body; 
  connection.query('CALL insertarProductos(?,?,?,?,?)', [nombre, precio, imagen,disponibles,categoria], (err, result) => {
    if (err) {
      console.error('Error al crear el Producto:', err);
      res.status(500).json({ error: 'Error al crear el Producto' });
      return;
    }
    res.status(201).json({ message: 'Producto creado exitosamente' });
  });
});




app.post('/venta', (req, res) => {
  const nuevaCategoria = req.body; // Suponiendo que los datos de la nueva categoría se envían en el cuerpo de la solicitud
  connection.query('INSERT INTO categorias SET ?', nuevaCategoria, (err, result) => {
    if (err) {
      console.error('Error al crear la categoría:', err);
      res.status(500).json({ error: 'Error al crear la categoría' });
      return;
    }
    res.status(201).json({ message: 'Categoría creada exitosamente' });
  });
});

app.put('/productosAdmin/:id', (req, res) => {
  const idProducto = req.params.id;
  const {nombreProducto, precioProducto, stockProducto, nombreCategoria } = req.body;
  connection.query(`call actualizarProductos(?,?,?,?,?)`, [nombreProducto, precioProducto, stockProducto, nombreCategoria,idProducto], (err, result) => {
    if (err) {
      console.error('Error:', err);
      res.status(500).json({ error: 'Error' });
      return;
    }
    res.json({ message: 'Actualizado Exitosamente' });
  });
});



app.put('/productos/:id', (req, res) => {
  // console.log(req.params.id,req.body);
  const productoId = req.params.id;
  const {cantidad} = req.body;
  connection.query(`UPDATE productos SET stock_producto = stock_producto - ? WHERE id_producto = ?`, [cantidad,productoId], (err, result) => {
    if (err) {
      console.error('Error:', err);
      res.status(500).json({ error: 'Error' });
      return;
    }
    res.json({ message: 'Descontados Exitosamente' });
  });
});



app.listen(port, () => {
  console.log(`Servidor backend escuchando en el puerto ${port}`);
});
