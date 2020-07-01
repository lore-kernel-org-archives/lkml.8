Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE81C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F4620747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGAIq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:46:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGAIqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:46:25 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MBUuV-1jfImW2uUR-00Cx67; Wed, 01 Jul 2020 10:46:23 +0200
Received: by mail-qv1-f49.google.com with SMTP id a14so10627617qvq.6;
        Wed, 01 Jul 2020 01:46:23 -0700 (PDT)
X-Gm-Message-State: AOAM532r1B6zxfZAQF81TX/UCunult4L7qpb4xqfKCLVivWHZAz1T1wE
        PurKoXP7Kqwsg476oXmjWtFmZsGk+Un+XDEXUSM=
X-Google-Smtp-Source: ABdhPJwrzYo6PQxrtHQbh9u4z/tRMSR3GGemLdoXTFImwLWlSjpgTS61/zI0mi8Iddadp1KYJcoDyovJ05sIcsXJc9M=
X-Received: by 2002:a0c:f802:: with SMTP id r2mr23070520qvn.197.1593593182516;
 Wed, 01 Jul 2020 01:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
 <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com> <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 10:46:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
Message-ID: <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+hKZeAFfQa0vbT+EWR/f+6aorgQODV3irX6ufAec/hFqiRP6Osc
 VfimTVjs8g/xCPzuRTNtEaN16lRCyAJEETewREothhx1ozl4bn4DUvdu9ix7lAiyzKO7vPi
 BlN0Yn9jWm8IfVVX0wZK6coKQjnx8tebHpPfv+lPQrOejJB82KAy06zWZP1O0vUIm4bAceK
 ExYVKUPhfwuHfS3qQEqug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LqUUW26TEkY=:zKLbRT6/obq9HC9AKiLiYk
 jEzWzVElc9qPFZoCBzwOiYNqyRZ+Tk1lxO27tKnXD4dwsdwFhUTXkRGxfUcsRpcsPOYvDalk2
 Xp8ifYC6t6VOE6bwsrLHiDx2HE02hAlyenuHfNHKr1Ksappjlb6/b4z9oXe4+SPNWNeuYiA9K
 /HqpNtODiBV5pPFoZrMrAYR3sJ39PL9yj+r5ro89JYOPdb3z8x8IALL9AAGP7LsUk/qezkj2K
 +FAae/3lAiKr50jqMm+239ql2MPBTUdYMqu3tmMe5PBzFDPaonNryYkg4fFqmHwdQ4FRKrlVG
 YhUxoAsVaHRZyfcBU6ZVEqL+6njqal2YZLQmoZk0r5FTab247c0QBN7jmGE07e6rU2oYxI/dJ
 JDJkcT1acieWpyWuoKgFz78sTTpPYf3Tk851wjjqlCt09S+6OR83rtbjuH2TaWXQ/hTWxDE0s
 aQmEclWbMrUSXj+rLa3CCQ7JTfbUeqtnvZGIo2HuKBqc8Ft0gHqSs4GAs8vVo1LqmThBfCVUW
 4x4nqzD5VNp5llJ9tV/dmTtDck7xulsvmp0/5ULsPyI25FkwM9MvAtALKn+JBVrazoffpQct6
 fGXxjS2oLAZrlp5YrphtPovM4YoLgL1/0dCBxN9pSUXvH70pkJA9bEEw0lwHAovFV5O+LbfBe
 yl7dvj55SVRXadknTT0DF01cKiwTMaiTKOY9UXk2h+4DEKvW6AiBz5XWTf+lGjEMgjsHvwYDY
 uoVshpPpfR/xphInAymn7hffn7B9YN3mJacIP2XatkKDwvID1plthLoGXSxaaB1fPN5JVxbEu
 bWhZoc5vhq77fjIN459o5SNgeh/I2OLwwL6zdVZM3TVPLDIcz7/sVPqere8HDvaE9zW/K1d56
 x5R/ynFCMwv6lF8f3W5u32fgWycKMVLR5FTAaT+aWiFVNSUb4rkBDAvvRovpASW6KJCrSiSIM
 qZo990i6PQkBPx2QrrWB5V4xzTvd8D6Oeg0C/natBYcZjaRjSHxGy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 9:19 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
> > On Tue, Jun 30, 2020 at 5:16 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > SCU clock driver is a common driver for all SCU based platforms.
> > Current i.MX8QXP SCU clock driver will be extended to support all future SCU
> > based platforms.
> > So theoretically clk-scu.o and clk-imx8qxp.o can be combined. LPCG  is
> > similar.
> > Maybe you can give a try as Arnd suggested.
> >
>
> Do we really need to link clk-scu and i.MX8QXP clock driver together just to avoid some export?

It was just meant to be easier than exporting a symbol and dealing with module
dependencies. If it's not easier, then don't.

> I met some build issues if using this method, the i.MX8QXP module build is OK, but other platforms
> like i.MX8MM/i.MX8MN/i.MX8MQ/i.MX8MP clock drivers are just skipped for build, even these
> i.MX8M clock config are existing in .config, anyone know why? Looks like the change in Makefile for
> i.MX8QXP clock driver introduce this issue.

You have a ":=" instead of "+=" typo, so all earlier "+=" are ignored:

> obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
> obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
> obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
> obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>
> obj-$(CONFIG_MXC_CLK_SCU) := clk-imx-scu.o clk-imx-lpcg-scu.o

                                   ^^^^^^^^

      Arnd
