Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B1CC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E337720720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594477620;
	bh=e/9LYPdcKCiFpCvMorMnwcl40GSAMJjc/wJdeKLs31I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xwDherOBYRxZ+J5llT/dM6Cm85orMZnNqnUewGKNJHOt/9QZfRCplHnF/ssCpKcgA
	 oKbOm2Cp2jLwoWcwuQ4E2vfomiXkjNWJcIfmoh1VSBo8Uu9VyAAOlNoz6CUcXeT27t
	 kV+8mHrZzO27imfOQw7cu5xsBTfiFVfoDcGlYDlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGKO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 10:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 10:26:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8609720720;
        Sat, 11 Jul 2020 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594477610;
        bh=e/9LYPdcKCiFpCvMorMnwcl40GSAMJjc/wJdeKLs31I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1Cu3DReyelZj2+0mf6nU9OWkEHe0u0TD971W6RGvAQ0xTnDhRCN+LZkpMth0xv6O
         zhkPWWErpH5IZvrjGX2unaDRA8ySmyiNvtdRsYBct2QIT04MId9TO0ocRlLBwJux7Q
         ZJwmPcQSNYxmUGJlPl3GjP3615h+RGGYmQLwo4TY=
Date:   Sat, 11 Jul 2020 22:26:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RESEND v2] arm64: dts: imx8m: Add NOC nodes
Message-ID: <20200711142642.GJ21277@dragon>
References: <1594070006-816-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594070006-816-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:13:26AM +0300, Abel Vesa wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add nodes for the main interconnect of the imx8m series chips.
> 
> These nodes are bound to by devfreq and interconnect drivers.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> Changes since v1:
>  - picked up the bindinds header which were part of the original patch
>    from Leonard
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 76f040e..970d132 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mm.h>
>  
>  #include "imx8mm-pinfunc.h"
>  
> @@ -877,6 +878,29 @@
>  
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MM_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-150M {
> +					opp-hz = /bits/ 64 <150000000>;
> +				};

Please have a newline between nodes.

Shawn

> +				opp-375M {
> +					opp-hz = /bits/ 64 <375000000>;
> +				};
> +				opp-750M {
> +					opp-hz = /bits/ 64 <750000000>;
> +				};
> +			};
> +		};
> +
>  		aips4: bus@32c00000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32c00000 0x400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 9385dd7..cd38aae 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mn.h>
>  
>  #include "imx8mn-pinfunc.h"
>  
> @@ -764,6 +765,29 @@
>  
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MN_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100M {
> +					opp-hz = /bits/ 64 <100000000>;
> +				};
> +				opp-600M {
> +					opp-hz = /bits/ 64 <600000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>  		aips4: bus@32c00000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32c00000 0x400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index f70435c..d585650 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -11,6 +11,7 @@
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
>  
>  / {
> @@ -1045,6 +1046,29 @@
>  			};
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MQ_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133M {
> +					opp-hz = /bits/ 64 <133333333>;
> +				};
> +				opp-400M {
> +					opp-hz = /bits/ 64 <400000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>  		bus@32c00000 { /* AIPS4 */
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32c00000 0x400000>;
> -- 
> 2.7.4
> 
