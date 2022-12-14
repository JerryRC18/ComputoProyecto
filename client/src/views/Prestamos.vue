<template>
    <v-container>
        <v-data-table
                :headers="headers"
                :items="prestamos"
                :items-per-page="5"
            
        >
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-tittle>Prestamos</v-toolbar-tittle>
                    <v-spacer></v-spacer>
                    <v-btn color='success' @click="nl_dialog = true">Nuevo Prestamo</v-btn>
                </v-toolbar>
            </template>


            <template v-slot:[`item.actions`]="{item}">
                <v-icon @click="eliminar_prestamo(item)" small class="mr-3">
                fas fa-trash
                </v-icon>
                 <v-icon @click="agregar_libros(item)" small class="mr-3">
                fas fa-pencil-alt
                </v-icon>
                <v-icon @click="detalle_prestamo(item)" small>
                fas fa-eye
                </v-icon>
            </template>
        </v-data-table>
        <v-dialog v-model='nl_dialog' max-width="500px">
            <v-card>
                <v-card-title>Nuevo Prestamo</v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-select
                                    :items="usuarios"
                                    v-model="nuevo_prestamo.pre_usu_id"
                                    label="Usuario"
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                    <v-menu
                                        v-model="menu1"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="nuevo_prestamo.pre_fec_pres"
                                                label="Fecha de Prestamo"
                                                prepend-icon="far fa-calendar"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker
                                            v-model="nuevo_prestamo.pre_fec_pres"
                                            @input="menu1 = false"
                                        ></v-date-picker>
                                    </v-menu>
                            </v-col>
                            <v-col cols="6">
                                 <v-menu
                                        v-model="menu2"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="nuevo_prestamo.pre_fec_entre"
                                                label="Fecha de Entrega Asignada"
                                                prepend-icon="far fa-calendar"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker
                                            v-model="nuevo_prestamo.pre_fec_entre"
                                            @input="menu2 = false"
                                        ></v-date-picker>
                                    </v-menu>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col cols="6">
                                 <v-menu
                                        v-model="menu3"
                                        :close-on-content-click="false"
                                        :nudge-right="40"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto"
                                    >
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="nuevo_prestamo.pre_fec_real_entre"
                                                label="Fecha de Entrega Real"
                                                prepend-icon="far fa-calendar"
                                                readonly
                                                v-bind="attrs"
                                                v-on="on"
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker
                                            v-model="nuevo_prestamo.pre_fec_real_entre"
                                            @input="menu3 = false"
                                        ></v-date-picker>
                                    </v-menu>
                            </v-col>
                        </v-row>    
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color='success' @click="guardar()">Guardar</v-btn>
                    <v-btn color='error' @click="cancelar()">Cancelar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-dialog v-model='np_dialog' max-width="500px">
            <v-card>
                <v-card-title>
                    Agregar libros
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="agregar_renglon()">Agregar Libro</v-btn>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row v-for="(libro, index) in det_prestamo" v-bind:key="index">
                            <v-col cols="12">
                                <v-select
                                    :items="libros"
                                    label="Titulo del libro"
                                    v-model="libro.dep_lib_id"
                                >
                                </v-select>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="success" @click="guardar_libros()">Guardar</v-btn>
                    <v-btn color="error" @click="cancelar()">Cancelar</v-btn>
                </v-card-actions>
            
            </v-card>
        </v-dialog>
        <v-dialog v-model='p_dialog' max-width="500px">
            <v-card>
                <v-card-title>
                    Libros Prestados
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <v-row v-for="(libro, index) in libros_prestados" v-bind:key="index">
                            <v-col cols="12">
                                <v-text-field
                                    label="Titulo del libro"
                                    v-model="libro.lib_titulo"
                                    disabled
                                >   
                                </v-text-field>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-card-text> 
                <v-card-actions>
                    <v-spacer></v-spacer>
                        <v-btn color="primary" @click="p_dialog = false"> Cerrar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>


    </v-container>

</template>

<script>
export default {
    name: "Prestamos",

    data() {
        return{
            headers: [
                {
                    text: 'Identificador',
                    align: 'start',
                    sortable: false,
                    value: 'pre_id',
                },
                { text: 'Nombre del usuario', value: 'usu_nom_comp' },
                { text: 'Fecha de Prestamo', value: 'pre_fec_pres' },
                { text: 'Fecha de Entrega Asignada', value: 'pre_fec_entre' },
                { text: 'Fecha de Entrega Real', value: 'pre_fec_real_entre' },
                { text: 'Acciones', value: 'actions'}
                ],
                prestamos: [],
                usuarios: [],
                libros: [],
                det_prestamo: [],
                libros_prestados: [],
                dep_pre_id: '',
                

                nl_dialog: false,
                np_dialog: false,
                p_dialog: false,

                menu1: false,
                menu2: false,
                menu3: false,

                nuevo_prestamo: {
                    pre_fec_pres: '',
                    pre_fec_entre: '',
                    pre_fec_real_entre: null,
                    pre_usu_id: ''

                },

        }
    },

    created() {
        this.llenar_prestamos();
        this.llenar_usuarios();
        this.llenar_libros();
    },

    methods: {
        async llenar_prestamos(){
            const api_data = await this.axios.get('/prestamos/todos_los_prestamos/');
            this.prestamos = api_data.data;
        },

        async llenar_usuarios(){
            const api_data = await this.axios.get('/usuarios/todos_los_usuarios/');
            api_data.data.forEach((item) => {
                this.usuarios.push ({
                    text: item.usu_nombre + ' ' + item.usu_ap_pat + ' ' + item.usu_ap_mat,
                    value: item.usu_id

                });
            });
        },

        async llenar_libros(){
            const api_data = await this.axios.get('/libros/todos_los_libros/');
            api_data.data.forEach((item) => {
                this.libros.push ({
                    text: item.lib_titulo,
                    value: item.lib_id

                });
            });
        },




        async eliminar_prestamo(item){
        const body = {
          pre_id: item.pre_id
        };
        await this.axios.post('/prestamos/eliminar_prestamo/', body);
        this.llenar_prestamos();

      },

      cancelar(){
        this.nuevo_prestamo = {};
        this.det_prestamo = [];
        this.nl_dialog = false;
        this.np_dialog = false;
      },

      async guardar(){
        await this.axios.post('/prestamos/nuevo_prestamo/', this.nuevo_prestamo);
        this.llenar_prestamos();
        this.cancelar();

      },

      async guardar_libros(){
          const body = {
              dep_pre_id: this.dep_pre_id,
              dep_lib_id: '',
              dep_multa: 0

          }

            this.det_prestamo.forEach(async (libro)=> {
            body.dep_lib_id = libro.dep_lib_id;
            await this.axios.post('/prestamos/nuevo_det_prestamo/', body);
            });
        this.cancelar();

      },

      agregar_libros(item){
          this.dep_pre_id = item.pre_id;
          this.np_dialog = true;

      },

      agregar_renglon(){
          this.det_prestamo.push({
              dep_lib_id: '',

          });

      },

      async detalle_prestamo(item){
          this.p_dialog = true;
          const api_data = await this.axios.get('prestamos/leer_det_prestamo/' + item.pre_id.toString());
          this.libros_prestados = api_data.data; 
      },


    },


}
    
</script>