Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB9205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgG2MRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:17:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56038 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2MRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:17:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBC0D1A112B;
        Wed, 29 Jul 2020 14:17:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF5681A112A;
        Wed, 29 Jul 2020 14:17:38 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CA5732032B;
        Wed, 29 Jul 2020 14:17:38 +0200 (CEST)
Date:   Wed, 29 Jul 2020 15:17:38 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: dts: imx8mp: Add hdmi_blk_ctrl node
Message-ID: <20200729121738.rzhtjjyej3nfu3vh@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-18-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-18-git-send-email-abel.vesa@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-29 15:08:03, Abel Vesa wrote:
> Some of the features of the hdmi_ctrl will be used by some
> different drivers in a way those drivers will know best, so adding the
> syscon compatible we allow those to do just that. Only the resets
> and the clocks are registered bit the clk-blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 172c548..5a76c4d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -751,6 +751,15 @@
>  				#clock-cells = <1>;
>  				#reset-cells = <1>;
>  			};
> +
> +			hdmi_blk_ctrl: hdmi-blk-ctrl@32fc0000 {
> +				compatible = "fsl,imx8mp-hdmi-blk-ctrl", "syscon";
> +				reg = <0x32fc0000 0x1000>;
> +				power-domains = <&hdmimix_pd>;

I forget to remove the power-domains property.

Will remove in the next version.

> +
> +				#clock-cells = <1>;
> +				#reset-cells = <1>;
> +			};
>  		};
>  
>  		aips5: bus@30c00000 {
> -- 
> 2.7.4
> 
