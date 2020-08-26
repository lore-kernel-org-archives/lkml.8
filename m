Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09112080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrxU1NWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHZQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHZQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:00:31 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69AC061574;
        Wed, 26 Aug 2020 09:00:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so2238513ilm.2;
        Wed, 26 Aug 2020 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBrFb6jnhRxK2pE9Uf4aDwedIGM0WKpvarBK1Vuymfk=;
        b=JrxU1NWpArAPG9qvA7QSt+OG2bRAqwOm/cMEtAapa2DSLLIHjnKjyUjn+G6/vuhr7p
         xFuyV+70u0ZkFTmRBg8RthkfR/tAXbgOJz+dgs35i8yQOjOdTy3xydIBSre9lG/gi2XF
         GVgpJh9dfLGW7J5juIragtkSbfcMpRF6q1sfFP/XaQ5aGJK25TYLGUl9C+ZmVWaEEAxv
         dxsElXtWa9u3uU+F4YJppmzZefzPNSxJiGziUPMt+5WM+7wPRFsHnX2cCFLZ0actFGdA
         fv4YOSyoAtG2TYRHUzjMi0/PuDlMuZO9PJ2YunQ2083jcZL8aNZOQ21AeIu86El9x0e0
         MMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBrFb6jnhRxK2pE9Uf4aDwedIGM0WKpvarBK1Vuymfk=;
        b=mKocAI5UCO3N+tvBGvEBGKSLmzMOgzJufdoTouasPHOfVTAR2AmuLe/cCnH7SsgBlu
         ytnpuF6JsYoz/6GJid2yn19/3R7M8vE4XJozjUDJ7O68O92f+tiRdEpzeVuDl24voocg
         1LBd7xPg8n14bT2bptZudY80BSsL1WGYgArbJ4VFo9quqLBKN0V9B7xY2UdqUnM071y9
         xHTAP2xhi5qMxFVUDwaWA/VPry03ObHcRefJAQlpk96nvHSrKbz1p0k5sLDz5fKZthST
         VCvDCo38ijKI47VPobgmaaXTUM9VQOu/LX97jW8uHnZKjeTNW2b72ZEiPJkc7n6zQpr6
         NvIA==
X-Gm-Message-State: AOAM533lPCNOW4sFLrJfoOpMjwWRDQhieRJ92ZjyI6u7LwoR4nyT/ErY
        ST0Le1xG/Jb/dJcJHLMt4tl3QknXevSG1z+CzSU=
X-Google-Smtp-Source: ABdhPJy+OCXtS+MIm488/SkgPQw1OHAlRys9kvA/GklBIJzCL5pNuy0EHvg5lM2w9KUososCV7G1/MajWrRb/8kZ8cg=
X-Received: by 2002:a92:a052:: with SMTP id b18mr11252757ilm.10.1598457630141;
 Wed, 26 Aug 2020 09:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-2-alcooperx@gmail.com>
 <20200824233040.GA3532378@bogus> <CAOGqxeXWXkRD=agGL45D0sGe64TUBBq=OtibkX8AkiC5g0sWww@mail.gmail.com>
 <CAL_JsqLvDq1L1BZKfgobfhe7UEqbkGtXXfHzUwfo36m4MCARhw@mail.gmail.com>
In-Reply-To: <CAL_JsqLvDq1L1BZKfgobfhe7UEqbkGtXXfHzUwfo36m4MCARhw@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 26 Aug 2020 12:00:19 -0400
Message-ID: <CAOGqxeVL1Usx0g-zzg4qp8mCKAbf-XEY=OugUNAUCfCkyC2wgw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:46 AM Rob Herring <robh@kernel.org> wrote:
>
> +Linus W
>
> On Tue, Aug 25, 2020 at 6:26 AM Alan Cooper <alcooperx@gmail.com> wrote:
> >
> > On Mon, Aug 24, 2020 at 7:30 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Aug 12, 2020 at 04:20:16PM -0400, Al Cooper wrote:
> > > > Add DT bindings for the Broadcom USB pin map driver. This driver allows
> > > > some USB input and output signals to be mapped to any GPIO instead
> > > > of the normal dedicated pins to/from the XHCI controller.
> > >
> > > Is this a driver or h/w block because bindings are for h/w blocks?
> >
> > This is a hardware block. I'll remove "driver" from the description.
>
> Another question, this kind of looks like a pin mux controller. Is
> that not a fit for this? If not, why?

This driver is not doing any pin-muxing of a physical pin on the chip.
Instead it's using standard gpio's, through gpiolib, and propagating
the gpio state for in-coming signals to a special register that feeds
into a XHCI host controller register and it's propagating the state of
out-going signals from the special register fed by a XHCI controller
register to a gpio. Both directions are interrupt driven and
continually mirroring the state between the XHCI host controller
registers and the gpios. I don't see any pinmux/pinctrl driver doing
this kind of thing.

Thanks
Al

>
> > > > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > > > ---
> > > >  .../bindings/usb/brcm,usb-pinmap.yaml         | 63 +++++++++++++++++++
> > > >  1 file changed, 63 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > > > new file mode 100644
> > > > index 000000000000..19cf6ad36373
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > > > @@ -0,0 +1,63 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Broadcom USB pin map Controller Device Tree Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Al Cooper <alcooperx@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +      items:
> > > > +          - const: brcm,usb-pinmap
> > >
> > > 2 space indentation please.
> >
> > Fixed.
> >
> > >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +    description: Must be defined if any out-gpios are specified.
> > >
> > > 'dependencies' can express this in schema.
> >
> > Okay.
> >
> > >
> > > > +
> > > > +  in-gpios:
> > > > +    description: Array of one or more GPIO pins used for input signals.
> > >
> > > You need to define how many GPIOs are valid.
> >
> > I tried to avoid doing this because there is a possibility that future
> > chips will have a few more signals added and the driver was written so
> > new signals can be added entirely in device tree without any changes
> > to the driver. If this is unacceptable, I can add the current max in
> > and out valid gpios.
>
> A 'should be enough for a while' value is fine. The driver doesn't
> have to have a max. I'd expect the binding to be updated for new SoCs
> anyways.
>
> > >
> > > > +
> > > > +  in-names:
> > > > +    description: Array of input signal names, one per gpio in in-gpios.
> > >
> > > No, this isn't how we name GPIOs. The part before '-gpios' is how.
> >
> > This is the meant to be a description of how each gpio is being used
> > to help with error messages in the driver.
> > What if I use "brcmstb,in-functions" instead?
>
> 'brcmstb' is not a vendor. But brcm,in-functions is fine.
>
> > > > +
> > > > +  in-masks:
> > > > +    description: Array of enable and mask pairs, one per gpio in-gpios.
> > >
> > > Needs a vendor prefix.
> >
> > I'll change it to "brcmstb,in-masks"
> >
> > >
> > > > +
> > > > +  out-gpios:
> > > > +    description: Array of one or more GPIO pins used for output signals.
> > > > +
> > > > +  out-names:
> > > > +    description: Array of output signal names, one per gpio in out-gpios.
> > > > +
> > > > +  out-masks:
> > > > +    description: Array of enable, value, changed and clear masks, one
> > > > +      per gpio in out-gpios.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    usb_pinmap: usb-pinmap@22000d0 {
> > > > +        compatible = "brcm,usb-pinmap";
> > > > +        reg = <0x22000d0 0x4>;
> > > > +        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> > > > +        in-names = "VBUS", "PWRFLT";
> > > > +        in-masks = <0x8000 0x40000 0x10000 0x80000>;
> > > > +        out-gpios = <&gpio 20 0>;
> > > > +        out-names = "PWRON";
> > > > +        out-masks = <0x20000 0x800000 0x400000 0x200000>;
> > > > +        interrupts = <0x0 0xb2 0x4>;
> > > > +    };
> > > > +
> > > > +...
> > > > --
> > > > 2.17.1
> > > >
