Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E623C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F7C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sl4jeNcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCTJHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:07:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40440 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:07:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K9749f001160;
        Fri, 20 Mar 2020 04:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584695224;
        bh=Utp2bYw61RXYVAOCnJQvVihm8BNTybfuAKiMIT8R1Z4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sl4jeNcX4+ZPpF6DMIQR3I+jARl4W9KcDQ6lG32NW6KQ9aK+kOrjBCg+xsTyVaTlL
         d9wN6hHlSsOAn8gzsN0hrgAAdQI7LEbaU4mcHy0E7cZV++UrUgJrFINq4a5YwSBV9R
         rBPVSxQfRMTXjZcDGxZXXoZl+3bnGUpxb8ZKhTqI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K974bl035172;
        Fri, 20 Mar 2020 04:07:04 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 04:07:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 04:07:04 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K970g2086730;
        Fri, 20 Mar 2020 04:07:02 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Add clocks to dwc3 nodes
To:     Roger Quadros <rogerq@ti.com>
CC:     <nm@ti.com>, <d-gerlach@ti.com>, <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>
References: <20200311144111.7112-1-rogerq@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <3dcb6199-2276-7aa5-2857-1208f8024b56@ti.com>
Date:   Fri, 20 Mar 2020 11:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311144111.7112-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2020 16:41, Roger Quadros wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> The TI sci-clk driver can scan the DT for all clocks provided by system
> firmware and does this by checking the clocks property of all nodes, so
> we must add this to the dwc3 nodes so USB clocks are available.
> 
> Without this USB does not work with latest system firmware i.e.
> [    1.714662] clk: couldn't get parent clock 0 for /interconnect@100000/dwc3@4020000
> 
> Fixes: cc54a99464ccd ("arm64: dts: ti: k3-am6: add USB suppor")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: stable@kernel.org
> ---

Queued up towards 5.7, thanks.

-Tero

>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index e5df20a2d2f9..d86c5c7b82fc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -296,6 +296,7 @@
>   		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>   		dma-coherent;
>   		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
>   		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
>   		assigned-clock-parents = <&k3_clks 151 4>,	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>   					 <&k3_clks 151 9>;	/* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
> @@ -335,6 +336,7 @@
>   		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
>   		dma-coherent;
>   		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 152 2>;
>   		assigned-clocks = <&k3_clks 152 2>;
>   		assigned-clock-parents = <&k3_clks 152 4>;	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>   
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
