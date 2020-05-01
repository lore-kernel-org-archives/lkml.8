Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642FBC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED9421835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588366999;
	bh=m+AX6G5VMVrsZP5E7u4dpjX8CN7FfXCTKMmR3jIjMP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0gpy+cNjQJWqUkzrlmE7U8Ilfb6IMm+q61nACGCVN7jkKRlegoa4TlJQ7d/rdJ7ja
	 bgU+0cGNtw4nbDQI3hZrapoiP6mnQ/HiIyNRZOA3q5BKnyy/29xiEmKFQ40mUHWh/N
	 Gq10KU+G1IAKUsSpAj4BNmCSE7Bob7udwqH0Q6oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgEAVDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:03:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43442 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:03:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14so3582315otg.10;
        Fri, 01 May 2020 14:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVEnETLx3JtdBSug2Xc6PksJ3cJU92UDSZdfD6H+2sY=;
        b=pF4B/6/2Dwdr6XoiFXHRa9jR3iNL5tBjJGgH06RnLnL+9DXgwbosHUpK0k4DF0/Yvd
         YN7sVXOJ2Af2k9HGuC+Y1/2f/hZWHxDNvbTknjKIkygeqbeYB07/oEvQjOgn4U1pIJre
         L8d8ycCmIZqwfr4cgsVjq1J4t3wFnLVlIz5n3DDnWcAkJTpDByZOMHM9akZVwqJZMQpM
         0PPNhxfgR10qy6lEgeS7jmYk+AtVp6Lkx0yD/UjxJD0mwF3MAcNvrcFmUt1iXObtSJUg
         Ay8TLEk7kcVm0jQZ22i2Fcl8ZXjHhsTqsjYBmeZ9QO0dsN0/10XyunO2YFFt3saX2z/e
         Grlw==
X-Gm-Message-State: AGi0PubuOsK9vFa9xLP/8iuzrUgXaHaN3CvQ0bHhKAPkru/JKz4Es20F
        AVZpNDjqemDzGr93z625PA==
X-Google-Smtp-Source: APiQypIYpNqXSUSToj6E+hxI9EqvJncl2t2nemQRGITzBdz9FCv81Nupe8XhvFGtRMILQ0N1TXgPSw==
X-Received: by 2002:a05:6830:19fa:: with SMTP id t26mr5311504ott.34.1588366997285;
        Fri, 01 May 2020 14:03:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm1099485ott.17.2020.05.01.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:03:16 -0700 (PDT)
Received: (nullmailer pid 19900 invoked by uid 1000);
        Fri, 01 May 2020 21:03:14 -0000
Date:   Fri, 1 May 2020 16:03:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 5/6] clk: lochnagar: Move binding over to dtschema
Message-ID: <20200501210314.GC24163@bogus>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-5-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427102812.23251-5-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:28:11AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/clock/cirrus,lochnagar.txt |  94 ---------
>  .../bindings/clock/cirrus,lochnagar.yaml           | 220 +++++++++++++++++++++
>  2 files changed, 220 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml


> diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
> new file mode 100644
> index 0000000000000..55d27e4475333
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
> @@ -0,0 +1,220 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,lochnagar.yaml#
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
> +  This binding document describes the binding for the clock portion of the
> +  driver.
> +
> +  Also see these documents for generic binding information:
> +    [1] Clock : ../clock/clock-bindings.txt
> +
> +  And these for relevant defines:
> +    [2] include/dt-bindings/clock/lochnagar.h
> +
> +  This binding must be part of the Lochnagar MFD binding:
> +    [3] ../mfd/cirrus,lochnagar.yaml
> +
> +properties:
> +  lochnagar-clk:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        contains:

Drop contains.

> +          enum:
> +            - cirrus,lochnagar1-clk
> +            - cirrus,lochnagar2-clk
> +
> +      '#clock-cells':
> +        description:
> +          Must be 1. The first cell indicates the clock number, see [2] for
> +          available clocks and [1].
> +        const: 1
> +      clock-names:
> +        description: |
> +          May contain entries for each of the following clocks:
> +           - ln-cdc-clkout : Output clock from CODEC card.
> +           - ln-dsp-clkout : Output clock from DSP card.
> +           - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
> +             input audio clocks from host system.
> +           - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
> +             external connector.
> +           - ln-spdif-mclk : Optional input audio clock from SPDIF.
> +           - ln-spdif-clkout : Optional input audio clock from SPDIF.
> +           - ln-adat-mclk : Optional input audio clock from ADAT.
> +           - ln-pmic-32k : On board fixed clock.
> +           - ln-clk-12m : On board fixed clock.
> +           - ln-clk-11m : On board fixed clock.
> +           - ln-clk-24m : On board fixed clock.
> +           - ln-clk-22m : On board fixed clock.
> +           - ln-clk-8m : On board fixed clock.
> +           - ln-usb-clk-24m : On board fixed clock.
> +           - ln-usb-clk-12m : On board fixed clock.

Don't define the list twice. Make the description a comment above or 
after each item below.

> +        items:
> +          enum:
> +            - ln-cdc-clkout
> +            - ln-dsp-clkout
> +            - ln-gf-mclk1
> +            - ln-gf-mclk2
> +            - ln-gf-mclk3
> +            - ln-gf-mclk4
> +            - ln-psia1-mclk
> +            - ln-psia2-mclk
> +            - ln-spdif-mclk
> +            - ln-spdif-clkout
> +            - ln-adat-mclk
> +            - ln-pmic-32k
> +            - ln-clk-12m
> +            - ln-clk-11m
> +            - ln-clk-24m
> +            - ln-clk-22m
> +            - ln-clk-8m
> +            - ln-usb-clk-24m
> +            - ln-usb-clk-12m
> +        minItems: 1
> +        maxItems: 19
> +      clocks: true
> +      assigned-clocks: true
> +      assigned-clock-parents: true
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +
> +  lochnagar-pmic32k:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 32768
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency

The fixed-clock.yaml schema will be applied to this. So all you need 
here are addtional constraints:

clock-frequency:
  const: 32768

> +
> +  lochnagar-clk12m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 12288000
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-clk11m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 11298600
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-clk24m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 24576000
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-clk22m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 22579200
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-clk8m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 8192000
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-usb24m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 24576000
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> +
> +  lochnagar-usb12m:
> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - fixed-clock
> +      '#clock-cells':
> +        const: 0
> +      clock-frequency:
> +        const: 12288000
> +    required:
> +      - compatible
> +      - '#clock-cells'
> +      - clock-frequency
> -- 
> 2.11.0
> 
