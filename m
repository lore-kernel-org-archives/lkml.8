Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD118C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8D4206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXBzIwmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFVKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFVKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:24:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4545C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:24:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so14125006wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yz9650V/ncbubBykBcytsySqbuuA1Aq+cvVGqOCH2jE=;
        b=aXBzIwmCLIGhHF5TfxOryr8YGgBDUzHh6ODnXI2T1vtPc4RaKYkFgSmhlpBTLiDI49
         dp99K8zbWaHRA444VRxW5psZqWIsDZ/KXRv+qVEWw2Pnquaw4ClK2bIN4JdNyMKy0a3j
         LjUWV+GiZnRKeP8mgvXFbDtl+gU6NPQmwBXzYamqn2SDyO/NBphGcnaVZE5ejSJhE0Nb
         ZwRPjiQTRZCpoDD+VH9J7C8k0Y8v9oBqltFgBrJ8vBh/m0lrtGHiwo+mLY1ZLEQFjcdB
         rw64IO5oG+5KgL+lZIQN10UoNyHUYYBqOySr8/FBdjylIfNeOggHwBK9IENRhy63Nm8D
         UEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yz9650V/ncbubBykBcytsySqbuuA1Aq+cvVGqOCH2jE=;
        b=TJhF3XsbKkZrsNEXMI476DtLyRMJVwD2s+O2yHnje7iZ6qmCgi3DDTwZ8mDxMqEG44
         A+NS2wKlazXFOj7HOSr+YJldU+dk7X1v43NiR19IJ2yUNfzLXLSWT07Zqv0ldsuX9Srd
         zbX7xoRV86i6RLxgFz6D18w0NrBIctjkS+lkglk2mUOhk2x0lCXR1zlWDo9xJAicpfj2
         zBzDXX9L8xT0naxsvfYUZ7Gi4LKOUv3ykvcz6mvW+hedpzqwF7lYEQ9yTqdZUBNSQf34
         r3c21eTuTTd4iQFZtzGoXM7eVzD1OVFcqE3UoFGQOsJkEeL2aeOtbCXz1GlMjEN2qP7c
         5cbA==
X-Gm-Message-State: AOAM532n6EYTHyqXxfIa/E70FoaOPVF/vKciyHvLgzWkN7Qa/A/8Dbdc
        Vr3zy8TxlYQs4HiTKA3u06kwhw==
X-Google-Smtp-Source: ABdhPJwC3+qELgrxT+zzg9N/mqSbLY7YSj9GEhs8KqoYClB0BVGTXdu3q12qUUTH+rYQtXlZhL2N7Q==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr14220275wra.188.1592821463432;
        Mon, 22 Jun 2020 03:24:23 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u74sm16509467wmu.31.2020.06.22.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:24:22 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:24:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jic23@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmurphy@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add bindings for the Mediatek
 MT6360 PMIC
Message-ID: <20200622102420.GR954398@dell>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
 <1592567631-20363-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592567631-20363-2-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add devicetree binding document support Mediatek MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6360.txt | 122 +++++++++++++++++++++++

This needs converting to YAML.

>  include/dt-bindings/mfd/mt6360.h                 |  15 +++
>  2 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt
>  create mode 100644 include/dt-bindings/mfd/mt6360.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6360.txt b/Documentation/devicetree/bindings/mfd/mt6360.txt
> new file mode 100644
> index 0000000..7d7d349
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mt6360.txt
> @@ -0,0 +1,122 @@
> +MediaTek MT6360 PMIC Driver
> +
> +MT6360 is a multifunction device with the following sub modules:

Sub modules do not follow this sentence.

Please do not use the term "multi-function" in DT bindings.  An MFD is
something we made up.  It's a Linuxisum and has no real meaning in
DT.  This device is not multi-functional.  It has one function, to
control Power.  The multi-function part comes from the fact that we
like things split-up into subsystem for organisation purposes and
simplicity.

> +It is interfaced to host controller using I2C interface.
> +This document describes the binding for PMIC device and its sub module.

This sentence should be at the top.

s/sub module/sub-devices/

> +- ADC
> +- Battery Charger/OTG boost
> +- Flash LED/RGB LED/moonlight LED
> +- 2-channel Buck and 6-channel LDO
> +- USB_PD

These should follow the sentence reviewing to the "sub modules".

> +Required properties:
> +- compatible:	Must be "mediatek,mt6360-pmu"
> +- reg:		Specifies the I2C slave address of PMIC block, Must be <0x34>
> +- interrupts:	I2C device IRQ line connected to the main SoC.

Remove the '.'.

> +Optional subnodes:
> +- ADC
> +	Required properties:
> +		- compatible: "mediatek,mt6360-adc"
> +- battery charger/OTG boost

"Battery"

> +	Required properties:
> +		- compatible: "mediatek,mt6360-chg"
> +- Flash LED/RGB LED/moonlight LED
> +	Required properties:
> +		- compatible: "mediatek,mt6360-led"
> +- 2-channel Buck and 6-channel LDO
> +	Required properties:
> +		- compatible: "mediatek,mt6360-regulator"
> +- USB_PD

Remove the "_" and expand PD.

> +	Required properties:
> +		- compatible: "mediatek,mt6360-tcpc"
> +
> +Example:
> +
> +	#include <dt-bindings/interrupt-controller/irq.h>
> +	#include <dt-bindings/mfd/mt6360.h>
> +
> +	mt6360@34 {
> +		compatible = "mediatek,mt6360";
> +		reg = <0x34>;
> +		wakeup-source;
> +		interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "IRQB";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;

'\n'

> +		adc {
> +			compatible = "mediatek,mt6360-adc";
> +			#io-channel-cells = <1>;

Where is the channel cell?

> +		};

'\n'

> +		regulator {
> +			compatible = "mediatek,mt6360-regulator";
> +			LDO_VIN3-supply = <&BUCK2>;

'\n'

> +			buck1 {
> +				regulator-compatible = "BUCK1";
> +				regulator-name = "mt6360,buck1";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +			};

'\n'

Etc etc.

> +			BUCK2: buck2 {
> +				regulator-compatible = "BUCK2";
> +				regulator-name = "mt6360,buck2";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +			};
> +			ldo6 {
> +				regulator-compatible = "LDO6";
> +				regulator-name = "mt6360,ldo6";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +			ldo7 {
> +				regulator-compatible = "LDO7";
> +				regulator-name = "mt6360,ldo7";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +			ldo1 {
> +				regulator-compatible = "LDO1";
> +				regulator-name = "mt6360,ldo1";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +			ldo2 {
> +				regulator-compatible = "LDO2";
> +				regulator-name = "mt6360,ldo2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +			ldo3 {
> +				regulator-compatible = "LDO3";
> +				regulator-name = "mt6360,ldo3";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +			ldo5 {
> +				regulator-compatible = "LDO5";
> +				regulator-name = "mt6360,ldo5";
> +				regulator-min-microvolt = <2700000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};

Why aren't the LDO cells in order?

> +		};
> +	};
> diff --git a/include/dt-bindings/mfd/mt6360.h b/include/dt-bindings/mfd/mt6360.h
> new file mode 100644
> index 0000000..6368388
> --- /dev/null
> +++ b/include/dt-bindings/mfd/mt6360.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides macros for MT6360 device bindings.
> + *
> + * Copyright (c) 2020 Mediatek Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_MT6360_H__
> +#define __DT_BINDINGS_MT6360_H__
> +
> +#define MT6360_OPMODE_LP		(2)
> +#define MT6360_OPMODE_ULP		(3)
> +#define MT6360_OPMODE_NORMAL		(0)
> +
> +#endif /* __DT_BINDINGS_MT6360_H__ */
> -- 
> 2.7.4
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
