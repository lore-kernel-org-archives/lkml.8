Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD62074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="E/d4gQIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDTP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:28:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531CC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:28:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so1805739otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pdhitu/GA13B0b+pKwpEIsLq4K1KtaHyPOEGx43ocN4=;
        b=E/d4gQIiqdJcRaikcAjbAfHFdIwMplawIg6BdNW/RmRpg0TeBBclMy/2L8Pikcyp3h
         5txC5GRIKZparX3RXZHhl24WjcltJuF7gvhG/VFg27b7mQCZnJBvtJXckl/9gEBCuLXd
         mLh4fO6XRc7B5tLtTDooYRSikQNMwnraigxd65oHtBcKCWBRLy5t5hweFvRNOQ4OF8Uu
         hMrJW14RkCGMO0t7KVf5Fox3yDL/8TwxXUXGwUYn6yiRNqNxYiROBW7iGszagGDajSXB
         TTJE9lOcGrwjHw5EwYG1E3QjzqCwyCAjwwSHxemIrP+wDMHlXaxua/np7rMuaE/Wnir3
         BVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pdhitu/GA13B0b+pKwpEIsLq4K1KtaHyPOEGx43ocN4=;
        b=U1AesBwuH7p9ax/L/xnAYLENZ3gX8HAfSzzj7sH9JiXIQMdaph8kwhgJXjNlTcjiTD
         sNeZqVfXa4u6h8kqyC38Fp08Ro0dsDBrLOtJj62dtyRefDI5jjna5z7trDMdNnWYgnHy
         SUufuis8dqnZtF7rgjk2QtxwkgisSoqUC0oKDvfb4HLCPo6yoOl1hD2EK+SehqrEj7HT
         E37p3ZNWASFOS46KUF+ut2jq1LWDW5AiOpQ4pUsMSxeYIR5nQu61+cXRH9ksdRXZFcL2
         TQab++23jeAh5kT/+VW0XjMplBwhv5++YE4/F+RBPyXQSz9xeM8SWMsmcxKjm7Qwlhb0
         63Lw==
X-Gm-Message-State: AGi0Pubk1Tj+omLikBSbM9ckSYlDgXC4eTrB223O8S1dOAxnrbt8WLn0
        W25VdHjR+Lz9W5pNivvOGr+vYl7v2xwhlD+/VL9Log==
X-Google-Smtp-Source: APiQypKljkdmPJSFbCodFsRJPlON7rGbbY1ej40phxYNyRoBtjH9cv47s6AEwc6+8FPADLordGEzaxl4nbbBuoFonCI=
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr4846402otn.33.1587396510050;
 Mon, 20 Apr 2020 08:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <1585341214-25285-1-git-send-email-tharvey@gateworks.com>
 <1585341214-25285-2-git-send-email-tharvey@gateworks.com> <20200417095831.GI2167633@dell>
In-Reply-To: <20200417095831.GI2167633@dell>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 20 Apr 2020 08:28:17 -0700
Message-ID: <CAJ+vNU32JcADb-p4+rpX5fzA8PkfknMr0Qd-UCMs-6AxLRGc5w@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 2:57 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 27 Mar 2020, Tim Harvey wrote:
>
> > This patch adds documentation of device-tree bindings for the
> > Gateworks System Controller (GSC).
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>

<snip>

> > ---
> >  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 194 +++++++++++++++++++++
> >  1 file changed, 194 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > new file mode 100644
> > index 00000000..a96751c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > @@ -0,0 +1,194 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Gateworks System Controller multi-function device
>
> I'd prefer if you didn't use Linuxisums in DT docs.
>
> A 'multi-function device' isn't a thing - we made it up.
>
> Nowhere in the documentation [0] is the Gateworks System Controller
> described as a multi-function device.
>
> [0] http://trac.gateworks.com/wiki/gsc
>
> > +description: |
> > +  The GSC is a Multifunction I2C slave device with the following submodules:
>
> No it isn't.  It's a:
>
>   "The Gateworks System Controller (GSC) is a device present across
>    various Gateworks product families that provides a set of system
>    related feature such as the following (refer to the board hardware
>    user manuals to see what features are present)"
>
> > +   - Watchdog Timer
> > +   - GPIO
> > +   - Pushbutton controller
> > +   - Hardware Monitor with ADC's for temperature and voltage rails and
> > +     fan controller
>
> Why is "Monitor" capitalised, but "controller" is not?
>
> I would s/Monitor/monitor/ here.
>
> > +maintainers:
> > +  - Tim Harvey <tharvey@gateworks.com>
> > +  - Robert Jones <rjones@gateworks.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "gsc@[0-9a-f]{1,2}"
> > +  compatible:
> > +    const: gw,gsc
> > +
> > +  reg:
> > +    description: I2C device address
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  adc:
> > +    type: object
> > +    description: Optional Hardware Monitoring module
>
> Again, an odd thing to capitalise.
>
> > +    properties:
> > +      compatible:
> > +        const: gw,gsc-adc
> > +
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^channel@[0-9]+$":
> > +        type: object
> > +        description: |
> > +          Properties for a single ADC which can report cooked values
> > +          (ie temperature sensor based on thermister), raw values
> > +          (ie voltage rail with a pre-scaling resistor divider).
>
> /ie/i.e./
>
> > +        properties:
> > +          reg:
> > +            description: Register of the ADC
> > +            maxItems: 1
> > +
> > +          label:
> > +            description: Name of the ADC input
> > +
> > +          gw,mode:
> > +            description: |
> > +              conversion mode:
> > +                0 - temperature, in C*10
> > +                1 - pre-scaled voltage value
> > +                2 - scaled voltage based on an optional resistor divider
> > +                    and optional offset
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/uint32
>
> Rob just submitted a patch-set to remove 'allOf's from '$ref'
> properties.
>
> > +            enum: [0, 1, 2]
> > +
> > +          gw,voltage-divider-ohms:
> > +            description: values of resistors for divider on raw ADC input
>
> s/values/Values/
>
> > +            maxItems: 2
> > +            items:
> > +             minimum: 1000
> > +             maximum: 1000000
> > +
> > +          gw,voltage-offset-microvolt:
> > +            description: |
> > +              A positive voltage offset to apply to a raw ADC
> > +              (ie to compensate for a diode drop).
>
> s/ie/i.e/
>
> > +            minimum: 0
> > +            maximum: 1000000
> > +
> > +        required:
> > +          - gw,mode
> > +          - reg
> > +          - label
> > +
> > +    required:
> > +      - compatible
> > +      - "#address-cells"
> > +      - "#size-cells"
> > +
> > +patternProperties:
> > +  "^fan-controller@[0-9a-f]+$":
> > +    type: object
> > +    description: Optional FAN controller
>
> "Fan"
>
> > +    properties:
> > +      compatible:
> > +        const: gw,gsc-fan
> > +
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +      reg:
> > +        description: The fan controller base address
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - "#address-cells"
> > +      - "#size-cells"
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        gsc@20 {
> > +            compatible = "gw,gsc";
> > +            reg = <0x20>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <4 GPIO_ACTIVE_LOW>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <1>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            adc {
> > +                compatible = "gw,gsc-adc";
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                channel@0 { /* A0: Board Temperature */
> > +                    reg = <0x00>;
> > +                    label = "temp";
> > +                    gw,mode = <0>;
> > +                };
> > +
> > +                channel@2 { /* A1: Input Voltage (raw ADC) */
> > +                    reg = <0x02>;
> > +                    label = "vdd_vin";
> > +                    gw,mode = <1>;
> > +                    gw,voltage-divider-ohms = <22100 1000>;
> > +                    gw,voltage-offset-microvolt = <800000>;
> > +                };
> > +
> > +                channel@b { /* A2: Battery voltage */
> > +                    reg = <0x0b>;
> > +                    label = "vdd_bat";
> > +                    gw,mode = <1>;
> > +                };
> > +            };
> > +
> > +            fan-controller@2c {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                compatible = "gw,gsc-fan";
> > +                reg = <0x2c>;
> > +            };
> > +        };
> > +    };
>

Lee,

Thanks for the review. I will send a v9 once you have had time to
review the mfd driver patch in this series.

Best Regards,

Tim
