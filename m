Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D529C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CEA207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHSUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:33:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45880 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgHSUdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:33:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 09289201200;
        Wed, 19 Aug 2020 22:33:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0A2A2011AA;
        Wed, 19 Aug 2020 22:33:36 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DC4F7203C2;
        Wed, 19 Aug 2020 22:33:36 +0200 (CEST)
Date:   Wed, 19 Aug 2020 23:33:36 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 15/17] arm64: dts: imx8mp: Add audio_blk_ctrl node
Message-ID: <20200819203336.42nmy6atmbbvlnri@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-16-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=TiU_3z8a0eEn3tYfyJ7JWZ-u8Yes1NOgXEnbeh43q7TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=TiU_3z8a0eEn3tYfyJ7JWZ-u8Yes1NOgXEnbeh43q7TA@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-18 19:32:05, Dong Aisheng wrote:
> On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > Some of the features of the audio_ctrl will be used by some
> > different drivers in a way those drivers will know best, so adding the
> > syscon compatible we allow those to do just that. Only the resets
> > and the clocks are registered bit the clk-blk-ctrl driver.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index daa1769..dede0ae 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -736,6 +736,22 @@
> >                         };
> >                 };
> >
> > +               aips5: bus@30c00000 {
> > +                       compatible = "fsl,aips-bus", "simple-bus";
> > +                       reg = <0x30c00000 0x400000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       audio_blk_ctrl: clock-controller@30e20000 {
> > +                               compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
> > +                               reg = <0x30e20000 0x50C>;
> 
> 0x50c
> 

Will do.

> > +
> 
> remove unnecessary blank line
> 

Will do.

> Otherwise:
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Aisheng
> 
> > +                               #clock-cells = <1>;
> > +                               #reset-cells = <1>;
> > +                       };
> > +               };
> > +
> >                 gic: interrupt-controller@38800000 {
> >                         compatible = "arm,gic-v3";
> >                         reg = <0x38800000 0x10000>,
> > --
> > 2.7.4
> >
