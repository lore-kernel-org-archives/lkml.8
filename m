Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54ADC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE37020736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589291069;
	bh=Ysp4s+ZpzTFI3yGOxKN62j8WqlJDMvi/rRLMDlpSH3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9jt5JyhhQ9NyLb9MjspzKFsSyv9ecIfHF+D1hwqtnmpLUrwghVNvzp2Drq1Mgl1k
	 ngD2MiZSYsvlU1ktO8DJJuDsAdNvxt8w6P1SBHVr+tFSrPTsY8Qrd1GeipWFhfxstV
	 lXuFBIR9HBeZlclnC/IygTlxh/BWcQTqqPInSsic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgELNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:44:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44724 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:44:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id a2so18034211oia.11;
        Tue, 12 May 2020 06:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMsyl4qJDPD11e6fr9/kLy2vOSTB2tI8cXSfJC9spT8=;
        b=oSHNwrXZa2n/j7DPPBfsRCPIg8N1jhBlJxiFzMKZHw+N6+aUaWyPDkguTYMw7eS7B3
         isGUcZ1o6qXcnzX++yZ1hEmQSIJOJy+YkkUD1kyEa91ov3kBG10cmNtgUHoHG32+I1zd
         ndS+E1Jf/B27wHGo6/fLRnA1ET9vg1E7sMEUBD+I2kvW3p+tsdLMDofywK9sR8GZzoU/
         LYog9vLprir9WB2nbHJewJO2c0BPe1inShZvGkb+ZYIj3rSMYuRImzQvNj2LOoD8wxwk
         EIrKEKITRYVu2kHnIx0KCcDodjAsKl5YelaNCEqBFNZ66JwdDiaFKcild/95mDyKOoty
         d7sg==
X-Gm-Message-State: AGi0PuYMLxYCJfmlxbj3d2u+Qxa7QQSG3oynPzqis21FCwSrz8lEqCkk
        xNLc/6gtp8Q47hYTjI/SBg==
X-Google-Smtp-Source: APiQypK7OHs1VUmLgoEV9wFSHpDDhFLVZwTb2iqi9qsY6mBzxL2SDHYg2mLC/CsP+y4MwRrVQ2EaRA==
X-Received: by 2002:aca:1313:: with SMTP id e19mr19882652oii.74.1589291065126;
        Tue, 12 May 2020 06:44:25 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d64sm262826oig.53.2020.05.12.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:44:24 -0700 (PDT)
Received: (nullmailer pid 10673 invoked by uid 1000);
        Tue, 12 May 2020 13:44:23 -0000
Date:   Tue, 12 May 2020 08:44:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/5] pinctrl: lochnagar: Move binding over to dtschema
Message-ID: <20200512134423.GB23637@bogus>
References: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
 <20200504154757.17519-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504154757.17519-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 04:47:55PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Moved sub-node into MFD file leaving just the properties in here
>  - Removed contains on the compatible
>  - Added a required -pins suffix for pinmux/ctrl nodes
>  - Added some extra blank lines for readability
> 
> Thanks,
> Charles
> 
>  .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 ---------------
>  .../bindings/pinctrl/cirrus,lochnagar.yaml         | 191 +++++++++++++++++++++
>  2 files changed, 191 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml


> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> new file mode 100644
> index 0000000000000..2d6f832f1e4c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> @@ -0,0 +1,191 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,lochnagar.yaml#
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
> +  Logic devices on mini-cards, as well as allowing connection of various
> +  application processor systems to provide a full evaluation platform.
> +  Audio system topology, clocking and power can all be controlled through
> +  the Lochnagar, allowing the device under test to be used in a variety of
> +  possible use cases.
> +
> +  This binding document describes the binding for the pinctrl portion of
> +  the driver.
> +
> +  Also see these documents for generic binding information:
> +    [1] GPIO : ../gpio/gpio.txt
> +    [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
> +
> +  And these for relevant defines:
> +    [3] include/dt-bindings/pinctrl/lochnagar.h
> +
> +  This binding must be part of the Lochnagar MFD binding:
> +    [4] ../mfd/cirrus,lochnagar.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,lochnagar-pinctrl
> +
> +  gpio-controller:
> +    description:
> +      Indicates this device is a GPIO controller.

No need to re-describe common properties unless you have something 
specific about this device to say. Just:

gpio-controller: true

> +
> +  '#gpio-cells':
> +    description:
> +      The first cell is the pin number and the second cell is used
> +      to specify optional parameters.
> +    const: 2
> +
> +  gpio-ranges:
> +    description:
> +      Range of pins managed by the GPIO controller, see [1]. Both the
> +      GPIO and Pinctrl base should be set to zero and the count to the
> +      appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define, see [3].
> +    maxItems: 1
> +
> +  pinctrl-0:
> +    description:
> +      A phandle to the default pinctrl state.
> +
> +  pinctrl-names:
> +    description:
> +      A pinctrl state named "default" must be defined.
> +    const: default
> +
> +patternProperties:
> +  '^.*$':

No need to allow anything here. Use 'pin-settings' instead.

Needs 'type: object' too.

> +    patternProperties:
> +      '^.*-pins$':

Just '-pins$' is equivalent.

> +        description:
> +          The pin configurations are defined as a child of the pinctrl
> +          states node, see [2]. Each sub-node can have the following
> +          properties.
> +        type: object
> +        allOf:
> +          - $ref: pincfg-node.yaml#
> +          - $ref: pinmux-node.yaml#
> +
> +        properties:
> +          groups:
> +            description:
> +              A list of groups to select (either this or "pins" must be
> +              specified), available groups.
> +            enum: [ codec-aif1, codec-aif2, codec-aif3, dsp-aif1,
> +                    dsp-aif2, psia1, psia2, gf-aif1, gf-aif2, gf-aif3,
> +                    gf-aif4, spdif-aif, usb-aif1, usb-aif2, adat-aif,
> +                    soundcard-aif ]
> +
> +          pins:
> +            description:
> +              A list of pin names to select (either this or "groups" must
> +              be specified), available pins.
> +            enum: [ fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
> +                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
> +                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
> +                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
> +                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
> +                    gf-gpio2, gf-gpio3, gf-gpio7, codec-aif1-bclk,
> +                    codec-aif1-rxdat, codec-aif1-lrclk, codec-aif1-txdat,
> +                    codec-aif2-bclk, codec-aif2-rxdat, codec-aif2-lrclk,
> +                    codec-aif2-txdat, codec-aif3-bclk, codec-aif3-rxdat,
> +                    codec-aif3-lrclk, codec-aif3-txdat, dsp-aif1-bclk,
> +                    dsp-aif1-rxdat, dsp-aif1-lrclk, dsp-aif1-txdat,
> +                    dsp-aif2-bclk, dsp-aif2-rxdat, dsp-aif2-lrclk,
> +                    dsp-aif2-txdat, psia1-bclk, psia1-rxdat, psia1-lrclk,
> +                    psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
> +                    psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat,
> +                    gf-aif3-lrclk, gf-aif3-txdat, gf-aif4-bclk,
> +                    gf-aif4-rxdat, gf-aif4-lrclk, gf-aif4-txdat,
> +                    gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
> +                    gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat,
> +                    gf-aif2-lrclk, gf-aif2-txdat, dsp-uart1-rx,
> +                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
> +                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, codec-pdmclk1,
> +                    codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
> +                    codec-dmicclk1, codec-dmicdat1, codec-dmicclk2,
> +                    codec-dmicdat2, codec-dmicclk3, codec-dmicdat3,
> +                    codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
> +                    dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
> +                    i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda,
> +                    dsp-standby, codec-mclk1, codec-mclk2, dsp-clkin,
> +                    psia1-mclk, psia2-mclk, gf-gpio1, gf-gpio5,
> +                    dsp-gpio20, led1, led2 ]
> +
> +          function:
> +            description:
> +              The mux function to select, available functions.
> +            enum: [ aif, fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
> +                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
> +                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
> +                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
> +                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
> +                    gf-gpio2, gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5,
> +                    dsp-gpio20, codec-clkout, dsp-clkout, pmic-32k,
> +                    spdif-clkout, clk-12m288, clk-11m2986, clk-24m576,
> +                    clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
> +                    gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1,
> +                    codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
> +                    spdif-mclk, codec-irq, codec-reset, dsp-reset,
> +                    dsp-irq, dsp-standby, codec-pdmclk1, codec-pdmdat1,
> +                    codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
> +                    codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
> +                    codec-dmicclk3, codec-dmicdat3, codec-dmicclk4,
> +                    codec-dmicdat4, dsp-dmicclk1, dsp-dmicdat1,
> +                    dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
> +                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
> +                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, usb-uart-tx,
> +                    i2c2-scl, i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl,
> +                    i2c4-sda, spdif-aif, psia1, psia1-bclk, psia1-lrclk,
> +                    psia1-rxdat, psia1-txdat, psia2, psia2-bclk,
> +                    psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
> +                    codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
> +                    codec-aif1-txdat, codec-aif2, codec-aif2-bclk,
> +                    codec-aif2-lrclk, codec-aif2-rxdat, codec-aif2-txdat,
> +                    codec-aif3, codec-aif3-bclk, codec-aif3-lrclk,
> +                    codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
> +                    dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat,
> +                    dsp-aif1-txdat, dsp-aif2, dsp-aif2-bclk,
> +                    dsp-aif2-lrclk, dsp-aif2-rxdat, dsp-aif2-txdat,
> +                    gf-aif3, gf-aif3-bclk, gf-aif3-lrclk, gf-aif3-rxdat,
> +                    gf-aif3-txdat, gf-aif4, gf-aif4-bclk, gf-aif4-lrclk,
> +                    gf-aif4-rxdat, gf-aif4-txdat, gf-aif1, gf-aif1-bclk,
> +                    gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat, gf-aif2,
> +                    gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
> +                    gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif,
> +                    soundcard-aif ]
> +
> +          output-enable:
> +            description:
> +              Specifies that an AIF group will be used as a master
> +              interface (either this or input-enable is required if a
> +              group is being muxed to an AIF)
> +
> +          input-enable:
> +            description:
> +              Specifies that an AIF group will be used as a slave
> +              interface (either this or output-enable is required if a
> +              group is being muxed to an AIF)
> +
> +        additionalProperties: false

Blank line.

> +        required:
> +          - function
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +  - pinctrl-0
> +  - pinctrl-names
> -- 
> 2.11.0
> 
