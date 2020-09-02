Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A54A207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T+if4hZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIBX3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:29:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38112 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:29:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082NTg7N023002;
        Wed, 2 Sep 2020 18:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599089382;
        bh=5ismlKMcchJg6W6QoumUCgvbzAC8BXk4SjpAViJ4qts=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T+if4hZPcBLlHYJ6RddogpPBKvM+LOIs76Kcmmi5a7euud7ZIX0A3u6rSz+Q0MYxS
         YM/ns7UgKhc+OZkWjq/7VBP9DQWEV3HfnHpCfXbL6+pCLX8c5R4IcFRKpfGNdXiDVm
         9f5vBGDdAgy/4z7sSoVAQ7yzdxWYcHk29EUV/kTo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082NTgES068502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 18:29:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 18:29:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 18:29:42 -0500
Received: from [10.250.34.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082NTfUQ128253;
        Wed, 2 Sep 2020 18:29:41 -0500
Subject: Re: [v4,4/4] arm64: dts: mt8192: add infracfg_rst node
To:     Crystal Guo <crystal.guo@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <seiya.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-5-crystal.guo@mediatek.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <211bd78f-3b70-1e65-eea9-75cc73a3dfdd@ti.com>
Date:   Wed, 2 Sep 2020 18:29:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817030324.5690-5-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crystal,

On 8/16/20 10:03 PM, Crystal Guo wrote:
> add infracfg_rst node which is for MT8192 platform
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>

I understand you are posting these together for complete reference, but driver
subsystem maintainers typically don't pick dts patches. In anycase, can you
clarify if your registers are self-clearing registers?

regards
Suman

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 931e1ca17220..a0cb9904706b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>  #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/ti-syscon.h>
>  
>  / {
>  	compatible = "mediatek,mt8192";
> @@ -219,9 +220,17 @@
>  		};
>  
>  		infracfg: infracfg@10001000 {
> -			compatible = "mediatek,mt8192-infracfg", "syscon";
> +			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
>  			reg = <0 0x10001000 0 0x1000>;
>  			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "mediatek,infra-reset", "ti,syscon-reset";
> +				#reset-cells = <1>;
> +				ti,reset-bits = <
> +					0x140 15 0x144 15 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: pcie */
> +				>;
> +			};
>  		};
>  
>  		pericfg: pericfg@10003000 {
> 

