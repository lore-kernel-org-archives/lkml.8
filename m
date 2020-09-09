Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA64C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236CB216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Wt8Qnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIIJ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:29:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EAEC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:29:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so2168574wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpC69Ledxm8aESJEdNv7DksLMBIaJDKDcIxj8rglvFg=;
        b=d6Wt8Qnv0NFv4xViX2CvPEjOml0Ele+Mq2zRdjAIGno6kzZCa0U/Q3BXYZzdLLmzzD
         iQsqJZG/4XaKvdT8QyRjkyOR8CSx2oDaQQkBAk9XfnmIL8e+xNwfQ0j6FGJG9AZ/Od2+
         Yww35DmrzKMjwjn5Mrzjo56EZkMN/HXDU83OB/6ktfz2dqNjXsnNwqJmGQ1F3EtpbCyq
         9YNAbbf9dA7G6llfxDXh1leuhJJDCyKo4Sgh2zmiClZ968Lbl3R9dCuMJPtlKApKHf/T
         eg4CxdcU/ZaHM/03/honTOQGc3B/dgrF1rHlJpuRYa0ZG2N/CZzjK3R/KQZ7g2WMCylJ
         zaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpC69Ledxm8aESJEdNv7DksLMBIaJDKDcIxj8rglvFg=;
        b=siQSQrtcyDBjOaRS8y8cQirKhtNVSNZT5m66FqpGTnGPV7ZYexNKN2Uz3W9DFNaHbX
         xg4Rp7tp2R4eIq8VRHmArzWre/ewnT7EXVBsXvmhMZyAGdpRLyjTmlchS7gsEgkLgrAO
         6PDpdvUP6Bc8rQ9Q0Wh6HWmA01iSVNAgBCkkri2snZSw2Qtoy3k3qT3fJ30c/z8mObCF
         E6/naJIcMSUqbdWrq5Y/3ysVOQsLqyvYX4IfcDmGlkmO4HDbytO/nm77cNKmV3rS/XQX
         TU+yZ+yNn9dzWmI1SzkW8eJbwU2nq8JqQRb8i66/gXfKr+aed89vEkloV9om16dzLnN/
         AA1Q==
X-Gm-Message-State: AOAM531bsl466uqzpsXgdeEBwxa0Wc6dLaUU0DqLwgN4Bq6n5+HMwsEK
        KL3cdWOVmiCxtpXXWKICXRU=
X-Google-Smtp-Source: ABdhPJy2znkNcihUeqt0ozuCxbafLm9FhaDfllLXjobb8Yni+l373M4lNf+e8aHyg8AK3fqsB8K2RA==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr3002995wrv.8.1599643765207;
        Wed, 09 Sep 2020 02:29:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id b11sm3284731wrt.38.2020.09.09.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:29:24 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] arm: dts: mt7623: move display nodes to separate
 mt7623n.dtsi
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-7-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <57085883-5044-aec2-021b-3b0880da70bc@gmail.com>
Date:   Wed, 9 Sep 2020 11:29:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819081752.4805-7-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2020 10:17, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> mt7623a has no graphics support so move nodes from generic mt7623.dtsi
> to mt7623n.dtsi
> 
> Fixes: 1f6ed224594 ("arm: dts: mt7623: add Mali-450 device node")
> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied to v5.9-next/dts32

Thanks!

> ---
>   arch/arm/boot/dts/mt7623.dtsi                 | 123 ----------------
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |   2 +-
>   arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |   2 +-
>   arch/arm/boot/dts/mt7623n.dtsi                | 134 ++++++++++++++++++
>   4 files changed, 136 insertions(+), 125 deletions(-)
>   create mode 100644 arch/arm/boot/dts/mt7623n.dtsi
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index a106c0d90a52..d09b5671c91b 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -14,7 +14,6 @@
>   #include <dt-bindings/power/mt2701-power.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/memory/mt2701-larb-port.h>
>   #include <dt-bindings/reset/mt2701-resets.h>
>   #include <dt-bindings/thermal/thermal.h>
>   
> @@ -297,17 +296,6 @@ timer: timer@10008000 {
>   		clock-names = "system-clk", "rtc-clk";
>   	};
>   
> -	smi_common: smi@1000c000 {
> -		compatible = "mediatek,mt7623-smi-common",
> -			     "mediatek,mt2701-smi-common";
> -		reg = <0 0x1000c000 0 0x1000>;
> -		clocks = <&infracfg CLK_INFRA_SMI>,
> -			 <&mmsys CLK_MM_SMI_COMMON>,
> -			 <&infracfg CLK_INFRA_SMI>;
> -		clock-names = "apb", "smi", "async";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> -	};
> -
>   	pwrap: pwrap@1000d000 {
>   		compatible = "mediatek,mt7623-pwrap",
>   			     "mediatek,mt2701-pwrap";
> @@ -339,17 +327,6 @@ sysirq: interrupt-controller@10200100 {
>   		reg = <0 0x10200100 0 0x1c>;
>   	};
>   
> -	iommu: mmsys_iommu@10205000 {
> -		compatible = "mediatek,mt7623-m4u",
> -			     "mediatek,mt2701-m4u";
> -		reg = <0 0x10205000 0 0x1000>;
> -		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&infracfg CLK_INFRA_M4U>;
> -		clock-names = "bclk";
> -		mediatek,larbs = <&larb0 &larb1 &larb2>;
> -		#iommu-cells = <1>;
> -	};
> -
>   	efuse: efuse@10206000 {
>   		compatible = "mediatek,mt7623-efuse",
>   			     "mediatek,mt8173-efuse";
> @@ -725,94 +702,6 @@ mmc0: mmc@11230000 {
>   		status = "disabled";
>   	};
>   
> -	g3dsys: syscon@13000000 {
> -		compatible = "mediatek,mt7623-g3dsys",
> -			     "mediatek,mt2701-g3dsys",
> -			     "syscon";
> -		reg = <0 0x13000000 0 0x200>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -	mali: gpu@13040000 {
> -		compatible = "mediatek,mt7623-mali", "arm,mali-450";
> -		reg = <0 0x13040000 0 0x30000>;
> -		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 178 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 179 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
> -				  "ppmmu1", "pp2", "ppmmu2", "pp3", "ppmmu3",
> -				  "pp";
> -		clocks = <&topckgen CLK_TOP_MMPLL>,
> -			 <&g3dsys CLK_G3DSYS_CORE>;
> -		clock-names = "bus", "core";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
> -		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
> -	};
> -
> -	mmsys: syscon@14000000 {
> -		compatible = "mediatek,mt7623-mmsys",
> -			     "mediatek,mt2701-mmsys",
> -			     "syscon";
> -		reg = <0 0x14000000 0 0x1000>;
> -		#clock-cells = <1>;
> -	};
> -
> -	larb0: larb@14010000 {
> -		compatible = "mediatek,mt7623-smi-larb",
> -			     "mediatek,mt2701-smi-larb";
> -		reg = <0 0x14010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		mediatek,larb-id = <0>;
> -		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> -			 <&mmsys CLK_MM_SMI_LARB0>;
> -		clock-names = "apb", "smi";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> -	};
> -
> -	imgsys: syscon@15000000 {
> -		compatible = "mediatek,mt7623-imgsys",
> -			     "mediatek,mt2701-imgsys",
> -			     "syscon";
> -		reg = <0 0x15000000 0 0x1000>;
> -		#clock-cells = <1>;
> -	};
> -
> -	larb2: larb@15001000 {
> -		compatible = "mediatek,mt7623-smi-larb",
> -			     "mediatek,mt2701-smi-larb";
> -		reg = <0 0x15001000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		mediatek,larb-id = <2>;
> -		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> -			 <&imgsys CLK_IMG_SMI_COMM>;
> -		clock-names = "apb", "smi";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -	};
> -
> -	jpegdec: jpegdec@15004000 {
> -		compatible = "mediatek,mt7623-jpgdec",
> -			     "mediatek,mt2701-jpgdec";
> -		reg = <0 0x15004000 0 0x1000>;
> -		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> -		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> -			  <&imgsys CLK_IMG_JPGDEC>;
> -		clock-names = "jpgdec-smi",
> -			      "jpgdec";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -		mediatek,larb = <&larb2>;
> -		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> -			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> -	};
> -
>   	vdecsys: syscon@16000000 {
>   		compatible = "mediatek,mt7623-vdecsys",
>   			     "mediatek,mt2701-vdecsys",
> @@ -821,18 +710,6 @@ vdecsys: syscon@16000000 {
>   		#clock-cells = <1>;
>   	};
>   
> -	larb1: larb@16010000 {
> -		compatible = "mediatek,mt7623-smi-larb",
> -			     "mediatek,mt2701-smi-larb";
> -		reg = <0 0x16010000 0 0x1000>;
> -		mediatek,smi = <&smi_common>;
> -		mediatek,larb-id = <1>;
> -		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> -			 <&vdecsys CLK_VDEC_LARB>;
> -		clock-names = "apb", "smi";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> -	};
> -
>   	hifsys: syscon@1a000000 {
>   		compatible = "mediatek,mt7623-hifsys",
>   			     "mediatek,mt2701-hifsys",
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 2b760f90f38c..344f8c65c4aa 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -6,7 +6,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/input/input.h>
> -#include "mt7623.dtsi"
> +#include "mt7623n.dtsi"
>   #include "mt6323.dtsi"
>   
>   / {
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> index 0447748f9fa0..f8efcc364bc3 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> @@ -7,7 +7,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/input/input.h>
> -#include "mt7623.dtsi"
> +#include "mt7623n.dtsi"
>   #include "mt6323.dtsi"
>   
>   / {
> diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
> new file mode 100644
> index 000000000000..a47e82468895
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt7623n.dtsi
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright © 2017-2020 MediaTek Inc.
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *	   Ryder Lee <ryder.lee@mediatek.com>
> + *
> + */
> +
> +#include "mt7623.dtsi"
> +#include <dt-bindings/memory/mt2701-larb-port.h>
> +
> +/ {
> +	g3dsys: syscon@13000000 {
> +		compatible = "mediatek,mt7623-g3dsys",
> +			     "mediatek,mt2701-g3dsys",
> +			     "syscon";
> +		reg = <0 0x13000000 0 0x200>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +	mali: gpu@13040000 {
> +		compatible = "mediatek,mt7623-mali", "arm,mali-450";
> +		reg = <0 0x13040000 0 0x30000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 178 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
> +				  "ppmmu1", "pp2", "ppmmu2", "pp3", "ppmmu3",
> +				  "pp";
> +		clocks = <&topckgen CLK_TOP_MMPLL>,
> +			 <&g3dsys CLK_G3DSYS_CORE>;
> +		clock-names = "bus", "core";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
> +		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
> +	};
> +
> +	mmsys: syscon@14000000 {
> +		compatible = "mediatek,mt7623-mmsys",
> +			     "mediatek,mt2701-mmsys",
> +			     "syscon";
> +		reg = <0 0x14000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	larb0: larb@14010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x14010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <0>;
> +		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> +			 <&mmsys CLK_MM_SMI_LARB0>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
> +	larb1: larb@16010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x16010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <1>;
> +		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> +			 <&vdecsys CLK_VDEC_LARB>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> +	};
> +
> +	larb2: larb@15001000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x15001000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <2>;
> +		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> +			 <&imgsys CLK_IMG_SMI_COMM>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +	};
> +
> +	imgsys: syscon@15000000 {
> +		compatible = "mediatek,mt7623-imgsys",
> +			     "mediatek,mt2701-imgsys",
> +			     "syscon";
> +		reg = <0 0x15000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	iommu: mmsys_iommu@10205000 {
> +		compatible = "mediatek,mt7623-m4u",
> +			     "mediatek,mt2701-m4u";
> +		reg = <0 0x10205000 0 0x1000>;
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_M4U>;
> +		clock-names = "bclk";
> +		mediatek,larbs = <&larb0 &larb1 &larb2>;
> +		#iommu-cells = <1>;
> +	};
> +
> +	jpegdec: jpegdec@15004000 {
> +		compatible = "mediatek,mt7623-jpgdec",
> +			     "mediatek,mt2701-jpgdec";
> +		reg = <0 0x15004000 0 0x1000>;
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> +		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> +			  <&imgsys CLK_IMG_JPGDEC>;
> +		clock-names = "jpgdec-smi",
> +			      "jpgdec";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +		mediatek,larb = <&larb2>;
> +		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> +			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> +	};
> +
> +	smi_common: smi@1000c000 {
> +		compatible = "mediatek,mt7623-smi-common",
> +			     "mediatek,mt2701-smi-common";
> +		reg = <0 0x1000c000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_SMI>,
> +			 <&mmsys CLK_MM_SMI_COMMON>,
> +			 <&infracfg CLK_INFRA_SMI>;
> +		clock-names = "apb", "smi", "async";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +};
> 
