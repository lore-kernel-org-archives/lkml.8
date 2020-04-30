Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D5CC8300D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A76D20757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD3LNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:13:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40102 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3LNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:13:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D8D5A2007DC;
        Thu, 30 Apr 2020 13:13:42 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C865E2007D8;
        Thu, 30 Apr 2020 13:13:42 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AA7D920397;
        Thu, 30 Apr 2020 13:13:42 +0200 (CEST)
Date:   Thu, 30 Apr 2020 14:13:42 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Message-ID: <20200430111342.b2fj7ko3uvffv4wg@fsr-ub1664-175>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
 <20200417080747.GE2167633@dell>
 <20200422091854.rhtkcfrdptwofngs@fsr-ub1664-175>
 <AM6PR04MB4966B3527BF97918C1689A4580D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200424062727.GI3612@dell>
 <20200430100355.zwl7wfbq64cikqxp@fsr-ub1664-175>
 <AM6PR04MB496612839A11EA05D60DF6AE80AA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB496612839A11EA05D60DF6AE80AA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-30 10:22:04, Aisheng Dong wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > Sent: Thursday, April 30, 2020 6:04 PM
> > To: Lee Jones <lee.jones@linaro.org>
> > On 20-04-24 07:27:27, Lee Jones wrote:
> > > On Thu, 23 Apr 2020, Aisheng Dong wrote:
> > >
> > > > > From: Abel Vesa <abel.vesa@nxp.com>
> > > > > Sent: Wednesday, April 22, 2020 5:19 PM On 20-04-17 09:07:47, Lee
> > > > > Jones wrote:
> > > > > > On Wed, 15 Apr 2020, Abel Vesa wrote:
> > > > > >
> > > > > > > Some of the i.MX SoCs have a IP for interfacing the dedicated
> > > > > > > IPs with clocks, resets and interrupts, plus some other specific control
> > registers.
> > > > > > > To allow the functionality to be split between drivers, this
> > > > > > > MFD driver is added that has only two purposes: register the
> > > > > > > devices and map the entire register addresses. Everything else
> > > > > > > is left to the dedicated drivers that will bind to the registered devices.
> > > > > > >
> > > > > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > > > > ---
> > > > > > >  drivers/mfd/Kconfig   | 11 +++++++++++
> > > > > > >  drivers/mfd/Makefile  |  1 +
> > > > > > >  drivers/mfd/imx-mix.c | 48
> > > > > > > ++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 60 insertions(+)  create mode 100644
> > > > > > > drivers/mfd/imx-mix.c
> > > > > >
> > > > > > For completeness - Arnd's reply to this patch:
> > > > > >
> > > > >
> > > > > I'm replying here to Arnd's reply.
> > > > >
> > > > > I'm trying to give here a whole picture of the entire problem
> > > > > while the documentation for i.MX8MP is _not yet_ public.
> > > > >
> > > > > Historically, each IP would have its own enclosure for all the related GPRs.
> > > > > Starting with i.MX8MP some GPRs (and some subparts) from the IP
> > > > > were placed inside these mixes.
> > > > >
> > > > > Audiomix for example, has multiple SAIs, a PLL, and some reset
> > > > > bits for EARC and some GPRs for AudioDSP. This means that i.MX8MP
> > > > > has 7 SAIs, 1 EARC and
> > > > > 1 AudioDSP.
> > > > > Future platforms might have different numbers of SAIs, EARCs or
> > AudioDSPs.
> > > > > The PLL can't be placed in one of those SAIs and it was placed in audiomix.
> > > > > The i.MX8MP has at least 4 of these mixes.
> > > > >
> > > > > Now, the commonalities between all mixes are:
> > > > >  - have their own power domains
> > > > >  - driven by dedicated clock slice
> > > > >  - contain clocks and resets
> > > > >  - some very subsystem specific GPRs
> > > > >
> > > > > Knowing that each mix has its own power domain, AFAICT, it needs
> > > > > to be registered as a single device. Considering that it can have
> > > > > clocks (audiomix has gates, muxes and plls), I believe that needs
> > > > > a clock driver, even more so since the muxes need their parents
> > > > > from the platform clock driver. Same principle applies to reset
> > > > > bits. The subsystem specific GPRs can be registered as syscon
> > > > > devices and taken care of by its counterpart IP (e.g. the AudioDSP specific
> > regs would be taken care of by the DSP driver, if there is one).
> > > > >
> > > > > Now based on all of the above, by using MFD we take care of the
> > > > > power domain control for the entire mix, plus, the MFD doesn't
> > > > > have any kind of functionality by its own, relying on its children
> > > > > devices that are populated based on what is in the mix MFD devicetree
> > node.
> > > > >
> > > >
> > > > How about doing like this which maybe can address Arnd's concerns?
> > > > audiomix: audiomix@30e20000 {
> > > >         compatible = "fsl,imx8mp-audiomix", "syscon";
> > > >         reg = <0x30e20000 xxx>,
> > > >               <0x30e20xxx xxx>;
> > > >         reg-names = "audio", "reset", "...";
> > > >         #clock-cells = <1>;
> > > >         #reset-cells = <1>;
> > > >         power-domains = <&audiomix_pd>; }
> > > >
> > > > That means we have one combo driver registering two controllers
> > > > (clk/reset), both use the same power domain as audiomix.
> > > > And it can be easily extended to support more services provided by
> > > > audiomix over syscon if needed.
> > > > Then the 'dummy' MDF driver is not needed anymore.
> > > >
> > > > Jones & Arnd,
> > > > How do you think?
> > >
> > > Sounds okay in principle.  Anything that prevents the existence of a
> > > dummy (a.k.a. pointless) MFD must be seen as a positive move.
> > >
> > 
> > OK, I'll do it in a single driver and single dts node.
> > 
> > But there might be an issue with the placement of this new driver.
> > 
> > drivers/clk/imx/ could be an option, but the driver will use a lot of different APIs
> > from different subsystems. Not the audiomix, but the future mixes.
> 
> Maybe Stephen could comment whether it's ok to push a combo driver
> (e.g. clk&reset&syscon) In drivers/clk/imx.
> 
> From what we see, it seems already some similar combo drivers (clk&reset) there.
> 
> BTW, not sure if any technical block reasons to put in drivers/clk.
> Maybe we can quickly try internally first.
> 

Working on it already.

> Regards
> Aisheng
> 
> > 
> > > --
> > > Lee Jones [李琼斯]
> > > Linaro Services Technical Lead
> > > Linaro.org │ Open source software for ARM SoCs Follow Linaro: Facebook
> > > | Twitter | Blog
