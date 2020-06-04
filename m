Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE55206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFDEUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDEUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:20:41 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D1FC03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 21:20:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D0CF730000CE5;
        Thu,  4 Jun 2020 06:20:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A52032913C2; Thu,  4 Jun 2020 06:20:38 +0200 (CEST)
Date:   Thu, 4 Jun 2020 06:20:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
Message-ID: <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604034655.15930-3-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:46:54PM -0700, Florian Fainelli wrote:
> The BCM2711 SoC features 5 SPI controllers which all share the same
> interrupt line, the SPI driver needs to support interrupt sharing,
> therefore use the chip specific compatible string to help with that.

You're saying above that the 5 controllers all share the interrupt
but below you're only changing the compatible string of 4 controllers.

So I assume spi0 still has its own interrupt and only the additional
4 controllers present on the BCM2711/BCM7211 share their interrupt?

Thanks,

Lukas

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index a91cf68e3c4c..9a9ea67fbc2d 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -152,7 +152,7 @@
>  		};
>  
>  		spi3: spi@7e204600 {
> -			compatible = "brcm,bcm2835-spi";
> +			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
>  			reg = <0x7e204600 0x0200>;
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clocks BCM2835_CLOCK_VPU>;
> @@ -162,7 +162,7 @@
>  		};
>  
>  		spi4: spi@7e204800 {
> -			compatible = "brcm,bcm2835-spi";
> +			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
>  			reg = <0x7e204800 0x0200>;
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clocks BCM2835_CLOCK_VPU>;
> @@ -172,7 +172,7 @@
>  		};
>  
>  		spi5: spi@7e204a00 {
> -			compatible = "brcm,bcm2835-spi";
> +			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
>  			reg = <0x7e204a00 0x0200>;
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clocks BCM2835_CLOCK_VPU>;
> @@ -182,7 +182,7 @@
>  		};
>  
>  		spi6: spi@7e204c00 {
> -			compatible = "brcm,bcm2835-spi";
> +			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
>  			reg = <0x7e204c00 0x0200>;
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clocks BCM2835_CLOCK_VPU>;
> -- 
> 2.17.1
> 
