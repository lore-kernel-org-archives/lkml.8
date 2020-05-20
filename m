Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6957C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960B4206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETPUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:20:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69816C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:20:03 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jbQVh-0005kX-IH; Wed, 20 May 2020 17:19:57 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jbQVg-0002uG-9b; Wed, 20 May 2020 17:19:56 +0200
Date:   Wed, 20 May 2020 17:19:56 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v7 0/5] mainline Protonic boards
Message-ID: <20200520151956.sdkbxh3xkmoj7jvx@pengutronix.de>
References: <20200520092937.15797-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rtjclzefu7dbfjwq"
Content-Disposition: inline
In-Reply-To: <20200520092937.15797-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:18:55 up 187 days,  6:37, 194 users,  load average: 0.05, 0.07,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rtjclzefu7dbfjwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please ignore this version, i used wrong commit hash to format-patch.

On Wed, May 20, 2020 at 11:29:32AM +0200, Oleksij Rempel wrote:
> changes v7:
> - VT7: reorder node alphabetically
> - VT7: rename "reg_12v_bl: regulator-bl-12v" to "reg_bl_12v0: regulator-b=
l-12v0"
> - VT7: remove panel and TS nodes. This drivers are currently not
>   mainline.
> - prti6q.dtsi: move reg_1v8 to prti6q.dts
> - prti6q.dtsi: remove pinctrl from the can1 node. It is done on almost
>   every board file.
>=20
> changes v6:
> - move fsl.yaml changes to separate patch
> - remove partitions, they are provided by the bootloader
> - update flash compatible
> - rename can3 to can
> - fix fsl,mode
> - fix interrupt in the wlan node on PRTI6Q
>=20
> changes v5:
> - PRTI6Q: remove status from the pwm-backlight node
> - drop the vendor-prefixes patch, it is already taken by Rob
> - add Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> changes v4:
> - VT7: fix typo
>=20
> changes v3:
> - move compatible to the start of node
> - move status to the end
> - use generic names in compatible
> - refactor dts/dtsi
> - use alphabet order for pinctrl and phandels
> - remove unused or currently not supported nodes
>=20
> changes v2:
> - squash PRTI6Q patches
>=20
> Oleksij Rempel (5):
>   ARM: dts: add Protonic PRTI6Q board
>   ARM: dts: add Protonic WD2 board
>   ARM: dts: add Protonic VT7 board
>   ARM: dts: add Protonic RVT board
>   dt-bindings: arm: fsl: add different Protonic boards
>=20
>  .../devicetree/bindings/arm/fsl.yaml          |   4 +
>  arch/arm/boot/dts/Makefile                    |   4 +
>  arch/arm/boot/dts/imx6dl-prtrvt.dts           | 182 ++++++
>  arch/arm/boot/dts/imx6dl-prtvt7.dts           | 472 ++++++++++++++++
>  arch/arm/boot/dts/imx6q-prti6q.dts            | 529 ++++++++++++++++++
>  arch/arm/boot/dts/imx6q-prtwd2.dts            | 188 +++++++
>  arch/arm/boot/dts/imx6qdl-prti6q.dtsi         | 174 ++++++
>  7 files changed, 1553 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi
>=20
> --=20
> 2.26.2
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--rtjclzefu7dbfjwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7FSpgACgkQ4omh9DUa
UbPNBBAAgrOuGaQL3A6w7l6/WjkgEYXtLUlTmqnvmGT93ref/kOZCGB6euAiNOhF
1JORufLhqt3fpT3j0x1RZ0gPzahQr3iVSDVHe0zvFJMVPlzeYDEG+qVq4ozDanSL
LIA6H9D/IWnLNF0C7Z2ho9fyymgRguyjUwUQZCqiNnfbOMLOJbf2HUvTMoF2nLES
NTSHPHTQa7qBLpxsu7XRPHbXPqwDsnfSYzbRxcvE0hu2YGk7Jsz+4NZXoVd7XXS2
cQIkSp9Su2Uh0qnTB/UGm/PeKgqqt1cHypIhoISSkjjyzlAtG+RciEpA1lbDgeBC
mP0ga3d/we+PU98hShT1ElK7GJyXSjTqeXsumgibl1d7NnwZuHFtDHgzq0vj+Yfh
pWWmpG2uteAgf41u0k0ezn9B9c9a2VetaHRlHPyUlsp8GYEremqG/X81fL+uIslM
4Y22irZ7JzuOpI6E8s/fS0UUPJmJikPhUlpaboylRoIAH5B78kOI+H0PpdnicMXi
ioLyL82aJyNgkPrvVSSdZivxeQ69ShpDKTbUmGlSii9kMgfzZtiMtCebaIg7gE+A
gB7ikUefVpFUcHupR52vdcnutB8HmZFfZDDxWGaKRPK7p2DP02aJ8eQpnpZVTNAI
mj85FrbM1whU+KiK5xU+cRsQWglHs5nDXElkVtQ36HOK56IyATg=
=MQg1
-----END PGP SIGNATURE-----

--rtjclzefu7dbfjwq--
