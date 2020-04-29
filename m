Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7321BC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E22076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/Ii+ZFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2Hvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgD2Hvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:51:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2094C035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:51:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so1286286wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8NAhf7wha4yR/lg0VT+G0SzgLMFOPbSrGi3bE5Wim2g=;
        b=d/Ii+ZFlUySfg0HKB+mMYqzshV8MMo6a7kwmUKLNV8hgk8fn3z3cHLth9nNldwRD9z
         1IFZD0sFF4nqQAvBzKU3olJoII8FqAj3/SCP1Yjs1RBg0ivZeLp1bOvrvbSP+kFF1ORS
         Ah6do+KsqJhoVSvXy6JvXLncytXc36bD/DqPWLYUc9fqz6cL23ZzU0Gej7LGZQrfHd19
         eCm1/i5wucHTIwEh5gp6xMRTv6AS0GhO/AKKDcNew+LMlhXBFQLHWjwjK7Nm2LcdKd9C
         cbW+dU9cS+Jx0GrJFsfsKMRBniopka1ovM5sYL9W9vYs7yiL2DssyY+cK3lFZ3jQifCU
         6xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8NAhf7wha4yR/lg0VT+G0SzgLMFOPbSrGi3bE5Wim2g=;
        b=ZibVYVp1goTeVDEiUFj/zw6Og0H1COzU5NCb9PP6qiZzlrYmUtcSPj1ZUnDo74zF8y
         sQexATkhAQ1gTa6WYtTyzszGUC9KEumYw4xUqaw60aftVqShqHAWuhp9jND5C8aCOqPv
         M4Vl/nnnXiOqa3Wvucnz4xUI7X+eD84/59I9CzMklCDjU1XyTGKu0GZygP+kNBNzTSP1
         3gdejM0iBqwMFV9f7eYCNKCPSc3TmFQHpJEGgXIUmb/baCdgwECrSJHom/xX1FpwaJyr
         SfiENHtH1D6bP+VKTdajh7f8KBt20CC+Pm6mPcsiOwEslSg6Qa5HE20PnxIPr4EVy0oY
         dEPQ==
X-Gm-Message-State: AGi0PuZ90KPJTOO7yU8XDyx4fsY5vjESIZyhIj8ZqM1KwOJ0jfm7NWP3
        R9N14Gcer+ovMDMJJS1OWorUvA==
X-Google-Smtp-Source: APiQypLvKWerLf6aM+oCmGHp/RU0pCRKiU8F1cNGbeTwLdfGm3WpiRrx6/fGPPua6nb5JnAaoY4lTg==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr36326058wrx.62.1588146711629;
        Wed, 29 Apr 2020 00:51:51 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id q8sm6463797wmg.22.2020.04.29.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:51:51 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:51:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mfd: Document QTI I2C PMIC controller
Message-ID: <20200429075149.GY3559@dell>
References: <cover.1588115326.git.gurus@codeaurora.org>
 <0960b5d17013124d9bbdbe7f28374b3d6c9c026e.1588115326.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0960b5d17013124d9bbdbe7f28374b3d6c9c026e.1588115326.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Guru Das Srinagesh wrote:

> The Qualcomm Technologies, Inc. I2C PMIC Controller is used by
> multi-function PMIC devices which communicate over the I2C bus.  The
> controller enumerates all child nodes as platform devices, and
> instantiates a regmap interface for them to communicate over the I2C
> bus.
> 
> The controller also controls interrupts for all of the children platform
> devices.  The controller handles the summary interrupt by deciphering
> which peripheral triggered the interrupt, and which of the peripheral
> interrupts were triggered.  Finally, it calls the interrupt handlers for
> each of the virtual interrupts that were registered.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
> Changes from v0:
> - Fixed "FATAL ERROR: Unable to parse input tree" error thrown by `make
>   dt_binding_check`.
> 
>  .../devicetree/bindings/mfd/qcom,i2c-pmic.yaml     | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,i2c-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,i2c-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,i2c-pmic.yaml
> new file mode 100644
> index 0000000..42482af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,i2c-pmic.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/qcom,i2c-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. I2C PMIC Interrupt Controller Platform Independent Bindings
> +
> +description: |
> +  The I2C PMIC Controller is used by multi-function PMIC devices which
> +  communicate over the I2C bus. An I2C PMIC controller node typically contains
> +  one or more child nodes representing the device's peripherals. Each of the
> +  peripherals typically has its own driver on the platform bus and will be
> +  enumerated by this controller. The controller exposes a regmap to the
> +  peripherals to communicate over the I2C bus.
> +
> +  The controller also controls interrupts for all of the peripherals on the
> +  bus. The controller takes a summary interrupt, deciphers which peripheral
> +  triggered the interrupt, and which of the peripheral's interrupts were
> +  triggered. Finally, it calls the handlers for each of the virtual interrupts
> +  that were registered.
> +
> +  This document describes the common platform independent bindings that apply
> +  to all I2C PMIC interrupt controllers.
> +
> +maintainers:
> +  - Guru Das Srinagesh <gurus@codeaurora.org>
> +
> +properties:
> +  compatible:
> +    const: qcom,i2c-pmic
> +
> +  reg:
> +    description: 7-bit I2C address of the device.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Summary interrupt specifier.
> +
> +  interrupt-controller:
> +    description: Flag indicating that this device is an interrupt controller.
> +
> +  "#interrupt-cells":
> +    description: Number of cells to encode an interrupt source.
> +
> +  qcom,periph-map:
> +    description: |
> +      A contiguous list of u32 arrays where each element specifies the base
> +      address of a single peripheral within the chip. This provides a mapping
> +      between the summary status register bits and peripheral addresses as each
> +      bit in the summary status register represents a peripheral.
> +
> +      The number of arrays should match the number of summary registers with up
> +      to 8 elements each. Within each array, One element per bit of the summary
> +      status register in order from the least sigificant bit to the most
> +      significant bit.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  pinctrl-names:
> +    const: default
> +
> +  pinctrl-0:
> +    description: phandle of the pin configuration.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    qcom,smb138x@8 {
> +      compatible = "qcom,i2c-pmic";
> +      reg = <0x8>;
> +      interrupt-parent = <&tlmm_pinmux>;
> +      interrupts = <83 0>;
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&smb_stat_active>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      qcom,periph-map = <0x10 0x11 0x12 0x13 0x14 0x16 0x36>;

Please provide examples of this device's children.

> +    };
> +
> +...

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
