Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E58C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7239A20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgG0Gl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0Gl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:41:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCDC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:41:58 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwpc-0004bD-7k; Mon, 27 Jul 2020 08:41:52 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwpb-0004Pb-Lk; Mon, 27 Jul 2020 08:41:51 +0200
Date:   Mon, 27 Jul 2020 08:41:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Message-ID: <20200727064151.767kc7622tcqmqfs@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
 <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
 <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ed2z4r5eschfv4zu"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:39:25 up 254 days, 21:58, 240 users,  load average: 0.06, 0.05,
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


--ed2z4r5eschfv4zu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 06:28:20AM +0000, Peng Fan wrote:
> Hi Oleksij,
>=20
> > Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
> >=20
> > On Fri, Jul 24, 2020 at 04:08:06PM +0800, Peng Fan wrote:
> > > We might need to map an region multiple times, becaue the region might
> > > be shared between remote processors, such i.MX8QM with dual M4 cores.
> > > So use devm_ioremap, not devm_ioremap_resource.
> >=20
> > Can you please give an example of this kind of shared resources and how=
 they
> > should be handled by two separate devices?
>=20
> This is to share vdevbuffer space, there is a vdevbuffer in device tree, =
it will be
> shared between M4_0 and M4_1.
>
> For the buffer, it is Linux DMA API will handle the space.

Why remoteproc need to care about it? If I see it correctly, from the
linux perspective, it is one buffer and one driver is responsible for
it. Or do I missing some thing?

> Thanks,
> Peng.
>=20
> >=20
> > > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 3b3904ebac75..82594a800a1b
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -296,9 +296,10 @@ static int imx_rproc_addr_init(struct imx_rproc
> > *priv,
> > >  		if (b >=3D IMX7D_RPROC_MEM_MAX)
> > >  			break;
> > >
> > > -		priv->mem[b].cpu_addr =3D devm_ioremap_resource(&pdev->dev,
> > &res);
> > > +		/* Not use resource version, because we might share region*/
> > > +		priv->mem[b].cpu_addr =3D devm_ioremap(&pdev->dev, res.start,
> > > +resource_size(&res));
> > >  		if (IS_ERR(priv->mem[b].cpu_addr)) {
> > > -			dev_err(dev, "devm_ioremap_resource failed\n");
> > > +			dev_err(dev, "devm_ioremap %pR failed\n", &res);
> > >  			err =3D PTR_ERR(priv->mem[b].cpu_addr);
> > >  			return err;
> > >  		}
> > > --
> > > 2.16.4
> > >
> > >
> >=20
> > --
> > Pengutronix e.K.                           |
> > |
> > Steuerwalder Str. 21                       |
> > http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone:
> > +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> > +49-5121-206917-5555 |

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ed2z4r5eschfv4zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8edy4ACgkQ4omh9DUa
UbOGUxAAugZ5OEb3oSGGEqKi5nPzYX8UehUn3dyEuiqqEyZh0TOHjLqGr51FA/SL
PRGYI1LDhOp66XgIbpV/rpqn98nqWoJnViWw+sLBjerJVUKIhF8ZKJuRdSWuVlU7
bD4aozS2xlXDISMGt3COIJgrTDQWkrGY202lKGWFvysBW30YCOkzsaGbnuSxz54j
dbSy/2lWx+CnMa24NWFMcw4HIj9DBJuTu5IoPGY4couKomVORa9PbZOx4GTQUgqR
mOYpaKkjlmYphf9V9Edwv7zq7eIvF00rLEI7WDVlv7wAu7kZ8ED3N+qpIFkt29Vq
P/2ePfTx41d3DnSupyZufVNW5ZpIbSjdU/OzpfRXrkbORMx4X4Dc6PewCrELlKqz
ZXn/eFcDV/+Lx1yhz6uw+Zvj96sB82kIIo0GWt5hst206wtzAgS/Nk5ydvcwpsQp
5Ga9DdEPGQqB5q+Xbcourm+B3mVvUqKwKbHzDaDJt0TLuwBoVHW3WctAjNkOs68H
eu34/WLo+wxVTh8rMqwf20aDziv/KLAbznAL53fzsoezQ8945vg+EyX3KBKnzlJY
nlK76lOo1zxdbK2IkfhR7fqH3WBkhk9rXjZkVeixr6S8lD0wkfoi4QHGyCXJfi4k
2OKmdgCZvB6gwOSJ1Gl6ad/yrFUuAFC8YjeQ/SshyOhsVd2K5D0=
=xXOi
-----END PGP SIGNATURE-----

--ed2z4r5eschfv4zu--
