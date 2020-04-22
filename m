Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B1C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017E1206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:18:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43116 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgDVJS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:18:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60C65201036;
        Wed, 22 Apr 2020 11:18:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 53E5620101B;
        Wed, 22 Apr 2020 11:18:54 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E942202AF;
        Wed, 22 Apr 2020 11:18:54 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:18:54 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Message-ID: <20200422091854.rhtkcfrdptwofngs@fsr-ub1664-175>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
 <20200417080747.GE2167633@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417080747.GE2167633@dell>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-17 09:07:47, Lee Jones wrote:
> On Wed, 15 Apr 2020, Abel Vesa wrote:
>
> > Some of the i.MX SoCs have a IP for interfacing the dedicated IPs with
> > clocks, resets and interrupts, plus some other specific control registers.
> > To allow the functionality to be split between drivers, this MFD driver is
> > added that has only two purposes: register the devices and map the entire
> > register addresses. Everything else is left to the dedicated drivers that
> > will bind to the registered devices.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/mfd/Kconfig   | 11 +++++++++++
> >  drivers/mfd/Makefile  |  1 +
> >  drivers/mfd/imx-mix.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 60 insertions(+)
> >  create mode 100644 drivers/mfd/imx-mix.c
>
> For completeness - Arnd's reply to this patch:
>
>  https://www.spinics.net/lists/linux-clk/msg47703.html

I'm replying here to Arnd's reply.

I'm trying to give here a whole picture of the entire problem while the
documentation for i.MX8MP is _not yet_ public.

Historically, each IP would have its own enclosure for all the related GPRs.
Starting with i.MX8MP some GPRs (and some subparts) from the IP were placed
inside these mixes.

Audiomix for example, has multiple SAIs, a PLL, and some reset bits for EARC and
some GPRs for AudioDSP. This means that i.MX8MP has 7 SAIs, 1 EARC and 1 AudioDSP.
Future platforms might have different numbers of SAIs, EARCs or AudioDSPs. The PLL
can't be placed in one of those SAIs and it was placed in audiomix.
The i.MX8MP has at least 4 of these mixes.

Now, the commonalities between all mixes are:
 - have their own power domains
 - driven by dedicated clock slice
 - contain clocks and resets
 - some very subsystem specific GPRs

Knowing that each mix has its own power domain, AFAICT, it needs to be registered
as a single device. Considering that it can have clocks (audiomix has gates,
muxes and plls), I believe that needs a clock driver, even more so since the
muxes need their parents from the platform clock driver. Same principle applies
to reset bits. The subsystem specific GPRs can be registered as syscon devices
and taken care of by its counterpart IP (e.g. the AudioDSP specific regs would
be taken care of by the DSP driver, if there is one).

Now based on all of the above, by using MFD we take care of the power domain
control for the entire mix, plus, the MFD doesn't have any kind of
functionality by its own, relying on its children devices that are populated
based on what is in the mix MFD devicetree node.

> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
