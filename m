Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0082A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LrOwPuUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGWUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:39:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55852 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:39:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NKd59s089716;
        Thu, 23 Jul 2020 15:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595536745;
        bh=XrrL0pTGTe0nirwnqWshWlwZVR6EPvREgS4kdAgimRo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LrOwPuUyyV1ZPuqgD7/umXCh3fdlAlbLxoqZb4BuiwAml+kgo+EEQZACViT3MJRrN
         gzVjoZtdmloQM6/1hfPdKZGLBnrCagGEUWoXOULD38Ms4zl4T8+sVzSaNWozQPEoE9
         G5POjqzlUCM/bShOMTT+/xcNmZzTJ7HTCkGy3AQo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NKd5Sl058932;
        Thu, 23 Jul 2020 15:39:05 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 15:39:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 15:39:05 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NKd4TH077831;
        Thu, 23 Jul 2020 15:39:04 -0500
Subject: Re: [PATCH 3/4] arm64: dts: ti: Add support for J7200 SoC
To:     Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
 <20200723084628.19241-4-lokeshvutla@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <7b3e1731-b7bc-8ac7-e4f7-1c16761c4f8f@ti.com>
Date:   Thu, 23 Jul 2020 15:39:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723084628.19241-4-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 3:46 AM, Lokesh Vutla wrote:
> The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
> It is targeted for automotive gateway, vehicle compute systems,
> Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
> The SoC aims to meet the complex processing needs of modern embedded
> products.
> 
> Some highlights of this SoC are:
> * Dual Cortex-A72s in a single cluster, two clusters of lockstep
>    capable dual Cortex-R5F MCUs and a Centralized Device Management and
>    Security Controller (DMSC).
> * Configurable L3 Cache and IO-coherent architecture with high data
>    throughput capable distributed DMA architecture under NAVSS.
> * Integrated Ethernet switch supporting up to a total of 4 external ports
>    in addition to legacy Ethernet switch of up to 2 ports.
> * Upto 1 PCIe-GEN3 controller, 1 USB3.0 Dual-role device subsystems,
>    20 MCANs, 3 McASP, eMMC and SD, OSPI/HyperBus memory controller, I3C
>    and I2C, eCAP/eQEP, eHRPWM among other peripherals.
> * One hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>    management.
> 
> See J7200 Technical Reference Manual (SPRUIU1, June 2020)
> for further details: https://www.ti.com/lit/pdf/spruiu1
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 199 ++++++++++++++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  84 ++++++++
>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          | 165 +++++++++++++++
>   3 files changed, 448 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> new file mode 100644
> index 000000000000..70c8f7e941fb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for J7200 SoC Family Main Domain peripherals
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_main {
> +	msmc_ram: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x70000000 0x0 0x100000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x70000000 0x100000>;
> +
> +		atf-sram@0 {
> +			reg = <0x0 0x20000>;
> +		};
> +	};
> +
> +	gic500: interrupt-controller@1800000 {
> +		compatible = "arm,gic-v3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> +		      <0x00 0x01900000 0x00 0x100000>;	/* GICR */
> +
> +		/* vcpumntirq: virtual CPU interface maintenance interrupt */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +		};
> +	};
> +
> +	main_navss: navss@30000000 {
> +		compatible = "simple-mfd";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
> +
> +		secure_proxy_main: mailbox@32c00000 {
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x32c00000 0x00 0x100000>,
> +			      <0x00 0x32400000 0x00 0x100000>,
> +			      <0x00 0x32800000 0x00 0x100000>;
> +			interrupt-names = "rx_011";
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
> +	main_pmx0: pinmux@11c000 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x0 0x11c000 0x0 0x2b4>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	main_uart0: serial@2800000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02800000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 146 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart1: serial@2810000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02810000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 278 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart2: serial@2820000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02820000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 279 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart3: serial@2830000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02830000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 280 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart4: serial@2840000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02840000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 281 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart5: serial@2850000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02850000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 282 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart6: serial@2860000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02860000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 283 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart7: serial@2870000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02870000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 284 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart8: serial@2880000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02880000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 285 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	main_uart9: serial@2890000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x02890000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 286 2>;
> +		clock-names = "fclk";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> new file mode 100644
> index 000000000000..670e4c7cd9fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for J7200 SoC Family MCU/WAKEUP Domain peripherals
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_mcu_wakeup {
> +	dmsc: dmsc@44083000 {
> +		compatible = "ti,k2g-sci";
> +		ti,host-id = <12>;
> +
> +		mbox-names = "rx", "tx";
> +
> +		mboxes= <&secure_proxy_main 11>,
> +			<&secure_proxy_main 13>;
> +
> +		reg-names = "debug_messages";
> +		reg = <0x00 0x44083000 0x0 0x1000>;
> +
> +		k3_pds: power-controller {
> +			compatible = "ti,sci-pm-domain";
> +			#power-domain-cells = <2>;
> +		};
> +
> +		k3_clks: clocks {
> +			compatible = "ti,k2g-sci-clk";
> +			#clock-cells = <2>;
> +		};
> +
> +		k3_reset: reset-controller {
> +			compatible = "ti,sci-reset";
> +			#reset-cells = <2>;
> +		};
> +	};
> +
> +	chipid@43000014 {
> +		compatible = "ti,am654-chipid";
> +		reg = <0x0 0x43000014 0x0 0x4>;
> +	};
> +
> +	wkup_pmx0: pinmux@4301c000 {
> +		compatible = "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x4301c000 0x00 0x178>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	mcu_ram: sram@41c00000 {
> +		compatible = "mmio-sram";
> +		reg = <0x00 0x41c00000 0x00 0x100000>;
> +		ranges = <0x0 0x00 0x41c00000 0x100000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +
> +	wkup_uart0: serial@42300000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x42300000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <48000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 287 2>;
> +		clock-names = "fclk";
> +	};
> +
> +	mcu_uart0: serial@40a00000 {
> +		compatible = "ti,j721e-uart", "ti,am654-uart";
> +		reg = <0x00 0x40a00000 0x00 0x100>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <96000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 149 2>;
> +		clock-names = "fclk";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> new file mode 100644
> index 000000000000..f7cee5a4ca1a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for J7200 SoC Family
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/k3.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +/ {
> +	model = "Texas Instruments K3 J7200 SoC";
> +	compatible = "ti,j7200";
> +	interrupt-parent = <&gic500>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &wkup_uart0;
> +		serial1 = &mcu_uart0;
> +		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
> +		serial4 = &main_uart2;
> +		serial5 = &main_uart3;
> +		serial6 = &main_uart4;
> +		serial7 = &main_uart5;
> +		serial8 = &main_uart6;
> +		serial9 = &main_uart7;
> +		serial10 = &main_uart8;
> +		serial11 = &main_uart9;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu-map {
> +			cluster0: cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +
> +		};
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a72";
> +			reg = <0x000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0xC000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a72";
> +			reg = <0x001>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0xC000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&L2_0>;
> +		};
> +	};
> +
> +	L2_0: l2-cache0 {
> +		compatible = "cache";
> +		cache-level = <2>;
> +		cache-size = <0x100000>;
> +		cache-line-size = <64>;
> +		cache-sets = <2048>;
> +		next-level-cache = <&msmc_l3>;
> +	};
> +
> +	msmc_l3: l3-cache0 {
> +		compatible = "cache";
> +		cache-level = <3>;
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	a72_timer0: timer-cl0-cpu0 {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	cbass_main: bus@100000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> +			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
> +			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
> +			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> +			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
> +			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00800000>, /* MSMC RAM */
> +			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT */
> +
> +			 /* MCUSS_WKUP Range */
> +			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
> +			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
> +			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
> +			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
> +			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
> +			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
> +			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
> +			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
> +			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
> +			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
> +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>;
> +
> +		cbass_mcu_wakeup: bus@28380000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
> +				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
> +				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
> +				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
> +				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
> +				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
> +				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
> +				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
> +				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
> +				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
> +				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>; /* FSS OSPI0/1 data region 0 */
> +		};
> +	};
> +};
> +
> +/* Now include the peripherals for each bus segments */
> +#include "k3-j7200-main.dtsi"
> +#include "k3-j7200-mcu-wakeup.dtsi"
> 

