Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F8AC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgCKK7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:59:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKK7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:59:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 147311FB;
        Wed, 11 Mar 2020 03:59:50 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 335663F6CF;
        Wed, 11 Mar 2020 03:59:49 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:59:37 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: sun8i: r40: Move AHCI device node based
 on address order
Message-ID: <20200311105937.040cd947@donnerap.cambridge.arm.com>
In-Reply-To: <20200310174709.24174-2-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
 <20200310174709.24174-2-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 01:47:07 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> When the AHCI device node was added, it was added in the wrong location
> in the device tree file. The device nodes should be sorted by register
> address.
> 
> Move the device node to before EHCI1, where it belongs.
> 
> Fixes: 41c64d3318aa ("ARM: dts: sun8i: r40: add sata node")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index d5442b5b6fd2..b278686d0c22 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -307,6 +307,17 @@ crypto: crypto@1c15000 {
>  			resets = <&ccu RST_BUS_CE>;
>  		};
>  
> +		ahci: sata@1c18000 {
> +			compatible = "allwinner,sun8i-r40-ahci";
> +			reg = <0x01c18000 0x1000>;
> +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> +			resets = <&ccu RST_BUS_SATA>;
> +			reset-names = "ahci";
> +			status = "disabled";
> +

Did this empty line serve any particular purpose before? If not, you could remove it on the way.

With that fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre.

> +		};
> +
>  		ehci1: usb@1c19000 {
>  			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
>  			reg = <0x01c19000 0x100>;
> @@ -733,17 +744,6 @@ spi3: spi@1c0f000 {
>  			#size-cells = <0>;
>  		};
>  
> -		ahci: sata@1c18000 {
> -			compatible = "allwinner,sun8i-r40-ahci";
> -			reg = <0x01c18000 0x1000>;
> -			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> -			resets = <&ccu RST_BUS_SATA>;
> -			reset-names = "ahci";
> -			status = "disabled";
> -
> -		};
> -
>  		gmac: ethernet@1c50000 {
>  			compatible = "allwinner,sun8i-r40-gmac";
>  			syscon = <&ccu>;

