Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750F6C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5668D20848
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgCKLWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:22:23 -0400
Received: from foss.arm.com ([217.140.110.172]:48288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:22:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E20051FB;
        Wed, 11 Mar 2020 04:22:21 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B013F6CF;
        Wed, 11 Mar 2020 04:22:20 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:22:18 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, juanesf91@gmail.com
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: r40: Fix register base address for
 SPI2 and SPI3
Message-ID: <20200311112218.3537478b@donnerap.cambridge.arm.com>
In-Reply-To: <20200310174709.24174-3-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
 <20200310174709.24174-3-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 01:47:08 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

sorry, didn't spot this before posting my version!

> From: Chen-Yu Tsai <wens@csie.org>
> 
> When the SPI device nodes were added, SPI2 and SPI3 had incorrect
> register base addresses.
> 
> Fix the base address for both of them.
> 
> Fixes: 554581b79139 ("ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

As you suggested, it would be nice to add Juan's reported by, since he reported this before:
https://groups.google.com/forum/#!topic/linux-sunxi/5ZzkDXx2F-M

Cheers,
Andre

> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index b278686d0c22..81cc92ddc78b 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -718,10 +718,10 @@ spi1: spi@1c06000 {
>  			#size-cells = <0>;
>  		};
>  
> -		spi2: spi@1c07000 {
> +		spi2: spi@1c17000 {
>  			compatible = "allwinner,sun8i-r40-spi",
>  				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c07000 0x1000>;
> +			reg = <0x01c17000 0x1000>;
>  			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
>  			clock-names = "ahb", "mod";
> @@ -731,10 +731,10 @@ spi2: spi@1c07000 {
>  			#size-cells = <0>;
>  		};
>  
> -		spi3: spi@1c0f000 {
> +		spi3: spi@1c1f000 {
>  			compatible = "allwinner,sun8i-r40-spi",
>  				     "allwinner,sun8i-h3-spi";
> -			reg = <0x01c0f000 0x1000>;
> +			reg = <0x01c1f000 0x1000>;
>  			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
>  			clock-names = "ahb", "mod";

