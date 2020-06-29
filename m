Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5256320672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG+uJ082"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgF2Uih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgF2TOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7CC08EE1D;
        Mon, 29 Jun 2020 00:18:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so5657411edb.13;
        Mon, 29 Jun 2020 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2L4K4v92H9t7F+mwi5xNVx0XUcZw472JCsWZtGnGQg=;
        b=gG+uJ082jLDUdML+mwynl+1BnqW67+3WT3dlTEU7LSjF3dQJ1baOXMA/xpnxCs+kPC
         407nqkucDlhpMqpawv+0ZgWqPZfBW/IN0Cl1D9ud9Lw3XUuydZI4fQgi9xfm5Jd7In49
         KEXleIlfAGleWY3tZdFVMr+DoYt0D7tYepeD5YAm/Fykm8JUXSMkReqO6wkEFTlBbdg1
         Ft1gav4VEiE5ri/iRkV07YNlqtiPpzmbJyJDiZsN7BklaldpommqrTYE14rPtFRykspj
         vWtSS2Bs3uWgo0QE75DskhHiAMqMt2UE6awKbWuqjhdHJtKMfBoDC5f8PD2rQI6BPfv9
         bG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2L4K4v92H9t7F+mwi5xNVx0XUcZw472JCsWZtGnGQg=;
        b=o9hMqn3sp7gl7MTmtwTL+1qHJ+TSnqD7/bcogxtSZVyssu1cPBu2rlwGnLvNPIAfqZ
         G/Y+LM+WnVeOLqX7p7rVPvCxNHN7+ptPKQuswMusLzSiRrHQ7EObkDopGG2DapJcuFGM
         wJgFx/a9LTXqsE1fr/mzaaxQHYQYJjoLiLBIVEUotiiAU3bQdP+oLywSwhGQ7QqqAUlB
         6QJvQXYhhBV9KeE9DDT4IJqZimjjZTO0NBGwsCFHHBtFO5fXDoC7Jsew7wwG9tuEgTyf
         UJAK2OhXeB4RAgG+wJd3PzDOjZX37FYLolERTMoPoRe4HNf/UqoxKiilHoAFkYivRdnU
         e/Gg==
X-Gm-Message-State: AOAM533OW4DE64iDrHczTV5Y8oOjWR60+JizHkG0itlakQDR5rpiIGtH
        llOQFTtXghyNZYfrJ9K3tnAaBJ7nKAzQotP89Yo=
X-Google-Smtp-Source: ABdhPJwpTY6tJjps0qhuQLdx+RnvLQZWXZ9Uet7dmPvC8dHpw3U52mZTR76cVBU11J99wSK/NOoEvpviomSJTWqF7RE=
X-Received: by 2002:a50:9b0b:: with SMTP id o11mr16784048edi.22.1593415117387;
 Mon, 29 Jun 2020 00:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
In-Reply-To: <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 29 Jun 2020 15:04:40 +0800
Message-ID: <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>, allison@lohutok.net,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>, info@metux.net,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        oleksandr.suvorov@toradex.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yuehaibing@huawei.com,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:43 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Aisheng Dong (2020-06-23 19:59:09)
> > > > > > -       bool
> > > > > > -       def_bool ARCH_MXC
> > > > > > +       tristate "IMX clock"
> > > > > > +       depends on ARCH_MXC
> > > > > >
> > > > > > But user can still set MXC_CLK to be m, either via make menuconfig
> > > > > > or
> > > > > defconfig.
> > > > >
> > > > > Isn't that what we want?
> > > >
> > > > No, if user set MXC_CLK to m, the build will break for i.MX6&7.
> > > >
> > > > > Why does ARCH_MXC being enabled mandate that it is builtin? Is some
> > > > > architecture level code calling into the clk driver?
> > > >
> > > >
> > > > It's mainly because there's no Kconfig options for i.MX6 &7 clock drivers.
> > > > It just reuses ARCH config CONFIG_SOC_XXX which can only be y.
> > > > e.g.
> > > > obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
> > > > obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
> > > > obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> > > > obj-$(CONFIG_SOC_VF610)  += clk-vf610.o ..
> > > >
> > > > If setting MXC_CLK to m, the platform clock drivers will fail to build
> > > > due to miss to find symbols defined in the common clock library by
> > > > CONFIG_MXC_CLK.
> > > > So we have to avoid users to be able to config MXC_CLK to m for i.MX6&7.
> > > > Only depends on ARCH_MXC mean user still can set it to m.
> > >
> > > I think for i.MX6/7, although MXC_CLK is tristate, but it is selected by
> > > ARCH_MXC which is always "y", so MXC_CLK can ONLY be "y" even it is explicitly
> > > set to "m" in imx_v6_v7_defconfig file. So that means MXC_CLK can ONLY
> > > support built-in for i.MX6/7 SoCs, and that is what we want?
> > >
> >
> > Yes, I'm trying to explain to Stephen why we have to select MXC_CLK in ARCH_MXC
> > And what issues we will met if not select it.
> >
>
> Why aren't there options to enable clk-imx6q and clk-imx6sl in the
> clk/imx/Kconfig file? Those can be bool or tristate depending on if the
> SoC drivers use CLK_OF_DECLARE or not and depend on the mxc-clk library
> and SoC config we have in the makefile today.

Yes, we can do that in clk/imx/Kconfig as follows theoretically.
config CLK_IMX6Q
        bool
        def_bool ARCH_MXC && ARM
        select MXC_CLK

But we have totally 15 platforms that need to change.
e.g.
drivers/clk/imx/Makefile
obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
obj-$(CONFIG_SOC_IMX27)  += clk-imx27.o
obj-$(CONFIG_SOC_IMX31)  += clk-imx31.o
obj-$(CONFIG_SOC_IMX35)  += clk-imx35.o
obj-$(CONFIG_SOC_IMX5)   += clk-imx5.o
obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
obj-$(CONFIG_SOC_VF610)  += clk-vf610.o

Not sure if it's really worth to do that.
The easiest way to address this issue is just select it in
arch/arm/mach-imx/Kconfig,
then no need to change those 15 clock config options or just builtin
clk libraries.

Stephen,
which one do you prefer?

Regards
Aisheng
