Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A320C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0619C20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="WycwRzCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgIJREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIJQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:57:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8EC061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:46:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so88138wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6thAmsUl4Y+M7Ev1B1iv8hCqeIOWewwGqPNbleVqUdY=;
        b=WycwRzCFjKZLRJM+j2ql2cioAkQbc08NDMu2bEbJBXmj54rmW/3C6fX9n6nAB10WLv
         Ack27CuoEaysZU+HpElHgttYwqshcgyTEm1wi7A5IxEq8STl5u3lb4KEprp72CzzEKIQ
         tgW9fB27uIhN8TMyJg/eD4F+sGpibO1vGcjn2Ud0+mU5Qq7fDiWUjItTj1BPtFxZTPS5
         UbUqFBUPqJBnMfRJJS+elx6DHWuokKZsWSTFkUV7C6LZwvqEE+1GulXCAdJ4WAo+Boxr
         hyD1721jJtsgeqejKHV0crKRyEOAJdHKtvA0WkyZ7aSI54LR6H02w72BqTrMN6OA7siM
         vnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6thAmsUl4Y+M7Ev1B1iv8hCqeIOWewwGqPNbleVqUdY=;
        b=j7cdksL61VQcmTvcjt6KHiiWB1Itv00RcswNF6BY2tWSnsiXCS02mfk3hsnzeOyAK/
         yGv0nlQEX3ZQYMqxN9MZQ/lffH6UM0CpxKLP18/Y9mp11zGUeuEvsDUE1het3lrqipC/
         GhHk5THf+Pxq9979h7/NBeRXUj2RZIkV8kf8LzmL7o5dZVD5oZsZaNfotAybCZhBPJFA
         njkLAq/uRoUyJ+q3f5lzxErk9kp00SXWic3WxQIQDKqY4W/kUwTfO7awirV9ezsYb1Bj
         OWzSSTvNqf9hdLVFWRlALK5RniLaM3+bXmHHg42aYjW3BflvZJPJf6lqtx/qJF6sOqtS
         TFuw==
X-Gm-Message-State: AOAM532qPbqMvyCrHkSIvP6QF2oOPDnEklXfps5lAg9OTb5nH5vKBrEd
        c/VpOSstu36UIAUiIbHuPzjwhQ==
X-Google-Smtp-Source: ABdhPJwEBTRTqtjkAvsaVtw8Lqt2Geg38QkvvsxZlrCtgYuiFxccymywMW7ZEN9HpG7qpxHOUd/Nag==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr54074wmu.73.1599745612445;
        Thu, 10 Sep 2020 06:46:52 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v17sm9118533wrr.60.2020.09.10.06.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 06:46:51 -0700 (PDT)
Subject: Re: [PATCH] ARM: zynq: Add Z-turn board V5
To:     agriveaux@deutnet.info, michal.simek@xilinx.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200909150608.1984952-1-agriveaux@deutnet.info>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <5e0bf2ca-307e-f610-95c4-441864293a7a@monstr.eu>
Date:   Thu, 10 Sep 2020 15:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909150608.1984952-1-agriveaux@deutnet.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09. 09. 20 17:06, agriveaux@deutnet.info wrote:
> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> 
> Adding Z-turn board V5 to resolve the change between:
> 
> "Z-TURNBOARD_schematic.pdf" schematics state version 1 to 4 has Atheros AR8035
> "Z-Turn_Board_sch_V15_20160303.pdf" schematics state version 5 has Micrel KSZ9031
> 
> At this time the S25FL128SAGNFI003 doesn't work because of bug:
> 
> *** Warning - spi_flash_probe_bus_cs() failed, using default environment
> 
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/zynq-zturn-v5.dts                | 121 ++++++++
>  .../xilinx/zynq/zynq-zturn-v5/ps7_init_gpl.c  | 273 ++++++++++++++++++
>  configs/xilinx_zynq_virt_defconfig            |   4 +-
>  4 files changed, 398 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/zynq-zturn-v5.dts
>  create mode 100644 board/xilinx/zynq/zynq-zturn-v5/ps7_init_gpl.c
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index f8f529435b..0f8973b1c8 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -277,6 +277,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>  	zynq-zc770-xm013.dtb \
>  	zynq-zed.dtb \
>  	zynq-zturn.dtb \
> +	zynq-zturn-v5.dtb \
>  	zynq-zybo.dtb \
>  	zynq-zybo-z7.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += \
> diff --git a/arch/arm/dts/zynq-zturn-v5.dts b/arch/arm/dts/zynq-zturn-v5.dts
> new file mode 100644
> index 0000000000..eebeec800f
> --- /dev/null
> +++ b/arch/arm/dts/zynq-zturn-v5.dts
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2020 Alexandre Griveaux <alex@deutnet.info>
> + *
> + *  Based on zynq-zturn.dts which is:
> + *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
> + *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
> + *
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +
> +/ {
> +	model = "Zynq Z-Turn MYIR Board V5";
> +	compatible = "myir,zynq-zturn", "xlnx,zynq-7000";
> +
> +	aliases {
> +		ethernet0 = &gem0;
> +		serial0 = &uart1;
> +		serial1 = &uart0;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		usr-led1 {
> +			label = "usr-led1";
> +			gpios = <&gpio0 0x0 0x1>;
> +			default-state = "off";
> +		};
> +
> +		usr-led2 {
> +			label = "usr-led2";
> +			gpios = <&gpio0 0x9 0x1>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		K1 {
> +			label = "K1";
> +			gpios = <&gpio0 0x32 0x1>;
> +			linux,code = <0x66>;
> +			wakeup-source;
> +			autorepeat;
> +		};
> +	};
> +};
> +
> +&clkc {
> +	ps-clk-frequency = <33333333>;
> +};
> +
> +&qspi {
> +	u-boot,dm-pre-reloc;
> +	status = "okay";
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0x3>;
> +	};
> +};
> +
> +&sdhci0 {
> +	u-boot,dm-pre-reloc;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	u-boot,dm-pre-reloc;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	u-boot,dm-pre-reloc;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&can0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	stlm75@49 {
> +		status = "okay";
> +		compatible = "lm75";
> +		reg = <0x49>;
> +	};
> +
> +	accelerometer@53 {
> +		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
> +		reg = <0x53>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <0x0 0x1e 0x4>;
> +	};
> +};
> diff --git a/board/xilinx/zynq/zynq-zturn-v5/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zturn-v5/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..5d573868cb
> --- /dev/null
> +++ b/board/xilinx/zynq/zynq-zturn-v5/ps7_init_gpl.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) Xilinx, Inc.
> + */
> +
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +static unsigned long ps7_pll_init_data[] = {
> +	EMIT_WRITE(0xF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0xF8000110, 0x003FFFF0U, 0x000FA220U),
> +	EMIT_MASKWRITE(0xF8000100, 0x0007F000U, 0x00028000U),
> +	EMIT_MASKWRITE(0xF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0xF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0xF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0xF8000114, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0xF8000104, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0xF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0xF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0xF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0xF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0xF8000118, 0x003FFFF0U, 0x001452C0U),
> +	EMIT_MASKWRITE(0xF8000108, 0x0007F000U, 0x0001E000U),
> +	EMIT_MASKWRITE(0xF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0xF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0xF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0xF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0xF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +};
> +
> +static unsigned long ps7_clock_init_data[] = {
> +	EMIT_WRITE(0xF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0xF8000128, 0x03F03F01U, 0x00700F01U),
> +	EMIT_MASKWRITE(0xF8000138, 0x00000011U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000140, 0x03F03F71U, 0x00100801U),
> +	EMIT_MASKWRITE(0xF800014C, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0xF8000150, 0x00003F33U, 0x00001401U),
> +	EMIT_MASKWRITE(0xF8000154, 0x00003F33U, 0x00000A03U),
> +	EMIT_MASKWRITE(0xF800015C, 0x03F03F33U, 0x00200501U),
> +	EMIT_MASKWRITE(0xF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8000168, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0xF8000170, 0x03F03F30U, 0x00200500U),
> +	EMIT_MASKWRITE(0xF8000180, 0x03F03F30U, 0x00400500U),
> +	EMIT_MASKWRITE(0xF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF800012C, 0x01FFCCCDU, 0x01FD044DU),
> +	EMIT_WRITE(0xF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +};
> +
> +static unsigned long ps7_ddr_init_data[] = {
> +	EMIT_MASKWRITE(0xF8006000, 0x0001FFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0xF8006004, 0x0007FFFFU, 0x00001082U),
> +	EMIT_MASKWRITE(0xF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0xF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0xF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0xF8006014, 0x001FFFFFU, 0x0004285BU),
> +	EMIT_MASKWRITE(0xF8006018, 0xF7FFFFFFU, 0x44E458D3U),
> +	EMIT_MASKWRITE(0xF800601C, 0xFFFFFFFFU, 0x7282BCE5U),
> +	EMIT_MASKWRITE(0xF8006020, 0x7FDFFFFCU, 0x270872D0U),
> +	EMIT_MASKWRITE(0xF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0xF800602C, 0xFFFFFFFFU, 0x00000008U),
> +	EMIT_MASKWRITE(0xF8006030, 0xFFFFFFFFU, 0x00040B30U),
> +	EMIT_MASKWRITE(0xF8006034, 0x13FF3FFFU, 0x000116D4U),
> +	EMIT_MASKWRITE(0xF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF800603C, 0x000FFFFFU, 0x00000777U),
> +	EMIT_MASKWRITE(0xF8006040, 0xFFFFFFFFU, 0xFFF00000U),
> +	EMIT_MASKWRITE(0xF8006044, 0x0FFFFFFFU, 0x0F666666U),
> +	EMIT_MASKWRITE(0xF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0xF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0xF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0xF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0xF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0xF8006068, 0x03FFFFFFU, 0x00284141U),
> +	EMIT_MASKWRITE(0xF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0xF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0xF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0xF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0xF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
> +	EMIT_MASKWRITE(0xF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0xF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0xF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0xF80060B8, 0x01FFFFFFU, 0x00200066U),
> +	EMIT_MASKWRITE(0xF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0xF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0xF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0xF8006120, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0xF8006124, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0xF800612C, 0x000FFFFFU, 0x0002A81FU),
> +	EMIT_MASKWRITE(0xF8006130, 0x000FFFFFU, 0x00029822U),
> +	EMIT_MASKWRITE(0xF8006134, 0x000FFFFFU, 0x00026C10U),
> +	EMIT_MASKWRITE(0xF8006138, 0x000FFFFFU, 0x00026013U),
> +	EMIT_MASKWRITE(0xF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0xF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0xF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0xF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0xF8006154, 0x000FFFFFU, 0x0000009FU),
> +	EMIT_MASKWRITE(0xF8006158, 0x000FFFFFU, 0x000000A2U),
> +	EMIT_MASKWRITE(0xF800615C, 0x000FFFFFU, 0x00000090U),
> +	EMIT_MASKWRITE(0xF8006160, 0x000FFFFFU, 0x00000093U),
> +	EMIT_MASKWRITE(0xF8006168, 0x001FFFFFU, 0x000000FFU),
> +	EMIT_MASKWRITE(0xF800616C, 0x001FFFFFU, 0x000000FBU),
> +	EMIT_MASKWRITE(0xF8006170, 0x001FFFFFU, 0x000000F0U),
> +	EMIT_MASKWRITE(0xF8006174, 0x001FFFFFU, 0x000000EDU),
> +	EMIT_MASKWRITE(0xF800617C, 0x000FFFFFU, 0x000000DFU),
> +	EMIT_MASKWRITE(0xF8006180, 0x000FFFFFU, 0x000000E2U),
> +	EMIT_MASKWRITE(0xF8006184, 0x000FFFFFU, 0x000000D0U),
> +	EMIT_MASKWRITE(0xF8006188, 0x000FFFFFU, 0x000000D3U),
> +	EMIT_MASKWRITE(0xF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0xF8006194, 0x000FFFFFU, 0x0001FC82U),
> +	EMIT_MASKWRITE(0xF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0xF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0xF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0xF80062B4, 0x0003FFFFU, 0x000012A8U),
> +	EMIT_MASKPOLL(0xF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0xF8006000, 0x0001FFFFU, 0x00000081U),
> +	EMIT_MASKPOLL(0xF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +};
> +
> +static unsigned long ps7_mio_init_data[] = {
> +	EMIT_WRITE(0xF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0xF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0xF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0xF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0xF8000B4C, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0xF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0xF8000B54, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0xF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0xF8000B5C, 0xFFFFFFFFU, 0x0018C61CU),
> +	EMIT_MASKWRITE(0xF8000B60, 0xFFFFFFFFU, 0x00F9861CU),
> +	EMIT_MASKWRITE(0xF8000B64, 0xFFFFFFFFU, 0x00F9861CU),
> +	EMIT_MASKWRITE(0xF8000B68, 0xFFFFFFFFU, 0x00F9861CU),
> +	EMIT_MASKWRITE(0xF8000B6C, 0x00007FFFU, 0x00000260U),
> +	EMIT_MASKWRITE(0xF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0xF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0xF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0xF8000700, 0x00003FFFU, 0x00001600U),
> +	EMIT_MASKWRITE(0xF8000704, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF8000708, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF800070C, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF8000710, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF8000714, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF8000718, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF800071C, 0x00003FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0xF8000720, 0x00003FFFU, 0x00000602U),
> +	EMIT_MASKWRITE(0xF8000724, 0x00003FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0xF8000728, 0x00003FFFU, 0x000016E1U),
> +	EMIT_MASKWRITE(0xF800072C, 0x00003FFFU, 0x000016E0U),
> +	EMIT_MASKWRITE(0xF8000730, 0x00003FFFU, 0x00001640U),
> +	EMIT_MASKWRITE(0xF8000734, 0x00003FFFU, 0x00001640U),
> +	EMIT_MASKWRITE(0xF8000738, 0x00003FFFU, 0x00001621U),
> +	EMIT_MASKWRITE(0xF800073C, 0x00003FFFU, 0x00001620U),
> +	EMIT_MASKWRITE(0xF8000740, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF8000744, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF8000748, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF800074C, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF8000750, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF8000754, 0x00003FFFU, 0x00001202U),
> +	EMIT_MASKWRITE(0xF8000758, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF800075C, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF8000760, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF8000764, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF8000768, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF800076C, 0x00003FFFU, 0x00001203U),
> +	EMIT_MASKWRITE(0xF8000770, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF8000774, 0x00003FFFU, 0x00001205U),
> +	EMIT_MASKWRITE(0xF8000778, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF800077C, 0x00003FFFU, 0x00001205U),
> +	EMIT_MASKWRITE(0xF8000780, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF8000784, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF8000788, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF800078C, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF8000790, 0x00003FFFU, 0x00001205U),
> +	EMIT_MASKWRITE(0xF8000794, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF8000798, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF800079C, 0x00003FFFU, 0x00001204U),
> +	EMIT_MASKWRITE(0xF80007A0, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007A4, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007A8, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007AC, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007B0, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007B4, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007B8, 0x00003F01U, 0x00000201U),
> +	EMIT_MASKWRITE(0xF80007BC, 0x00003F01U, 0x00000201U),
> +	EMIT_MASKWRITE(0xF80007C0, 0x00003FFFU, 0x000012E0U),
> +	EMIT_MASKWRITE(0xF80007C4, 0x00003FFFU, 0x000012E1U),
> +	EMIT_MASKWRITE(0xF80007C8, 0x00003FFFU, 0x00000200U),
> +	EMIT_MASKWRITE(0xF80007CC, 0x00003FFFU, 0x00000200U),
> +	EMIT_MASKWRITE(0xF80007D0, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF80007D4, 0x00003FFFU, 0x00001280U),
> +	EMIT_MASKWRITE(0xF8000830, 0x003F003FU, 0x002E002FU),
> +	EMIT_WRITE(0xF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +};
> +
> +static unsigned long ps7_peripherals_init_data[] = {
> +	EMIT_WRITE(0xF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0xF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0xF8000B4C, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0xF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0xF8000B54, 0x00000180U, 0x00000180U),
> +	EMIT_WRITE(0xF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0xE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0xF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKWRITE(0xE000A244, 0x003FFFFFU, 0x00080000U),
> +	EMIT_MASKWRITE(0xE000A00C, 0x003F003FU, 0x00370008U),
> +	EMIT_MASKWRITE(0xE000A248, 0x003FFFFFU, 0x00080000U),
> +	EMIT_MASKWRITE(0xE000A00C, 0x003F003FU, 0x00370000U),
> +	EMIT_MASKDELAY(0xF8F00200, 1),
> +	EMIT_MASKWRITE(0xE000A00C, 0x003F003FU, 0x00370008U),
> +	EMIT_EXIT(),
> +};
> +
> +static unsigned long ps7_post_config_0[] = {
> +	EMIT_WRITE(0xF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0xF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0xF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0xF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 8acdab25b7..afbc81afd1 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -49,7 +49,7 @@ CONFIG_CMD_MTDPARTS=y
>  CONFIG_CMD_MTDPARTS_SPREAD=y
>  CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
>  CONFIG_CMD_UBI=y
> -CONFIG_OF_LIST="zynq-zc702 zynq-zc706 zynq-zc770-xm010 zynq-zc770-xm011 zynq-zc770-xm011-x16 zynq-zc770-xm012 zynq-zc770-xm013 zynq-cc108 zynq-microzed zynq-minized zynq-picozed zynq-zed zynq-zturn zynq-zybo zynq-zybo-z7 zynq-dlc20-rev1.0"
> +CONFIG_OF_LIST="zynq-zc702 zynq-zc706 zynq-zc770-xm010 zynq-zc770-xm011 zynq-zc770-xm011-x16 zynq-zc770-xm012 zynq-zc770-xm013 zynq-cc108 zynq-microzed zynq-minized zynq-picozed zynq-zed zynq-zturn zynq-zturn-v5 zynq-zybo zynq-zybo-z7 zynq-dlc20-rev1.0"
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> @@ -90,6 +90,8 @@ CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_PHY_MARVELL=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_PHY_XILINX=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
>  CONFIG_MII=y
>  CONFIG_ZYNQ_GEM=y
>  CONFIG_ARM_DCC=y
> 

As I wrote to u-boot mailing list.

I prefer to make this simpler because the most of that stuff is just c&p.

What about this?

#include "zynq-zturn.dts";

/ {
	model = "Zynq Z-Turn MYIR Board V5";
	compatible = "myir,zynq-zturn-v5", "myir,zynq-zturn", "xlnx,zynq-7000";
};

&ethernet_phy {
	reg = <3>;
};

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



