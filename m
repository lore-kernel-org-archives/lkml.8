Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E47C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A420719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585250013;
	bh=AJx2DoDzBAsnZsa5HGaQbr8zhKzSabXNRj/J1Xlod0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qim0q1xmziskRuLbFw9pxNT3Dz/qrBn2m581MaoFP+iZPQZ/F0CrDRwc/dbRbvoFX
	 5DVcpmWhxtGaiKm0kT+qUmmmntnY3hGb7qc8qpBcJEtMY65hKVYdCkyOsiEXgY9SCu
	 PduVt3zrK1UeTBlovi2GVSO3BaSBQmlvxEaxNjJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgCZTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:13:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34322 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:13:31 -0400
Received: by mail-io1-f65.google.com with SMTP id h131so7319362iof.1;
        Thu, 26 Mar 2020 12:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lV2UHAI4DrIYW6rSj3tPA5hIszzj928pZD3nBI8/xbM=;
        b=JXIB1gFjcX/3TDOnLuf+TAXf9iUCxsGcSZUxKJlxEqhZcJ35GS+6U/dw4W44+pyKii
         YGzGi9swrRcv8RtqbWnWjlHzY4pq0Y5cAj2nzxd/4s85CR8DjHI6CMX1CIkZXcrTFqRH
         8KWkIkyCN8EhOJjyjsbodkW3ftC1kkR4BrR8Ksn9oUq4yf95gddpNnlO0O5XH8psTNki
         CekaHCt75Fn5g8LR798uJ79f0wT5HL9UAX2vS8NeA9Q+6/Tdh33qhO9PKuhEqoM7nKWZ
         QjhP++v/L6vjCw/8TojBtnvldCam/uL8dfnna4QEzDL6yNqBWX7ch++zvizosZpeZhoM
         Gz6g==
X-Gm-Message-State: ANhLgQ2TK32TFeoDMe+UyBQAAxWMHBhhGjM8GY1I4EutNe1gh1y6dElq
        sfeq94jeK6/pX7M4XzpAyg==
X-Google-Smtp-Source: ADFU+vvkD0gqxwTSZI44S2pcrAYhpd2eOloQseFzMmG2iAWcgTbVvbdJz8EX+48uyueBiyEvk9OHrQ==
X-Received: by 2002:a5d:84d0:: with SMTP id z16mr8987488ior.88.1585250010123;
        Thu, 26 Mar 2020 12:13:30 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j18sm1091552ila.56.2020.03.26.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:13:28 -0700 (PDT)
Received: (nullmailer pid 32104 invoked by uid 1000);
        Thu, 26 Mar 2020 19:13:27 -0000
Date:   Thu, 26 Mar 2020 13:13:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Message-ID: <20200326191327.GA27256@bogus>
References: <1584736550-7520-1-git-send-email-tharvey@gateworks.com>
 <1584736550-7520-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584736550-7520-2-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 01:35:48PM -0700, Tim Harvey wrote:
> This patch adds documentation of device-tree bindings for the
> Gateworks System Controller (GSC).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
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
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> new file mode 100644
> index 00000000..0457137
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -0,0 +1,173 @@
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
> +          gw,voltage-divider-ohms:
> +            description: values of resistors for divider on raw ADC input
> +            maxItems: 2
> +            items:
> +             minimum: 1000
> +             maximum: 1000000
> +
> +          gw,voltage-offset-microvolt:
> +            description: |
> +              A positive voltage offset to apply to a raw ADC
> +              (ie to compensate for a diode drop).
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
> +  fan-controller:
> +    type: object
> +    description: Optional FAN controller
> +
> +    properties:
> +      compatible:
> +        const: gw,gsc-fan
> +
> +      reg:
> +        description: The fan controller base address
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
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
> +            fan-controller {

fan-controller@2c

(and the schema will need to be changed either to the above or a 
pattern)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +                compatible = "gw,gsc-fan";
> +                reg = <0x2c>;
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
