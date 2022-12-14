<template>
<v-container>
  <v-data-table
    :headers="headers"
    :items="libros"
    :items-per-page="5"
 
  >
  <template v-slot:top>
      <v-toolbar flat>
        <v-toolbar-tittle>Libros</v-toolbar-tittle>
        <v-spacer></v-spacer>
        <v-btn color='success' @click="nl_dialog = true">Nuevo Libro</v-btn>
      </v-toolbar>
  </template>


  <template v-slot:[`item.actions`]="{item}">
    <v-icon @click="eliminar_libro(item)" small>
      fas fa-trash
    </v-icon>
  </template>
</v-data-table>

<v-dialog v-model='nl_dialog' max-width="500px">
    <v-card>
      <v-card-title>
        Nuevo Libro
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_libro.lib_titulo" label ='Titulo'>
              </v-text-field> 
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_libro.lib_autor" label ='Autor'>
              </v-text-field>
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_libro.lib_editorial" label ='Editorial'>
              </v-text-field>
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_libro.lib_edicion" label ='Edicion' type="Number">
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color='success' @click="guardar()">Guardar</v-btn>
        <v-btn color='error' @click="cancelar()">Cancelar</v-btn>
        <v-spacer></v-spacer>
      </v-card-actions>
      </v-card-text>
    </v-card>
</v-dialog>

</v-container>

</template>

<script>
 

  export default {
    name: 'Home',

     data () {
      return {
        headers: [
          {
            text: 'Identificador',
            align: 'start',
            sortable: false,
            value: 'lib_id',
          },
          { text: 'titulo', value: 'lib_titulo' },
          { text: 'autor', value: 'lib_autor' },
          { text: 'Editorial', value: 'lib_editorial' },
          { text: 'Edicion', value: 'lib_edicion' },
          { text: 'Acciones', value: 'actions'}
        ],
        libros: [

        ],

        nl_dialog: false,

        nuevo_libro: {
          lib_titulo: '',
          lib_autor: '',
          lib_editorial: '',
          lib_edicion: ''

        },

        }
          
    },

    created(){
        this.llenar_libros();
      },

    methods: {

      async llenar_libros(){
        const api_data = await this.axios.get('/libros/todos_los_libros/');
        this.libros = api_data.data;

      },

      async eliminar_libro(item){
        const body = {
          lib_id: item.lib_id
        };
      await this.axios.post('/libros/eliminar_libro', body);
      
      this.llenar_libros();

      },

      cancelar(){
        this.nuevo_libro = {};
        this.nl_dialog = false;
      },

      async guardar(){
        await this.axios.post('libros/nuevo_libro', this.nuevo_libro);
        this.llenar_libros();
        this.cancelar();

      },


      
    },

    components: {
  
    },
  }
</script>
