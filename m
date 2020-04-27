Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76029C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BD9206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I6JmHCAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0K2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:28:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33592 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0K2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:28:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RASC6I053238;
        Mon, 27 Apr 2020 05:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587983292;
        bh=OIoRkEDtSdqjO07eoDGoCXzJPcwcaFncwmq6XymLSwQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I6JmHCAwl0UmdN6MVgBG7ihi8V0D6OjmzdLnTWGgj6DEW/JyGj09c7o7gPOXG63LQ
         naaPd8fQRButejVsBYVlpq3/tXzzgdkTzhyFc4mJ6Z4tZofTAoBHmht/0+yhHcjnQb
         iTAIDeLMxwe7MBTmSvRRDvqkKTSn5tY2T86GfoNc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RASC93101456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 05:28:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:28:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:28:12 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RAS9l5043373;
        Mon, 27 Apr 2020 05:28:10 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-main: Add ehrpwm nodes
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200322112630.25541-1-vigneshr@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <0ebef6a3-7b0e-fc3a-3101-7e1a135093b0@ti.com>
Date:   Mon, 27 Apr 2020 13:28:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322112630.25541-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2020 13:26, Vignesh Raghavendra wrote:
> Add DT nodes for all ehrpwm instances present on AM654 EVM.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> clk driver and bindings has been merged to clk-next tree.

Queued up for 5.8, thanks.

-Tero

> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 60 ++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index e5df20a2d2f9..da6427bed801 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -285,6 +285,12 @@ serdes_mux: mux-controller {
>   			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>   					<0x4090 0x3>; /* SERDES1 lane select */
>   		};
> +
> +		ehrpwm_tbclk: syscon@4140 {
> +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> +			reg = <0x4140 0x18>;
> +			#clock-cells = <1>;
> +		};
>   	};
>   
>   	dwc3_0: dwc3@4000000 {
> @@ -742,4 +748,58 @@ csi2_0: port@0 {
>   			};
>   		};
>   	};
> +
> +	ehrpwm0: pwm@3000000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3000000 0x0 0x100>;
> +		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 40 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	ehrpwm1: pwm@3010000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3010000 0x0 0x100>;
> +		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 41 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	ehrpwm2: pwm@3020000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3020000 0x0 0x100>;
> +		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 42 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	ehrpwm3: pwm@3030000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3030000 0x0 0x100>;
> +		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 43 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	ehrpwm4: pwm@3040000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3040000 0x0 0x100>;
> +		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 44 0>;
> +		clock-names = "tbclk", "fck";
> +	};
> +
> +	ehrpwm5: pwm@3050000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x3050000 0x0 0x100>;
> +		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 45 0>;
> +		clock-names = "tbclk", "fck";
> +	};
>   };
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
