/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     01/10/2021 00:32:25                          */
/*==============================================================*/


drop table if exists Agendamento;

drop table if exists Coleta;

drop table if exists Cupom;

drop table if exists Endereco;

drop table if exists HistoricoCupom;

drop table if exists Material;

drop table if exists Motorista;

drop table if exists Parceiro;

drop table if exists Pessoa;

drop table if exists Pontuacao;

/*==============================================================*/
/* Table: Agendamento                                           */
/*==============================================================*/
create table Agendamento
(
   AgendamentoID        int not null,
   PessoaID             int,
   AgendaData           date,
   AgendaHora           time
);

alter table Agendamento
   add primary key (AgendamentoID);

/*==============================================================*/
/* Table: Coleta                                                */
/*==============================================================*/
create table Coleta
(
   ColetaID             int not null,
   AgendamentoID        int,
   MaterialID           int,
   ColetaPeso           decimal,
   ColetaPonto          int
);

alter table Coleta
   add primary key (ColetaID);

/*==============================================================*/
/* Table: Cupom                                                 */
/*==============================================================*/
create table Cupom
(
   CupomID              int not null,
   ParceiroID           int,
   DescCupom            longtext,
   CondicaoCupom        longtext
);

alter table Cupom
   add primary key (CupomID);

/*==============================================================*/
/* Table: Endereco                                              */
/*==============================================================*/
create table Endereco
(
   EnderecoID           int not null,
   PessoaID             int,
   ParceiroID           int,
   Logradouro           char(50),
   CEP                  numeric(8,0),
   Numero               char(10),
   Complemento          longtext,
   Bairro               longtext,
   Cidade               longtext,
   UF                   char(2)
);

alter table Endereco
   add primary key (EnderecoID);

/*==============================================================*/
/* Table: HistoricoCupom                                        */
/*==============================================================*/
create table HistoricoCupom
(
   HistoricoID          int not null,
   PessoaID             int,
   CupomID              int,
   DataGeracao          date
);

alter table HistoricoCupom
   add primary key (HistoricoID);

/*==============================================================*/
/* Table: Material                                              */
/*==============================================================*/
create table Material
(
   MaterialID           int not null,
   MaterialTipo         char(60),
   MaterialNome         longtext,
   PontoQuilo           int
);

alter table Material
   add primary key (MaterialID);

/*==============================================================*/
/* Table: Motorista                                             */
/*==============================================================*/
create table Motorista
(
   MotoristaID          int not null,
   PessoaID             int,
   CNH                  varchar(20),
   Veiculo              char(60)
);

alter table Motorista
   add primary key (MotoristaID);

/*==============================================================*/
/* Table: Parceiro                                              */
/*==============================================================*/
create table Parceiro
(
   ParceiroID           int not null,
   NomeParc             longtext,
   CNPJParc             varchar(14),
   EmailParc            longtext,
   TelParc              numeric(11,0)
);

alter table Parceiro
   add primary key (ParceiroID);

/*==============================================================*/
/* Table: Pessoa                                                */
/*==============================================================*/
create table Pessoa
(
   PessoaID             int not null,
   NomePessoa           longtext,
   CPFPessoa            char(11),
   EmailPessoa          char(255),
   TelPessoa            numeric(11,0)
);

alter table Pessoa
   add primary key (PessoaID);

/*==============================================================*/
/* Table: Pontuacao                                             */
/*==============================================================*/
create table Pontuacao
(
   PontuacaoID          int not null,
   PessoaID             int,
   Pontos               int
);

alter table Pontuacao
   add primary key (PontuacaoID);

alter table Agendamento add constraint FK_Realiza foreign key (PessoaID)
      references Pessoa (PessoaID) on delete restrict on update restrict;

alter table Coleta add constraint FK_Participa foreign key (MaterialID)
      references Material (MaterialID) on delete restrict on update restrict;

alter table Coleta add constraint FK_Realiza foreign key (AgendamentoID)
      references Agendamento (AgendamentoID) on delete restrict on update restrict;

alter table Cupom add constraint FK_Disponibiliza foreign key (ParceiroID)
      references Parceiro (ParceiroID) on delete restrict on update restrict;

alter table Endereco add constraint FK_Possui foreign key (ParceiroID)
      references Parceiro (ParceiroID) on delete restrict on update restrict;

alter table Endereco add constraint FK_Possui foreign key (PessoaID)
      references Pessoa (PessoaID) on delete restrict on update restrict;

alter table HistoricoCupom add constraint FK_Gera foreign key (CupomID)
      references Cupom (CupomID) on delete restrict on update restrict;

alter table HistoricoCupom add constraint FK_Gera foreign key (PessoaID)
      references Pessoa (PessoaID) on delete restrict on update restrict;

alter table Motorista add constraint FK_Identifica foreign key (PessoaID)
      references Pessoa (PessoaID) on delete restrict on update restrict;

alter table Pontuacao add constraint FK_Possui foreign key (PessoaID)
      references Pessoa (PessoaID) on delete restrict on update restrict;

