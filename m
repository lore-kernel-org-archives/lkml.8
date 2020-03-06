Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B94C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B9D2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="T13lPKXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCFP6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:58:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41146 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:58:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so2978712oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1+6fz7momKdjDKRLqw8BplaQOzNVOpCnEBk52cR68k=;
        b=T13lPKXqnNZA59yIPmcWAvKkYxPbFJQE//C8CuWxSSA8Eryr9CjcGHr59f+vzEsplC
         rRw87sCAHXLcwHm4zXgKv2p66+F36erpOXSanqygBXQXMjnpKQRzWAT/+sxCFGJfFo2N
         uOHIBEON7sHSiK1F5ZoB9htmkQ/j5Am4ReDlUxOcwG0M+xSxXwFGKDBVXRhaukVUodEC
         udVuRgtU58l7Z5L2JTSmxKsHDyaLWNg1vRlLjywcVWWROoquqxIkIzPlXB3XQKCMXIyO
         8bycVdDw24Tu4/bZpYnLfxDP1wnCFYMJryKl1M53ad78js6TpLseSmUMdPTOf/pWzSpC
         NFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1+6fz7momKdjDKRLqw8BplaQOzNVOpCnEBk52cR68k=;
        b=iKPw9lipJVqVw/nz/2O7pE8JmlLj+VngY1d1P+dAG84cfJeLRM3szzv5aTD9YzdPsF
         U4ab2RhuDEtXErp3KS+RqQu4bv/mpRG8MsAhhDp0rnA8ODxS1vwEtvpIByzRIsXUqg3L
         PvTTeT6tC+kHU85W8/43vjouGtirIY+z3lIi2LaLFxze0aSmcDLFvpnUNae66Y68z5h8
         hVVPvJJe+0P6MPS8xFlbx+D95lclAXg6sgvhI7bDfEO1+v2yI+Y9/CkxJzZ4ccdemwJd
         82diN/Zsta6Q8ij6s/xsBf0BropEgqJtK5V6qJdBsRAHQjMG69pZZFq8e6sprro+rwXb
         +yFA==
X-Gm-Message-State: ANhLgQ1YXLnJSC4U3GBVGzEhdc/aWV2A/+bKzB4en1upr2nHykvWAqjc
        1KLvHdgUkenrVpZUOPDqO0nMhfL7CaTZyI5mwGumkNm8
X-Google-Smtp-Source: ADFU+vuurdK1tLYKRHZySVDtkBsBts5O21phnWVSyzdskxYRWATOvZ9qJ0gvvcLFvlEeFknTq1uWLIeBBdhGqgGFm9c=
X-Received: by 2002:aca:fc44:: with SMTP id a65mr2929862oii.119.1583510297120;
 Fri, 06 Mar 2020 07:58:17 -0800 (PST)
MIME-Version: 1.0
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-2-git-send-email-tharvey@gateworks.com> <20200302204949.GA6649@bogus>
In-Reply-To: <20200302204949.GA6649@bogus>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 6 Mar 2020 07:58:06 -0800
Message-ID: <CAJ+vNU2ySjAP3q-4rgGy1U=iJeswv1kx6bKCy+Zw7V7oArkumw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 12:49 PM Rob Herring <robh@kernel.org> wrote:
>

Rob,

Thanks for the review! Some questions below:

> On Mon, Feb 24, 2020 at 12:54:23PM -0800, Tim Harvey wrote:
> > This patch adds documentation of device-tree bindings for the
> > Gateworks System Controller (GSC).
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v5:
> >  - resolve dt_binding_check issues
> >
> > v4:
> >  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> >  - remove unncessary resolution/scaling properties for ADCs
> >  - update to yaml
> >  - remove watchdog
> >
> > v3:
> >  - replaced _ with -
> >  - remove input bindings
> >  - added full description of hwmon
> >  - fix unit address of hwmon child nodes
> > ---
> >  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 158 +++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > new file mode 100644
> > index 00000000..f7c1a05
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > @@ -0,0 +1,158 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Gateworks System Controller multi-function device
> > +
> > +description: |
> > +  The GSC is a Multifunction I2C slave device with the following submodules:
> > +   - Watchdog Timer
> > +   - GPIO
> > +   - Pushbutton controller
> > +   - Hardware Monitore with ADC's for temperature and voltage rails and
>
> typo

will fix

>
> > +     fan controller
> > +
> > +maintainers:
> > +  - Tim Harvey <tharvey@gateworks.com>
> > +  - Robert Jones <rjones@gateworks.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "gsc@[0-9a-f]{1,2}"
> > +  compatible:
> > +    const: gw,gsc
>
> That's not very specific.
>

Do you mean something like 'gw,system-controller' would be better
instead of the gsc abbreviation for 'Gateworks System Controller'?

> +
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
> > +    description: The IRQ number
>
> description is wrong. You can just drop it.
>

ok

> > +
> > +  hwmon:
>
> 'hwmon' is a Linux thing. I'm suspicious...
>

Yes, we've discussed this before and I understand that DT shouldn't
use terminology that is Linux specific (which is why I replaced
'hwmon' with 'adc' in the ADC nodes below) but I still see a long of
dt bindings in Documentation/devicetree/bindings with the word 'hwmon'
in them.

Perhaps this makes more sense?

adc {
  compatible = "gw,gsc-adc";
  #address-cells = <1>;
  #size-cells = <0>;

  channel@6 {
    type = "gw,hwmon-temperature";
    reg = <0x06>;
    label = "temp";
  };
  ...
};


> > +    type: object
> > +    description: Optional Hardware Monitoring module
> > +
> > +    properties:
> > +      compatible:
> > +        const: gw,gsc-hwmon
> > +
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +      gw,fan-base:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: The fan controller base address
>
> Shouldn't this be described as a node in the DT or be implied by the
> compatible?

It does look out of place there. Would adding another subnode outside
of the (perhaps misnamed) 'hwmon' node make more sense?:

fan:
 properties:
   compatible: gw,gsc-fancontroller
   reg:
     description: address of the fan controller base register
     maxItems: 1

>
> > +
> > +    patternProperties:
> > +      "^adc@[0-2]$":
>
> There's only one number space at any level. So if you ever need anything
> else at this level, it can't have an address. Just something to
> consider.
>

yes, one number space is ok if I understand what you mean but I meant
this to be "^adc@[0-9]+$" to support the number of ADC pins the part
supports.

> > +        type: object
> > +        description: |
> > +          Properties for a single ADC which can report cooked values
> > +          (ie temperature sensor based on thermister), raw values
> > +          (ie voltage rail with a pre-scaling resistor divider).
> > +
> > +        properties:
> > +          reg:
> > +            description: Register of the ADC
> > +            maxItems: 1
> > +
> > +          label:
> > +            description: Name of the ADC input
> > +
> > +          type:
>
> Very generic property name, but it's not generic. Needs a vendor prefix
> at least.

You mean the property name of 'type' is fine, but the values will need
to be vendor specific like 'gw,temperature', 'gw,voltage',
'gw,voltage-raw' or is it inappropriate to use 'type'?

>
> > +            description: |
> > +              temperature in C*10 (temperature),
> > +              pre-scaled voltage value (voltage),
> > +              or scaled based on an optional resistor divider and optional
> > +              offset (voltage-raw)
> > +            enum:
> > +              - temperature
> > +              - voltage
> > +              - voltage-raw
> > +
> > +          gw,voltage-divider:
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +            description: values of resistors for divider on raw ADC input
> > +            items:
> > +              - description: R1
> > +              - description: R2
>
> Needs a standard unit suffix. With that, you can drop the type
> reference.

I understand the unit suffix but not sure what you mean by type
reference. Do you mean:

gw,voltage-divider-milli-ohms:
  description: values of resistors for divider on raw ADC input
    items:
      - description: R1
      - description: R2

>
> > +
> > +          gw,voltage-offset:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: |
> > +              A positive uV voltage offset to apply to a raw ADC
> > +              (ie to compensate for a diode drop).
>
> Needs a unit suffix.

ok

Thanks!

Tim
