Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E134AC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7F4216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588366566;
	bh=nAPIQ/ctzcZNlSeI4vthYzGts69FdtrP1YhBQv5x4vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iI2rMn78dgVn3q2X/jCFuWQ7ZuEKI6ifSCHFVZ4CMd2OjfzvMmKLfnbA2eawXawNf
	 4xy36OIhUri5M3dWYT4mHpO4dLNBK2b5lKQKB7FShNeXQ3/eXQ1F9iu9Cup9CB/ZXP
	 wp9wG8o9orN/xJ1GvFB3ZgSLL8LNpjweFNNqcqiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEAU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:56:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37326 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAU4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:56:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so860820oij.4;
        Fri, 01 May 2020 13:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6IC17tZW6vqT9CmLTlwRsx4notXDh7Wwch+6E+uiiM=;
        b=tkaC0Za+0bCuTNoJJmN47yZsff7osoJ3aTXl7VsFcLRWYazlX/JkD0vpTaLz7hHz9Z
         6mP3cnvOso+JnqRQ2Pzb+awsAOixfAHiZq3CCQ1Se9E8HpJhHvOKChdLmL+dHwFEiFIw
         wGsKF2dLo8heqdKDPske2MJVUoPn6rMaWLOzNw0liJPQplonhjBaFb2iZ9K+hXQHjnRu
         gJ5X/u8U6pIBlngfZ123VBSHrChlmSZHCvgIsbvbmdVrgGlEAhQWC0h0uaSsaHZ+O3t5
         izc2KFxR/cSmkjwLLpXwqWjbV5MxnvudLcW03jA2MLmM6peMyRCilHN+TDtNhP3y9w7h
         B8MA==
X-Gm-Message-State: AGi0PuafLBsnOpnXJHz3uj8KVtnMkPnPhJ0FmOQev1MaZ5H0AB/dIdOh
        6gYLCDjb/BaXOSEsv+wQ5Q==
X-Google-Smtp-Source: APiQypKwloeYWVQME9YEttq2mIKBrICEUzFbLarsog4cs4kj61sUK0KRhbHf2yiUjkS9hilRLwofdQ==
X-Received: by 2002:aca:895:: with SMTP id 143mr1072960oii.153.1588366560856;
        Fri, 01 May 2020 13:56:00 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r6sm1093672oom.26.2020.05.01.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:56:00 -0700 (PDT)
Received: (nullmailer pid 8107 invoked by uid 1000);
        Fri, 01 May 2020 20:55:59 -0000
Date:   Fri, 1 May 2020 15:55:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 6/6] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200501205559.GB24163@bogus>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:28:12AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  85 ----------
>  .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 183 +++++++++++++++++++++
>  MAINTAINERS                                        |  12 +-
>  3 files changed, 189 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml

> diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> new file mode 100644
> index 0000000000000..b2967f141b2af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> @@ -0,0 +1,183 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/cirrus,lochnagar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic Lochnagar Audio Development Board
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  Lochnagar is an evaluation and development board for Cirrus Logic
> +  Smart CODEC and Amp devices. It allows the connection of most Cirrus
> +  Logic devices on mini-cards, as well as allowing connection of
> +  various application processor systems to provide a full evaluation
> +  platform.  Audio system topology, clocking and power can all be
> +  controlled through the Lochnagar, allowing the device under test
> +  to be used in a variety of possible use cases.
> +
> +  Also see these documents for generic binding information:
> +    [1] GPIO : ../gpio/gpio.txt
> +
> +  And these for relevant defines:
> +    [2] include/dt-bindings/pinctrl/lochnagar.h
> +    [3] include/dt-bindings/clock/lochnagar.h
> +
> +  And these documents for the required sub-node binding details:
> +    [4] Clock: ../clock/cirrus,lochnagar.yaml
> +    [5] Pinctrl: ../pinctrl/cirrus,lochnagar.yaml
> +    [6] Regulator: ../regulator/cirrus,lochnagar.yaml
> +    [7] Sound: ../sound/cirrus,lochnagar.yaml
> +    [8] Hardware Monitor: ../hwmon/cirrus,lochnagar.yaml
> +
> +allOf:
> +  - $ref: /schemas/clock/cirrus,lochnagar.yaml#
> +  - $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
> +  - $ref: /schemas/regulator/cirrus,lochnagar.yaml#

The preferred form is to define the child nodes in this schema and then 
reference the child schema:

lochnagar-clk:
  type: object
  $ref: /schemas/clock/cirrus,lochnagar.yaml#

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - cirrus,lochnagar2
> +    then:
> +      allOf:
> +        - $ref: /schemas/sound/cirrus,lochnagar.yaml#
> +        - $ref: /schemas/hwmon/cirrus,lochnagar.yaml#

That makes this part a bit more challenging:

then:
  required:
    - lochnagar-sc
else:
  not:
    required:
      - lochnagar-sc

> +
> +properties:
> +  compatible:
> +    contains:

So this is valid?

"foo", "cirrus,lochnagar1"

I think you just want to drop 'contains'.

> +      enum:
> +        - cirrus,lochnagar1
> +        - cirrus,lochnagar2
> +
> +  reg:
> +    description:
> +      I2C slave address.

No need for generic descriptions of common properties.

> +    const: 0x22
> +
> +  reset-gpios:
> +    description: |
> +      Reset line to the Lochnagar, see [1].
> +    maxItems: 1
> +
> +  present-gpios:
> +    description: |
> +      Host present line, indicating the presence of a
> +      host system, see [1]. This can be omitted if the present line is
> +      tied in hardware.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - lochnagar-clk
> +  - lochnagar-pinctrl
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clk/lochnagar.h>
> +    #include <dt-bindings/pinctrl/lochnagar.h>
> +    i2c@e0004000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0xe0004000 0x1000>;
> +
> +        lochnagar: lochnagar@22 {
> +            compatible = "cirrus,lochnagar2";
> +            reg = <0x22>;
> +
> +            reset-gpios = <&gpio0 55 0>;
> +            present-gpios = <&gpio0 60 0>;
> +
> +            lochnagarclk: lochnagar-clk {
> +                compatible = "cirrus,lochnagar2-clk";
> +
> +                #clock-cells = <1>;
> +                clocks = <&clkaudio>, <&clkpmic>;
> +                clock-names = "ln-gf-mclk2", "ln-pmic-32k";
> +
> +                assigned-clocks = <&lochnagarclk LOCHNAGAR_CDC_MCLK1>,
> +                                  <&lochnagarclk LOCHNAGAR_CDC_MCLK2>;
> +                assigned-clock-parents = <&clkaudio>, <&clkpmic>;
> +            };
> +
> +            clkpmic: lochnagar-pmic32k {
> +                compatible = "fixed-clock";
> +                #clock-cells = <0>;
> +                clock-frequency = <32768>;
> +            };
> +
> +            lochnagar-pinctrl {
> +                compatible = "cirrus,lochnagar-pinctrl";
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
> +
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinsettings>;
> +
> +                pinsettings: pin-settings {
> +                    ap2aif {
> +                        input-enable;
> +                        groups = "gf-aif1";
> +                        function = "codec-aif3";
> +                    };
> +                    codec2aif {
> +                        output-enable;
> +                        groups = "codec-aif3";
> +                        function = "gf-aif1";
> +                    };
> +                };
> +            };
> +
> +            lochnagar-sc {
> +                compatible = "cirrus,lochnagar2-soundcard";
> +
> +                #sound-dai-cells = <1>;
> +
> +                clocks = <&lochnagarclk LOCHNAGAR_SOUNDCARD_MCLK>;
> +                clock-names = "mclk";
> +            };
> +
> +            lochnagar-hwmon {
> +                compatible = "cirrus,lochnagar2-hwmon";
> +            };
> +
> +            MIC1VDD {
> +                compatible = "cirrus,lochnagar2-mic1vdd";
> +
> +                MICBIAS1-supply = <&eric>;
> +
> +                cirrus,micbias-input = <3>;
> +            };
> +
> +            MICVDD {
> +                compatible = "cirrus,lochnagar2-micvdd";
> +
> +                SYSVDD-supply = <&wallvdd>;
> +
> +                regulator-min-microvolt = <3300000>;
> +                regulator-max-microvolt = <3300000>;
> +            };
> +
> +            VDD1V8 {
> +                compatible = "regulator-fixed";
> +
> +                regulator-name = "VDD1V8";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-boot-on;
> +                regulator-always-on;
> +
> +                vin-supply = <&wallvdd>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db314976..a2b94e8cf585c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4062,12 +4062,12 @@ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
>  M:	Richard Fitzgerald <rf@opensource.cirrus.com>
>  L:	patches@opensource.cirrus.com
>  S:	Supported
> -F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> -F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
> -F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
> -F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
> -F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
> -F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
> +F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
> +F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
> +F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> +F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> +F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.yaml
> +F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
>  F:	Documentation/hwmon/lochnagar.rst
>  F:	drivers/clk/clk-lochnagar.c
>  F:	drivers/hwmon/lochnagar-hwmon.c
> -- 
> 2.11.0
> 
