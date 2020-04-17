Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E98C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D1F21D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1OM7MYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgDQJ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgDQJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:57:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF72C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:57:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so2378776wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BxdOY3z0xM0CI52w6qoCNlpFo6ByBsjg8n/akR2lelc=;
        b=r1OM7MYyPLUl1o1MFezOlO7AvDxrNPs6Xz4NAaLKl1TeAvn0VSfVhxoS0vfa7/Whv7
         THcyu2XioGBgIj5oDSF+9361zmgyquIbS6my6peNI0bAJtf04uWiutCiT4VdZSUcguLn
         /6zCSWZVeKEHxaSRyu6OI1F5yMOym//DYJYCLlB2PwcKGxDvuI9fczsQyuGHOTTUKATk
         UyU9NBUqVdnPgXC7eWYrSlZ3X+QDCmPPMoREUkj+At+d6rc1t+LXvEME7+Qhg8L+xmJX
         zktoqKg+G5CMds+vod2roisaCDjzmK8OdJn3j2tpAzF6ZPwYrfe6fMWje3JXw45cYzb7
         k/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BxdOY3z0xM0CI52w6qoCNlpFo6ByBsjg8n/akR2lelc=;
        b=azmwce1y/UHTujQE3UpPF3FlbK6GJ+KnKQdP+dwk8zd+TIw4m6dZdDjz4/8UySQ7O7
         wNpCVSjE6Cus2Rw9YO/4hbS3vCe6NqeXkuMgFKncAdfg80HsB6D8/TFBOOX8fB3sKwY+
         EY4AKfCuZIaC1qHYw+y+JtRoFhL28vJjtAxXgPQowRnneVMgrQrtbTQnbVWnRPbkS4/d
         oSvkRW9BzVu1CsKBrO2kNRCzMbi0fh4GUJmGSe8eiqrXTVRw1/1gKo8KZQLUrfivCekY
         2bfAf3S4BysF4yhcZyVEMvW2HdAHx7WAzy3KVtDvrHQNWkZuv2PvoS5o4KYAhI5xOQEd
         Hxaw==
X-Gm-Message-State: AGi0PuZwJ0ITftjgHwW/R0tc5MLlNmGyzXxTUvufV+EJhS7J0i3TVdXE
        mkX8iHKCG2Clid58JAukKID/yQ==
X-Google-Smtp-Source: APiQypIue/Km0CGvOVXLRMs3dRNzNn2b+oQJbWUSRC7S+I6HZthWyFZ45PSiWlv1OzGFmHnp1EEYHg==
X-Received: by 2002:adf:b1c8:: with SMTP id r8mr2997631wra.218.1587117452173;
        Fri, 17 Apr 2020 02:57:32 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h188sm7601572wme.8.2020.04.17.02.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:57:31 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:58:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20200417095831.GI2167633@dell>
References: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
 <1585341214-25285-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585341214-25285-2-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Tim Harvey wrote:

> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v8:
>  - add register to fan-controller node name
> 
> v7:
>  - change divider from mili-ohms to ohms
>  - add constraints for voltage divider and offset
>  - remove unnecessary ref for offset
>  - renamed fan to fan-controller and changed base prop to reg
> 
> v6:
>  - fix typo
>  - drop invalid description from #interrupt-cells property
>  - fix adc pattern property
>  - add unit suffix
>  - replace hwmon/adc with adc/channel
>  - changed adc type to mode and enum int
>  - add unit suffix and drop ref for voltage-divider
>  - moved fan to its own subnode with base register
> 
> v5:
>  - resolve dt_binding_check issues
> 
> v4:
>  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
>  - remove unncessary resolution/scaling properties for ADCs
>  - update to yaml
>  - remove watchdog
> 
> v3:
>  - replaced _ with -
>  - remove input bindings
>  - added full description of hwmon
>  - fix unit address of hwmon child nodes
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 194 +++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> new file mode 100644
> index 00000000..a96751c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -0,0 +1,194 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gateworks System Controller multi-function device

I'd prefer if you didn't use Linuxisums in DT docs.

A 'multi-function device' isn't a thing - we made it up.

Nowhere in the documentation [0] is the Gateworks System Controller
described as a multi-function device.

[0] http://trac.gateworks.com/wiki/gsc

> +description: |
> +  The GSC is a Multifunction I2C slave device with the following submodules:

No it isn't.  It's a:

  "The Gateworks System Controller (GSC) is a device present across
   various Gateworks product families that provides a set of system
   related feature such as the following (refer to the board hardware
   user manuals to see what features are present)"

> +   - Watchdog Timer
> +   - GPIO
> +   - Pushbutton controller
> +   - Hardware Monitor with ADC's for temperature and voltage rails and
> +     fan controller

Why is "Monitor" capitalised, but "controller" is not?

I would s/Monitor/monitor/ here.

> +maintainers:
> +  - Tim Harvey <tharvey@gateworks.com>
> +  - Robert Jones <rjones@gateworks.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "gsc@[0-9a-f]{1,2}"
> +  compatible:
> +    const: gw,gsc
> +
> +  reg:
> +    description: I2C device address
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  adc:
> +    type: object
> +    description: Optional Hardware Monitoring module

Again, an odd thing to capitalise.

> +    properties:
> +      compatible:
> +        const: gw,gsc-adc
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@[0-9]+$":
> +        type: object
> +        description: |
> +          Properties for a single ADC which can report cooked values
> +          (ie temperature sensor based on thermister), raw values
> +          (ie voltage rail with a pre-scaling resistor divider).

/ie/i.e./

> +        properties:
> +          reg:
> +            description: Register of the ADC
> +            maxItems: 1
> +
> +          label:
> +            description: Name of the ADC input
> +
> +          gw,mode:
> +            description: |
> +              conversion mode:
> +                0 - temperature, in C*10
> +                1 - pre-scaled voltage value
> +                2 - scaled voltage based on an optional resistor divider
> +                    and optional offset
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32

Rob just submitted a patch-set to remove 'allOf's from '$ref'
properties.

> +            enum: [0, 1, 2]
> +
> +          gw,voltage-divider-ohms:
> +            description: values of resistors for divider on raw ADC input

s/values/Values/

> +            maxItems: 2
> +            items:
> +             minimum: 1000
> +             maximum: 1000000
> +
> +          gw,voltage-offset-microvolt:
> +            description: |
> +              A positive voltage offset to apply to a raw ADC
> +              (ie to compensate for a diode drop).

s/ie/i.e/

> +            minimum: 0
> +            maximum: 1000000
> +
> +        required:
> +          - gw,mode
> +          - reg
> +          - label
> +
> +    required:
> +      - compatible
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +patternProperties:
> +  "^fan-controller@[0-9a-f]+$":
> +    type: object
> +    description: Optional FAN controller

"Fan"

> +    properties:
> +      compatible:
> +        const: gw,gsc-fan
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      reg:
> +        description: The fan controller base address
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gsc@20 {
> +            compatible = "gw,gsc";
> +            reg = <0x20>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <4 GPIO_ACTIVE_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            adc {
> +                compatible = "gw,gsc-adc";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                channel@0 { /* A0: Board Temperature */
> +                    reg = <0x00>;
> +                    label = "temp";
> +                    gw,mode = <0>;
> +                };
> +
> +                channel@2 { /* A1: Input Voltage (raw ADC) */
> +                    reg = <0x02>;
> +                    label = "vdd_vin";
> +                    gw,mode = <1>;
> +                    gw,voltage-divider-ohms = <22100 1000>;
> +                    gw,voltage-offset-microvolt = <800000>;
> +                };
> +
> +                channel@b { /* A2: Battery voltage */
> +                    reg = <0x0b>;
> +                    label = "vdd_bat";
> +                    gw,mode = <1>;
> +                };
> +            };
> +
> +            fan-controller@2c {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                compatible = "gw,gsc-fan";
> +                reg = <0x2c>;
> +            };
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
