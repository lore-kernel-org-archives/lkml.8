Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26995C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C622072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZBBjk6Rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgAQIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:08:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58740 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:08:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00H88Tu3019621;
        Fri, 17 Jan 2020 02:08:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579248509;
        bh=h04PjAMDL1FtVudgz/Df4dwDowqI3YAr79xF/WspK4g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZBBjk6Rve2UPz25W/dSwPh/q1PllomFVILWHvh1uHVpp7IpeW8yRUKO7YjGO2vEFF
         zVhwxLq5CHrvun2rUcSiFPg/MUcvUuFOLse+Njw/H+ewHZ21TM4SrX/VzJ8O8AiUXc
         EK+TEqgPwSsaQv/4dl3NipafMwGZ2CVF4XoDv3S8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00H88Tt6052815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jan 2020 02:08:29 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Jan 2020 02:08:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Jan 2020 02:08:29 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00H88QTL071044;
        Fri, 17 Jan 2020 02:08:27 -0600
Subject: Re: [PATCH] arm: dts: ti: k3-am654-main: Update otap-del-sel values
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>
References: <20200109085152.10573-1-faiz_abbas@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <5dc0bca0-502d-01b8-554b-4c4bc06688a8@ti.com>
Date:   Fri, 17 Jan 2020 10:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109085152.10573-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 10:51, Faiz Abbas wrote:
> According to the latest AM65x Data Manual[1], a different output tap
> delay value is optimum for a given speed mode. Update these values.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

I believe this patch is going to be updated, as the dt binding has 
received comments. As such, going to ignore this for now.

-Tero

> ---
> 
> This patch depends on my two kernel series posted here:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=225425
> https://patchwork.kernel.org/project/linux-mmc/list/?series=225459
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index efb24579922c..c8d812fdfa0a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -253,7 +253,17 @@
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
