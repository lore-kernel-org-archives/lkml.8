Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC898C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2D720735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgEDJTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEDJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:19:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C94C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 02:19:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jVXFl-0000mc-RS; Mon, 04 May 2020 11:19:09 +0200
Message-ID: <97aa62e8aaf8fa1c462c7db117fca9b6ea9bfec0.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx8m
 family
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 04 May 2020 11:19:08 +0200
In-Reply-To: <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
References: <1587999532-30006-1-git-send-email-abel.vesa@nxp.com>
         <0d301ed303faea4895d30b682133ec5c9d44bd8b.camel@pengutronix.de>
         <AM6PR04MB504745F6EB1FB17F6DBDD9A387AF0@AM6PR04MB5047.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 27.04.2020, 15:37 +0000 schrieb Jacky Bai:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: Monday, April 27, 2020 11:11 PM
> > To: Abel Vesa <abel.vesa@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Shawn
> > Guo <shawnguo@kernel.org>; Sascha Hauer <kernel@pengutronix.de>; Liam
> > Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>
> > Cc: Aisheng Dong <aisheng.dong@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] soc: imx: Add power domain driver support for i.mx8m
> > family
> > 
> > Am Montag, den 27.04.2020, 17:58 +0300 schrieb Abel Vesa:
> > > From: Jacky Bai <ping.bai@nxp.com>
> > > 
> > > The i.MX8M family is a set of NXP product focus on delivering the
> > > latest and greatest video and audio experience combining
> > > state-of-the-art media-specific features with high-performance
> > > processing while optimized for lowest power consumption.
> > > 
> > > i.MX8MQ, i.MX8MM, i.MX8MN, even the furture i.MX8MP are all belong to
> > > this family. A GPC module is used to manage all the PU power domain
> > > on/off. But the situation is that the number of power domains & the
> > > power up sequence has significate difference on those SoCs. Even on
> > > the same SoC. The power up sequence still has big difference. It makes
> > > us hard to reuse the GPCv2 driver to cover the whole i.MX8M family.
> > > Each time a new SoC is supported in the mainline kernel, we need to
> > > modify the GPCv2 driver to support it. We need to add or modify
> > > hundred lines of code in worst case.
> > > It is a bad practice for the driver maintainability.
> > > 
> > > This driver add a more generic power domain driver that the actual
> > > power on/off is done by TF-A code. the abstraction give us the
> > > possibility that using one driver to cover the whole i.MX8M family in
> > > kernel side.
> > > 
> > 
> > Again: what does this driver bring to the table, other than moving a fraction of
> > the power domain functionality into the firmware?
> > 
> > The discussions on the last submissions of this driver already established that
> > we can't move all functionality for the power domains into the firmware, as
> > controlling regulators is probably not easy to do from this context. Also the
> > TF-A side implementation of this driver is "interesting" IMHO, it does stuff like
> > accessing the clock controller registers without any locking or other means of
> > mutual exclusion with the Linux kernel clock controller driver.
> > 
> 
> The clock handling is in kernel side through CCF, not in ATF. See the patch below.
> 
> > Why can't we just extend the existing GPCv2 driver with support for the other
> > i.MX8M family members?
> > 
> 
> The reason that why I don’t like to extend the GPCv2 is that when doing domain on/off,
> We need to access some special control register in each domain & do some special flow,
> These control register(mediamix block control, vpumix block control) is not in GPC
> module's address range. No benefit to reuse the GPCv2. Only bring complexity to the
> GPCv2 driver each time a new SoC is added.
> 
> Yes, the i.MX8M power domain support has been pending for a while. ARM guys rejected this patchset
> because they suggest us to use SCMI rather than SiP. But SCMI is only partial suitable for our
> case.

Can you please point me to the most resent version of the TF-A side
implementation of this? The i.MX8MM implementation in the
imx_5.4.3_2.0.0 branch in the codeaurora imx-atf repo still contains
writes to the clock controller register range.

Also I would love to learn why the GPC needs to access Mediamix and
VPUmix domain registers. If you are talking about the NOC configuration
I would strongly suggest that those should be handled by a Linux side
interconnect driver, this has nothing to do with the power domain
sequencing, it just happens to lose state over the power down and needs
to be reprogrammed after power on. The NOC configuration though is use-
case dependent, so this should be properly handled in a rich OS driver.

Sure we needs to extend the Linux side GPC driver for each new SoC
generation, but that's no different from any other hardware driver in
Linux. Drivers are the abstraction around the hardware, there is no
need to invent another one if there are no clear benefits.

Regards,
Lucas

