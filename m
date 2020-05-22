Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BE1206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgEVJMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:12:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52130 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgEVJMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:12:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7BB42004D8;
        Fri, 22 May 2020 11:12:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB65F2004D2;
        Fri, 22 May 2020 11:12:32 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B7682205C1;
        Fri, 22 May 2020 11:12:32 +0200 (CEST)
Date:   Fri, 22 May 2020 12:12:32 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] clk: imx8mp: Set the correct parent for audio_root_clk
Message-ID: <20200522091232.gjmmbdlqwkp2kubq@fsr-ub1664-175>
References: <1588000281-6594-1-git-send-email-abel.vesa@nxp.com>
 <AM6PR04MB49663A072F56397BE55FF3C480AC0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20200430101107.t76727jwwkyhlkvd@fsr-ub1664-175>
 <AM6PR04MB49664013B43C46422C0195A780AA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB49664013B43C46422C0195A780AA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-30 10:18:24, Aisheng Dong wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > Sent: Thursday, April 30, 2020 6:11 PM
> > 

Sorry I didn't answer the other ones earlier. See below.

> > On 20-04-28 08:15:51, Aisheng Dong wrote:
> > > > From: Abel Vesa <abel.vesa@nxp.com>
> > > > Sent: Monday, April 27, 2020 11:11 PM
> > > >
> > > > Instead of ipg_root, the parent needs to be ipg_audio_root.
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > >
> > > I have a few doubts about this patch:
> > > 1. From latest RM, it seems CCGR101 (0x4650) is a shared gate for many audio
> > instances.

Yes. This is true. I'm working on adding the shared gate now.

> > > 2. If this patch is about AUDIO_AHB_CLK_ROOT, then it's parent is
> > AHB[POST_PODF] from the clock tree in RM.
> > > Not quite understand why this patch changes to IPG[POST_PODF]. Is this RM
> > incorrect issue?

Yes. Right again. It needs to be the IMX8MP_CLK_AUDIO_AHB. Will change that now.

> > >
> > > BTW, if this patch is taken from someone else, we usually better keep the
> > original author if not fundamental changes.
> > >
> > 
> > I made this change at the suggestion from S.j. Wang.
> > I'm the original author in linux-nxp (internal tree).
> > 
> 
> That's fine. Then please ignore my "stupid" reminder. 😊
> BTW, how about other questions?
> 
> Regards
> Aisheng
> 
> > > Regards
> > > Aisheng
> > >
> > > > ---
> > > >  drivers/clk/imx/clk-imx8mp.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > > > b/drivers/clk/imx/clk-imx8mp.c index 41469e2..dcdfc9d 100644
> > > > --- a/drivers/clk/imx/clk-imx8mp.c
> > > > +++ b/drivers/clk/imx/clk-imx8mp.c
> > > > @@ -727,7 +727,7 @@ static int imx8mp_clocks_probe(struct
> > > > platform_device
> > > > *pdev)
> > > >  	hws[IMX8MP_CLK_HDMI_ROOT] =
> > imx_clk_hw_gate4("hdmi_root_clk",
> > > > "hdmi_axi", ccm_base + 0x45f0, 0);
> > > >  	hws[IMX8MP_CLK_TSENSOR_ROOT] =
> > > > imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
> > > >  	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk",
> > > > "vpu_bus", ccm_base + 0x4630, 0);
> > > > -	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk",
> > > > "ipg_root", ccm_base + 0x4650, 0);
> > > > +	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk",
> > > > +"ipg_audio_root", ccm_base + 0x4650, 0);
> > > >
> > > >  	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
> > > >  					     hws[IMX8MP_CLK_A53_CORE]->clk,
> > > > --
> > > > 2.7.4
> > >
