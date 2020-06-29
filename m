Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F68AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795CC206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459491;
	bh=IxP7fkKngaycJwsg21YV+tvkJ91Wj/BE51SsDiZ/4k8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2QWcqgWWcJbD4dSRm+P6t/6UVbtn9QAM2t9wRxW2u0ZIKgmf3PvIJzmSKQzp+MUDD
	 JupVsQmDAi+VVk9rcEHnaqcEd4COkOJItG4wq2ayGJXtHv6UGI5FFi2ZxuAIul25No
	 rxNtAU7enxJOAxf/J7SI5fpX508jjQ8EIENt4QSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgF2TiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbgF2TiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:38:00 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22EF20780;
        Mon, 29 Jun 2020 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593459479;
        bh=IxP7fkKngaycJwsg21YV+tvkJ91Wj/BE51SsDiZ/4k8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sb7NGoy7T/HwxKy8QYvemUwy3DhQCubraado/xaW5kE1It/wO5zWa02cLwxkKlDun
         FNvofZFfbaECarbvSqXT5Ocyk9BDO/wT+yRsxZyh111mndxwKLBeNp2D+Nvoe98cr0
         iJ+dcVMJIHFs1G137M/dvcD5voKNYOQUl9Po0L0s=
Received: by mail-ot1-f52.google.com with SMTP id 18so16545539otv.6;
        Mon, 29 Jun 2020 12:37:59 -0700 (PDT)
X-Gm-Message-State: AOAM5311vdv4r+NGlHKFVURWnKyJ6EUfYhWtNelqBt0R7t53JI+0lV2d
        LiTSF9tnEDw3TegA2nWZY0JHc/SegfbpDXSCcA==
X-Google-Smtp-Source: ABdhPJz6kmqtXJ1OIC7MMXmPStyq8zxaV71RF1e7y0B2HRZcYqLhuf4XSQqPFMKWaNblWCA07w8uXnCW74H/zUsItAM=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr14923890ots.192.1593459479172;
 Mon, 29 Jun 2020 12:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200618224413.1115849-1-robh@kernel.org> <20200619215341.GA6857@ravnborg.org>
In-Reply-To: <20200619215341.GA6857@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Jun 2020 13:37:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJcL6VJXiTGyAAs-UCD24wxh4NBAs_SntLomwUTo6Qhzw@mail.gmail.com>
Message-ID: <CAL_JsqJcL6VJXiTGyAAs-UCD24wxh4NBAs_SntLomwUTo6Qhzw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight bindings
 to DT schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 3:53 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob.
>
> Good to have these converted. A few comments in the following. One
> comment is for the backlight people as you copied the original text.
>
>         Sam
>
> On Thu, Jun 18, 2020 at 04:44:13PM -0600, Rob Herring wrote:
> > Convert the common GPIO, LED, and PWM backlight bindings to DT schema
> > format.
> >
> > Given there's only 2 common properties and the descriptions are slightly
> > different, I opted to not create a common backlight schema.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../leds/backlight/gpio-backlight.txt         | 16 ---
> >  .../leds/backlight/gpio-backlight.yaml        | 41 ++++++++
> >  .../bindings/leds/backlight/led-backlight.txt | 28 ------
> >  .../leds/backlight/led-backlight.yaml         | 58 +++++++++++
> >  .../bindings/leds/backlight/pwm-backlight.txt | 61 ------------
> >  .../leds/backlight/pwm-backlight.yaml         | 98 +++++++++++++++++++
> >  6 files changed, 197 insertions(+), 105 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
> > deleted file mode 100644
> > index 321be6640533..000000000000
> > --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -gpio-backlight bindings
> > -
> > -Required properties:
> > -  - compatible: "gpio-backlight"
> > -  - gpios: describes the gpio that is used for enabling/disabling the backlight.
> > -    refer to bindings/gpio/gpio.txt for more details.
> > -
> > -Optional properties:
> > -  - default-on: enable the backlight at boot.
> > -
> > -Example:
> > -     backlight {
> > -             compatible = "gpio-backlight";
> > -             gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
> > -             default-on;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> > new file mode 100644
> > index 000000000000..75cc569b9c55
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/gpio-backlight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: gpio-backlight bindings
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > +  - Jingoo Han <jingoohan1@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: gpio-backlight
> > +
> > +  gpios:
> > +    description: The gpio that is used for enabling/disabling the backlight.
> > +    maxItems: 1
> > +
> > +  default-on:
> > +    description: enable the backlight at boot.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    backlight {
> > +        compatible = "gpio-backlight";
> > +        gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
> > +        default-on;
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> > deleted file mode 100644
> > index 4c7dfbe7f67a..000000000000
> > --- a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> > +++ /dev/null
> > @@ -1,28 +0,0 @@
> > -led-backlight bindings
> > -
> > -This binding is used to describe a basic backlight device made of LEDs.
> > -It can also be used to describe a backlight device controlled by the output of
> > -a LED driver.
> > -
> > -Required properties:
> > -  - compatible: "led-backlight"
> > -  - leds: a list of LEDs
> > -
> > -Optional properties:
> > -  - brightness-levels: Array of distinct brightness levels. The levels must be
> > -                       in the range accepted by the underlying LED devices.
> > -                       This is used to translate a backlight brightness level
> > -                       into a LED brightness level. If it is not provided, the
> > -                       identity mapping is used.
> > -
> > -  - default-brightness-level: The default brightness level.
> > -
> > -Example:
> > -
> > -     backlight {
> > -             compatible = "led-backlight";
> > -
> > -             leds = <&led1>, <&led2>;
> > -             brightness-levels = <0 4 8 16 32 64 128 255>;
> > -             default-brightness-level = <6>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> > new file mode 100644
> > index 000000000000..ae50945d2798
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/led-backlight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: led-backlight bindings
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > +  - Jingoo Han <jingoohan1@gmail.com>
> > +
> > +description:
> > +  This binding is used to describe a basic backlight device made of LEDs. It
> > +  can also be used to describe a backlight device controlled by the output of
> > +  a LED driver.
> > +
> > +properties:
> > +  compatible:
> > +    const: led-backlight
> > +
> > +  leds:
> > +    description: A list of LED nodes
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +  brightness-levels:
> > +    description: Array of distinct brightness levels. The levels must be
> > +      in the range accepted by the underlying LED devices. This is used
> > +      to translate a backlight brightness level into a LED brightness level.
> > +      If it is not provided, the identity mapping is used.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> bike-shedding. To me it is a tad easier to read when multi-line
> descriptions are on a separate line.
> So "description:" on one line, and the text on following lines.
> example-schema.yaml does both - so both are official acceptable.

I agree, but the one issue is ruamel yaml wants it the above way
unless you do '|' (or really '>' may be the correct annotation here).
That's mainly an issue if doing tree wide yaml->python
processing->yaml transformations. But if the line lengths don't match
exactly what ruamel is set to, then it reformats it anyways, so in the
end it doesn't really matter. I just have to filter out unwanted
reformatting (until ruamel can really do roundtrips with no
reformatting).

Rob
