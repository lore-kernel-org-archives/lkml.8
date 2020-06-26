Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9809C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57BE20781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgFZQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:35:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgFZQfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:35:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C09CC2A5D7A
Received: by earth.universe (Postfix, from userid 1000)
        id 4FBEE3C08CD; Fri, 26 Jun 2020 18:35:11 +0200 (CEST)
Date:   Fri, 26 Jun 2020 18:35:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ian Ray <ian.ray@ge.com>, Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] ARM: dts: imx53: ppd: alarm LEDs use kernel LED interface
Message-ID: <20200626163511.ecblnjw6ckh77kog@earth.universe>
References: <20200416145123.73039-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5m6ldzthn5ejezqb"
Content-Disposition: inline
In-Reply-To: <20200416145123.73039-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5m6ldzthn5ejezqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Can this be applied please? There were no changes in 5.8 cycle to
PPD's DT file, so it still applies.

Thanks,

-- Sebastian

On Thu, Apr 16, 2020 at 04:51:23PM +0200, Sebastian Reichel wrote:
> From: Ian Ray <ian.ray@ge.com>
>=20
> Use kernel LED interface for the alarm LEDs.
>=20
> Signed-off-by: Ian Ray <ian.ray@ge.com>
> [Rebased]
> Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
> [Rebased]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm/boot/dts/imx53-ppd.dts | 49 +++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-pp=
d.dts
> index 5ff9a179c83c..34ce41600098 100644
> --- a/arch/arm/boot/dts/imx53-ppd.dts
> +++ b/arch/arm/boot/dts/imx53-ppd.dts
> @@ -176,7 +176,7 @@ pwm_bl: backlight {
>  		power-supply =3D <&reg_3v3_lcd>;
>  	};
> =20
> -	leds {
> +	leds-brightness {
>  		compatible =3D "pwm-leds";
> =20
>  		alarm-brightness {
> @@ -185,6 +185,32 @@ alarm-brightness {
>  		};
>  	};
> =20
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_alarmled_pins>;
> +
> +		alarm1 {
> +			label =3D "alarm:red";
> +			gpios =3D <&gpio7 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		alarm2 {
> +			label =3D "alarm:yellow";
> +			gpios =3D <&gpio7 7 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		alarm3 {
> +			label =3D "alarm:blue";
> +			gpios =3D <&gpio7 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		alarm4 {
> +			label =3D "alarm:silenced";
> +			gpios =3D <&gpio7 13 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
>  	gpio-poweroff {
>  		compatible =3D "gpio-poweroff";
>  		gpios =3D <&gpio3 9 GPIO_ACTIVE_HIGH>;
> @@ -909,18 +935,10 @@ MX53_PAD_NANDF_CS2__GPIO6_15		0x0
>  			MX53_PAD_NANDF_CS3__GPIO6_16		0x0
>  			/* POWER_AND_BOOT_STATUS_INDICATOR */
>  			MX53_PAD_PATA_INTRQ__GPIO7_2		0x1e4
> -			/* ACTIVATE_ALARM_LIGHT_RED */
> -			MX53_PAD_PATA_DIOR__GPIO7_3		0x0
> -			/* ACTIVATE_ALARM_LIGHT_YELLOW */
> -			MX53_PAD_PATA_DA_1__GPIO7_7		0x0
> -			/* ACTIVATE_ALARM_LIGHT_CYAN */
> -			MX53_PAD_PATA_DA_2__GPIO7_8		0x0
>  			/* RUNNING_ON_BATTERY_INDICATOR_GREEN */
>  			MX53_PAD_GPIO_16__GPIO7_11		0x0
>  			/* BATTERY_STATUS_INDICATOR_AMBER */
>  			MX53_PAD_GPIO_17__GPIO7_12		0x0
> -			/* AUDIO_ALARMS_SILENCED_INDICATOR */
> -			MX53_PAD_GPIO_18__GPIO7_13		0x0
>  		>;
>  	};
> =20
> @@ -1080,4 +1098,17 @@ pinctrl_usb_otg: usbotggrp {
>  			MX53_PAD_KEY_COL4__USBOH3_USBOTG_OC	0x180
>  		>;
>  	};
> +
> +	pinctrl_alarmled_pins: qmx6alarmledgrp {
> +		fsl,pins =3D <
> +			/* ACTIVATE_ALARM_LIGHT_RED */
> +			MX53_PAD_PATA_DIOR__GPIO7_3		0x0
> +			/* ACTIVATE_ALARM_LIGHT_YELLOW */
> +			MX53_PAD_PATA_DA_1__GPIO7_7		0x0
> +			/* ACTIVATE_ALARM_LIGHT_CYAN */
> +			MX53_PAD_PATA_DA_2__GPIO7_8		0x0
> +			/* AUDIO_ALARMS_SILENCED_INDICATOR */
> +			MX53_PAD_GPIO_18__GPIO7_13		0x0
> +		>;
> +	};
>  };
> --=20
> 2.25.1
>=20

--5m6ldzthn5ejezqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl72I6sACgkQ2O7X88g7
+prlww//X/bBvm2laqBr3zVAZ/6mUh8OcKpesdRnIXJoRZ10f7lcj0sLJWxHmHia
PY0/OeaIuCek6sUgC28KgnUThe4SBsBQCMefODeAwLb0l1vJJF/qCOX7rdN0uKVu
9zKuIGY5tWM9GllWMEBZfENIVmctqt0egCg+Pi2XLN+En5CpwOOS01rl6tIYXgwk
a1YaveHdSCMe9WO2UNV/RpxZBGSaiBHeFbBPuOhbJSZJh5CuhhYIlxw0szB1cIln
OKp3S9wXjx9u5nDxHwxJ8WUSjWWUFdcXxh9i89/gCAMrXj3kYtWWlRvfJAzoJKTU
4Y8qTdlKLNUuSyLTLctMXpZ9cIIJnxFQoSGuRoCruXZmVV9WdpVBm5yaPgpRchCd
vfLXjaBVEmUSnWMPEjBTMD9aJlrhbf+i6JiY/tgGWSKBopyKIbyF77DhW7zJPeUe
WrBvckFQQgtdR8S680Qyo4Yw2R714QAjCi7cb/HRkVe6/3NnO+HAU7t58bBlUAJH
MwxmK9cqOm+llQKwzRYHzko4vI7Lm2D9Ze14tzcA10McCoAZsQrI8+0H+FhaN/xs
iASm21gq/5lZXsUw++kWuvhuNThU9BxaaQ3AXK1ZgGgBYVxCVOlinKXjBqLzy9sU
On28G29Tt9tqlAN4HXXDakc9cWeBf8VD4B9QzLohXI9vH4TR0W0=
=ga+g
-----END PGP SIGNATURE-----

--5m6ldzthn5ejezqb--
