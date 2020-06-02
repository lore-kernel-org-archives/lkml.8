Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF02C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A388220772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBFZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFBFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:25:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF901C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:25:02 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jfzPu-0002KI-09; Tue, 02 Jun 2020 07:24:50 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jfzPs-0002Lz-VZ; Tue, 02 Jun 2020 07:24:48 +0200
Date:   Tue, 2 Jun 2020 07:24:48 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Message-ID: <20200602052448.fxepmwltc4465q4i@pengutronix.de>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c2h6m5xrkl3f4s3k"
Content-Disposition: inline
In-Reply-To: <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:18:57 up 199 days, 20:37, 185 users,  load average: 0.07, 0.08,
 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2h6m5xrkl3f4s3k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 04:20:00PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX8MQ/M/N/P compatible string to support i.MX8M SoCs
>=20
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Docum=
entation/devicetree/bindings/mailbox/fsl,mu.txt
> index 26b7a88c2fea..906377acf2cd 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -18,7 +18,8 @@ Messaging Unit Device Node:
>  Required properties:
>  -------------------
>  - compatible :	should be "fsl,<chip>-mu", the supported chips include
> -		imx6sx, imx7s, imx8qxp, imx8qm.
> +		imx6sx, imx7s, imx8qxp, imx8qm, imx8mq, imx8mm, imx8mn,
> +		imx8mp.
>  		The "fsl,imx6sx-mu" compatible is seen as generic and should
>  		be included together with SoC specific compatible.
>  		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
> --=20
> 2.16.4
>=20
>=20

Hi Peng,

The fsl,mu.yaml was already taken by Rob, so one or other patch will
break by merge. I assume you should drop this change.


Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--c2h6m5xrkl3f4s3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7V4pgACgkQ4omh9DUa
UbObbg//WhWLqmjlyeR0A0GCaFvcBoDzS1TBdruVqmmFsGcgHhnHeH3c3STzS8ig
cvnCfziAkNQLbRiqqPZO9J2n39SIX/Nps2JujTRTUldgKYK4/OTge15skrNTXQDD
R/J3a6HaqgFPDTjEMzgjOe/1MvMtJrao1Ej4sJ08BSkQICy/GOPzVGy7/VeSFF1g
3X6Z8lzHsU2BdS5IzTwQGEWVZ2JkEnK8qmyTHFL7HFjpNgh7CWwv34u2GAaeaC8/
HnpfPA1JI2WEHbv+fVxMZjx04cmbHXFclp2qPu8skAgcEJMB1+UelVUPuXDgvqlj
0kE2SgPeVtgX+IWWqaUbZh5f3baAUXu/I+miACCeLCV3SBcDJMDI7G5N4KV8mMu4
QzXzHXVSEshTKSNx8rj6v04TSycrD/F5zArIfy04dnkoWd9ZZuwDR2BzQziHQqUa
STPlogKn80dqho1oScRU0UtVTJtnk/SH8AgNatL+vJZbD4x4eW5ntE1LiU5oUfUR
VvbsdhCPduN2QvTv+cENBC6BzqONJMDumHgY/8RirvqvfL2zSFxKwtAu9q5ay56r
0Lkv2AQhn8d49EbEebxIPSM++gdUEw5usf/pbRT0J+YHPAviTZkhovjCAuPlli9D
VKZHRW2V7rsbv4BArG8SpKGFDuHLgFNDZvaI+aM0HqiGYrS/hbM=
=YyCu
-----END PGP SIGNATURE-----

--c2h6m5xrkl3f4s3k--
