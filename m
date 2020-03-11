Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B688CC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952C921655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgCKLWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:22:39 -0400
Received: from foss.arm.com ([217.140.110.172]:48308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:22:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5BC1FB;
        Wed, 11 Mar 2020 04:22:38 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A60F3F6CF;
        Wed, 11 Mar 2020 04:22:37 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:22:35 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: r40: Move SPI device nodes based
 on address order
Message-ID: <20200311112235.62d89683@donnerap.cambridge.arm.com>
In-Reply-To: <20200310174709.24174-4-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
        <20200310174709.24174-4-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 01:47:09 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> When the SPI device nodes were added, they were added in the wrong
> location in the device tree file. The device nodes should be sorted
> by register address.
> 
> Move the devices node to their correct positions within the file.

Diffed the minus and plus lines, it's indeed a pure move:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> 
> Fixes: 554581b79139 ("ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 104 +++++++++++++++----------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 81cc92ddc78b..f0ede4f52aa3 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -198,6 +198,32 @@ nmi_intc: interrupt-controller@1c00030 {
>  			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		spi0: spi@1c05000 {
> +			compatible = "allwinner,sun8i-r40-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c05000 0x1000>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		spi1: spi@1c06000 {
> +			compatible = "allwinner,sun8i-r40-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c06000 0x1000>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI1>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		csi0: csi@1c09000 {
>  			compatible = "allwinner,sun8i-r40-csi0",
>  				     "allwinner,sun7i-a20-csi0";
> @@ -307,6 +333,19 @@ crypto: crypto@1c15000 {
>  			resets = <&ccu RST_BUS_CE>;
>  		};
>  
> +		spi2: spi@1c17000 {
> +			compatible = "allwinner,sun8i-r40-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c17000 0x1000>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI2>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		ahci: sata@1c18000 {
>  			compatible = "allwinner,sun8i-r40-ahci";
>  			reg = <0x01c18000 0x1000>;
> @@ -364,6 +403,19 @@ ohci2: usb@1c1c400 {
>  			status = "disabled";
>  		};
>  
> +		spi3: spi@1c1f000 {
> +			compatible = "allwinner,sun8i-r40-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c1f000 0x1000>;
> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI3>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		ccu: clock@1c20000 {
>  			compatible = "allwinner,sun8i-r40-ccu";
>  			reg = <0x01c20000 0x400>;
> @@ -692,58 +744,6 @@ i2c4: i2c@1c2c000 {
>  			#size-cells = <0>;
>  		};
>  
> -		spi0: spi@1c05000 {
> -			compatible = "allwinner,sun8i-r40-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c05000 0x1000>;
> -			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> -			clock-names = "ahb", "mod";
> -			resets = <&ccu RST_BUS_SPI0>;
> -			status = "disabled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -
> -		spi1: spi@1c06000 {
> -			compatible = "allwinner,sun8i-r40-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c06000 0x1000>;
> -			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> -			clock-names = "ahb", "mod";
> -			resets = <&ccu RST_BUS_SPI1>;
> -			status = "disabled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -
> -		spi2: spi@1c17000 {
> -			compatible = "allwinner,sun8i-r40-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c17000 0x1000>;
> -			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
> -			clock-names = "ahb", "mod";
> -			resets = <&ccu RST_BUS_SPI2>;
> -			status = "disabled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -
> -		spi3: spi@1c1f000 {
> -			compatible = "allwinner,sun8i-r40-spi",
> -				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c1f000 0x1000>;
> -			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
> -			clock-names = "ahb", "mod";
> -			resets = <&ccu RST_BUS_SPI3>;
> -			status = "disabled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -
>  		gmac: ethernet@1c50000 {
>  			compatible = "allwinner,sun8i-r40-gmac";
>  			syscon = <&ccu>;

