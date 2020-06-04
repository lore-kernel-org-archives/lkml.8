Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D82C207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgFDQxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:53:06 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:50300 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:53:06 -0400
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E965C200479;
        Thu,  4 Jun 2020 16:53:03 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 9CF6320B20; Thu,  4 Jun 2020 18:52:33 +0200 (CEST)
Date:   Thu, 4 Jun 2020 18:52:33 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, gustavoars@kernel.org
Subject: [GIT PULL] pcmcia updates for v5.8
Message-ID: <20200604165233.GA167431@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

the following changes since b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available from

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-ne=
xt

up to 46d0797906633d82bd50ef26780ee39fac5d27d6:

  pcmcia: make pccard_loop_tuple() static (2020-05-18 11:16:39 +0200)


Two minor PCMCIA odd fixes, one replacing zero-length arrays with a
flexible-array member, and one making a local function static.


Thanks,
	Dominik

----------------------------------------------------------------
Dominik Brodowski (1):
      pcmcia: make pccard_loop_tuple() static

Gustavo A. R. Silva (1):
      pcmcia: Replace zero-length array with flexible-array

 drivers/pcmcia/cs_internal.h | 6 ------
 drivers/pcmcia/pcmcia_cis.c  | 6 +++---
 include/pcmcia/cistpl.h      | 6 +++---
 3 files changed, 6 insertions(+), 12 deletions(-)



diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index fb9b17fa0fb5..580369f3c0b0 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -164,12 +164,6 @@ int pcmcia_replace_cis(struct pcmcia_socket *s,
 int pccard_validate_cis(struct pcmcia_socket *s, unsigned int *count);
 int verify_cis_cache(struct pcmcia_socket *s);
=20
-int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
-		      cisdata_t code, cisparse_t *parse, void *priv_data,
-		      int (*loop_tuple) (tuple_t *tuple,
-					 cisparse_t *parse,
-					 void *priv_data));
-
 int pccard_get_first_tuple(struct pcmcia_socket *s, unsigned int function,
 			tuple_t *tuple);
=20
diff --git a/drivers/pcmcia/pcmcia_cis.c b/drivers/pcmcia/pcmcia_cis.c
index b553f7ab532f..e4c4daf92038 100644
--- a/drivers/pcmcia/pcmcia_cis.c
+++ b/drivers/pcmcia/pcmcia_cis.c
@@ -78,9 +78,9 @@ int pccard_read_tuple(struct pcmcia_socket *s, unsigned i=
nt function,
  * calls the @loop_tuple function for each entry. If the call to @loop_tup=
le
  * returns 0, the loop exits. Returns 0 on success or errorcode otherwise.
  */
-int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
-		      cisdata_t code, cisparse_t *parse, void *priv_data,
-		      int (*loop_tuple) (tuple_t *tuple,
+static int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int functio=
n,
+			     cisdata_t code, cisparse_t *parse, void *priv_data,
+			     int (*loop_tuple) (tuple_t *tuple,
 					 cisparse_t *parse,
 					 void *priv_data))
 {
diff --git a/include/pcmcia/cistpl.h b/include/pcmcia/cistpl.h
index 59a011101e0e..749320cc9aba 100644
--- a/include/pcmcia/cistpl.h
+++ b/include/pcmcia/cistpl.h
@@ -161,7 +161,7 @@ typedef struct cistpl_funcid_t {
=20
 typedef struct cistpl_funce_t {
     u_char	type;
-    u_char	data[0];
+    u_char	data[];
 } cistpl_funce_t;
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -255,7 +255,7 @@ typedef struct cistpl_data_serv_t {
     u_char	escape;
     u_char	encrypt;
     u_char	misc_features;
-    u_char	ccitt_code[0];
+    u_char	ccitt_code[];
 } cistpl_data_serv_t;
=20
 typedef struct cistpl_fax_serv_t {
@@ -265,7 +265,7 @@ typedef struct cistpl_fax_serv_t {
     u_char	encrypt;
     u_char	features_0;
     u_char	features_1;
-    u_char	ccitt_code[0];
+    u_char	ccitt_code[];
 } cistpl_fax_serv_t;
=20
 typedef struct cistpl_voice_serv_t {

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAl7ZJs0ACgkQmpdgiUyN
ow2QJhAArnjpVcZP1ngj2F6cfxdN0ixvs0CVmoJ0rZaLkopfC9PqVPlVvboYZl80
KExJqkZA5GwwxTB0u2rNmsrHAUXIaGpz1T6Um6i2/Tn/QRaoBsTjeEqNYLQN6akt
I5rnJxUZ6KedIcPdv73u+MJBhdDAg2I9/hPocLSmr86CcUmskoDnwd1TT5rzc/BJ
D+KJVTNugcLSYjuhEbY+DTaUgNSsy/tHaqd8orPrzA/1UqFloUfJ5Wls+gKIDODc
YHupsiPrn9tJjAbb8+TxYviiXZP1VGNwsfXxg8jzak94bOk7ddZd7TXoCE8OODMO
Ka5NYkyr/MDt0TN5rCDyOV2Alk21sRZjPo1JKR6OsBFoFUsBg5S1QUpXtsLlKk++
cQ878ScsYZryxVsPOljhIGdgMWxd4wkvuOEYOxjazYLm+5sUhdQy/Ks2zwcuaShj
+4OsHkzAOvCk+iBcQa1XoAa8S7otIeHqqbBzr6VJ0LWryY5J1OwMat1X0+qJ+BzP
NszM2aPsQuoOtEegKYs05zYRickY6lyrFG7GUl7FEa33wrHadEM93WfzX5K5d6YG
zxBS6xDnvcr5deubOZt/81ba9NJz6FkjHEqe9o4ovvgfZR8XbvZ6Rc/l9GSSdgAa
viDllm1Ey7BDYvLX46mvF3zgrrvqLrpMxeJBLpHrYxLXD+bu0ss=
=02wz
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
