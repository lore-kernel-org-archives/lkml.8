Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DFCC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B250F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgANK7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:59:55 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgANK7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:59:55 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MVdUQ-1jGiYn0RfA-00RdML for <linux-kernel@vger.kernel.org>; Tue, 14 Jan
 2020 11:59:53 +0100
Received: by mail-qt1-f173.google.com with SMTP id d5so12052491qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:59:52 -0800 (PST)
X-Gm-Message-State: APjAAAWUwx1uP5/Fy+kTCiTnjbd12gb0A+RTYjxntsD5m3Xm/iq0YW9h
        hl4Z6qV4jhL2u2Hmre0jratCPsFJUmNbEhzX/pg=
X-Google-Smtp-Source: APXvYqy7DVQeNpwjj8/PcKvWd95l2BRRTtcYFTLWs1RZ+YhziEOQD5McLfFwTnVEhhx5R0yRDJ/gghU9Y+a5TCN65G8=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr2975529qtm.18.1578999591888;
 Tue, 14 Jan 2020 02:59:51 -0800 (PST)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 11:59:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
Message-ID: <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
To:     Peng Fan <peng.fan@nxp.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cE0A+PnSYgySMGJC6R6kvE52gv2pSNLSoRnLGEpf61gFOrhWkmX
 f08AEHMtRfEkuc7hitJwpz0A9rwkXxjodQxT1uYaoS+QhpWrnQ+lSX5eGNl5QUub0VkBHe9
 7HIlb6nD2AzlurBxnh9KzqVq/B3kXfV6CkuSApmC9QktImwsszpXAAJ6ELxe58mo2PG5AQI
 ABWL3qEDTZ1qARZk8Oh4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:njkbmezlBps=:rB2AmmCVywC4eKHL9ohjnZ
 Y/Fit45mtwwJ7hsRtdC1M4fPt+nRdgUPk5vUpJ/WSTF/jBEroHF6QeVq+9769OMw+lBHNAd0M
 4jFFippfptC9fGpyGUUA90HSJOXxNeofuie/USXS08c3ek8Hilj/tNrrmWSAZtG7H0uhz2ry6
 7iupsp/lR7RtaItYPSsVKva5RGsrmt87v9gQJlbJ2Cx5QKqL1+chcgcSowxHiU4ajXz9O833Q
 8fIDR/v7YcxJugz98T5BbsuDDE0FpV4pAArQRgpTnsnCOapdh1ycqLniUHUyGFq8Jb5VETNoc
 gMVOHdjx1ZI1lc4/x34rve8hEmUSaSrKOA9AIydaSQk9CM+B19YzyYaB9OI1oWbhPVk88kGKU
 xrMk+EHJnILeV0jKL++tUZP/n0A/uxT8x+Oc3mWUJb26VhjzEM5YZx7xLl9iHSZkUPUQxS0iK
 +4cEaTDmSwoFK3BFEH0RMBAAgUEu9TRNAImG4kDbW9J23j5zCYx+fP3hkwGWzTWUS+d2F/hgc
 h384hyh3LBobKtcesA1Qm20KeJwA3p6bhXrPKR8kOXSUX/rrqgn86n1K0L7kw4dJ0GdLX/bqn
 +2NlY6Uelq4Wndv9IudgTwFScZmEqP3msJaQvN2iR730+WrRsxSZfzyHIriOecK4LbId77mxh
 yPWeXpNUUxGHzCGInzxbLw9myejcVImuv4pwoFIb4QvqgnOujLh//x7vEcD0bKOHltywmqsos
 P0MWoG+sn+5DTZQJcl5ziX7zMOv4mEsMFmUUwNmpNAD6yItFUXEhfb9QUQ3yK5MYopOv1luNA
 hR6JZuorufUchYpWyH4lxV2HgTFSgbIJU9V+JXZ5PdkHn3IFSZNIc7rOKi5XJeK2C4KC/redc
 z7aWpjPWRTvcZYaSJHpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:32 AM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > CONFIG_ARM64
> >
> > On Tue, Jan 14, 2020 at 08:08:45AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Only need to build soc-imx8.c when CONFIG_ARM64 defined, no need to
> > > build it for CONFIG_ARM32 currently.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/soc/imx/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
> > > cf9ca42ff739..cfcbc62b11d7 100644
> > > --- a/drivers/soc/imx/Makefile
> > > +++ b/drivers/soc/imx/Makefile
> > > @@ -1,5 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> > >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> > > +ifdef CONFIG_ARM64
> > >  obj-$(CONFIG_ARCH_MXC) += soc-imx8.o
> > > +endif
> >
> > For earlier SoCs we had kconfig symbols like SOC_IMX25. Actually
> > SOC_IMX8 would be the right one to decide about soc-imx8.c to be compiled,
> > it would be easier to read and verify than the suggested
> > "ARM64 && ARCH_MXC" and it would stay right once NXP presents it's next
> > 64-bit SoC i.MX9.
>
> There is no SOC_IMX8 currently. Need to introduce one in
> arch/arm64/Kconfig.platforms. But I not see other vendors
> introduce options like SOC_XX. Is this the right direction to
> add one in Kconfig.platforms?

I think it would be more consistent with the other platforms to have
a symbol in drivers/soc/imx/Kconfig to control whether we build
that driver.

If the driver is well written, it should be possible to allow compile
testing it on any architecture (please test this, at least on x86).

For some SoCs, we also allow running 32-bit kernels, so it would
not be wrong to allow enabling the symbol on 32-bit ARM as
well, but this is probably something where you want to consider
the bigger picture to see if you want to support that configuration
or not.

      Arnd
