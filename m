Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D2FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D322072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MNMsCdV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgICPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:38:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59884 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgICPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:38:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083DLLZQ050729;
        Thu, 3 Sep 2020 08:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599139281;
        bh=eaAGcywfA/M9ZZjeUNXOrgGSq2797CckUuCriGH8Uuc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MNMsCdV5eFxqTbHQEGUfTnxVk1GKrfbWvYHxcl4zuXlmYQIyijdVthGQvy4xp5x6E
         iLElFY2zncoMi5c0m0evL/pyrxd1ffhgCYLQkZIdyQF2O4HhMHVT8plbKLZx7ogZ4N
         eNCFMNl5i43hiAc9DxJqnkf4d+in1dcAHNlkh998=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083DLL8d064551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:21:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:21:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:21:21 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083DLHG1130034;
        Thu, 3 Sep 2020 08:21:18 -0500
Subject: Re: [PATCH V2 4/8] arm64: dts: ti: k3-am65*: Use generic clock for
 syscon clock names
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        <lokeshvutla@ti.com>, <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200903130015.21361-5-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <e8bc1cd8-a220-7cdf-19a7-ce95429dc509@ti.com>
Date:   Thu, 3 Sep 2020 18:51:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903130015.21361-5-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 6:30 PM, Nishanth Menon wrote:
> serdes and ehrpwm_tbclk nodes should be using clock@ naming for nodes
> following standard conventions of device tree (section 2.2.2 Generic
> Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> ---
> Change:
> v2:  added ehrpwm_tbclk based on review comments.
> v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-3-nm@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index a2fc508e59a6..63a1299cb0b2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -327,12 +327,12 @@
>  			reg = <0x00000210 0x4>;
>  		};
>  
> -		serdes0_clk: serdes_clk@4080 {
> +		serdes0_clk: clock@4080 {
>  			compatible = "syscon";
>  			reg = <0x00004080 0x4>;
>  		};
>  
> -		serdes1_clk: serdes_clk@4090 {
> +		serdes1_clk: clock@4090 {
>  			compatible = "syscon";
>  			reg = <0x00004090 0x4>;
>  		};
> @@ -349,7 +349,7 @@
>  			reg = <0x0000041e0 0x14>;
>  		};
>  
> -		ehrpwm_tbclk: syscon@4140 {
> +		ehrpwm_tbclk: clock@4140 {
>  			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
>  			reg = <0x4140 0x18>;
>  			#clock-cells = <1>;
> 

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>
