Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A1FC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BC52065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgG1HUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgG1HUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:20:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC115C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:20:13 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1k0JuB-00052U-BM; Tue, 28 Jul 2020 09:20:07 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1k0JuA-0004oF-Cm; Tue, 28 Jul 2020 09:20:06 +0200
Date:   Tue, 28 Jul 2020 09:20:06 +0200
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
Message-ID: <20200728072006.6lqia5gssfepnpbq@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
 <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
 <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727064151.767kc7622tcqmqfs@pengutronix.de>
 <DB6PR0402MB276063FBE74FCF222CB00F8588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727073757.r2vq6djh3a4dyfp6@pengutronix.de>
 <DB6PR0402MB2760EFCB8C91680DC719C82C88720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5eqgdj3pjiydqz6"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760EFCB8C91680DC719C82C88720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:17:41 up 255 days, 22:36, 251 users,  load average: 0.03, 0.06,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5eqgdj3pjiydqz6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 08:11:09AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
> >=20
> > On Mon, Jul 27, 2020 at 06:51:00AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
> > > >
> > > > On Mon, Jul 27, 2020 at 06:28:20AM +0000, Peng Fan wrote:
> > > > > Hi Oleksij,
> > > > >
> > > > > > Subject: Re: [PATCH 03/10] remoteproc: imx: use devm_ioremap
> > > > > >
> > > > > > On Fri, Jul 24, 2020 at 04:08:06PM +0800, Peng Fan wrote:
> > > > > > > We might need to map an region multiple times, becaue the
> > > > > > > region might be shared between remote processors, such i.MX8QM
> > > > > > > with dual
> > > > M4 cores.
> > > > > > > So use devm_ioremap, not devm_ioremap_resource.
> > > > > >
> > > > > > Can you please give an example of this kind of shared resources
> > > > > > and how they should be handled by two separate devices?
> > > > >
> > > > > This is to share vdevbuffer space, there is a vdevbuffer in device
> > > > > tree, it will be shared between M4_0 and M4_1.
> > > > >
> > > > > For the buffer, it is Linux DMA API will handle the space.
> > > >
> > > > Why remoteproc need to care about it? If I see it correctly, from
> > > > the linux perspective, it is one buffer and one driver is
> > > > responsible for it. Or do I missing some thing?
> > >
> > > We not have the vdev buffer in resource table, so I added in device t=
ree, see
> > below:
> >=20
> > Hm.. if vdev is not in resource table and should not be controlled by
> > remoteproc, why do we need remoteproc?
>=20
> I use same approach as stm32 rproc driver.
>=20
> The resource table here only publish vring address.
>=20
> >=20
> > >         imx8qm_cm40: imx8qm_cm4@0 {
> > >                 compatible =3D "fsl,imx8qm-cm4";
> > >                 rsc-da =3D <0x90000000>;
> > >                 mbox-names =3D "tx", "rx", "rxdb";
> > >                 mboxes =3D <&lsio_mu5 0 1
> > >                           &lsio_mu5 1 1
> > >                           &lsio_mu5 3 1>;
> > >                 mub-partition =3D <3>;
> > >                 memory-region =3D <&vdev0vring0>, <&vdev0vring1>,
> > <&vdevbuffer>,
> > >                                 <&vdev1vring0>, <&vdev1vring1>;
> > >                 core-index =3D <0>;
> > >                 core-id =3D <IMX_SC_R_M4_0_PID0>;
> > >                 status =3D "okay";
> > >                 power-domains =3D <&pd IMX_SC_R_M4_0_PID0>,
> > >                                 <&pd IMX_SC_R_M4_0_MU_1A>;
> > >         };
> > >
> > >         imx8qm_cm41: imx8x_cm4@1 {
> > >                 compatible =3D "fsl,imx8qm-cm4";
> > >                 rsc-da =3D <0x90100000>;
> > >                 mbox-names =3D "tx", "rx", "rxdb";
> > >                 mboxes =3D <&lsio_mu6 0 1
> > >                           &lsio_mu6 1 1
> > >                           &lsio_mu6 3 1>;
> > >                 mub-partition =3D <4>;
> > >                 memory-region =3D <&vdev2vring0>, <&vdev2vring1>,
> > <&vdevbuffer>,
> > >                                 <&vdev3vring0>, <&vdev3vring1>;
> > >                 core-index =3D <1>;
> > >                 core-id =3D <IMX_SC_R_M4_1_PID0>;
> > >                 status =3D "okay";
> > >                 power-domains =3D <&pd IMX_SC_R_M4_1_PID0>,
> > >                                 <&pd IMX_SC_R_M4_1_MU_1A>;
> > >         };
> > >
> > >                 vdevbuffer: vdevbuffer {
> > >                         compatible =3D "shared-dma-pool";
> > >                         reg =3D <0 0x90400000 0 0x100000>;
> > >                         no-map;
> > >                 };
> > >
> > > I have the upper vdevbuffer node shared between M40 and M41 node.
> > > The vdevbuffer will be used as virtio data buffer.
> > >
> > > And I have the following in rproc_add_virtio_dev to share vdevbuffer:
> > >         /* Try to find dedicated vdev buffer carveout */
> > >         mem =3D rproc_find_carveout_by_name(rproc, "vdev%dbuffer",
> > rvdev->index);
> > >         if (!mem)
> > >                 mem =3D rproc_find_carveout_by_name(rproc,
> > > "vdevbuffer");
> >=20
> > With kernel v5.8-rc7 i get following call chain:
>=20
> Please use Linux-next which has support of M4 booted before Linux in
> in remoteproc.
>=20
> > rproc_boot()
> >   rproc_fw_boot()
> >     rproc_handle_vdev
> >       rproc_vdev_do_start()
> >         rproc_add_virtio_dev()
> >=20
> >=20
> > So, at the end, we will call rproc_add_virtio_dev() only if we boot fir=
mware by
> > linux, or if we get at least the resource table.
>=20
>=20
> Resource table could be got from elf file if it is booted by Linux, or go=
t from
> an address if M4 is booted before Linux.

Ok, i see now. Thank you!

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--i5eqgdj3pjiydqz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8f0aEACgkQ4omh9DUa
UbPAsQ//XBoFlYduiR5diPTVmdX6G5+l7hpLt+H0SBighq2rejKsHq/dH8w/MHT1
OBlB8JEZJgJIY3VzYIvBwYs9M5qGYYQfLymZVORDi59RDuyYkBDI0LeIBVCxfSxb
JnmOEXly2nGD/cVRQB2O2NLBCpE1SFiZ/LbQ21DCzm40gfaXFkO7/bxgpMz1r/XY
Whr7fb3772f4NGOYOTRVUj7n5+jp48yFRoCwEnjeTC/fZ7Jpi1YzJpmfdFq5Hzjt
9ZRhHITjac2FcicZjJ5Ac92JZvt7lII1tFhh7UGxt7tnkS1mOglehuhynst5RoGk
NbrzCgozsbJenU6vfdgcsMFHO49Mjj1EP+hITKDClQVbImEgdU4ZmhW4sRY1cAO7
3FeG9ZH7ru60PnEUR/SUt4e3dIAcGr4vjLdtY0kODpkfgyvYJfrssCzJIkCuboO2
Xn7DWtoANixGZpr8g00VcBgEQL+zfEUrGcHS8pEIH/P9jippTsYnP7bX3EEDIkJR
qwqQ/UUyiZ9yGGX2z/ShdUplEho9HaSz0DXl/C64kMikQAROAy/B+bk/Vs0rCgEY
ESq82Ghy5FBdakZouPA1DfYvWmRTgolIiFALkZT/X1RyaVPjvf5vNG7Ceyb7upn3
uB5KZu1T1i99l44Ff5yZR5/+hYp+YuO4CLaGYlNoXrtBIlH0iwU=
=q0i1
-----END PGP SIGNATURE-----

--i5eqgdj3pjiydqz6--
