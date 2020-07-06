Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D45A2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LKSmgX1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgGFPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:55:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgGFPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:55:33 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200706155528epoutp025f4aceb52af71cfdf165d8458bfdaee3~fNN_-1DBr0087600876epoutp02f
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:55:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200706155528epoutp025f4aceb52af71cfdf165d8458bfdaee3~fNN_-1DBr0087600876epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594050928;
        bh=a4hOPj26ktkNZHMlwsv2FkutL1xG3z97DNNHsP0XOpw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LKSmgX1ltTnL4p6bgw3xXRLKKWbKhCKnsARtiPWcuxEvBb773v6yroFfTHItb6zb6
         StEeYTHeCgAXbwhHDENnd8Cmd1c5bURpirbRdYdPvLV80oyG0/J0fr+OsB/ypJp3Og
         M4MwJGfveM7KclY0IWsdH7j3BEAeBsc7Eo1OvrKI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200706155527epcas5p2e6243c6da52b06fe49ca112876ed3aa9~fNN_JMqf91335313353epcas5p2S;
        Mon,  6 Jul 2020 15:55:27 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.F6.09467.F69430F5; Tue,  7 Jul 2020 00:55:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200706155526epcas5p3fc2749953ec193916309c02a0ea22cd4~fNN8wkaPD0274002740epcas5p3E;
        Mon,  6 Jul 2020 15:55:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200706155526epsmtrp29de71ffaa2a8b6157c665a9b43741db1~fNN8vzB6g0223802238epsmtrp2S;
        Mon,  6 Jul 2020 15:55:26 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-22-5f03496f4877
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.1B.08382.E69430F5; Tue,  7 Jul 2020 00:55:26 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200706155522epsmtip2c9ba57bcd0ed911d635f8c83b935389c~fNN5T3O9_3071330713epsmtip2v;
        Mon,  6 Jul 2020 15:55:22 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        "'Sylwester Nawrocki'" <snawrocki@kernel.org>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <20200705181754.13284-1-krzk@kernel.org>
Subject: RE: [PATCH v3] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
Date:   Mon, 6 Jul 2020 21:25:20 +0530
Message-ID: <02e701d653ad$dd155a20$97400e60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGWPQF/hEIPjRkXfGvxA0ds6tRIKQJHnZulqWiklCA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmhm6+J3O8wZ8DOhYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLRVu/sFu07j3CbtH+9CWzA7fHplWd
        bB6bl9R79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8aT89cYC5Y2M1Yce7ybpYHxUlIXIyeH
        hICJxIvvE1i6GLk4hAR2M0pMvXaUEcL5xCjxetZvdgjnG6NE1+PrzDAtJ+7NgKrayyixsXMm
        C0hCSOANo8SKvbEgNpuArsSOxW1sIEUiAu1MEnv3LwdzmAWOMUr0r/0ENJeDg1PAVGJpnx1I
        g7BAhsSGGVfZQWwWARWJFZfns4CU8ApYSrz9lwgS5hUQlDg58wnYLmYBeYntb+dAHaQg8fPp
        MlYQW0TASuLMjlOMEDXiEkd/9jCDrJUQ2MIh0bbjLjtEg4tE953pULawxKvjW6BsKYnP7/ay
        geyVEMiW6NllDBGukVg67xgLhG0vceDKHLDTmAU0Jdbv0odYxSfR+/sJE0Qnr0RHmxBEtapE
        87urUJ3SEhO7u1khbA+JzZ/msU1gVJyF5LFZSB6bheSBWQjLFjCyrGKUTC0ozk1PLTYtMMxL
        LdcrTswtLs1L10vOz93ECE5RWp47GO8++KB3iJGJg/EQowQHs5IIb682Y7wQb0piZVVqUX58
        UWlOavEhRmkOFiVxXqUfZ+KEBNITS1KzU1MLUotgskwcnFINTBvaWY5XeaZ+qUjUDDJTZltu
        n3r0eoeRmMW061OatYzmBJ9+UeH/M9459e2OuXL78+YGrVqy2uGGq/JFhWtWjp8myJcUqpxv
        fap8sarLQuh2+ZefpimF8WEupl8++VdyeidfmL6qbIZPhcW7e08zF63lKZYK/9qqsdCt9qWk
        yLHlJXMEGdao+lgdLOpasMji7pb/755k6c7Ou7FQY1Kx0ere3N+hYf8fLeG5bPSKP1Js6rz7
        USsmLHgkEvf45WsBu58zvmrpsP90/sPd6dR84EOt8je5pcJcU2ROyl9qy9fZ+DE9xX+dPfvc
        Estfdqvf9awQc488wf3PeL1LyUn2VntOP5X9f6Kk3FkCFvXLKLEUZyQaajEXFScCAIbF3G3A
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvG6eJ3O8wecWXouNM9azWlz/8pzV
        Yv6Rc6wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFoq1f2C1a9x5ht2h/+pLZgdtj06pO
        No/NS+o9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PJ+WuMBUubGSuOPd7N0sB4KamLkZND
        QsBE4sS9GYxdjFwcQgK7GSU+n3/IBpGQlri+cQI7hC0ssfLfc3aIoleMEif3f2UGSbAJ6Ers
        WNwG1iAi0MskcfK9CUgRs8AJRomfdyewQXS0MUrceP2DpYuRg4NTwFRiaZ8dSIOwQJpE1/2/
        jCA2i4CKxIrL88FKeAUsJd7+SwQJ8woISpyc+QQszCygJ9G2EayaWUBeYvvbOcwQtylI/Hy6
        jBXiBCuJMztOQdWISxz92cM8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1
        ihNzi0vz0vWS83M3MYIjTUtzB+P2VR/0DjEycTAeYpTgYFYS4e3VZowX4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznujcGGckEB6YklqdmpqQWoRTJaJg1OqgWmPT0C9queZwLq063u5FzdnPfh/
        6elR5w0KggkXFp1IKuC99sHAylnVJXSdhFGlUcS289wXn/66IH9K4ktCwI7nOUnRx12eBl24
        +93if6z0h/vnKi/sPdS8/Ou0XwunL2D5NOff2/zDi2+cnbX3fASL091MwSaWQtaf3Qp7fZed
        PRh14+tybrFo09kO9jzGVxq0OP94rvl7ibHyqEPN/ogf93yWaRy5rhpjpHhhy8xlXdJi2zSm
        zflzveFk/8XUTTeCF+nZ8J0rfbGxJ9Z+OQNzSUbwzRkeZQzf51+9dCd27eeMGVcDr3L8Spu2
        pNEkhUvZ66Pgfvc+iz5bIalDCVLvj5qfqud0nRPddfqFpPceJZbijERDLeai4kQAAMNRfyMD
        AAA=
X-CMS-MailID: 20200706155526epcas5p3fc2749953ec193916309c02a0ea22cd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705181808epcas5p17b8cc48c46ecedad9d3252c6359869ea
References: <CGME20200705181808epcas5p17b8cc48c46ecedad9d3252c6359869ea@epcas5p1.samsung.com>
        <20200705181754.13284-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 05 July 2020 23:48
> To: Rob Herring <robh+dt@kernel.org>; Kukjin Kim <kgene@kernel.org>;
> Krzysztof Kozlowski <krzk@kernel.org>; devicetree@vger.kernel.org;
linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; Sylwester
Nawrocki
> <snawrocki@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>; Chanwoo
> Choi <cw00.choi@samsung.com>; Pankaj Dubey
> <pankaj.dubey@samsung.com>
> Subject: [PATCH v3] ARM: dts: exynos: Remove DMA controller bus node name
> to fix dtschema warnings
> 
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
> 
>     amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-
> 9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
> 
> Changes since v2:
> 1. Keep the alphabetical order in exynos4210-universal_c210.dts, as
suggested
> by Marek
> 
> Changes since v1:
> 1. Remove the bus, as suggested by Marek
> ---
>  arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
>  arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
>  .../boot/dts/exynos4210-universal_c210.dts    |  28 ++--
>  arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
>  arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
>  6 files changed, 187 insertions(+), 226 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi
> b/arch/arm/boot/dts/exynos3250.dtsi
> index 044e5da64a76..d3fb45a56527 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -418,33 +418,26 @@
>  			status = "disabled";
>  		};
> 
> -		amba {
> -			compatible = "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 138
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 139
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cmu CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>  		};
> 
>  		adc: adc@126c0000 {
> diff --git a/arch/arm/boot/dts/exynos4.dtsi
b/arch/arm/boot/dts/exynos4.dtsi
> index d2779a790ce3..a1e54449f33f 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -669,45 +669,37 @@
>  			status = "disabled";
>  		};
> 
> -		amba: amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@12680000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12680000 0x1000>;
> -				interrupts = <GIC_SPI 35
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@12690000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12690000 0x1000>;
> -				interrupts = <GIC_SPI 36
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma1: mdma@12850000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x12850000 0x1000>;
> -				interrupts = <GIC_SPI 34
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@12680000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12680000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@12690000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12690000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma1: mdma@12850000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x12850000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>  		};
> 
>  		fimd: fimd@11c00000 {
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 02fde1a75ebd..99ce53b120ac 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -181,20 +181,6 @@
>  	};
>  };
> 
> -&amba {
> -	mdma0: mdma@12840000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x12840000 0x1000>;
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clock CLK_MDMA>;
> -		clock-names = "apb_pclk";
> -		#dma-cells = <1>;
> -		#dma-channels = <8>;
> -		#dma-requests = <1>;
> -		power-domains = <&pd_lcd0>;
> -	};
> -};
> -
>  &camera {
>  	status = "okay";
> 
> @@ -616,6 +602,20 @@
>  	/delete-property/dma-names;
>  };
> 
> +&soc {
> +	mdma0: mdma@12840000 {
> +		compatible = "arm,pl330", "arm,primecell";
> +		reg = <0x12840000 0x1000>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clock CLK_MDMA>;
> +		clock-names = "apb_pclk";
> +		#dma-cells = <1>;
> +		#dma-channels = <8>;
> +		#dma-requests = <1>;
> +		power-domains = <&pd_lcd0>;
> +	};
> +};
> +
>  &sysram {
>  	smp-sram@0 {
>  		status = "disabled";
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index b6135af7ef39..e3dbe4166836 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -679,56 +679,48 @@
>  			samsung,pmureg-phandle =
> <&pmu_system_controller>;
>  		};
> 
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> -
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>  		};
> 
>  		gsc_0:  gsc@13e00000 {
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi
> b/arch/arm/boot/dts/exynos5410.dtsi
> index 2eab80bf5f3a..abe75b9e39f5 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -189,34 +189,26 @@
>  			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> 
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121a0000 0x1000>;
> -				interrupts = <GIC_SPI 34
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121a0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> 
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121b0000 0x1000>;
> -				interrupts = <GIC_SPI 35
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121b0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>  		};
> 
>  		audi2s0: i2s@3830000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi
> index b672080e7469..c76460b70532 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -433,76 +433,68 @@
>  			power-domains = <&mau_pd>;
>  		};
> 
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			interrupt-parent = <&gic>;
> -			ranges;
> -
> -			adma: adma@3880000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x03880000 0x1000>;
> -				interrupts = <GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock_audss EXYNOS_ADMA>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <6>;
> -				#dma-requests = <16>;
> -				power-domains = <&mau_pd>;
> -			};
> -
> -			pdma0: pdma@121a0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> -				interrupts = <GIC_SPI 34
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			pdma1: pdma@121b0000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> -				interrupts = <GIC_SPI 35
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> -
> -			mdma0: mdma@10800000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x10800000 0x1000>;
> -				interrupts = <GIC_SPI 33
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -			};
> +		adma: adma@3880000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x03880000 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock_audss EXYNOS_ADMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <6>;
> +			#dma-requests = <16>;
> +			power-domains = <&mau_pd>;
> +		};
> 
> -			mdma1: mdma@11c10000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x11C10000 0x1000>;
> -				interrupts = <GIC_SPI 124
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clock CLK_MDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <1>;
> -				/*
> -				 * MDMA1 can support both secure and non-
> secure
> -				 * AXI transactions. When this is enabled in
> -				 * the kernel for boards that run in secure
> -				 * mode, we are getting imprecise external
> -				 * aborts causing the kernel to oops.
> -				 */
> -				status = "disabled";
> -			};
> +		pdma0: pdma@121a0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma@121b0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma@10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma@11c10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_MDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +			/*
> +			 * MDMA1 can support both secure and non-secure
> +			 * AXI transactions. When this is enabled in
> +			 * the kernel for boards that run in secure
> +			 * mode, we are getting imprecise external
> +			 * aborts causing the kernel to oops.
> +			 */
> +			status = "disabled";
>  		};
> 
>  		i2s0: i2s@3830000 {
> --
> 2.17.1


