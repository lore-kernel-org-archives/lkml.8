Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E99C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085B82177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgG1Hzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG1Hzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:55:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0373C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:55:51 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1k0KSi-0000xu-DU; Tue, 28 Jul 2020 09:55:48 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1k0KSi-0005rg-0A; Tue, 28 Jul 2020 09:55:48 +0200
Date:   Tue, 28 Jul 2020 09:55:47 +0200
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
Message-ID: <20200728075547.u7bk22xnmu5jjpoo@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
 <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727075441.lgscydoj3txupeay@pengutronix.de>
 <DB6PR0402MB27605640244CE751317E6DE888720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200728072651.zcflghll4wa7rm55@pengutronix.de>
 <DB6PR0402MB27603441BEE037ECCB3F021088730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zr56xg4gghcrtcpk"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27603441BEE037ECCB3F021088730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:54:57 up 255 days, 23:13, 251 users,  load average: 0.05, 0.08,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zr56xg4gghcrtcpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 07:50:04AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and ear=
ly
> > boot
> >=20
> > On Mon, Jul 27, 2020 at 09:18:31AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and
> > > > early boot
> > > >
> > > > On Mon, Jul 27, 2020 at 06:44:32AM +0000, Peng Fan wrote:
> > > > > Hi Oleksij,
> > > > >
> > > > > > Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M
> > > > > > and early boot
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Fri, Jul 24, 2020 at 04:08:03PM +0800, Peng Fan wrote:
> > > > > > > This patchset is to support i.MX8MQ/M coproc booted before li=
nux.
> > > > > > > Since i.MX8MQ/M was not supported, several patches are needed
> > > > > > > to first support the platform, then support early boot case.
> > > > > > >
> > > > > > > I intended to included i.MX8QM/QXP, but that would introduce a
> > > > > > > large patchset, so not included. But the clk/syscon optional
> > > > > > > patch for i.MX8QM/QXP was still kept here to avoid rebase err=
or.
> > > > > >
> > > > > > Thank you for your work.
> > > > > >
> > > > > > Can you please provide more information about big picture of th=
is
> > work.
> > > > > >
> > > > > > If I see it correctly, we have here support for i.MX8MM, which
> > > > > > seems to be able to fully control Cortex M4 (enable CPU core, e=
tc...).
> > > > >
> > > > > Yes.
> > > >
> > > > In this case, I would recommend to mainline the i.MX8MM part
> > > > first/separately.
> > >
> > > Only the last patch is to support earlyboot, all others is imx8mm par=
t.
> >=20
> > ok
> >=20
> > > >
> > > > > >
> > > > > > And other case, where remoteproc is running on application
> > > > > > processor and can't or should not touch M4 (i.MX7ULP,
> > > > > > i.MX8QM/QXP..). Since M4 provides some functionality, you are
> > > > > > trying to reuse remoteproc framework to get resource table
> > > > > > present in ELF header and to dynamically load things. For some
> > > > > > reasons this header provides more information then needed, so
> > > > > > you are changing the ELF parser in the kernel
> > > > to workaround it.
> > > > >
> > > > > Not exactly.
> > > > >
> > > > > For i.MX8MM, we support two cases. M4 kicked by U-Boot, M4 kicked
> > > > > by
> > > > Linux remoteproc.
> > > > > For i.MX8QM/QXP, the typical usecase is M4 kicked by SCFW, but we
> > > > > will also add M4 kicked by Linux remoteproc.
> > > > > For i.MX7ULP, I would only support M4 dual boot case, M4 control
> > > > everything.
> > > >
> > > > From current state of discussion, i'm not sure what role plays
> > > > remoteproc in the scenario where M4 is started before linux.
> > > > Especially if we are not using resource table.
> > >
> > > We are using resource table from an address, not in elf file.
> > > This is the new feature in Linux-next to support coproc booted early.
> > >
> > > >
> > > > > The reason the change the elf parser is that when M4 elf is loaded
> > > > > by Linux remoteproc, It use memset to clear area.
> > > >
> > > > The use of memset, depends on ELF format. Fix/change the linker
> > > > script on your firmware and memset will be never called.
> > > >
> > > > > However we use ioremap, memset on ARM64 will report crash to
> > > > > device nGnRE memory. And we could not use ioremap_wc to TCM area,
> > > > > since it could have data correctly written into TCM.
> > > >
> > > > I have strong feeling, that we are talking about badly or not
> > > > properly formatted ELF binary. I would prefer to double check it,
> > > > before we will apply fixes on wrong place.
> > > >
> > > > > Maintainer not wanna to drop memset in common code, and TI guys
> > > > > suggest add i.MX specific elf stuff. So I add elf handler in i.MX=
 code.
> > > >
> > > > I think, removing memset may damage current users of imx_rproc driv=
er.
> > > > Since, like I said: the use of memset depends on ELF format.
> > >
> > > In my elf file, the last PT_LOAD contains data/bss/heap/stack. I'll
> > > check with our MCU guys, we only need the specific data loaded.
> > >
> > > Elf file type is EXEC (Executable file) Entry point 0x1ffe0355 There
> > > are 3 program headers, starting at offset 52
> > >
> > > Program Headers:
> > >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz
> > Flg Align
> > >   LOAD           0x010000 0x1ffe0000 0x1ffe0000 0x00240 0x00240
> > R   0x10000
> > >   LOAD           0x010240 0x1ffe0240 0x1ffe0240 0x03e90 0x03e90
> > RWE 0x10000
> > >   LOAD           0x020000 0x20000000 0x1ffe40d0 0x00068 0x0ad00
> > RW  0x10000
> > >
> > >  Section to Segment mapping:
> > >   Segment Sections...
> > >    00     .interrupts
> > >    01     .resource_table .text .ARM .init_array .fini_array
> > >    02     .data .bss .heap .stack
> >=20
> > Here is an example of formatting ELF for remoteproc:
> > https://git.pengutronix.de/cgit/ore/OSELAS.BSP-Pengutronix-DualKit/tree=
/loc
> > al_src/remoteproc-elf/linker.ld
> > https://git.pengutronix.de/cgit/ore/OSELAS.BSP-Pengutronix-DualKit/tree=
/loc
> > al_src/remoteproc-elf/imx7m4.S
> >=20
> > In this example I pack linux in to remoteproc elf image and start linux=
 on
> > imx7d-m4 part.
> > Will be interesting if you can do the same on imx8* SoCs ;)
>=20
> In NXP release, the m4 elf files have data/bss/heap/stack in the same
> data area, so the linker merged them into one segment and cause
> memsz > filesz.
>=20
> I think I need to propose platform specific elf memset/memcpy,
> such as rproc_elf_memcpy, rproc_elf_memset,
>=20
> To i.MX, need use memset_io and memcpy_toio, taking TCM
> as device memory.
>=20
> Note: memset without io will cause abort when memsz>filesz.
> So use memset_io is safe.

Sounds good, i would prefer this way.

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--zr56xg4gghcrtcpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8f2f8ACgkQ4omh9DUa
UbMiRA/9EtUGM3624lRjzYAxczQgqe2vYquaps9/MyZarnC3pL9V01Pu+vor7ac1
WZRycoYC8kzhKuCLKykSaLda/Z7W/MUZ4kL4C7powYrPpxaRVh5cSIT/baYicR9F
PNnJkSJrJ35bIYqg7aCGHmzcymZi1q8mJGQ4bycgDjgGwC7c3bbpUYhisWnLaHYt
DdzR5G9XZ77mXq0pbHa5E9dodRVsTWzy78hHpt6ChR/AKDbQ0iNczdBUDdsUcZE/
7itAkxsh8l0qBJHchBjmRh4J5W7a85zGte/DG5LKPbzkuIYHXGXCz2D1BLwiJibW
WpwwU18J1ok7byCUZ3kOw0aanB4IQjpbuzL9YWRYi8Z4sIhLonuZred84I7FiKYq
2YJ/pJZBdaSLRPlfly2KhoBB6bW0OKpsFY+dUuTMfyI6M3MEZLKUA3aElAC3epYA
lVHEmiWo4amVELR5okS/XjyHVf/UuZ+KrTZZilI6hN8NU0n6YGWn6te2p26XryCo
6all/0DGfnFsGhbEnwd+y/+8y7dSTC9yLWoaSWgql4Qyu2Ol2k8x+VOxyW17vt5D
99n+noDbdCNjtmL6FZ/zXi8qEXITdMXvJ3UxzVy1aa5DxXCsOqNUtUykK/jKQiTq
bPa8jhymbYw6x/pOXa/HyxmMa4jvlkuQURaDgmaIhgnifwfT+iY=
=MHWV
-----END PGP SIGNATURE-----

--zr56xg4gghcrtcpk--
