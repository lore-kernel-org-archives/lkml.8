Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B4C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E5206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sFhbk/PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD0I3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:29:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0I27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:28:59 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03R8S5vl013283;
        Mon, 27 Apr 2020 10:28:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Ei68grOKsJeFCI9Ca78skkgOqw6dCGCXLGk/fJEiqBQ=;
 b=sFhbk/PUGRpNN8m9TEoWF1RDKSXWZyAp1ZJqe7r8Zl6YSgIgHU7/LLKpwJ3b45gk2nzv
 ZZMB0BGoLBP9z/Ln1Cwatp3WUkv0pjMiSRYpV95YPvoEahvX6oH7wG+CzsbXHO+P1MVB
 wEzvmrDBGOh48YrNRb8reSLJoSq5b5f46bhkbnPmSMNTZIvEg+nI8agtmaEcz1B6F8Eh
 qIxF0Z5mVwu3dAxH+1CsP/O6scKxCROl3hvX6IRqX5Au0NylIm2HSOqkvA9GZxEFdih0
 eZfhwUrMQePmnshfemoCQMJskFrh5O7ohtRRGzBzH0UFirRLo/g/c9/ND/VhkrkzhCaq UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhq5rky9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 10:28:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 906D0100034;
        Mon, 27 Apr 2020 10:28:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D5E52AC589;
        Mon, 27 Apr 2020 10:28:45 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Apr
 2020 10:28:42 +0200
Subject: Re: [PATCH 2/2] arm: dts: stm32f769-disco: Enable MIPI DSI display
 support
To:     Adrian Pop <pop.adrian61@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424182139.32190-1-pop.adrian61@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <3efb57a1-283b-f2f0-66a4-97e88c6c02d6@st.com>
Date:   Mon, 27 Apr 2020 10:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200424182139.32190-1-pop.adrian61@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_03:2020-04-24,2020-04-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian

On 4/24/20 8:21 PM, Adrian Pop wrote:
> STM32f769-disco features a 4" MIPI DSI display: add support for it.
> 
> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> ---

Commit title should be ARM: dts: stm32: ...

Can you explain a bit more in your commit message why do you use a 
reserved memory pool for DMA and where this pool is located. (I assume 
it's linked to a story of DMA and cache memory attribute on cortexM7...)

Did you try this configuration with XIP boot ?

regards
alex

>   arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
>   arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 93c063796780..202bb6edc9f1 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -48,6 +48,19 @@ / {
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			size = <0x10F000>;
> +		};
> +	};
> +
>   	clocks {
>   		clk_hse: clk-hse {
>   			#clock-cells = <0>;
> @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
>   	};
>   
>   	soc {
> +		ltdc: display-controller@40016800 {
> +			compatible = "st,stm32-ltdc";
> +			reg = <0x40016800 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> +			clocks = <&rcc 1 CLK_LCD>;
> +			clock-names = "lcd";
> +			status = "disabled";
> +		};
> +
> +		dsi: dsi@40016c00 {
> +			compatible = "st,stm32-dsi";
> +			reg = <0x40016c00 0x800>;
> +			interrupts = <98>;
> +			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> +			clock-names = "pclk", "ref";
> +			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> +			reset-names = "apb";
> +			status = "disabled";
> +		};
> +
>   		timer2: timer@40000000 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40000000 0x400>;
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 1626e00bb2cb..30ebbc193e82 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -153,3 +153,53 @@ &usbotg_hs {
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> +
> +&dsi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			dsi_in: endpoint {
> +				remote-endpoint = <&ltdc_out_dsi>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dsi_out: endpoint {
> +				remote-endpoint = <&dsi_in_panel>;
> +			};
> +		};
> +
> +	};
> +
> +	panel: panel {
> +		compatible = "orisetech,otm8009a";
> +		reg = <0>; /* dsi virtual channel (0..3) */
> +		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
> +		status = "okay";
> +
> +		port {
> +			dsi_in_panel: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&ltdc {
> +	dma-ranges;
> +	status = "okay";
> +
> +	port {
> +		ltdc_out_dsi: endpoint {
> +			remote-endpoint = <&dsi_in>;
> +		};
> +	};
> +};
> 
