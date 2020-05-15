Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4871C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB72C2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CSoxSEe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEOKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:14:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43398 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEOKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:14:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04FAEKJM120008;
        Fri, 15 May 2020 05:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589537660;
        bh=5VD+ZVOvXQx3TUmellcch5gik8b6+bYkOX6VNcCUEp0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CSoxSEe2X9CPHZzR6JUpwFS5KEX2i05Nz07Z8cadYjaS+sdLoEwvxhlMHECWY3X+/
         Z0l2m2SKD+bt6YVBGD7aaFXan0KhVTBi1gYIwtDK2L6AreFB55huoLLbhCflJq5x98
         RGq7Gy3LtYqrNRFt8gbLlUjI52f1Q2IdY0qUCgj0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04FAEK0D114544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 05:14:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 May 2020 05:14:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 May 2020 05:14:19 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04FAEFE7038725;
        Fri, 15 May 2020 05:14:18 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-main: Update otap-del-sel
 values
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>
References: <20200507181526.12529-1-faiz_abbas@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <c59653d0-2e24-8917-f5b9-8c1044786bc9@ti.com>
Date:   Fri, 15 May 2020 13:14:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200507181526.12529-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2020 21:15, Faiz Abbas wrote:
> According to the latest AM65x Data Manual[1], a different output tap
> delay value is optimum for a given speed mode. Update these values.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> v2: Rebased to the latest mainline kernel
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 11887c72f23a..6cd9701e4ead 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -244,7 +244,17 @@
>   		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>   		mmc-ddr-1_8v;
>   		mmc-hs200-1_8v;
> -		ti,otap-del-sel = <0x2>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-mmc-hs = <0x0>;
> +		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-sdr12 = <0x0>;
> +		ti,otap-del-sel-sdr25 = <0x0>;
> +		ti,otap-del-sel-sdr50 = <0x8>;
> +		ti,otap-del-sel-sdr104 = <0x5>;

Isn't this wrong? Doc claims the value for sdr104 should be 0x7?

-Tero

> +		ti,otap-del-sel-ddr50 = <0x5>;
> +		ti,otap-del-sel-ddr52 = <0x5>;
> +		ti,otap-del-sel-hs200 = <0x5>;
> +		ti,otap-del-sel-hs400 = <0x0>;
>   		ti,trm-icp = <0x8>;
>   		dma-coherent;
>   	};
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
