Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B8520CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592960275;
	bh=AIcBjg5EduAc2hzc+ZZu4+NrFWBrKK0dKtZ4TiZI8hk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ca7DZwR9L+twB86lYdAUswtZ1bI4D910ETcaad2RkM/HLAiTIrqhc67//g1mtyMMW
	 bH9ZTnfUTw4PVN7XK9h/IB46GGP0N8+NMwgMfBgTNmf+vMey/79zBJFnY6bYbXkPYI
	 iBaIJ4IjgDcWTYPW4Dv4kzVFqImku0LmoNydkn/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbgFXA5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgFXA5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:57:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FFD20C09;
        Wed, 24 Jun 2020 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592960272;
        bh=AIcBjg5EduAc2hzc+ZZu4+NrFWBrKK0dKtZ4TiZI8hk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ex/rw0Q2yGMJJ5Y1Mb0WjrwmRbTpPIUqWA18wpXyjDd1XLi9vRJJ1RXY662WE/6se
         VajoedT+VunLFcfmjeGvY5QuUCQiV9JcIeXOpfOhXeM4ha4A8ZedfIoP8Hf/vp2ZWI
         96rwsceBn9b6QQuXvSTxtwM5blaJD4NO4J6mEQUA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com> <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com> <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com> <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com> <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com> <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com> <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
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
Date:   Tue, 23 Jun 2020 17:57:51 -0700
Message-ID: <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2020-06-23 02:00:47)
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: Tuesday, June 23, 2020 4:34 PM
> > Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver=
 as
> > module
> >=20
> > Quoting Aisheng Dong (2020-06-22 20:42:19)
> > > > From: Stephen Boyd <sboyd@kernel.org>
> > > > Sent: Saturday, June 20, 2020 11:28 AM
> > > > Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock
> > > > driver as module
> > > >
> > > > Quoting Aisheng Dong (2020-06-17 18:58:51)
> > > > > > From: Anson Huang <anson.huang@nxp.com>
> > > > > > > > +obj-$(CONFIG_MXC_CLK_SCU) +=3D mxc-clk-scu.o
> > > > > > >
> > > > > > > Like i.MX pinctrl, I'm not sure if it's really necessary to
> > > > > > > build core libraries as modules. Probably the simplest way is
> > > > > > > only building platform drivers part as module. And leave those
> > > > > > > core libraries
> > > > built in kernel.
> > > > > > > This may make the code a bit cleaner.
> > > > > > >
> > > > > >
> > > > > > Will discuss this with Linaro guys about it, previous
> > > > > > requirement I received is all SoC specific modules need to be b=
uilt as
> > module.
> > > > > >
> > > > >
> > > > > Okay. AFAIK it's not conflict.
> > > > > You still make drivers into modules.
> > > > > Only difference is for those common libraries part, we don't
> > > > > convert them into module Which is less meaningless.
> > > > >
> > > >
> > > > What is the benefit of making the core part of the SoC driver not a=
 module?
> > >
> > > Usually we could try to build it as module if it's not hard.
> > >
> > > One question is sometimes those core part are shared with some platfo=
rms
> > which can't built as module.
> > > For i.MX case, it's mainly patch 4:
> > > [V2,4/9] clk: imx: Support building i.MX common clock driver as module
> > >
> > >
> > > Those libraries are also used by i.MX6&7 which can't build as module.
> > > So we need an extra workaround patch to forcely 'select' it under
> > > arch/arm/mach-imx/Kconfig [V2,2/9] ARM: imx: Select MXC_CLK for
> > > ARCH_MXC
> > > Then the users can't configure it as module in order to not break bui=
ld.
> > >
> > > If build-in those common libraries, the implementation could be a bit=
 easier
> > and cleaner.
> > > So I'm not sure if we still have to build them as module.
> > > How would you suggest for such case?
> >=20
> > Stop using 'select MXC_CLK' when requiring the core library code?
> > Instead, make it a 'depends' and then that will make depending modules =
(i.e. the
> > SoC files) that want to be builtin force the core module to be builtin =
too. Other
> > modular configs that depend on the core will still be modular.
> >=20
>=20
> It seems not work.
> Patch 4 already changes it to depend on ARCH_MXC which can only be 'Y'.
> [V2,4/9] clk: imx: Support building i.MX common clock driver as module
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index ded0643..678113b 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -1,8 +1,8 @@=20
>  # SPDX-License-Identifier: GPL-2.0
>  # common clock support for NXP i.MX SoC family.
>  config MXC_CLK
> -       bool
> -       def_bool ARCH_MXC
> +       tristate "IMX clock"
> +       depends on ARCH_MXC
>=20
> But user can still set MXC_CLK to be m, either via make menuconfig or def=
config.

Isn't that what we want? Why does ARCH_MXC being enabled mandate that it
is builtin? Is some architecture level code calling into the clk
driver?
