Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C95C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4042083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589971967;
	bh=0dvkQg4loHBHHMweXxF14prFqVj2uAiy14tBsqDdNFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ppkQZ/TvK8X8KoVPLzSzhKbnaoZ8GISPBM+Hp9rnZlaT4HX/fn+GJB8seEelA1Kx
	 Rz6x/zbxbMvaMuElAj5EA1CXm4r8N9W9kq7ghJlvfhKCXnNqTa/+rS712MZT+hPhj4
	 2mnXACoEMShWkbo6I40SVErg/I4RzE10tMY1ELX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgETKwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:52:46 -0400
Received: from earth.universe (dyndsl-037-138-188-077.ewe-ip-backbone.de [37.138.188.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7B6207F9;
        Wed, 20 May 2020 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589971966;
        bh=0dvkQg4loHBHHMweXxF14prFqVj2uAiy14tBsqDdNFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOnbB5DKikExs8meXJtc25F8LHLvmc+bmnsKpjxMxWpTzw79HG7iR869slH62LZLZ
         mUG5W6jhs4IeeZg0uOcE67Rlum6dZKSzOoE7UP5MAA1aocSpT0XE4ItyJDQ/kGfiwt
         XLkDCi62/vOj7SrtyTtseFsRkdUo3AS9W+bcFuKI=
Received: by earth.universe (Postfix, from userid 1000)
        id 9F5493C08C6; Wed, 20 May 2020 12:52:43 +0200 (CEST)
Date:   Wed, 20 May 2020 12:52:43 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management ICs
Message-ID: <20200520105243.jbnbz2pjlzs7yrsz@earth.universe>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
 <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6j7mu4vc6rwrgd3k"
Content-Disposition: inline
In-Reply-To: <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6j7mu4vc6rwrgd3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 20, 2020 at 09:11:28AM +0300, Matti Vaittinen wrote:
> Add entry for maintaining power management IC drivers for ROHM
> BD71837, BD71847, BD71850, BD71828, BD71878, BD70528 and BD99954.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  MAINTAINERS | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..63a2ca70540e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14490,6 +14490,12 @@ L:	linux-serial@vger.kernel.org
>  S:	Odd Fixes
>  F:	drivers/tty/serial/rp2.*
> =20
> +ROHM BD99954 CHARGER IC
> +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +S:	Supported
> +F:	drivers/power/supply/bd99954-charger.c
> +F:	drivers/power/supply/bd99954-charger.h
> +
>  ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> @@ -14507,6 +14513,30 @@ F:	drivers/mfd/bd9571mwv.c
>  F:	drivers/regulator/bd9571mwv-regulator.c
>  F:	include/linux/mfd/bd9571mwv.h
> =20
> +ROHM POWER MANAGEMENT IC DEVICE DRIVERS
> +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> +F:	Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
> +F:	drivers/clk/clk-bd718x7.c
> +F:	drivers/gpio/gpio-bd70528.c
> +F:	drivers/gpio/gpio-bd71828.c
> +F:	drivers/mfd/rohm-bd70528.c
> +F:	drivers/mfd/rohm-bd71828.c
> +F:	drivers/mfd/rohm-bd718x7.c
> +F:	drivers/power/supply/bd70528-charger.c
> +F:	drivers/regulator/bd70528-regulator.c
> +F:	drivers/regulator/bd71828-regulator.c
> +F:	drivers/regulator/bd718x7-regulator.c
> +F:	drivers/regulator/rohm-regulator.c
> +F:	drivers/rtc/rtc-bd70528.c
> +F:	drivers/watchdog/bd70528_wdt.c
> +F:	include/linux/mfd/rohm-shared.h
> +F:	include/linux/mfd/rohm-bd71828.h
> +F:	include/linux/mfd/rohm-bd70528.h
> +F:	include/linux/mfd/rohm-generic.h
> +F:	include/linux/mfd/rohm-bd718x7.h
> +
>  ROSE NETWORK LAYER
>  M:	Ralf Baechle <ralf@linux-mips.org>
>  L:	linux-hams@vger.kernel.org
> --=20
> 2.21.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20

--6j7mu4vc6rwrgd3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7FC/EACgkQ2O7X88g7
+po0Dw//SXkJH1qJ9ZWUuBUcJBulU0a3CY9sH8LJ9j8P9uAoEgzshEfjXtS8Rc+J
CAByRGZmkFwv0BfDsR0TGkk+Basi66+t5LdQJM88Lh2WTkV81UYNu0kI5lkhTgNJ
COt3NSC0Lzw6lX0TV1Sc1BIGl21WWqBd0/gr3d5HQPIo9TCUxaSlYEU8FYhP1AS/
g0Tn2C2kHQ3YBAHE7t6vR3j7JdVBmFXpdmQGMnE4lzounj+b1eZ5U6GFPzewJ2iv
+Mta73PX+X9oQQt/nrTs1qmAdx8mLbP2oBtfGUlXslPdCQ4U0TFH89nqW9CqxgJ+
pwQCtJ0lnlEKzr4UTPj6IemQNOYe++FFWqtA3PMFK6S0Gfcv+w3XkPin4oQKVjir
I0O1nz7BRfYnXWD0wgsJYcJilv47Rx4QpjpIE7o3BY/1Xo04NxuPJ3kxlVaQxCpu
7NnTxq5GwAjjVRC3bTCiEr/a1zW6Xk4OF8Upj6cm22I4JMyegFY3bmJkV8gGyDVp
8vrBkNelI0ktb49SqN4Gi0uLgVmq8mXGmo7GKIw5LOnU5AQLOiHHKfJNuWP+331o
OQB4A9yrlRM2trZDHspXhL7JJJqET9fgBkXy2CY/3DcexxyTxRs7bowyu+mARvVY
gv4+AAjhByOdmK/9zCrdLBMOQsqHeARExViifixRApYT1r0d3Ms=
=9KeZ
-----END PGP SIGNATURE-----

--6j7mu4vc6rwrgd3k--
