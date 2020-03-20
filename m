Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1FC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BF6206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584674119;
	bh=Qy4Drd2ux8KYY4KgJCZdJOObAhqMSo77y6zNWn+q4MM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VcvAdyRwZbBPhG7tyh0ZWqMequXtZq+TJ42mxrcDj+A/Kp4UXFj+sfPw1dboGJ9GU
	 ZwYmL9eMSkzQWX+uvOHq5LXJhBiLe0bmDFaE7JGROQva9OPX4PijwM94/UKuSOXntl
	 hMYKoQgjyu5YSGJm+Mr9bE8pEqcOd8XWZg/YkPPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCTDPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgCTDPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:15:18 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68AD20732;
        Fri, 20 Mar 2020 03:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584674117;
        bh=Qy4Drd2ux8KYY4KgJCZdJOObAhqMSo77y6zNWn+q4MM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w3GKc92cnRRSzt66icI55KS0YEpfwJqCiylsk1UA/e0G2dtEuTFM3ktG48tXpJvQH
         RUqJDJyM6DfJjtqBLJ5d/7Iv/23jWn4gz1/qanH0EYx3PWYHQZ5NnQOzLXVoT7V7yP
         pa/AWhK78n39Pbt4bzMzZAspmVtoVHhhot1C7FLo=
Received: by mail-qt1-f180.google.com with SMTP id d22so3881277qtn.0;
        Thu, 19 Mar 2020 20:15:16 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2RuSClpIGjk4Ol/gbJ7iJHsGYum2kCfd2o9VuF3OvTt+9X2Zws
        x+3Vhu6Q89az0ImCEVdkqVNYO7MufTDXJVc4GA==
X-Google-Smtp-Source: ADFU+vvbZ0m/eqkTFt+PYD8TMf6wIaTyZ1u2Jmh0zj6G5M05l2SrNwBvEVQ1sjhQ0kcRpDTwXiW7ElZTToN7kZFliKg=
X-Received: by 2002:ac8:1b33:: with SMTP id y48mr6410475qtj.136.1584674115935;
 Thu, 19 Mar 2020 20:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <1584464453-28200-1-git-send-email-tharvey@gateworks.com> <1584464453-28200-2-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1584464453-28200-2-git-send-email-tharvey@gateworks.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Mar 2020 21:15:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8isY1ymi6Kk=uDC-uLR5QZUYUUQJ3z=SJ6ToC5aTbjg@mail.gmail.com>
Message-ID: <CAL_JsqK8isY1ymi6Kk=uDC-uLR5QZUYUUQJ3z=SJ6ToC5aTbjg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:01 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v6:
>  - fix commit message typo
>  - drop invalid description from #interrupt-cells property
>  - fix adc pattern property
>  - add unit suffix
>  - replace hwmon/adc with adc/channel
>  - changed adc type to gw,mode
>  - add unit suffix and drop ref for voltage-divider
>  - add unit suffix for voltage-offset
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
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> new file mode 100644
> index 00000000..e921e67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -0,0 +1,172 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gateworks System Controller multi-function device
> +
> +description: |
> +  The GSC is a Multifunction I2C slave device with the following submodules:
> +   - Watchdog Timer
> +   - GPIO
> +   - Pushbutton controller
> +   - Hardware Monitor with ADC's for temperature and voltage rails and
> +     fan controller
> +
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
> +  adc:
> +    type: object
> +    description: Optional Hardware Monitoring module
> +
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
> +
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
> +            enum: [0, 1, 2]
> +
> +          gw,voltage-divider-milli-ohms:
> +            description: values of resistors for divider on raw ADC input
> +            items:
> +              - description: R1
> +              - description: R2

Aren't there some constraints on the values? You could do something like this:

            maxItems: 2
            items:
              minimum: 1
              maximum: 2000

I know I said the way you have it is fine, but the example fails with
it like this. It's related to how we encode the DT data for validation
and some schema fixups we do to cut down on some boilerplate. We could
just fix the example (with <> around each value), but having
constraints is better.

> +
> +          gw,voltage-offset-microvolt:
> +            $ref: /schemas/types.yaml#/definitions/uint32

Can drop this as .*-microvolt has a defined type.

Are there some constraints?

> +            description: |
> +              A positive voltage offset to apply to a raw ADC
> +              (ie to compensate for a diode drop).
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
> +  fan:

fan-controller

Save 'fan' for if/when we have a node representing the fan itself.

> +    type: object
> +    description: Optional FAN controller
> +
> +    properties:
> +      compatible:
> +        const: gw,gsc-fan
> +
> +      base:

What happened to 'reg'? While inconsistent that adc doesn't have an
address, better that than inventing your own address property.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The fan controller base address
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - base
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
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
> +
> +            adc {
> +                compatible = "gw,gsc-adc";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                channel@0 { /* A0: Board Temperature */
> +                    gw,mode = <0>;
> +                    reg = <0x00>;
> +                    label = "temp";
> +                };
> +
> +                channel@2 { /* A1: Input Voltage (raw ADC) */
> +                    gw,mode = <1>;
> +                    reg = <0x02>;
> +                    label = "vdd_vin";
> +                    gw,voltage-divider-milli-ohms = <22100 1000>;
> +                    gw,voltage-offset-microvolt = <800000>;
> +                };
> +
> +                channel@b { /* A2: Battery voltage */
> +                    gw,mode = <1>;
> +                    reg = <0x0b>;
> +                    label = "vdd_bat";
> +                };
> +            };
> +
> +            fan {
> +                compatible = "gw,gsc-fan";
> +                base = <0x2c>;
> +            };
> +        };
> +    };
> --
> 2.7.4
>
