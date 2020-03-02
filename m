Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D57C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E46521556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583182193;
	bh=Vg7RTh0DmR4uCUqIIcLRv1veXLOE/Bz3/Ee5k3i5bio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UV1nhcjM60DYp1/PVulr3h/PT2HVuKOsFkhxP5vJWyy508n/X+75PC0aQscp/ER6r
	 p8e+ASTbKj+tG82/1K5BUE77YtTL6pjHkWCMoNOvSVREnVlwSISEGOx9a1muRnECpL
	 a/hd/Dx3fSmva+k9h1My6w1olDcEgcN9A2ug/NJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCBUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:49:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39324 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgCBUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:49:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id x97so702160ota.6;
        Mon, 02 Mar 2020 12:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qssGF9qFB2gzSIbry+qMVppu5nTfK3/hDKpshcwFd+Q=;
        b=mksnkTzBcXT/eRpzg/ri87qeKmNK01PXYoxCco0HHCK2F5KQxPvyvCAVjMY9mYD4uY
         x91OUizkJ/Ovsu2d32KE+IOJYGgbV/g4iR4rGh/TZR++lp624n41IhvRJxtlDQ0vFbar
         aRv4yW3YOr0HLoQJ0rp1j/0iZ/+4FfRa2TefAHytEgKlQfSTh9WqnUVTvUOT1lwI8Oue
         ic4bQ0/0MTA9b/RL2YUc9Rp61jvJZ9qsPbnh+A9jqH9H7rHftnwkMHVb9wLflEX7nrSt
         KuOTjq5h+yaFbaSDlCLUmRk12h42JQiPOiUeO+CWOnvQm8Yh9CFMvjn8X9lYaeUEYGVN
         e7mQ==
X-Gm-Message-State: ANhLgQ3pGlEA0UnU/QZsqoZDafgRr/Zo8RuhFWzW1mXQn4yMtf5EsiUh
        vB8ALtNR4UK+iWIYAc2+vQ==
X-Google-Smtp-Source: ADFU+vt0jhM7ZnpP8nrP1UQSnjX51UgJY5kMa8SlcLri3xoEVlomkmVLn5RGxuVds/atQ4U9jNo8/A==
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr828272otp.231.1583182190727;
        Mon, 02 Mar 2020 12:49:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm6698704oic.31.2020.03.02.12.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:49:50 -0800 (PST)
Received: (nullmailer pid 5728 invoked by uid 1000);
        Mon, 02 Mar 2020 20:49:49 -0000
Date:   Mon, 2 Mar 2020 14:49:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20200302204949.GA6649@bogus>
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582577665-13554-2-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:54:23PM -0800, Tim Harvey wrote:
> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
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
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 158 +++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> new file mode 100644
> index 00000000..f7c1a05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -0,0 +1,158 @@
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
> +   - Hardware Monitore with ADC's for temperature and voltage rails and

typo

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

That's not very specific.

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
> +    description: The IRQ number

description is wrong. You can just drop it.

> +
> +  hwmon:

'hwmon' is a Linux thing. I'm suspicious...

> +    type: object
> +    description: Optional Hardware Monitoring module
> +
> +    properties:
> +      compatible:
> +        const: gw,gsc-hwmon
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      gw,fan-base:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: The fan controller base address

Shouldn't this be described as a node in the DT or be implied by the 
compatible?

> +
> +    patternProperties:
> +      "^adc@[0-2]$":

There's only one number space at any level. So if you ever need anything 
else at this level, it can't have an address. Just something to 
consider.

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
> +          type:

Very generic property name, but it's not generic. Needs a vendor prefix 
at least.

> +            description: |
> +              temperature in C*10 (temperature),
> +              pre-scaled voltage value (voltage),
> +              or scaled based on an optional resistor divider and optional
> +              offset (voltage-raw)
> +            enum:
> +              - temperature
> +              - voltage
> +              - voltage-raw
> +
> +          gw,voltage-divider:
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            description: values of resistors for divider on raw ADC input
> +            items:
> +              - description: R1
> +              - description: R2

Needs a standard unit suffix. With that, you can drop the type 
reference.

> +
> +          gw,voltage-offset:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |
> +              A positive uV voltage offset to apply to a raw ADC
> +              (ie to compensate for a diode drop).

Needs a unit suffix. 

> +
> +        required:
> +          - type
> +          - reg
> +          - label
> +
> +    required:
> +      - compatible
> +      - "#address-cells"
> +      - "#size-cells"
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
> +            hwmon {
> +                compatible = "gw,gsc-hwmon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                gw,fan-base = <0x2c>;
> +
> +                adc@0 { /* A0: Board Temperature */
> +                    type = "temperature";
> +                    reg = <0x00>;
> +                    label = "temp";
> +                };
> +
> +                adc@2 { /* A1: Input Voltage (raw ADC) */
> +                    type = "voltage-raw";
> +                    reg = <0x02>;
> +                    label = "vdd_vin";
> +                    gw,voltage-divider = <22100 1000>;
> +                    gw,voltage-offset = <800000>;
> +                };
> +
> +                adc@b { /* A2: Battery voltage */
> +                    type = "voltage";
> +                    reg = <0x0b>;
> +                    label = "vdd_bat";
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
