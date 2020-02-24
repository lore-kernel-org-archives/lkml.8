Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A2EC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE1820732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgBXRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgBXRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:23:56 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j6HSR-0003Aa-Cw; Mon, 24 Feb 2020 18:23:51 +0100
Message-ID: <5d0f20b76e31360372a410983b013551062e9a91.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/4] arm64: dts: imx8mq: add DCSS node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     agx@sigxcpu.org, lukas@mntmn.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Feb 2020 18:23:51 +0100
In-Reply-To: <1575625964-27102-5-git-send-email-laurentiu.palcu@nxp.com>
References: <1575625964-27102-1-git-send-email-laurentiu.palcu@nxp.com>
         <1575625964-27102-5-git-send-email-laurentiu.palcu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-12-06 at 11:52 +0200, Laurentiu Palcu wrote:
> This patch adds the node for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index f6e840c..da7e485 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -981,6 +981,31 @@
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
> +
> +			dcss: display-controller@32e00000 {

Node address is lower than the irqsteer node, so the dcss node should
be added before, not after the irqsteer node in the DT.

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "nxp,imx8mq-dcss";
> +				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> +				interrupts = <6>, <8>, <9>;
> +				interrupt-names = "ctx_ld", "ctxld_kick", "vblank";
> +				interrupt-parent = <&irqsteer>;
> +				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
> +					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
> +					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
> +					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
> +					 <&clk IMX8MQ_CLK_DISP_DTRC>;
> +				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> +				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
> +						  <&clk IMX8MQ_CLK_DISP_RTRM>,
> +						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
> +				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
> +							 <&clk IMX8MQ_SYS1_PLL_800M>,
> +							 <&clk IMX8MQ_CLK_27M>;
> +				assigned-clock-rates = <800000000>,
> +							   <400000000>;

Second line is not aligned to the first one.

> +				status = "disabled";
> +			};
>  		};
>  
>  		gpu: gpu@38000000 {

