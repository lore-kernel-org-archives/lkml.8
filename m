Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD13320780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404249AbgF2VsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:48:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgF2Vri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:47:38 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M9FX5-1jmoTe3Q7L-006Kx6; Mon, 29 Jun 2020 10:20:02 +0200
Received: by mail-qk1-f171.google.com with SMTP id 145so12007381qke.9;
        Mon, 29 Jun 2020 01:20:01 -0700 (PDT)
X-Gm-Message-State: AOAM530sbVfuJA94k3vrJQDz6ZSK29J41Kkifk6IKi1sN5MPrNnlV795
        epM+FY7dcAkv5NOauOC2GJPeh0BooGo0aC50fHg=
X-Google-Smtp-Source: ABdhPJyUnGB5lqBVkayiYL6LOPjQm0GbNdG1eqe9pwBbPRXhINutqeEw0hdnpM5VoWHPcIjswlrjFzeL+cTcw8l/eUE=
X-Received: by 2002:a37:a282:: with SMTP id l124mr13270383qke.3.1593418800617;
 Mon, 29 Jun 2020 01:20:00 -0700 (PDT)
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
 <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com> <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
In-Reply-To: <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 10:19:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
Message-ID: <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Allison Randal <allison@lohutok.net>,
        Fabio Estevam <festevam@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qRZ/7KKzWfBmnOFfHPJgOp20QegMhUqElr7vtzKIvVyb73Y5Ehr
 WAjKUdW7QtbqIzz5UXbNPUFF00YwtvPja95QYNHiCIXwWBq23egHHIM6CqtvAO4CrcvIaT8
 sTMSPP994qJOpZe1JEE+3xKArPzKas4+tf1RMDblDLwI6+vYKThQ1x1LQJs90uTf3TjePA5
 v48q04Rcg+9oDWg/d5QHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YEJedntkUDE=:14GGG9Un7SeVj0ffCfXNat
 0Do9UEqySUcAvKcSH8AWuia6m4S+mLVru/RCS+Yf/QWQtZnUSNK/WoYN79iH9M5WxAOsiSp/7
 MjcsQHYHX5e2tdeX0CuiBa2InsqVI747A5O2sNT0+JZIIkHZSN7syxnHVRDfskPba3mfIOkTx
 q8p/MyBfruhMZDkyLkD8oswwGRY0Q+PpNj3/bW+AxNaYIn9M7KOm0nMvmdzyfHS1fQI+z+tfR
 /KdFpmui1u8qxbYin/egUlk1ELPk6mKJ4R2QSvsSKJKlPxf3D4Rww0lG725jTFbJsoLnpGduW
 Ps7G+yxlvXMyxK2lY2Z464kl6Y9bfUw0KQYcFn8v8DPqpoBzXtFSgei+Wu/Wn2gzmLvBlTUEf
 c7ZA9Qhmv7NBsr1sNFPCaG0jA2aZWpApsFTAqwQc7FuzXN5zxg/lfPj49+rvzFYmSI6OWavHb
 Xq2wt/LBq6mHNMZW8Wy0ZPa8uxE0JZ/pr8nxU6u9snn9+mSuTYyfptVQ3kC5RunF1h6/V+6nN
 FFnDjzLPvlZRKfEougSOV6IBjkrVLvJk5yGwxKJR9NBPnpW/2xpQt84kkUvglQjpy3v5pqE6F
 nxUyVnUHSfR/dv8cjMCHVYyHG3Vov46K5TbG/M8F4OntIbzyx2l+hheFCJNFs5b4TIwPViRPw
 BL4I0q7q3HULUhL2ruiZ0aYH+3+pbo5DU1Z0sG5yZ+gNtUMj01T+AJW0oKCpsDQOdNGdG/cgH
 VzBcBqPiDq/inuZbYV5giVyqY9MCcX74d8ehNFNaPU/LkUq/JUZJhTzm2cYZFcTRTlFcxJF3Z
 CtkBftt5h7+1qPExHvqu7thRIxJbFQ96wHtNf0KU/uOytSZ8e4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 9:18 AM Dong Aisheng <dongas86@gmail.com> wrote:
> On Thu, Jun 25, 2020 at 6:43 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Aisheng Dong (2020-06-23 19:59:09)
> > Why aren't there options to enable clk-imx6q and clk-imx6sl in the
> > clk/imx/Kconfig file? Those can be bool or tristate depending on if the
> > SoC drivers use CLK_OF_DECLARE or not and depend on the mxc-clk library
> > and SoC config we have in the makefile today.
>
> Yes, we can do that in clk/imx/Kconfig as follows theoretically.
> config CLK_IMX6Q
>         bool
>         def_bool ARCH_MXC && ARM
>         select MXC_CLK
>
> But we have totally 15 platforms that need to change.

I would make that

config CLK_IMX6Q
         bool "Clock driver for NXP i.MX6Q"
         depends on SOC_IMX6Q || COMPILE_TEST
         default SOC_IMX6Q
         select MXC_CLK

> e.g.
> drivers/clk/imx/Makefile
> obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
> obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
> obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
> obj-$(CONFIG_SOC_IMX27)  += clk-imx27.o
> obj-$(CONFIG_SOC_IMX31)  += clk-imx31.o
> obj-$(CONFIG_SOC_IMX35)  += clk-imx35.o
> obj-$(CONFIG_SOC_IMX5)   += clk-imx5.o
> obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
> obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
> obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
> obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
>
> Not sure if it's really worth to do that.
> The easiest way to address this issue is just select it in
> arch/arm/mach-imx/Kconfig,

Changing them can be a one or two patches, that's totally
worth it IMHO.

I really don't like the 'select' in arch/arm/mach-imx/Kconfig: if
you've done the work to make the imx8 clk driver modular,
I would expect to see the same at least tried for the other
ones.

For the clk drivers that cannot yet be 'tristate' because of the
CLK_OF_DECLARE(), can you include a list of drivers
that depend on the clocks being available during early
boot?

       Arnd
