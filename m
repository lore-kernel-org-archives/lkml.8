Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1EC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CDD20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MbZXF4kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIBQvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:51:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54248 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIBQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:51:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082Gp5Pi033319;
        Wed, 2 Sep 2020 11:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599065465;
        bh=dDTC0gpdXie8DL9+hkg/Fiz8VsxEy70PtTPaF9NGk88=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MbZXF4kHAWsQrSOmCIKVq4M7gPmwVSHjYUy0LvUa0K1wiYX8R+md9/hnxngJrx/im
         q5371/6H3GfnClaIE2TUPU5Zl8O10v6Mc7NcxK9UxW9DjlEd3Rxwn0MkxZ3pYwnltx
         VO2LyhJUciRtsGOWOtSKDP2PKL2/9s1z7C4igTAE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082Gp4eq095150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 11:51:05 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 11:51:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 11:51:04 -0500
Received: from [10.250.34.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082Gp4rc046690;
        Wed, 2 Sep 2020 11:51:04 -0500
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-*: Use generic adc for node names
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-7-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <60e6b790-360a-6eaf-03a3-5bb256adf215@ti.com>
Date:   Wed, 2 Sep 2020 11:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901223059.14801-7-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 5:30 PM, Nishanth Menon wrote:
> Use adc@ naming for nodes following standard conventions of device
> tree (section 2.2.2 Generic Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 51ca4b4d4c21..6dfec68ac865 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -80,7 +80,7 @@
>  		#size-cells = <0>;
>  	};
>  
> -	tscadc0: tscadc@40200000 {
> +	tscadc0: adc@40200000 {

OK with these changes, since these seem to be only have the adc child nodes.
This node is essentially a parent node for touchscreen and adc child nodes. The
driver is currently looking for "tsc" on touchscreen child nodes, but none of
the K3 SoCs have them atm.

regards
Suman

>  		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
>  		reg = <0x0 0x40200000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
> @@ -98,7 +98,7 @@
>  		};
>  	};
>  
> -	tscadc1: tscadc@40210000 {
> +	tscadc1: adc@40210000 {
>  		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
>  		reg = <0x0 0x40210000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 9ad0266598ad..81801f519a61 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -211,7 +211,7 @@
>  		};
>  	};
>  
> -	tscadc0: tscadc@40200000 {
> +	tscadc0: adc@40200000 {
>  		compatible = "ti,am3359-tscadc";
>  		reg = <0x0 0x40200000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
> @@ -230,7 +230,7 @@
>  		};
>  	};
>  
> -	tscadc1: tscadc@40210000 {
> +	tscadc1: adc@40210000 {
>  		compatible = "ti,am3359-tscadc";
>  		reg = <0x0 0x40210000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
> 

