<template>
<v-container>
  <v-data-table
    :headers="headers"
    :items="usuarios"
    :items-per-page="5"
 
  >
  <template v-slot:top>
      <v-toolbar flat>
        <v-toolbar-tittle>Usuarios</v-toolbar-tittle>
        <v-spacer></v-spacer>
        <v-btn color='success' @click="nl_dialog = true">Nuevo Usuario</v-btn>
      </v-toolbar>
  </template>


  <template v-slot:[`item.actions`]="{item}">
    <v-icon @click="eliminar_usuario(item)" small>
      fas fa-trash
    </v-icon>
  </template>
</v-data-table>

<v-dialog v-model='nl_dialog' max-width="500px">
    <v-card>
      <v-card-title>
        Nuevo Usuario
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_usuario.usu_nombre" label ='Nombre'>
              </v-text-field> 
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_usuario.usu_ap_pat" label ='Apellido Paterno'>
              </v-text-field>
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_usuario.usu_ap_mat" label ='Apellido Materno'>
              </v-text-field>
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_usuario.usu_activo" label ='Activo'>
              </v-text-field>
            </v-col>
            <v-col cols='6'>
              <v-text-field v-model="nuevo_usuario.usu_correo" label ='Correo'>
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
    name: 'Usuarios',

     data () {
      return {
        headers: [
          {
            text: 'Identificador',
            align: 'start',
            sortable: false,
            value: 'usu_id',
          },
          { text: 'Nombre', value: 'usu_nombre' },
          { text: 'Apellido Paterno', value: 'usu_ap_pat' },
          { text: 'Apellido Materno', value: 'usu_ap_mat' },
          { text: 'Activo', value: 'usu_activo' },
          { text: 'Correo', value: 'usu_correo'},
          { text: 'Acciones', value: 'actions'}
        ],
        usuarios: [

        ],

        nl_dialog: false,

        nuevo_usuario: {
          usu_nombre: '',
          usu_ap_pat: '',
          usu_ap_mat: '',
          usu_activo: '',
          usu_correo: ''

        },

        }
          
    },

    created(){
        this.llenar_usuarios();
      },

    methods: {

      async llenar_usuarios(){
        const api_data = await this.axios.get('/usuarios/todos_los_usuarios/');
        this.usuarios = api_data.data;

      },

      async eliminar_usuario(item){
        const body = {
          usu_id: item.usu_id
        };
      await this.axios.post('/usuarios/eliminar_usuario/', body);
      
      this.llenar_usuarios();

      },

      cancelar(){
        this.nuevo_usuario = {};
        this.nl_dialog = false;
      },

      async guardar(){
        await this.axios.post('/usuarios/nuevo_usuario/', this.nuevo_usuario);
        this.llenar_usuarios();
        this.cancelar();

      },


      
    },

    components: {
  
    },
  }
</script>

