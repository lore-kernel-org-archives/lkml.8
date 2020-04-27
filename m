Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8CC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02601206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q4gWjPDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgD0KJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:09:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59964 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0KJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:09:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RA8jQ4048624;
        Mon, 27 Apr 2020 05:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587982125;
        bh=0BSivvB38GQp/I42y/EWTA/TBEG/9XtWq5DZOBtwxTA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=q4gWjPDJ/OKAvr1CpLQrnpndq2lnxsEnu3pZC2g17O7c1GOBAIJtgBITRjvKPJWMf
         9VtV71DVdMMOGWp1VXVZGJfR/Ms3CVQVysP7xgdxaEy95ryKKRmh2sKqB83hpIfC40
         KfMIbJ1XgqZ4J5ERFaw6NkIlIDhcGRq81DFu51LI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RA8jkn080564;
        Mon, 27 Apr 2020 05:08:45 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:08:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:08:45 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RA8gKT075451;
        Mon, 27 Apr 2020 05:08:43 -0500
Subject: Re: [PATCH 1/3] arm64: dts: ti: am654: Add DSS node
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <591ddc8e-b45a-5a36-ae81-e1b92727dd2d@ti.com>
Date:   Mon, 27 Apr 2020 13:08:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200422091512.950-1-tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 12:15, Tomi Valkeinen wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> Add DSS node to k3-am65-main.dtsi with labels for board specific
> support and syscon node for oldi-io-ctrl.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 44 ++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 11887c72f23a..7d1bc991708e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -287,6 +287,11 @@
>   			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>   					<0x4090 0x3>; /* SERDES1 lane select */
>   		};
> +
> +		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
> +			compatible = "syscon";
> +			reg = <0x0000041E0 0x14>;
> +		};
>   	};
>   
>   	dwc3_0: dwc3@4000000 {
> @@ -746,4 +751,43 @@
>   			};
>   		};
>   	};
> +
> +	dss: dss@04a00000 {
> +		compatible = "ti,am65x-dss";
> +		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
> +			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
> +			<0x0 0x04a06000 0x0 0x1000>, /* vid */
> +			<0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
> +			<0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
> +			<0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
> +			<0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
> +		reg-names = "common", "vidl1", "vid",
> +			"ovr1", "ovr2", "vp1", "vp2";
> +
> +		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
> +
> +		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
> +
> +		clocks =	<&k3_clks 67 1>,
> +				<&k3_clks 216 1>,
> +				<&k3_clks 67 2>;
> +		clock-names = "fck", "vp1", "vp2";
> +
> +		/*
> +		 * Set vp2 clk (DPI_1_IN_CLK) mux to PLL4 via
> +		 * DIV1. See "Figure 12-3365. DSS Integration"
> +		 * in AM65x TRM for details.
> +		 */
> +		assigned-clocks = <&k3_clks 67 2>;
> +		assigned-clock-parents = <&k3_clks 67 5>;
> +
> +		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
> +
> +		status = "disabled";

Any reason why the node is disabled? Are you planning to enable it 
somewhere later on, or is that left for the user to do?

-Tero

> +
> +		dss_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
>   };
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
