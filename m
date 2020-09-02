Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81AFC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12D820786
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J1fKZ4dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBEOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:14:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47262 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:14:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0824EFoK004547;
        Tue, 1 Sep 2020 23:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599020055;
        bh=JznF+Pkj8Kcgo85mrE2pp0Q+y78Aam9ytV2DY8hzz6c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J1fKZ4dJR/INN7jbpDrqDYp8yjfmFL32cHuyteLwyOxiNC6ngegmwJk7KKAYc+F2L
         659ZdGKFyysQtVOUqRVU8ML1GWUYdcEVRz3G237zAAP7eLrUad9E3T5pj9lwAM5V8F
         MwK3Jrv8Ef3pnZkhBqYMfuhUYenK2Ge5zlaNojIM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0824EFr4042711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 23:14:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 23:14:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 23:14:15 -0500
Received: from [10.250.33.196] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0824EEgq118181;
        Tue, 1 Sep 2020 23:14:14 -0500
Subject: Re: [PATCH 3/7] arm64: dts: ti: k3-*: Use generic pinctrl for node
 names
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-4-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <e70b2bcd-c642-5c3b-e8fd-c05d020fffbc@ti.com>
Date:   Tue, 1 Sep 2020 23:14:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901223059.14801-4-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 5:30 PM, Nishanth Menon wrote:
> Use pinctrl@ naming for nodes following standard conventions of device
> tree (section 2.2.2 Generic Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 03e28fc256de..9c96e3f58c86 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -134,7 +134,7 @@
>  		};
>  	};
>  
> -	main_pmx0: pinmux@11c000 {
> +	main_pmx0: pinctrl@11c000 {
>  		compatible = "pinctrl-single";
>  		reg = <0x0 0x11c000 0x0 0x2e4>;
>  		#pinctrl-cells = <1>;
> @@ -142,7 +142,7 @@
>  		pinctrl-single,function-mask = <0xffffffff>;
>  	};
>  
> -	main_pmx1: pinmux@11c2e8 {
> +	main_pmx1: pinctrl@11c2e8 {
>  		compatible = "pinctrl-single";
>  		reg = <0x0 0x11c2e8 0x0 0x24>;
>  		#pinctrl-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 0765700a8ba8..bb498be2f0a4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -39,7 +39,7 @@
>  		reg = <0x43000014 0x4>;
>  	};
>  
> -	wkup_pmx0: pinmux@4301c000 {
> +	wkup_pmx0: pinctrl@4301c000 {
>  		compatible = "pinctrl-single";
>  		reg = <0x4301c000 0x118>;
>  		#pinctrl-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 00a36a14efe7..1d2a7c05b6f3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -327,7 +327,7 @@
>  		};
>  	};
>  
> -	main_pmx0: pinmux@11c000 {
> +	main_pmx0: pinctrl@11c000 {
>  		compatible = "pinctrl-single";
>  		/* Proxy 0 addressing */
>  		reg = <0x0 0x11c000 0x0 0x2b4>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index c4a48e8d420a..9ad0266598ad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -53,7 +53,7 @@
>  		reg = <0x0 0x43000014 0x0 0x4>;
>  	};
>  
> -	wkup_pmx0: pinmux@4301c000 {
> +	wkup_pmx0: pinctrl@4301c000 {
>  		compatible = "pinctrl-single";
>  		/* Proxy 0 addressing */
>  		reg = <0x00 0x4301c000 0x00 0x178>;
> 

