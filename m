Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B4C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75320753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCRM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:28:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40829 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCRM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:28:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEXnh-0004BV-N8; Wed, 18 Mar 2020 13:27:57 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jEXng-0005YE-UQ; Wed, 18 Mar 2020 13:27:56 +0100
Date:   Wed, 18 Mar 2020 13:27:56 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 6/6] m arch/arm/boot/dts/imx6q-prti6q.dts
Message-ID: <20200318122756.sfoyydaggn2vcbk6@pengutronix.de>
References: <20200318120354.4989-1-o.rempel@pengutronix.de>
 <20200318120354.4989-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sl7c7igma5v47h5x"
Content-Disposition: inline
In-Reply-To: <20200318120354.4989-6-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:26:51 up 124 days,  3:45, 155 users,  load average: 0.31, 0.10,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl7c7igma5v47h5x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

oops,
forgot to squash this one. Will be done in v2

On Wed, Mar 18, 2020 at 01:03:54PM +0100, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6q-prti6q.dts | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/imx6q-prti6q.dts b/arch/arm/boot/dts/imx6q=
-prti6q.dts
> index a6fd4eb2e78b..8880d56c59ac 100644
> --- a/arch/arm/boot/dts/imx6q-prti6q.dts
> +++ b/arch/arm/boot/dts/imx6q-prti6q.dts
> @@ -229,8 +229,23 @@ &sata {
>  &fec {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_enet>;
> -	phy-mode =3D "rgmii";
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&rgmii_phy>;
>  	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		/* Microchip KSZ9031RNX PHY */
> +		rgmii_phy: ethernet-phy@0 {
> +			reg =3D <0>;
> +			interrupts-extended =3D <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;
> +			reset-assert-us =3D <10000>;
> +			reset-deassert-us =3D <300>;
> +		};
> +	};
>  };
> =20
>  &ldb {
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--sl7c7igma5v47h5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl5yE8gACgkQ4omh9DUa
UbNQiQ/9HK7bWAZI/ksEU1RVowMwf0bgmVkrH7ip/x4alfJ4447+CdHRfKp9KrLP
Pdy/cadbJyzViEmLqwM0pKoKE14q6yD8j9OJUHWk3ZqXPzMHhfgyETCe4sVYF2dN
v+Yf1LY3lutnRWHvyeZz9YKKkyf8HqYT783NzMJyxt1j4I74gmyBqUAFt44wFhbd
KPZ50tL9hS9nxzkZ0dk5RBcMvuv0Y0l+vOlcnndA+Ztxf9pHqaUwoBtWZ9Y7CmI4
SRQjZKUQUZ7oQCucHlKzScPzcZeV8oHGGGyKS9aYvhlZ2bAuXY9q4TUaz1UuXf85
RJ1BvRuQoy5xSHPJ4XmiGts2t088C94kqisDKugDs9ae36gY7mTqlsvVfH7dBThg
Jhz84deyp8HOCLYjQf3NyAj+vvl0QoEWZ2cv2jblGKQffUIsdIhJBDASIqsi1B0I
qHd5t3lIfLrWhNL/ZE4AL41NmT6IYFOqp7mgdQrQkB04/ievEGgvetsdCt1Mcq0H
DTZZGPUXMXyVuWl6YaIf+NPaT26KyNoYhLPdZBC0PRr7HHa7KrodCLzRSQ4t3CgM
U0gTVhyPdMWug/5RjqEnHA2wt63Yc86VleAjzkUZcmPx5xtuQ77fKQfkk24bMu9D
j4z7Iw827kZ31sk4lsyvOsDXKmgNCrlCPbHV3xGu4GEDgIK+cRY=
=9LEv
-----END PGP SIGNATURE-----

--sl7c7igma5v47h5x--
