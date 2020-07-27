Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A08C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC79820672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0Hyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgG0Hyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:54:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC37C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:54:45 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jzxy5-0004EB-Nm; Mon, 27 Jul 2020 09:54:41 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jzxy5-0008Pg-AP; Mon, 27 Jul 2020 09:54:41 +0200
Date:   Mon, 27 Jul 2020 09:54:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Message-ID: <20200727075441.lgscydoj3txupeay@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
 <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ndwcthydipkpuzsn"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:38:11 up 254 days, 22:56, 250 users,  load average: 0.02, 0.06,
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


--ndwcthydipkpuzsn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 06:44:32AM +0000, Peng Fan wrote:
> Hi Oleksij,
>=20
> > Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and ear=
ly
> > boot
> >=20
> > Hi,
> >=20
> > On Fri, Jul 24, 2020 at 04:08:03PM +0800, Peng Fan wrote:
> > > This patchset is to support i.MX8MQ/M coproc booted before linux.
> > > Since i.MX8MQ/M was not supported, several patches are needed to first
> > > support the platform, then support early boot case.
> > >
> > > I intended to included i.MX8QM/QXP, but that would introduce a large
> > > patchset, so not included. But the clk/syscon optional patch for
> > > i.MX8QM/QXP was still kept here to avoid rebase error.
> >=20
> > Thank you for your work.
> >=20
> > Can you please provide more information about big picture of this work.
> >=20
> > If I see it correctly, we have here support for i.MX8MM, which seems to=
 be
> > able to fully control Cortex M4 (enable CPU core, etc...).
>=20
> Yes.

In this case, I would recommend to mainline the i.MX8MM part
first/separately.

> >=20
> > And other case, where remoteproc is running on application processor and
> > can't or should not touch M4 (i.MX7ULP, i.MX8QM/QXP..). Since M4 provid=
es
> > some functionality, you are trying to reuse remoteproc framework to get
> > resource table present in ELF header and to dynamically load things. Fo=
r some
> > reasons this header provides more information then needed, so you are
> > changing the ELF parser in the kernel to workaround it.
>=20
> Not exactly.
>=20
> For i.MX8MM, we support two cases. M4 kicked by U-Boot, M4 kicked by Linu=
x remoteproc.
> For i.MX8QM/QXP, the typical usecase is M4 kicked by SCFW, but we will al=
so add M4 kicked
> by Linux remoteproc.
> For i.MX7ULP, I would only support M4 dual boot case, M4 control everythi=
ng.

=46rom current state of discussion, i'm not sure what role plays
remoteproc in the scenario where M4 is started before linux. Especially
if we are not using resource table.

> The reason the change the elf parser is that when M4 elf is loaded by Lin=
ux remoteproc,
> It use memset to clear area.

The use of memset, depends on ELF format. Fix/change the linker script
on your firmware and memset will be never called.

> However we use ioremap, memset on ARM64 will report
> crash to device nGnRE memory. And we could not use ioremap_wc to TCM area=
, since
> it could have data correctly written into TCM.

I have strong feeling, that we are talking about badly or not properly
formatted ELF binary. I would prefer to double check it, before we will
apply fixes on wrong place.

> Maintainer not wanna to drop memset in common code, and TI guys suggest
> add i.MX specific elf stuff. So I add elf handler in i.MX code.

I think, removing memset may damage current users of imx_rproc driver.
Since, like I said: the use of memset depends on ELF format.

> Thanks,
> Peng.
>=20
> >=20
> > Correct?
> >=20
> > > Peng Fan (10):
> > >   dt-bindings: remoteproc: imx_rproc: add i.MX8MQ/M
> > >   remoteproc: imx_rproc: correct err message
> > >   remoteproc: imx: use devm_ioremap
> > >   remoteproc: imx_rproc: make syscon optional
> > >   remoteproc: imx_rproc: make clk optional
> > >   remoteproc: imx_rproc: add load hook
> > >   remoteproc: imx_rproc: add i.MX specific parse fw hook
> > >   remoteproc: imx_rproc: support i.MX8MQ/M
> > >   remoteproc: imx_proc: enable virtio/mailbox
> > >   remoteproc: imx_rproc: support coproc booting before Linux
> > >
> > >  .../devicetree/bindings/remoteproc/imx-rproc.txt   |   3 +
> > >  drivers/remoteproc/imx_rproc.c                     | 409
> > ++++++++++++++++++++-
> > >  2 files changed, 401 insertions(+), 11 deletions(-)
> > >
> > > --
> > > 2.16.4
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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

--ndwcthydipkpuzsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8eiDwACgkQ4omh9DUa
UbPVKw//RiwTubWT5hjSS95taFOhrjklnCkKnNdNrx15w38fSGf1Gly5UtAfKTRo
7svoNWtbHzPDT5TILc/NQpP2C86ug3kuhLRzwzppP2DB217lFIzqwRWZ1QBYbYko
Ho8u4nHgR/++MiZs3KwgeJvlvKhISpvTxNKR1wmXj8MPw4lD6Vrq1L2GdKMiiaOb
x1bziy2+IEp+/ntohTvvjrUHjD7mcTEW25LPgP28cgED1mnJJX+IRKJnymBCTQi9
w+MHTgAGOPXkHeho3BFhg7S8T+Wj9JeiVewLOpryzosw96gGYmkRXE+QW75iIJRu
L4+2b1wrb5O3VpuhK7oVxpQe5QhEYG1PIAizWNQSJV5jRbuN1Xct7i949d+a91FF
8dcE4xOqsGVhQ7+IMf+6HMOk0m/FXXmjBZzpOs++RTsQR/cPAuD2QTLWHuaETb4v
H6aRwgLZGDZzyBAyF6HnFYdZvLYY0XiINfi1b65+lSarCgaIrHWqPogNtsX8RGET
PngXCMQ85XF4Bi/TR6vj0ym1jEd4fPBIHPSS/nCzwfDC5pkUUCdzdpEOdVPSKxf0
YIStW+5krTiQwnp566EC4+fHH+pyzcV6W6BrpKrDsAwUk4KUIpyxr9I9eKkp8YVp
xzYl92mLOq0vkp1Mv4WZFpKaH3LTWYqq4AwbryvEhpM29g9XXjQ=
=Hp2H
-----END PGP SIGNATURE-----

--ndwcthydipkpuzsn--
