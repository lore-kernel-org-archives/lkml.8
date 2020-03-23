Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42315C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244F420722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgCWKsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:48:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33342 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgCWKsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:48:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DC0F2011BD;
        Mon, 23 Mar 2020 11:48:15 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FFA62011A3;
        Mon, 23 Mar 2020 11:48:15 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 453CA2035C;
        Mon, 23 Mar 2020 11:48:15 +0100 (CET)
Date:   Mon, 23 Mar 2020 12:48:15 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [RFC 02/11] arm64: dts: imx8mp: Add AIPS 4 and 5
Message-ID: <20200323104815.u5f4cwdrs2nongm2@fsr-ub1664-175>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-3-git-send-email-abel.vesa@nxp.com>
 <AM0PR04MB44814EAE53E091499C639F3188FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44814EAE53E091499C639F3188FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-13 07:44:43, Peng Fan wrote:
> > Subject: [RFC 02/11] arm64: dts: imx8mp: Add AIPS 4 and 5
> > 
> > There are 5 AIPS maps in total, according to the RM. Add the missing ones
> > here.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 71b0c8f..a997ca7 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -603,6 +603,22 @@
> >  			};
> >  		};
> > 
> > +		aips4: bus@32c00000 {
> > +			compatible = "simple-bus";
> 
> "fsl,aips-bus", "simple-bus";
> 
> > +			reg = <0x32c00000 0x400000>;
> 
> Size is 64KB
> 
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +		};
> > +
> > +		aips5: bus@30c00000 {
> > +			compatible = "simple-bus";
> > +			reg = <0x30c00000 0x400000>;
> 
> Ditto. Please correct compatible and reg.
> 

Will do in the next version.

> Without this, I think there is no need to only
> add bus here? It might be better to also include
> subnodes under aips bus.

AIPS 5 is needed by the next patch in this series.
So it wouldn't make sense to have a patch that adds
only the fifth one, skipping the fourth one.

> 
> Regards,
> Peng.
> 
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +		};
> > +
> >  		gic: interrupt-controller@38800000 {
> >  			compatible = "arm,gic-v3";
> >  			reg = <0x38800000 0x10000>,
> > --
> > 2.7.4
> 
