<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >

    </v-app-bar>

    <v-main>
      <v-row class= "mt-5">
      <v-spacer></v-spacer>
        <router-link :to="{name: 'Home'}" class="mr-5">Libros</router-link>
        <router-link :to="{name: 'Usuarios'}" class="mr-5">Usuarios</router-link>
        <router-link :to="{name: 'Prestamos'}">Prestamos</router-link>
      <v-spacer></v-spacer>
      </v-row>
      <router-view>
      </router-view>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  data: () => ({
    //
  }),
};
</script>
