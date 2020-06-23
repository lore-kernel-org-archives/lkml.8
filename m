Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8727C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0120738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592901255;
	bh=xhJyNgexKUtQqsTRLYLgxO9uWTnpO1SU0yUZ5LR0Wo4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=C2CnmmyUVd5L6eG4Y9H9MJyF3CYRD8UnRYisLyE5max2l08yYVjcx4Bj5B88vYJUL
	 QRL50ioM61/HX1naI/4GboBf6Ln9CB7XH+VX9DqUqbvrGt56GeIkDF67dsYrvAc3SW
	 AQvC59zcSkKYSEmFs9ANHnBTGdaK6HJi1bTMBUT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgFWIeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbgFWIeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:34:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17032072E;
        Tue, 23 Jun 2020 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592901252;
        bh=xhJyNgexKUtQqsTRLYLgxO9uWTnpO1SU0yUZ5LR0Wo4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ks2iMxwjVDQaF6CrIGCOP56jLcSr3LgtnkdgSdDDO3INAZiCMtFiB9G+H2pjdqVM9
         ne5m50sMrW5MA+Hy1L3pWaNWHCebIUoPgDYXFJsd1dKm4PAPsjsOEJ6Al8b4Fmv4jG
         qiApvojFQ5MSp+dEZ3JOBZcz0UBhYVjP0s6GNScY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com> <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com> <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com> <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com> <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>, allison@lohutok.net,
        arnd@arndb.de, festevam@gmail.com, gregkh@linuxfoundation.org,
        info@metux.net, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, oleksandr.suvorov@toradex.com,
        s.hauer@pengutronix.de, sfr@canb.auug.org.au, shawnguo@kernel.org,
        tglx@linutronix.de, yuehaibing@huawei.com
Date:   Tue, 23 Jun 2020 01:34:12 -0700
Message-ID: <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2020-06-22 20:42:19)
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: Saturday, June 20, 2020 11:28 AM
> > Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver=
 as
> > module
> >=20
> > Quoting Aisheng Dong (2020-06-17 18:58:51)
> > > > From: Anson Huang <anson.huang@nxp.com>
> > > > > > +obj-$(CONFIG_MXC_CLK_SCU) +=3D mxc-clk-scu.o
> > > > >
> > > > > Like i.MX pinctrl, I'm not sure if it's really necessary to build
> > > > > core libraries as modules. Probably the simplest way is only
> > > > > building platform drivers part as module. And leave those core li=
braries
> > built in kernel.
> > > > > This may make the code a bit cleaner.
> > > > >
> > > >
> > > > Will discuss this with Linaro guys about it, previous requirement I
> > > > received is all SoC specific modules need to be built as module.
> > > >
> > >
> > > Okay. AFAIK it's not conflict.
> > > You still make drivers into modules.
> > > Only difference is for those common libraries part, we don't convert
> > > them into module Which is less meaningless.
> > >
> >=20
> > What is the benefit of making the core part of the SoC driver not a mod=
ule?
>=20
> Usually we could try to build it as module if it's not hard.
>=20
> One question is sometimes those core part are shared with some platforms =
which can't built as module.
> For i.MX case, it's mainly patch 4:
> [V2,4/9] clk: imx: Support building i.MX common clock driver as module
> https://patchwork.kernel.org/patch/11594801/
>=20
> Those libraries are also used by i.MX6&7 which can't build as module.
> So we need an extra workaround patch to forcely 'select' it under arch/ar=
m/mach-imx/Kconfig
> [V2,2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
> https://patchwork.kernel.org/patch/11594793/
> Then the users can't configure it as module in order to not break build.
>=20
> If build-in those common libraries, the implementation could be a bit eas=
ier and cleaner.
> So I'm not sure if we still have to build them as module.
> How would you suggest for such case?

Stop using 'select MXC_CLK' when requiring the core library code?
Instead, make it a 'depends' and then that will make depending modules
(i.e. the SoC files) that want to be builtin force the core module to be
builtin too. Other modular configs that depend on the core will still be
modular.=20

I don't know why an architecture is selecting the clk code at all to be
honest. That can be moved to the defconfig instead of in the
architecture Kconfig and then you don't get a working system unless you
select the MXC_CLK config from the configurator tool (menuconfig,
nconfig, etc.) So ARCH_MXC shouldn't be in this discussion and the core
module should be selectable by the configurator and that should be
tristate and all SoC modules should depend on that core library module
and be selectable too and those Kconfigs can be tristate or bool.
