Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03822C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEED0207C4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIe1lfRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgGARkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgGARj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:39:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BFFC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:39:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so23293343wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFDvcz0hYnyIh9jHxPAtyN9av+PQpLRh+pv6ybPeMDg=;
        b=VIe1lfRlNqAMzIzbFiAEcRtt3s5kdUhUyyonbZkUgEjVLIfbjIZu3u64YtUWaLE9CI
         47EuQyfu14+USSeqphEdlZoyK1L7EZYEHVd6mIJtXc1WyTyWKMoKxG8hG/NqlOXTBB/1
         orvk/ZzdqT1AU62l9ZeIRZncpViRgxAb5Fs7FibEQlxgR0iI74qn8HPzdGxY7auSTGUV
         Bmi4Tn0BcpaUttPPP+9E0k4SL36BM59D5hJjawW2nE8UYwDQEiev4mJgervwRf3JWQVN
         Cd9VICil1r3/r/2WmBbM4PUsMkcp4RooxuE32EOIfEjFQzdKOs8SGLpXwBdPgmEryPAD
         tkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFDvcz0hYnyIh9jHxPAtyN9av+PQpLRh+pv6ybPeMDg=;
        b=eqK6MefITjDIyiX7xEqcLI0Yp0gpU+WxutjW2/3xwJtqKki3sZcAprB3f5yImxmjFT
         9uQuPTTJiL5P/4HSegXkw+9ibON+0L8I6fyC5c7ZQ62n2WklYB4HDxBIyLW/zU16Y3WD
         X6/aA8B0gXN4CBD2J5nqR/+z8LKk/y/zyF6yZb9XfNpkOARCG/YTKM1TyyALpE6AAvZZ
         RpHbqR06Stz0Eh5hgUuR6m0lyctFb780MY7OR0rhUlqMnnLn6feS8M5aiBy8w6TptfIt
         FebudGSJJsHJFY95/b8jLC4eAnA36t4ouVydrhThvQkc4kzECngANzP0vJ3keTdkiq3G
         gB0A==
X-Gm-Message-State: AOAM530F6atzbYL8zFymbtbZu9HnM2Njz4CiRthMxOEbpt9QFYOLbTFL
        UuGxPLxB2m4+wGFQTAF0zHKHWZn4Lko=
X-Google-Smtp-Source: ABdhPJxt88x7esVs3Vxi2/yyNnJgjXSRmmn3Z3vqgAtoSBp17YHS9d8wHhnYIxYoEiXANomBBEzBIQ==
X-Received: by 2002:a1c:668b:: with SMTP id a133mr27422193wmc.10.1593625197372;
        Wed, 01 Jul 2020 10:39:57 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y7sm7918140wrt.11.2020.07.01.10.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:39:56 -0700 (PDT)
Subject: Re: [RESEND] arm64: dts: imx8m: Add NOC nodes
To:     Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1592905621-9689-1-git-send-email-abel.vesa@nxp.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <fe06a000-e53c-1d04-6995-92d570077efd@linaro.org>
Date:   Wed, 1 Jul 2020 20:39:55 +0300
MIME-Version: 1.0
In-Reply-To: <1592905621-9689-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On 6/23/20 12:47, Abel Vesa wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add nodes for the main interconnect of the imx8m series chips.
> 
> These nodes are bound to by devfreq and interconnect drivers.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> This is part of the following patchset:
> 
> https://www.spinics.net/lists/arm-kernel/msg797026.html

Nit: Looks like the previous version is also including the dt-bindings
headers, but this part is missing here?

In any case:
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

> 
> All the patches are already in except this one.
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 23 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c6bf8ba..00b96da 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -869,6 +869,29 @@
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
> index 9a4b65a..656fa9b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -756,6 +756,29 @@
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
> index 54bed64..6c24ec1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1037,6 +1037,29 @@
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
> 
