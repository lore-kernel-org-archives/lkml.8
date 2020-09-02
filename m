Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1989AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E3620773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xtu9LFAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIBXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:31:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A4C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:31:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so1079414ejl.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4yXzW6yLaOrjJCWDznrsqD2chk3J8tmvftWN4ofhYI=;
        b=Xtu9LFAQ1AsuRSYENiMC1JSVEyn/r84YRw+kVkrqLSiwzEk18vBQ5Bw6DIZQQeRd55
         LwGAzvYyrHms38I0HNnvqPlCsNjOV90RlA80Ze+BfYhdDY0nXTs1o69yz0AgVedqqGFx
         qXajRu4qWBN9/Y/EfquKUuZx+dOtEt11KYUCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4yXzW6yLaOrjJCWDznrsqD2chk3J8tmvftWN4ofhYI=;
        b=mPbHwG1KJ/I3J5hyjuR7bqD0GC5ctvYLE67Ji0suZbjGGJ/Q0waRhirSYgIGQ/rUkk
         qBo43Kgj7m4Jf7ZnIoSbykKvT0Fw6agkQrG10tlHNk+6Yla9QN5lQ9HZ408bSdyZ0h9i
         FEhHkG5DIj8VURDNc4bEcgUuQSM3YUzTPad+XAvv94Yr/lcGKfsNOaFUaHz/DfGX66KH
         QhsDP6hP1w3q52mBXSSr92b/f9r3Dr/nC1ZKhkpQXUDR9sWySCcJLsVJ72dHQkP2Guv8
         plrkiRQU3tbGnpzTFcaBVUCBykXzjaZG8xW70/r4VLMSNNh1TD9cd8ZrTjrB4Dj03e6F
         fJew==
X-Gm-Message-State: AOAM533xXW4o2z2UeTVm0bk5CU+QDYnEoRfkK+LpYrOjSMSBacQZHbMq
        JuYfy2WlMPVNcg4wSDDR6VpbOtKhLQPVfQ==
X-Google-Smtp-Source: ABdhPJyv1o3F4b+GC7jfQpLTSMPcW6CpSeYXgcoGGTs7bM3N50ioUdm4adB4P5Af2y/Ki9y2Fn0LYg==
X-Received: by 2002:a17:906:6a54:: with SMTP id n20mr500617ejs.401.1599089477025;
        Wed, 02 Sep 2020 16:31:17 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id g19sm1139947ejz.5.2020.09.02.16.31.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 16:31:16 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id w5so1090491wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:31:15 -0700 (PDT)
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr495865wrh.192.1599089475406;
 Wed, 02 Sep 2020 16:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200902224813.14283-1-tfiga@chromium.org> <20200902224813.14283-3-tfiga@chromium.org>
In-Reply-To: <20200902224813.14283-3-tfiga@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 3 Sep 2020 01:30:55 +0200
X-Gmail-Original-Message-ID: <CAAFQd5D3+yXv9iwfWwStxqUOrec3g0WjFF6ko-xRA=ejcNmhSQ@mail.gmail.com>
Message-ID: <CAAFQd5D3+yXv9iwfWwStxqUOrec3g0WjFF6ko-xRA=ejcNmhSQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] media: dt-bindings: media: i2c: Add bindings for GC5035
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hao He <hao.he@bitland.com.cn>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Xingyu Wu <wuxy@bitland.com.cn>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Sj Huang <sj.huang@mediatek.com>,
        darfur_liu <darfur_liu@gcoreinc.com>,
        "hao.he7" <hao.he7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self-review,

On Thu, Sep 3, 2020 at 12:48 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Add YAML device tree bindings for Galaxycore Inc. GC5035 imaging sensor.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  .../devicetree/bindings/media/i2c/gc5035.yaml | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/gc5035.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/gc5035.yaml b/Documentation/devicetree/bindings/media/i2c/gc5035.yaml
> new file mode 100644
> index 000000000000..cf8cc3b581cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/gc5035.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2019 MediaTek Inc.

Copyright 2020 Google LLC.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/gc5035.yaml
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Galaxycore Inc. GC5035 CMOS Sensor Device Tree Bindings
> +
> +maintainers:
> +  - Tomasz Figa <tfiga@chromium.org>
> +
> +description: |-
> +  The Galaxycore Inc. GC5035 is a 5 megapixel, 1/5 inch CMOS 10-bit Bayer image
> +  sensor that delivers 2592x1944 at 30fps. This chip is programmable through
> +  an I2C interface. The image output is available via a MIPI CSI-2 interface.
> +
> +properties:
> +  compatible:
> +    const: galaxycore,gc5035
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      Input clock for the sensor.
> +    items:
> +      - const: inclk

Typo: mclk.

> +
> +  clock-frequency:
> +    description:
> +      Frequency of the inclk clock in Hz.

mclk

> +
> +  iovdd-supply:
> +    description:
> +      Regulator driving the I/O power rail.
> +
> +  avdd28-supply:
> +    description:
> +      Regulator driving the analog power rail.
> +
> +  dvdd12-supply:
> +    description:
> +      Regulator driving the digital power rail.
> +
> +  resetb-gpios:
> +    description:
> +      The GPIO pin that drives the RESETB signal, controlling sensor reset.
> +      The RESETB signal must be driven low to activate the reset, so the
> +      GPIO_ACTIVE_LOW flag should be given by default.
> +
> +  pwdn-gpios:
> +    description:
> +      The GPIO pin that drives the PWDN signal, controlling sensor power-down
> +      mode. The PWDN signal must be driven low to activate the power-down
> +      mode, so the GPIO_ACTIVE_LOW flag should be given by default.
> +
> +  port:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      A node containing an output port node with an endpoint definition
> +      as documented in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +    properties:
> +      endpoint:
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          data-lanes:
> +            items:
> +              - const: 1
> +              - const: 2
> +
> +          link-frequencies: true
> +          remote-endpoint: true
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +          - remote-endpoint
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-frequency
> +  - iovdd-supply
> +  - avdd28-supply
> +  - dvdd12-supply
> +  - resetb-gpios
> +  - pwdn-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gc5035: camera@10 {
> +            compatible = "galaxycore,gc5035";
> +            reg = <0x10>;
> +
> +            reset-gpios = <&pio 111 GPIO_ACTIVE_LOW>;
> +            pwdn-gpios = <&pio 112 GPIO_ACTIVE_LOW>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&clk_24m_cam>;
> +
> +            clocks = <&cam_osc>;
> +            clock-names = "inclk";

mclk

Best regards,
Tomasz
