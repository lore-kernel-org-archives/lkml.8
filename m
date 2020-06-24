Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6592EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423EB20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbgFXHrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:47:15 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbgFXHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:47:13 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MAfpQ-1jhRbT0yHQ-00B1Ch; Wed, 24 Jun 2020 09:47:11 +0200
Received: by mail-qk1-f174.google.com with SMTP id l17so1010201qki.9;
        Wed, 24 Jun 2020 00:47:10 -0700 (PDT)
X-Gm-Message-State: AOAM5300cLsDr6w3XS6GDfYvty8eK9ekAv8iQenNQ7MW9Y8ja361SnNR
        5MxBbJ3YuMc7BETrON84O/YmTDFNB8zgwKhKR4s=
X-Google-Smtp-Source: ABdhPJzRJg39OvE4UOqHA4jbaqwKEkTXYEnow1sPdDB6pSK2lJwsGve56mVlkds9keVehXjnQG4gp1B3jWmMPIkEQIQ=
X-Received: by 2002:a37:a282:: with SMTP id l124mr9530251qke.3.1592984829990;
 Wed, 24 Jun 2020 00:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com> <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com> <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Jun 2020 09:46:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a21gJg-iVNupx94WZjcpNtHPLJhDM_Uh7E_4yGjSH_pJg@mail.gmail.com>
Message-ID: <CAK8P3a21gJg-iVNupx94WZjcpNtHPLJhDM_Uh7E_4yGjSH_pJg@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y6dkigMG8mvN+gfqKYP+s4ZHujfafsuTD60hVNB/9dcbFeFdW3w
 X9q3w7VLonDP27AowdBFEOjD0tBnnImA0qEInHEo5Wei/AXec+1OhyMv742nMHZ2LsSJzF9
 oB6DXaGzddglJJHmjA3wddz+JCn8S22iG7Fkqiw4t4fadpL+KbyBkE4ur37o3rvriQsning
 P2NvqRi2rjXXtRrYjP9rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPQ8zh+He6M=:NCZomK2k/5ze0TFOdfFKZv
 QdyirwjG5R2QbCVnb3gODIgxbhFHGXAOFHO+QgQ8xn7tPmyNCpGcsEYZO8elbgrFJAfjwmfpg
 7M4TM3jvvvn/N1JmO//YUHtL2HIZk5SBn/K1AMvB0Y1Q/r/Ouxywvu1D/K63FqdctzW6pfJB/
 sXq6UaFK0jUSUpBtGs1uD+34SK2IaP+L1Xo5yr8AzQjKZCgBd9e6Qhu12f+UjD+y4PWTpU6bD
 JEO3lSJKocj2ySx0MaA343c1lv+N1GWy9MiveeAq7Uoa9A6sreQIwE4pGbtzRBteRv58lhVWo
 tvtBj3Bw0cTunDyLYHZ3FsUG6HzfNBvFIvarH9NVNwyU4m0nM3Fr4eX2GoZ8qhPdBb5rVLWA9
 Te2XWebJNvTMxnBDSXrQfV1qH8NU+I2araWnHUnCxiGj1AqVq1QqvvyvccWZj1+GEPRqGD/sM
 yGojBpq3jX7RyZmuAZRFaDm7F/wXyt1z4EIkDtisirDLXYB9O/YZJ2gDj7sJ5q0e5pnraz36J
 93u93CGJzeKX36xsMGgD3sylRIwpTjfgq7I3ymJ+KrX6PhpllnZomEf19psUGmc34XKqnxLzp
 Irem8C9pbWbRpd52+fJ1tBQaFRPSe4AS8kX/Bwmv5l30N4VoV5N/oQ4qQMuFPPMzJurLW4ApP
 gCLhJVDeqb++3+eNElgLCnHTfajX+tyq56nttQmNmKYb4s2H6619CUKVP8NucIvFOlF7wmwn7
 ZljQ9wKRB92ZuK5LFEHibURxXJKFRnWfRAwmqhYmzlsZJAOvidEXti+ltIZMxtBmfLSQcX3hB
 juedtzw484VgHcrNZ99401W8073yMSBe/3Icv4ifopduZuREfg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 4:19 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
> > Isn't that what we want?
>
> No, if user set MXC_CLK to m, the build will break for i.MX6&7.
>
> > Why does ARCH_MXC being enabled mandate that it is
> > builtin? Is some architecture level code calling into the clk driver?
>
>
> It's mainly because there's no Kconfig options for i.MX6 &7 clock drivers.
> It just reuses ARCH config CONFIG_SOC_XXX which can only be y.
> e.g.
> obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
> obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
> obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> ..
>
> If setting MXC_CLK to m, the platform clock drivers will fail to build due to miss
> to find symbols defined in the common clock library by CONFIG_MXC_CLK.
> So we have to avoid users to be able to config MXC_CLK to m for i.MX6&7.
> Only depends on ARCH_MXC mean user still can set it to m.

The link error can be easily avoided by building all the clk support into
a single loadable module like below.

Hower this only works if all drivers that have a runtime dependency
on the clk driver support deferred probing or are built as loadable
modules as well and get loaded after the clk driver.

     Arnd

8<---
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874c73d2..638bc00f5731 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0

-obj-$(CONFIG_MXC_CLK) += \
+obj-$(CONFIG_MXC_CLK) := clk-imx.ko
+
+clk-imx-y += \
        clk.o \
        clk-busy.o \
        clk-composite-8m.o \
@@ -25,24 +27,24 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
        clk-scu.o \
        clk-lpcg-scu.o

-obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
-obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
-obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
-obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
-obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
+clk-imx-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
+clk-imx-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
+clk-imx-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
+clk-imx-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
+clk-imx-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o

-obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
-obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
-obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
-obj-$(CONFIG_SOC_IMX27)  += clk-imx27.o
-obj-$(CONFIG_SOC_IMX31)  += clk-imx31.o
-obj-$(CONFIG_SOC_IMX35)  += clk-imx35.o
-obj-$(CONFIG_SOC_IMX5)   += clk-imx5.o
-obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
-obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
-obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
-obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
-obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
-obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
-obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+clk-imx-$(CONFIG_SOC_IMX1)   += clk-imx1.o
+clk-imx-$(CONFIG_SOC_IMX21)  += clk-imx21.o
+clk-imx-$(CONFIG_SOC_IMX25)  += clk-imx25.o
+clk-imx-$(CONFIG_SOC_IMX27)  += clk-imx27.o
+clk-imx-$(CONFIG_SOC_IMX31)  += clk-imx31.o
+clk-imx-$(CONFIG_SOC_IMX35)  += clk-imx35.o
+clk-imx-$(CONFIG_SOC_IMX5)   += clk-imx5.o
+clk-imx-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
+clk-imx-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
+clk-imx-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
+clk-imx-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
+clk-imx-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
+clk-imx-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
+clk-imx-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
+clk-imx-$(CONFIG_SOC_VF610)  += clk-vf610.o
