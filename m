Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1076DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEA4206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441038AbgDOFuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393456AbgDOFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:50:14 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 22:50:14 PDT
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106BCC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:50:14 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOaw6-0006zO-9o; Wed, 15 Apr 2020 07:50:10 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jOaw5-0004qL-Sh; Wed, 15 Apr 2020 07:50:09 +0200
Date:   Wed, 15 Apr 2020 07:50:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        jaswinder.singh@linaro.org, linux@rempel-privat.de,
        devicetree@vger.kernel.org, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp: support scu mailbox channel
Message-ID: <20200415055009.uxkzy4j3l24dvvyv@pengutronix.de>
References: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
 <1586870668-32630-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrp2dftdgxv3jd5n"
Content-Disposition: inline
In-Reply-To: <1586870668-32630-2-git-send-email-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:49:46 up 151 days, 21:08, 164 users,  load average: 0.08, 0.03,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrp2dftdgxv3jd5n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:24:28PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> With mailbox driver support i.MX8 SCU MU channel, we could
> use it to avoid trigger interrupts for each TR/RR registers
> in one MU, instead, only one RX interrupt for a recv and
> one TX interrupt for a send.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>=20
> Note:
>  This patch needs https://patchwork.kernel.org/patch/11446659/
>  The other three patches in the patchset has been in linux-next
>=20
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot=
/dts/freescale/imx8qxp.dtsi
> index e8ffb7590656..d1c3c98e4b39 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -141,17 +141,11 @@
> =20
>  	scu {
>  		compatible =3D "fsl,imx-scu";
> -		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
> -			     "rx0", "rx1", "rx2", "rx3",
> +		mbox-names =3D "tx0",
> +			     "rx0",
>  			     "gip3";
>  		mboxes =3D <&lsio_mu1 0 0
> -			  &lsio_mu1 0 1
> -			  &lsio_mu1 0 2
> -			  &lsio_mu1 0 3
>  			  &lsio_mu1 1 0
> -			  &lsio_mu1 1 1
> -			  &lsio_mu1 1 2
> -			  &lsio_mu1 1 3
>  			  &lsio_mu1 3 3>;
> =20
>  		clk: clock-controller {
> @@ -548,14 +542,14 @@
>  		};
> =20
>  		lsio_mu1: mailbox@5d1c0000 {
> -			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +			compatible =3D "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1c0000 0x10000>;
>  			interrupts =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells =3D <2>;
>  		};
> =20
>  		lsio_mu2: mailbox@5d1d0000 {
> -			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +			compatible =3D "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1d0000 0x10000>;
>  			interrupts =3D <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells =3D <2>;
> @@ -563,7 +557,7 @@
>  		};
> =20
>  		lsio_mu3: mailbox@5d1e0000 {
> -			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +			compatible =3D "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1e0000 0x10000>;
>  			interrupts =3D <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells =3D <2>;
> @@ -571,7 +565,7 @@
>  		};
> =20
>  		lsio_mu4: mailbox@5d1f0000 {
> -			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +			compatible =3D "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1f0000 0x10000>;
>  			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells =3D <2>;
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

--hrp2dftdgxv3jd5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl6WoJEACgkQ4omh9DUa
UbMo2Q//VYhP/UGwmjOZJrG++dp/xo/uq550cWXhFlBWJ6DU4JoFl7Hxynr+YtPW
BvTr8huLL8PchbLwHUFtUF92vPbIBrtW0t6wzCkn0oAlfuV03b9+jB7rX2DFfAIc
4nm/+kk5ez6PCUNT0JMjgUFHKeeRtfVcy6qvIGTCYSj+Tvg2//2oukcWtUmLE9CN
XKLEfEPtDi63ihkhVkzYsWgzA7X5aLQPxrKc9+CopxOltx3dsrm4AoMR2XIZM8Vp
x1obhnTSbU1en/Jga1woTaNbks1nhLRnHgi328D0DbpBh10r4tYQKj/eBnEfpacu
fI3teKrvU8Qjr0XinVsdW5+asXEdOePM6Ufonje/8VdJ01G8rG4npORlqxaTb4mU
9wGHk0R4wERpuZhRShwhpui3h5WyeHuWz1+8b0B02+Vhw1RuSUv9WNt4B+xe7NbQ
oD831atJNNVSbjOWqW41SnPMQPJZRhwdvFwVhK/ib5TGvLSGqnMMtZ0AQhnpdLqD
u1CBQWVtCSMs0yU9W1b2b+8pWp+O6h/Nlg2XgL51xe19wP2s7xDgHAmJLmHo+c+7
n9P4xka4BV9n44bmBNq6P3EoJegv7cW1VWmYWhfCWfHdTAxedvX/iZgq2AINPo1X
wSp+DdgtYvFL/NlzH+kCR5FopdZj5hU869wcdL+n3MNS6zzcKMg=
=56Tk
-----END PGP SIGNATURE-----

--hrp2dftdgxv3jd5n--
