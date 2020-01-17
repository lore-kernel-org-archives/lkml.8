Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7DC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0213220728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KjJ8stgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAQM5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:57:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47614 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:57:07 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00HCuwqS121694;
        Fri, 17 Jan 2020 06:56:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579265818;
        bh=7gEJ4ZiNKYujS0X0Ji038gdLLrwdXo1/Qqki5a0GpZ8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KjJ8stgJRhMGbLfCc1+ETks+yaBrJeqybP1d3tWfJxwED2MEzi0O/vBT104pJW6Cp
         PPs2PLga3ILcgkn+/0h199LTPG9Z7fCilL9v4xyvDO5UqOdFJmjYnO34U1JjFB87wT
         G/2cpu7yoYb+DuuQBzevsjzmO1V7KO36wLpnqcjY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00HCuw5M092360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jan 2020 06:56:58 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Jan 2020 06:56:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Jan 2020 06:56:57 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00HCuu0q008811;
        Fri, 17 Jan 2020 06:56:56 -0600
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: k3-j721e: Add DT nodes for few
 peripherials
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191211170414.7026-1-vigneshr@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <5532c7dc-f8b0-497b-5a66-2bcf52b99195@ti.com>
Date:   Fri, 17 Jan 2020 14:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211170414.7026-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 19:04, Vignesh Raghavendra wrote:
> Enable I2Cs, ADCs, OSPIs and UFS peripherals present on J721e.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> v2:
> 
> Add GPIO expander IRQ lines

Queued up whole series towards 5.6, thanks!

-Tero

> 
>   .../dts/ti/k3-j721e-common-proc-board.dts     | 150 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  99 ++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 104 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  45 ++++++
>   4 files changed, 398 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2a3cd6174504..7a5c3d4adadd 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -67,6 +67,46 @@ main_usbss1_pins_default: main_usbss1_pins_default {
>   			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
>   		>;
>   	};
> +
> +	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
> +			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_i2c1_pins_default: main-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
> +			J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
> +		>;
> +	};
> +
> +	main_i2c3_pins_default: main-i2c3-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
> +			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
> +		>;
> +	};
> +
> +	main_i2c6_pins_default: main-i2c6-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
> +			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
> +		>;
> +	};
> +
> +	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
> +		 >;
> +	};
>   };
>   
>   &wkup_pmx0 {
> @@ -75,6 +115,19 @@ sw11_button_pins_default: sw11_button_pins_default {
>   			J721E_WKUP_IOPAD(0xcc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
>   		>;
>   	};
> +
> +	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x34, PIN_OUTPUT, 0) /* (F22) MCU_OSPI1_CLK */
> +			J721E_WKUP_IOPAD(0x50, PIN_OUTPUT, 0) /* (C22) MCU_OSPI1_CSn0 */
> +			J721E_WKUP_IOPAD(0x40, PIN_INPUT, 0) /* (D22) MCU_OSPI1_D0 */
> +			J721E_WKUP_IOPAD(0x44, PIN_INPUT, 0) /* (G22) MCU_OSPI1_D1 */
> +			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (D23) MCU_OSPI1_D2 */
> +			J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 0) /* (C23) MCU_OSPI1_D3 */
> +			J721E_WKUP_IOPAD(0x3c, PIN_INPUT, 0) /* (B23) MCU_OSPI1_DQS */
> +			J721E_WKUP_IOPAD(0x38, PIN_INPUT, 0) /* (A23) MCU_OSPI1_LBCLKO */
> +		>;
> +	};
>   };
>   
>   &wkup_uart0 {
> @@ -279,3 +332,100 @@ &usb1 {
>   	dr_mode = "host";
>   	maximum-speed = "high-speed";
>   };
> +
> +&ospi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
> +
> +	flash@0{
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <40000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&tscadc0 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp1: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	exp2: gpio@22 {
> +		compatible = "ti,tca6424";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp4: gpio@20 {
> +		compatible = "ti,tca6408";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&main_i2c1_exp4_pins_default>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&main_i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c3_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp3: gpio@20 {
> +		compatible = "ti,tca6408";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&main_i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c6_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp5: gpio@20 {
> +		compatible = "ti,tca6408";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 1e4c2b78d66d..4f14b9a645c5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -596,4 +596,103 @@ usb1: usb@6400000 {
>   			dr_mode = "otg";
>   		};
>   	};
> +
> +	main_i2c0: i2c@2000000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2000000 0x0 0x100>;
> +		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 187 0>;
> +		power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
> +	};
> +
> +	main_i2c1: i2c@2010000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2010000 0x0 0x100>;
> +		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 188 0>;
> +		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	main_i2c2: i2c@2020000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2020000 0x0 0x100>;
> +		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 189 0>;
> +		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	main_i2c3: i2c@2030000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2030000 0x0 0x100>;
> +		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 190 0>;
> +		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	main_i2c4: i2c@2040000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2040000 0x0 0x100>;
> +		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 191 0>;
> +		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	main_i2c5: i2c@2050000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2050000 0x0 0x100>;
> +		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 192 0>;
> +		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	main_i2c6: i2c@2060000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2060000 0x0 0x100>;
> +		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 193 0>;
> +		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	ufs_wrapper: ufs-wrapper@4e80000 {
> +		compatible = "ti,j721e-ufs";
> +		reg = <0x0 0x4e80000 0x0 0x100>;
> +		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 277 1>;
> +		assigned-clocks = <&k3_clks 277 1>;
> +		assigned-clock-parents = <&k3_clks 277 4>;
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ufs@4e84000 {
> +			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
> +			reg = <0x0 0x4e84000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			freq-table-hz = <250000000 250000000>, <19200000 19200000>, <19200000 19200000>;
> +			clocks = <&k3_clks 277 0>, <&k3_clks 277 1>, <&k3_clks 277 1>;
> +			clock-names = "core_clk", "phy_clk", "ref_clk";
> +			dma-coherent;
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 555dc7b7aedc..7cf1490f3928 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -121,4 +121,108 @@ wkup_gpio1: gpio@42100000 {
>   		clocks = <&k3_clks 114 0>;
>   		clock-names = "gpio";
>   	};
> +
> +	mcu_i2c0: i2c@40b00000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x40b00000 0x0 0x100>;
> +		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 194 0>;
> +		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	mcu_i2c1: i2c@40b10000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x40b10000 0x0 0x100>;
> +		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 195 0>;
> +		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	wkup_i2c0: i2c@42120000 {
> +		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x42120000 0x0 0x100>;
> +		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 197 0>;
> +		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
> +	};
> +
> +	fss: fss@47000000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x47000000 0x0 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi";
> +			reg = <0x0 0x47040000 0x0 0x100>,
> +				<0x5 0x00000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 103 0>;
> +			assigned-clocks = <&k3_clks 103 0>;
> +			assigned-clock-parents = <&k3_clks 103 2>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		ospi1: spi@47050000 {
> +			compatible = "ti,am654-ospi";
> +			reg = <0x0 0x47050000 0x0 0x100>,
> +				<0x7 0x00000000 0x1 0x00000000>;
> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 104 0>;
> +			power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	tscadc0: tscadc@40200000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x0 0x40200000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 0 1>;
> +		assigned-clocks = <&k3_clks 0 3>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am3359-adc";
> +		};
> +	};
> +
> +	tscadc1: tscadc@40210000 {
> +		compatible = "ti,am3359-tscadc";
> +		reg = <0x0 0x40210000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 1 1>;
> +		assigned-clocks = <&k3_clks 1 3>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am3359-adc";
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 1884fc70148f..7680109ca60a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -27,3 +27,48 @@ secure_ddr: optee@9e800000 {
>   		};
>   	};
>   };
> +
> +&wkup_pmx0 {
> +	wkup_i2c0_pins_default: wkup_i2c0_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
> +			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
> +		>;
> +	};
> +
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
> +			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
> +			J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
> +			J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
> +			J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
> +			J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
> +			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
> +			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
> +			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
> +			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
> +			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
> +		>;
> +	};
> +};
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +
> +	flash@0{
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <40000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
