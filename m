Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163362076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="P7fJSJdK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATo4uJ/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgDPDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:55:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39473 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgDPDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:55:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C4915C024D;
        Wed, 15 Apr 2020 23:55:06 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 15 Apr 2020 23:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=XobaS6f8FFofEDwVaA97uKXB7/n1qnX
        5ggwVVJ5x9d0=; b=P7fJSJdKt9uLuClJn0/Vl5eT9+yiJ8aGohA6ZyhUrcAgoAq
        XNylzwrMSpOpVSKnIMMZzFqJLXnFM51ESkwyHYOypyngdLKegT7EjuSPzU5IxrEl
        dEKpqMgk+PEkRRuwkQ8Ostl4rtZQc9P2eIT3NaVzAZ4O+9vE2SCc2YX575KGurt+
        g5EMwd+NlCX/+6oVkb5+e+fXWgO3x1N0dglEjwKbwtyd61ec5ejJpOiLPjWaQi46
        a9RAjZFGP2ewnAb1KsKjBw5YUROiHVgq+cF+VdPUDJD3qBeXD+LulMhTCiu2k1eR
        mla8x2kZX4ceX31bBB9gLgUCbityFaO6F5zaljg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XobaS6
        f8FFofEDwVaA97uKXB7/n1qnX5ggwVVJ5x9d0=; b=ATo4uJ/Pzi+MQ5zAHNQnqD
        cUlG0QhYDNSDY+DmrYTVAnkIRVzaxeJ5Q7wpM2A3jxStdHZl3SljxHuk8qh+oAXX
        HzZV6Z9Odb2Qf6Q6IqMTBODXQYsh6QkyOrnqr39zd0dGqA+/BlA43dpqssKqTpEH
        FDClYVPWAwqWAReFizSTk0KNhBlNibn0ylgDPcDesOF4DYQVTVrs48wTgYJKLkFA
        kLfR1mX1SsEat7LAQu69EnVf4hxX5AbcsbrA1CoYqYB6L11s1ONzrUvC2ynuM+kL
        Pk7GxegkwtMrgVTvhXGvC/TlHDy8hSn2Y0TyHJrkZc0THs2v+ZaAeFUXOgLYbHdA
        ==
X-ME-Sender: <xms:GNeXXlBeuI6jZ5q1ttEdztNMsE61UE29LxE1NKdIxjNR56EwVLBbAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfeeggdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:GNeXXv30pnx7cwVUBSRY8_gsZuG9TVYVHTUQxKe39Uvk9ycmQFajiw>
    <xmx:GNeXXjWnbGHAZfk3m6RZVTXVcKKBkJbMPex73yNK2lYUNhtYBSrPrg>
    <xmx:GNeXXhlv7Axx5fZ7UriWJ3QwHjXpsZfNdL4dyX4zYZ6TNHEO4zA8lg>
    <xmx:GteXXjDKUDIpHj5As-V6JorqgBbQj83OBqoy-6RvKi2QtXpY_EhzXQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 669F7E00B9; Wed, 15 Apr 2020 23:55:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-1131-g3221b37-fmstable-20200415v1
Mime-Version: 1.0
Message-Id: <008ef3bb-92bd-4202-a59d-0063ee726ce4@www.fastmail.com>
In-Reply-To: <20200410171613.30260-1-a.filippov@yadro.com>
References: <20200410171613.30260-1-a.filippov@yadro.com>
Date:   Thu, 16 Apr 2020 13:25:31 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Apr 2020, at 02:46, Alexander Filippov wrote:
> Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts | 270 ++++++++++++++++++++
>  2 files changed, 271 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e8dd99201397..6f9fe0f959f2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1347,6 +1347,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-microsoft-olympus.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-mihawk.dtb \
> +	aspeed-bmc-opp-nicole.dtb \
>  	aspeed-bmc-opp-palmetto.dtb \
>  	aspeed-bmc-opp-romulus.dtb \
>  	aspeed-bmc-opp-swift.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
> new file mode 100644
> index 000000000000..3f1d92bab07b
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 YADRO
> +/dts-v1/;
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Nicole BMC";
> +	compatible = "yadro,nicole-bmc", "aspeed,ast2500";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vga_memory: framebuffer@9f000000 {
> +			no-map;
> +			reg = <0x9f000000 0x01000000>; /* 16M */
> +		};
> +
> +		flash_memory: region@98000000 {
> +			no-map;
> +			reg = <0x98000000 0x04000000>; /* 64M */
> +		};
> +
> +		coldfire_memory: codefire_memory@9ef00000 {
> +			reg = <0x9ef00000 0x00100000>;
> +			no-map;
> +		};
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		power {
> +			gpios = <&gpio ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		identify {
> +			gpios = <&gpio ASPEED_GPIO(AA, 7) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		alarm_red {
> +			gpios = <&gpio ASPEED_GPIO(AA, 3) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		alarm_yellow {
> +			gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	fsi: gpio-fsi {
> +		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +		no-gpio-delays;
> +
> +		memory-region = <&coldfire_memory>;
> +		aspeed,sram = <&sram>;
> +		aspeed,cvic = <&cvic>;
> +
> +		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
> +		data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
> +		mux-gpios = <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
> +		trans-gpios = <&gpio ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		checkstop {
> +			label = "checkstop";
> +			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(J, 2)>;
> +		};
> +	};
> +
> +	iio-hwmon-battery {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 12>;

You should request the ADC pin via pinctrl in the ADC node below.

Andrew

> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-max-frequency = <100000000>;
> +	};
> +};
> +
> +&lpc_ctrl {
> +	status = "okay";
> +	memory-region = <&flash_memory>;
> +	flash = <&spi1>;
> +};
> +
> +&uart1 {
> +	/* Rear RS-232 connector */
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +			&pinctrl_rxd1_default
> +			&pinctrl_nrts1_default
> +			&pinctrl_ndtr1_default
> +			&pinctrl_ndsr1_default
> +			&pinctrl_ncts1_default
> +			&pinctrl_ndcd1_default
> +			&pinctrl_nri1_default>;
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	use-ncsi;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +    /* CPU0 characterization connector */
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +    /* CLK GEN SI5338 */
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +    /* Voltage regulators for CPU0 */
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +    /* Voltage regulators for CPU1 */
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +    /* CPLD */
> +};
> +
> +&gpio {
> +	nic_func_mode0 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "nic_func_mode0";
> +	};
> +	nic_func_mode1 {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "nic_func_mode1";
> +	};
> +	seq_cont {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "seq_cont";
> +	};
> +	ncsi_cfg {
> +		gpio-hog;
> +		input;
> +		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_HIGH>;
> +		line-name = "ncsi_cfg";
> +	};
> +};
> +
> +&vuart {
> +	status = "okay";
> +};
> +
> +&gfx {
> +	status = "okay";
> +	memory-region = <&gfx_memory>;
> +};
> +
> +&pinctrl {
> +	aspeed,external-nodes = <&gfx &lhc>;
> +};
> +
> +&ibt {
> +	status = "okay";
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> +
> +&adc {
> +	status = "okay";
> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +
> +#include "ibm-power9-dual.dtsi"
> -- 
> 2.21.1
> 
>
