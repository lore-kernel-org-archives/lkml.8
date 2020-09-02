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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC9C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0F22068E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TupaLDp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIBEOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:14:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38264 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:14:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0824E44s084975;
        Tue, 1 Sep 2020 23:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599020044;
        bh=KwAISsLDVHuoZdm5xkppTmt/lsDajGkiLvyRB4f47/8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TupaLDp2MewCoH4g8NbEESfmrML0KPIngqoQxx8+yEgRnu0iusPtPQrsrf8VKxnYS
         2VCMvwxGyW5lkLTU1s0IB+YE61Mu49oRCSgBMIlKEf6xUyC4uzYWBtYQnkv3KdvVfT
         frowq+q3u8VKG2x6SKDZZO4WwX5TB9FO3me2/AL0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0824E4TF102757;
        Tue, 1 Sep 2020 23:14:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 23:14:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 23:14:03 -0500
Received: from [10.250.33.196] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0824E3fS117806;
        Tue, 1 Sep 2020 23:14:03 -0500
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-am65*: Use generic gpio for node
 names
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-2-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <77863cb8-7ea7-5975-404a-fa96459671e0@ti.com>
Date:   Tue, 1 Sep 2020 23:13:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901223059.14801-2-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 5:30 PM, Nishanth Menon wrote:
> Use gpio@ naming for nodes following standard conventions of device
> tree (section 2.2.2 Generic Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 76e0edc4ad5c..336d09d6fec7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -661,7 +661,7 @@
>  		};
>  	};
>  
> -	main_gpio0:  main_gpio0@600000 {
> +	main_gpio0: gpio@600000 {
>  		compatible = "ti,am654-gpio", "ti,keystone-gpio";
>  		reg = <0x0 0x600000 0x0 0x100>;
>  		gpio-controller;
> @@ -676,7 +676,7 @@
>  		clock-names = "gpio";
>  	};
>  
> -	main_gpio1:  main_gpio1@601000 {
> +	main_gpio1: gpio@601000 {
>  		compatible = "ti,am654-gpio", "ti,keystone-gpio";
>  		reg = <0x0 0x601000 0x0 0x100>;
>  		gpio-controller;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index a1ffe88d9664..0765700a8ba8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -80,7 +80,7 @@
>  		ti,interrupt-ranges = <0 712 16>;
>  	};
>  
> -	wkup_gpio0: wkup_gpio0@42110000 {
> +	wkup_gpio0: gpio@42110000 {
>  		compatible = "ti,am654-gpio", "ti,keystone-gpio";
>  		reg = <0x42110000 0x100>;
>  		gpio-controller;
> 

