Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB4F2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591781724;
	bh=shHPBdfvjaI3EtJEb11KzerLLdcslgIsNxCBWh5ZjTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xWZ+u0FT9VkGGt+mcdz5WAR+7EAc4xRERpBuQmEjrSIDggyHx8bEy3EZ/c+xb71Sx
	 27Pii6G7THy8OaQYat23HV1wKfI3v3wvbxp4W1fl6Mog5RzCmkHC1JVennhiFd+ZNc
	 nWKTc28ycxowb5qpW393s20uIx1/yjyaUwrL6X+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgFJJfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgFJJfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:35:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F1D204EC;
        Wed, 10 Jun 2020 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591781722;
        bh=shHPBdfvjaI3EtJEb11KzerLLdcslgIsNxCBWh5ZjTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSd2ibiL2vMc86UmO2AWfVqGqe4bzDItFjD7ASUjGKhEH1viqqOEllRu28FRJgL4Z
         AzRb1KJdtipjF98or7O09ES6CB/h1kqJU30EIa74mjabfcs7o37qmbIIYGMI5rbwwD
         jPUTRVpThKrmEHixtenNWxrvZmNr4D7Qdmb/9fDY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jix8i-001jn4-H9; Wed, 10 Jun 2020 10:35:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jun 2020 10:35:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: mstar: Add infinity/mercury series dtsi
In-Reply-To: <20200610090421.3428945-4-daniel@0x0f.com>
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-4-daniel@0x0f.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <35ec0a2bf066509aa1b4b11d3eac2657@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel@0x0f.com, k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org, daniel@thingy.jp, robh+dt@kernel.org, linux@armlinux.org.uk, sam@ravnborg.org, linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com, mripard@kernel.org, lkundrak@v3.sk, stephan@gerhold.net, broonie@kernel.org, allen.chen@ite.com.tw, mchehab+huawei@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, armlinux@m.disordat.com, benjamin.gaignard@linaro.org, gregory.0xf0@gmail.com, bgolaszewski@baylibre.com, yamada.masahiro@socionext.com, ndesaulniers@google.com, will@kernel.org, nhuck15@gmail.com, natechancellor@gmail.com, ardb@kernel.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 2020-06-10 10:04, Daniel Palmer wrote:
> Adds initial dtsi for the base MStar ARMv7 SoCs, family dtsis for 
> infinity
> and mercury families, and then some chip level dtsis for chips in those
> families.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  MAINTAINERS                              |  3 +
>  arch/arm/boot/dts/infinity-msc313.dtsi   | 14 +++++
>  arch/arm/boot/dts/infinity.dtsi          | 10 ++++
>  arch/arm/boot/dts/infinity3-msc313e.dtsi | 14 +++++
>  arch/arm/boot/dts/infinity3.dtsi         | 10 ++++
>  arch/arm/boot/dts/mercury5-ssc8336n.dtsi | 14 +++++
>  arch/arm/boot/dts/mercury5.dtsi          | 10 ++++
>  arch/arm/boot/dts/mstar-v7.dtsi          | 71 ++++++++++++++++++++++++
>  8 files changed, 146 insertions(+)
>  create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
>  create mode 100644 arch/arm/boot/dts/infinity.dtsi
>  create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
>  create mode 100644 arch/arm/boot/dts/infinity3.dtsi
>  create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
>  create mode 100644 arch/arm/boot/dts/mercury5.dtsi
>  create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi

[...]

> diff --git a/arch/arm/boot/dts/mstar-v7.dtsi 
> b/arch/arm/boot/dts/mstar-v7.dtsi
> new file mode 100644
> index 000000000000..0fccc4ca52a4
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-v7.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +		};
> +	};
> +
> +	arch_timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <6000000>;

This is 2020, and not 2012 anymore. The frequency should be set
by your favourite bootloader.

> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gic: interrupt-controller@16001000 {
> +			compatible = "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-controller;
> +			reg = <0x16001000 0x1000>,
> +			      <0x16002000 0x1000>;

The GICC region is likely to be 8kB, and not 4kB.
Missing GICH and GICV regions, as well as the maintenance interrupt.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
