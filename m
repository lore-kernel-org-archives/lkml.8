Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B742C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7FF20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH1OS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:18:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35862 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgH1OSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:18:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id b9so928413oiy.3;
        Fri, 28 Aug 2020 07:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBq+rTLiIUXKTOPJ3t+Pb18logS9N5SHMSukF4dmdzo=;
        b=Suof/KMb7s0f3S7I2G8CtJqW8DY6+YS/sCimDdaZKdKStLneHAfzDAPpKWpLQk7CN9
         H0Pb5ZqKZ9zRMDeSP+tjI+k3NGh/9QhUAd1lhdVeqU/MaZ/S8nXp4DI9cZ7HSMqds3dt
         Yb/j8ofw88GowRQmQGbdTUwK+Swn/gxsdhM2v/WhHHAkb1TrqQjjx8e7lQJxCJYjcHEI
         DmcKIqWL9SgOuylaGMNENFqg3ZWTfU9YF5bhArXB8Ko3oaoi3tmq2hs2W6z6hioyEuwM
         SNU5bsS4OF/bhM/9IQHAzl4L+/GwC6A4qkYxEBkFYblGfMsOvR6fawrv3HdbaDkKwYwq
         NaSg==
X-Gm-Message-State: AOAM5337hXSFvLZKqyCmb6GWj65vr9KE9YSKvnV3sWUh/2a7M3ZjiZMy
        gYM4RhI4j21h38ZnBWTrfpe2EAxK374l5KzVR7I=
X-Google-Smtp-Source: ABdhPJzvoxPJuI8QBit61+jdNdzDe8hVbMe5fQAfx6sohY8OeIOX9NyqfufCvv6rprCk1eFhaiWbtxVIauRyrxVFkX0=
X-Received: by 2002:a05:6808:575:: with SMTP id j21mr1096847oig.54.1598624300147;
 Fri, 28 Aug 2020 07:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-2-alcooperx@gmail.com>
 <CACRpkdZVde024_CCwmKBY_zVzfcq7=A1+t=8nEe1ei8+_Le51A@mail.gmail.com>
In-Reply-To: <CACRpkdZVde024_CCwmKBY_zVzfcq7=A1+t=8nEe1ei8+_Le51A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Aug 2020 16:18:09 +0200
Message-ID: <CAMuHMdUToD9C+KUm8r1EqGpjj7ztmWJJZON+Gn7XfFgybb-9NQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus et al,

On Fri, Aug 28, 2020 at 4:00 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 12, 2020 at 10:20 PM Al Cooper <alcooperx@gmail.com> wrote:
> > Add DT bindings for the Broadcom USB pin map driver. This driver allows
> > some USB input and output signals to be mapped to any GPIO instead
> > of the normal dedicated pins to/from the XHCI controller.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> (...)
> > +title: Broadcom USB pin map Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Al Cooper <alcooperx@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +      items:
> > +          - const: brcm,usb-pinmap
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Must be defined if any out-gpios are specified.
> > +
> > +  in-gpios:
> > +    description: Array of one or more GPIO pins used for input signals.
> > +
> > +  in-names:
> > +    description: Array of input signal names, one per gpio in in-gpios.
> > +
> > +  in-masks:
> > +    description: Array of enable and mask pairs, one per gpio in-gpios.
> > +
> > +  out-gpios:
> > +    description: Array of one or more GPIO pins used for output signals.
> > +
> > +  out-names:
> > +    description: Array of output signal names, one per gpio in out-gpios.
> > +
> > +  out-masks:
> > +    description: Array of enable, value, changed and clear masks, one
> > +      per gpio in out-gpios.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    usb_pinmap: usb-pinmap@22000d0 {
> > +        compatible = "brcm,usb-pinmap";
> > +        reg = <0x22000d0 0x4>;
> > +        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> > +        in-names = "VBUS", "PWRFLT";
> > +        in-masks = <0x8000 0x40000 0x10000 0x80000>;
> > +        out-gpios = <&gpio 20 0>;
> > +        out-names = "PWRON";
> > +        out-masks = <0x20000 0x800000 0x400000 0x200000>;
> > +        interrupts = <0x0 0xb2 0x4>;
> > +    };
>
> Wow look at that.
>
> This looks very much like Geert's just invented GPIO aggregator.
> But in hardware!
>
> See:
> drivers/gpio/gpio-aggregator.c
>
> I think Geert is intending to add bindings to the aggregator, and
> while I do think this should be its own driver (in drivers/usb) these
> bindings and whatever Geert want to use for the aggregator
> should certainly be the same.

I don't intend to add any DT bindings to the GPIO Aggregator, as it's
meant to be an "abstract base" driver.  Actual hardware blocks for which
the GPIO Aggregator could be a suitable driver should have their own DT
bindings, and their compatible values added to the GPIO Aggregator
driver's match table.

Anyway, DT bindings would just be a compatible value, and a gpios
property.

> Geert what do you think?

This USB pin map driver seems to map GPIO pins to USB pins, not other
GPIO pins, so to me it looks like something different than the GPIO
Aggregator: a hardware mux instead of a software mux.

BTW, at least on most Renesas SoCs, you can usually mux output functions
to multiple pins at the same time, which could be considered mirroring,
too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
