Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50605C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3540820714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgG0GXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgG0GXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:23:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84773C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:23:43 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwXw-0002of-IK; Mon, 27 Jul 2020 08:23:36 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwXv-0003o8-V4; Mon, 27 Jul 2020 08:23:35 +0200
Date:   Mon, 27 Jul 2020 08:23:35 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Message-ID: <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6tzlik4lnidne2ag"
Content-Disposition: inline
In-Reply-To: <20200724080813.24884-4-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:19:20 up 254 days, 21:37, 239 users,  load average: 0.12, 0.04,
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


--6tzlik4lnidne2ag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 04:08:06PM +0800, Peng Fan wrote:
> We might need to map an region multiple times, becaue the region might
> be shared between remote processors, such i.MX8QM with dual M4 cores.
> So use devm_ioremap, not devm_ioremap_resource.

Can you please give an example of this kind of shared resources and
how they should be handled by two separate devices?

> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 3b3904ebac75..82594a800a1b 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -296,9 +296,10 @@ static int imx_rproc_addr_init(struct imx_rproc *pri=
v,
>  		if (b >=3D IMX7D_RPROC_MEM_MAX)
>  			break;
> =20
> -		priv->mem[b].cpu_addr =3D devm_ioremap_resource(&pdev->dev, &res);
> +		/* Not use resource version, because we might share region*/
> +		priv->mem[b].cpu_addr =3D devm_ioremap(&pdev->dev, res.start, resource=
_size(&res));
>  		if (IS_ERR(priv->mem[b].cpu_addr)) {
> -			dev_err(dev, "devm_ioremap_resource failed\n");
> +			dev_err(dev, "devm_ioremap %pR failed\n", &res);
>  			err =3D PTR_ERR(priv->mem[b].cpu_addr);
>  			return err;
>  		}
> --=20
> 2.16.4
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6tzlik4lnidne2ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8ectMACgkQ4omh9DUa
UbMnEw//ZgH40i5qUwwFDcMh8LHIrxrRN0O+VsFoBQ1duEG9Q84k0FJNjigGtOUJ
G7y0Dw8/ar+figjxswgcs/YpcQuR246wnR4eb8LLXKV3bvJ4mNdPjEbzzOnd6nMo
RMho0UsR8L2gryGDGHv1xn5eRN7xZiXwjw01bSDlJavcSIY6g6341RFRlNMLOs7d
z+2NnQGcGy6PVc/CFcR33+1HW10N6eGtbPthYVZIhQaDoA/imBgqXkUTxWoJJzi8
Ke3jbRP3XoDreV0+1NrK+7otk6JtXXWQQDnUtDhqZh+/iqJNoMcCkwYFORNqCCym
GQuhLHEnrACRXACj/QMZ2P7Jquh7e4YlDTafMtZCzqSMhRa5LDTF6M/NoInZPW+P
i8eZqtpNfqAIDehNJ1rXJOQ8q5Sb5JuhtuEUPz9yJ6huou6ArsyuRSY10rGm7S1B
WSmmpoXaPkj4qspjo0CJlajzojiVucyE1ta05xlmmMHw5dvo+Mr+LOFDQaHWYfip
8wNFRybYIZxlEsHX7Vwepxis5XUATKm7GEsApr/vaQTAaufO1FmZfgNa0VjfzPi1
ks6mi6HdCbzOl5n0ODyGuwO8FxJRSML7KJZlSWI878Bi8Es4UpOHoBNWb6UfMwYh
4h9kEgxFjcWK0Th5q6jpBtUSIGmAdjB+xsLwoonUz/r4Tcw1yIg=
=yeys
-----END PGP SIGNATURE-----

--6tzlik4lnidne2ag--
