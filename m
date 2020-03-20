Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9DC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A7F20752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mHza96b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCTJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:07:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40488 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:07:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K97sDA001263;
        Fri, 20 Mar 2020 04:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584695274;
        bh=N8POESgNbRbRirVxkmMy0bAxBkY2aB1P4q5cc5w0mZo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mHza96b7BZmaVRgaeagy0y5m6jAPu+h2wV85HjMq/r3EDQJnw5EnynO5ZVLHliB2u
         c4y8uR+tzc6NS8IxObqB44szLlr3vXVzSZbACpm9vxtrxYbEjB6cZTqeOQD/OBI5xi
         khOb7mZKyJDApLNYF1OMtXAhFkYP6E2rvwv1iEbA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K97slN035967;
        Fri, 20 Mar 2020 04:07:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 04:07:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 04:07:53 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K97pHN012013;
        Fri, 20 Mar 2020 04:07:52 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-mcu-wakeup: Add DMA entries for
 ADC
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200312121251.4582-1-vigneshr@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <10d8a214-82e7-e245-7a81-70f2dd59e7df@ti.com>
Date:   Fri, 20 Mar 2020 11:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312121251.4582-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 14:12, Vignesh Raghavendra wrote:
> Add DMA entries for ADC nodes
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Queued up for 5.7, thanks.

-Tero


> ---
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 16c874bfd49a..23f8a9dbb595 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -203,6 +203,9 @@ tscadc0: tscadc@40200000 {
>   		assigned-clocks = <&k3_clks 0 3>;
>   		assigned-clock-rates = <60000000>;
>   		clock-names = "adc_tsc_fck";
> +		dmas = <&main_udmap 0x7400>,
> +			<&main_udmap 0x7401>;
> +		dma-names = "fifo0", "fifo1";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> @@ -219,6 +222,9 @@ tscadc1: tscadc@40210000 {
>   		assigned-clocks = <&k3_clks 1 3>;
>   		assigned-clock-rates = <60000000>;
>   		clock-names = "adc_tsc_fck";
> +		dmas = <&main_udmap 0x7402>,
> +			<&main_udmap 0x7403>;
> +		dma-names = "fifo0", "fifo1";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
