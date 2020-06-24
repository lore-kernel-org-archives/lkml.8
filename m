Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AE020C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593038584;
	bh=2qOOeWqSin4Sk3mrQE3OE4Gaj5+C3lnfNsT9FLEUq/E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=LJgj8A2GuH4N8vm3MAQI1z0/Yz2BSrbUngJAz/eEffaOdbT3jQS1WzC7P8JetqvGb
	 QmL56aqOUfXnAIv04RKJyAnaXCXN8lz8dITWPH9vbap4lNaSuRYjOJ1KmxlIMMqkdV
	 2uIagQVcY1qVUHiQQiYZSSB961R6o1vmPWyWNQkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbgFXWnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388739AbgFXWnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:43:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5525B2065D;
        Wed, 24 Jun 2020 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593038581;
        bh=2qOOeWqSin4Sk3mrQE3OE4Gaj5+C3lnfNsT9FLEUq/E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OBWcVFZPJiUQ9b5nibHZITiKfn6+sO64TqaXwuDA90blUrv/FDKp3H6wMBuulQUWz
         4Q1WxhUQXtHBL8N+ymTa4sHwjQAtVXp89l1zDRjWXmK9hyKAQf5Tp/KEqBh/kPd587
         TJzapj4PsMh1XZg10Onm+pWiLhUxEFGacnQZDyzA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com> <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com> <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com> <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com> <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com> <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com> <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com> <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com> <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
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
Date:   Wed, 24 Jun 2020 15:43:00 -0700
Message-ID: <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2020-06-23 19:59:09)
> > > > > -       bool
> > > > > -       def_bool ARCH_MXC
> > > > > +       tristate "IMX clock"
> > > > > +       depends on ARCH_MXC
> > > > >
> > > > > But user can still set MXC_CLK to be m, either via make menuconfig
> > > > > or
> > > > defconfig.
> > > >
> > > > Isn't that what we want?
> > >
> > > No, if user set MXC_CLK to m, the build will break for i.MX6&7.
> > >
> > > > Why does ARCH_MXC being enabled mandate that it is builtin? Is some
> > > > architecture level code calling into the clk driver?
> > >
> > >
> > > It's mainly because there's no Kconfig options for i.MX6 &7 clock dri=
vers.
> > > It just reuses ARCH config CONFIG_SOC_XXX which can only be y.
> > > e.g.
> > > obj-$(CONFIG_SOC_IMX6Q)  +=3D clk-imx6q.o
> > > obj-$(CONFIG_SOC_IMX6SL) +=3D clk-imx6sl.o
> > > obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
> > > obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o ..
> > >
> > > If setting MXC_CLK to m, the platform clock drivers will fail to build
> > > due to miss to find symbols defined in the common clock library by
> > > CONFIG_MXC_CLK.
> > > So we have to avoid users to be able to config MXC_CLK to m for i.MX6=
&7.
> > > Only depends on ARCH_MXC mean user still can set it to m.
> >=20
> > I think for i.MX6/7, although MXC_CLK is tristate, but it is selected by
> > ARCH_MXC which is always "y", so MXC_CLK can ONLY be "y" even it is exp=
licitly
> > set to "m" in imx_v6_v7_defconfig file. So that means MXC_CLK can ONLY
> > support built-in for i.MX6/7 SoCs, and that is what we want?
> >=20
>=20
> Yes, I'm trying to explain to Stephen why we have to select MXC_CLK in AR=
CH_MXC
> And what issues we will met if not select it.
>=20

Why aren't there options to enable clk-imx6q and clk-imx6sl in the
clk/imx/Kconfig file? Those can be bool or tristate depending on if the
SoC drivers use CLK_OF_DECLARE or not and depend on the mxc-clk library
and SoC config we have in the makefile today.
