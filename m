Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B4C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F2D206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393461AbgDOFtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:49:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393419AbgDOFtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:49:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOav3-0006jl-3p; Wed, 15 Apr 2020 07:49:05 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jOav1-0004nR-Dw; Wed, 15 Apr 2020 07:49:03 +0200
Date:   Wed, 15 Apr 2020 07:49:03 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        jaswinder.singh@linaro.org, linux@rempel-privat.de,
        devicetree@vger.kernel.org, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: imx-mu: correct example
Message-ID: <20200415054903.uywcv5fzuq4fs26l@pengutronix.de>
References: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bzghxigj66j6f6n"
Content-Disposition: inline
In-Reply-To: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:45:17 up 151 days, 21:03, 164 users,  load average: 0.10, 0.04,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bzghxigj66j6f6n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:24:27PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The example use i.MX8QXP MU, but actually the MU is compatible with
> i.MX6SX, so add the compatible.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Docum=
entation/devicetree/bindings/mailbox/fsl,mu.txt
> index 31486c9f6443..26b7a88c2fea 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -51,7 +51,7 @@ Optional properties:
>  Examples:
>  --------
>  lsio_mu0: mailbox@5d1b0000 {
> -	compatible =3D "fsl,imx8qxp-mu";
> +	compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  	reg =3D <0x0 0x5d1b0000 0x0 0x10000>;
>  	interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>  	#mbox-cells =3D <2>;
> --=20
> 2.16.4
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4bzghxigj66j6f6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl6WoEMACgkQ4omh9DUa
UbMn5g//alHPJwdl+12HdDu5J7K5lGVY2ASoGoXkEd1qRc+qAKC+kXjb2JBL+dCF
AOjKPpxxpvby8yd0r41D0Fks9eS63COq/YlWpOHo2HwVmGDqa+bgiXozgQM/JJ1B
K5nxMZaMFmFmC1/zFmD3Wr2mZLlH1AEnqWTBrLwQpDBO8hjnieA8Br0bFLNqZWGu
0Xry1XW9+26Aa7WwlltfOnwfKjSfyDfg2r/zxoPusSXnBZzxcZt3jjDZ+Gr9DQ1C
Ivo1L5fjU8soOZ12SyLMGQTTwKBQQdt8ek4d88lao+Zoj64sho+evm/ux668Nd/7
q/Pp/1LYjphQYydzoqfRYeN+vKFbZtu9foEJbCbliOiMd7eFrit3yV4XrjeKx8F8
cCHeh5lZB2uKe60rrfwOP5+ynm8rJHGLKEFkGiTuZbR7KtK1ZqVAsdFiJYvjxC+K
m8sHuZfp9/7Eo8Y0oO8m+eJCw7fXPxduBH+28UTqcvzQ1e7Bke6iVAraNMJ5eIPc
qWcrznDmGZtTZp+48HxkmomsCPf0D/VWtzRA+29/ebumJyLU8ub7zrQxtIJ8o0l7
sx3Pi97n6745dNNBczhQc12dpdRAmjp6mpfexl8rR4sgOuuHJE1u7e/R/N3UmIHZ
NPUaoxI7DbQ6cX3nQoNAAyYtD9VliU6v4u8KJy8iKNYjJsMQXE8=
=5pgf
-----END PGP SIGNATURE-----

--4bzghxigj66j6f6n--
