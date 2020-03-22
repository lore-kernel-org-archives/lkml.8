Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE73C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D188220736
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NC4J8tcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCVXiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:38:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgCVXiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:38:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48lv843Rdjz9sPF;
        Mon, 23 Mar 2020 10:37:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584920276;
        bh=pB/ij0LQ+hU9R0vbeJpfiRSVLQIXMR/HzdLDcVicW6A=;
        h=Date:From:To:Cc:Subject:From;
        b=NC4J8tcMAabGrVma91oEIkvAInIZqsunZTcjrDh40RkMwcTQjumEvzpBypgcfMt1n
         qx5e8D92ptB43Gs5XTuBbjHXeLtbnLkNxYci8bAZ/hPtFw4EZpQnBhCa4m/UnPElTr
         g9b7rn3R9uBlkzHda06YC6h44bOSmKInZ1Tvyb8VZvVWGrESSyrWloRtMVrFfIO0Vh
         qDny1qk9Y8f4FXLf5qvGjnq4sWxpSak9PfqdJYbMYjtzGYgLJvxE/IWLVmIh3HY0JO
         4/yAi5vMyCYjWNkI8UCs6ZBVLS3OmEnc2XeUDk8Bx9sEl+v7W9adqDY7helWOrUEl4
         wsgurRTggO53A==
Date:   Mon, 23 Mar 2020 10:37:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grant Peltier <grantpeltier93@gmail.com>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20200323103753.09474a57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s6EK36.+4ZLEWuS5Ky_s876";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s6EK36.+4ZLEWuS5Ky_s876
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/pmbus/isl68137.c: In function 'raa_dmpvr2_read_word_data':
drivers/hwmon/pmbus/isl68137.c:125:9: error: too few arguments to function =
'pmbus_read_word_data'
  125 |   ret =3D pmbus_read_word_data(client, page, RAA_DMPVR2_READ_VMON);
      |         ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/hwmon/pmbus/isl68137.c:19:
drivers/hwmon/pmbus/pmbus.h:466:5: note: declared here
  466 | int pmbus_read_word_data(struct i2c_client *client, int page, int p=
hase,
      |     ^~~~~~~~~~~~~~~~~~~~
drivers/hwmon/pmbus/isl68137.c: In function 'isl68137_probe':
drivers/hwmon/pmbus/isl68137.c:199:24: error: assignment to 'int (*)(struct=
 i2c_client *, int,  int,  int)' from incompatible pointer type 'int (*)(st=
ruct i2c_client *, int,  int)' [-Werror=3Dincompatible-pointer-types]
  199 |   info->read_word_data =3D raa_dmpvr2_read_word_data;
      |                        ^
drivers/hwmon/pmbus/isl68137.c:203:24: error: assignment to 'int (*)(struct=
 i2c_client *, int,  int,  int)' from incompatible pointer type 'int (*)(st=
ruct i2c_client *, int,  int)' [-Werror=3Dincompatible-pointer-types]
  203 |   info->read_word_data =3D raa_dmpvr2_read_word_data;
      |                        ^
drivers/hwmon/pmbus/isl68137.c:206:24: error: assignment to 'int (*)(struct=
 i2c_client *, int,  int,  int)' from incompatible pointer type 'int (*)(st=
ruct i2c_client *, int,  int)' [-Werror=3Dincompatible-pointer-types]
  206 |   info->read_word_data =3D raa_dmpvr2_read_word_data;
      |                        ^
drivers/hwmon/pmbus/isl68137.c:216:24: error: assignment to 'int (*)(struct=
 i2c_client *, int,  int,  int)' from incompatible pointer type 'int (*)(st=
ruct i2c_client *, int,  int)' [-Werror=3Dincompatible-pointer-types]
  216 |   info->read_word_data =3D raa_dmpvr2_read_word_data;
      |                        ^

Caused by commit

  96c72647bc37 ("hwmon: (pmbus) add support for 2nd Gen Renesas digital mul=
tiphase")

I have used the version of the hwmon-staging from next-20200320 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/s6EK36.+4ZLEWuS5Ky_s876
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl539tEACgkQAVBC80lX
0GzadQf/WXl0ZzFl0ylfsDmaQRTjRRlXWFpbwMMnB8CmlUQPACBj6pmAMm3LazUs
XC9XkMYnxNYu/G2eaxeKtWL3hfclhZefVt72/y4Qj7AVm9vobWzGUNhsR+PJz5gt
D0LpUqRsx4w/utS8JYykl5EJJN36QTMabWOCXoPVK3pCOuXpyGsMjESdrODm1Bi+
eNdeFK9g2IWRDHq/TjhJObktaXx7q6MlU25ao4xYZMzBIxGpkKEluXI5dbHUBqCj
/rv2dlQVl/pFUdVYMeu3OB584Uh9GYQ+Mg8NSO5xrGcWhtNX5PtSj7Bs3hny75wu
xajbo1/YiKA5JGyjJGizaK8S67mf9w==
=x4Uq
-----END PGP SIGNATURE-----

--Sig_/s6EK36.+4ZLEWuS5Ky_s876--
