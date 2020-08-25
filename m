Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3876F2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598370413;
	bh=2igqG3uEPzuUzdqIXSzponq3YT5GudO3Gm4HYkcRAIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ReHIHuIWoQZklKVpPLcbxaj4mi/74/QpiIIJ020MdjQT7MXj3K+baEZOYZnGXH/+8
	 om3pGu8m5vVlFJHWZ8ZXRzXqWyexCG/ek/+3EaU8I06BHYmI7VzMazJClr8xeIiAXJ
	 yq+OmM7TvmACHP6W6/Px/1HJMvxtYzHGjO6r3kyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgHYPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:46:21 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925F92076C;
        Tue, 25 Aug 2020 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598370380;
        bh=2igqG3uEPzuUzdqIXSzponq3YT5GudO3Gm4HYkcRAIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m3lGya4cWZj7kD5PKWQK7urXVreNHeORDEhN7lv7Geec1Kv/7wlFgq/SCoT086bXM
         fx29PdOnOXfRVPH0QWFqjiIe76/4Z9Cka4rCUQ1nW15ORTHT5yGWPc3E54EPu6NSS+
         2yKnOjF0EpCcJDaJHVG18RlyrZEYzoPGtZ4n5oL0=
Received: by mail-oi1-f178.google.com with SMTP id v13so11991529oiv.13;
        Tue, 25 Aug 2020 08:46:20 -0700 (PDT)
X-Gm-Message-State: AOAM531g7X+Q1evM2iQM4Mo1DeKuXW1WhMQRxRUxeMvJEmqfW63wtFkF
        DlDDIPzNZjaiLDv62TOE8VtphP5IoVkST/IHLQ==
X-Google-Smtp-Source: ABdhPJzZUSVbY/c/oz2V3IJntQFHRss+WSxDpGuds7ZpZ7vy9EXlYkoPxM8dJAFy6Rn+JihsN1yHkr5GmU1Rae9WK+0=
X-Received: by 2002:aca:90a:: with SMTP id 10mr1406037oij.106.1598370379890;
 Tue, 25 Aug 2020 08:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-2-alcooperx@gmail.com>
 <20200824233040.GA3532378@bogus> <CAOGqxeXWXkRD=agGL45D0sGe64TUBBq=OtibkX8AkiC5g0sWww@mail.gmail.com>
In-Reply-To: <CAOGqxeXWXkRD=agGL45D0sGe64TUBBq=OtibkX8AkiC5g0sWww@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Aug 2020 09:46:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvDq1L1BZKfgobfhe7UEqbkGtXXfHzUwfo36m4MCARhw@mail.gmail.com>
Message-ID: <CAL_JsqLvDq1L1BZKfgobfhe7UEqbkGtXXfHzUwfo36m4MCARhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
To:     Alan Cooper <alcooperx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
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

+Linus W

On Tue, Aug 25, 2020 at 6:26 AM Alan Cooper <alcooperx@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 7:30 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Aug 12, 2020 at 04:20:16PM -0400, Al Cooper wrote:
> > > Add DT bindings for the Broadcom USB pin map driver. This driver allows
> > > some USB input and output signals to be mapped to any GPIO instead
> > > of the normal dedicated pins to/from the XHCI controller.
> >
> > Is this a driver or h/w block because bindings are for h/w blocks?
>
> This is a hardware block. I'll remove "driver" from the description.

Another question, this kind of looks like a pin mux controller. Is
that not a fit for this? If not, why?

> > > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > > ---
> > >  .../bindings/usb/brcm,usb-pinmap.yaml         | 63 +++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > > new file mode 100644
> > > index 000000000000..19cf6ad36373
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > > @@ -0,0 +1,63 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom USB pin map Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Al Cooper <alcooperx@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +      items:
> > > +          - const: brcm,usb-pinmap
> >
> > 2 space indentation please.
>
> Fixed.
>
> >
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +    description: Must be defined if any out-gpios are specified.
> >
> > 'dependencies' can express this in schema.
>
> Okay.
>
> >
> > > +
> > > +  in-gpios:
> > > +    description: Array of one or more GPIO pins used for input signals.
> >
> > You need to define how many GPIOs are valid.
>
> I tried to avoid doing this because there is a possibility that future
> chips will have a few more signals added and the driver was written so
> new signals can be added entirely in device tree without any changes
> to the driver. If this is unacceptable, I can add the current max in
> and out valid gpios.

A 'should be enough for a while' value is fine. The driver doesn't
have to have a max. I'd expect the binding to be updated for new SoCs
anyways.

> >
> > > +
> > > +  in-names:
> > > +    description: Array of input signal names, one per gpio in in-gpios.
> >
> > No, this isn't how we name GPIOs. The part before '-gpios' is how.
>
> This is the meant to be a description of how each gpio is being used
> to help with error messages in the driver.
> What if I use "brcmstb,in-functions" instead?

'brcmstb' is not a vendor. But brcm,in-functions is fine.

> > > +
> > > +  in-masks:
> > > +    description: Array of enable and mask pairs, one per gpio in-gpios.
> >
> > Needs a vendor prefix.
>
> I'll change it to "brcmstb,in-masks"
>
> >
> > > +
> > > +  out-gpios:
> > > +    description: Array of one or more GPIO pins used for output signals.
> > > +
> > > +  out-names:
> > > +    description: Array of output signal names, one per gpio in out-gpios.
> > > +
> > > +  out-masks:
> > > +    description: Array of enable, value, changed and clear masks, one
> > > +      per gpio in out-gpios.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    usb_pinmap: usb-pinmap@22000d0 {
> > > +        compatible = "brcm,usb-pinmap";
> > > +        reg = <0x22000d0 0x4>;
> > > +        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> > > +        in-names = "VBUS", "PWRFLT";
> > > +        in-masks = <0x8000 0x40000 0x10000 0x80000>;
> > > +        out-gpios = <&gpio 20 0>;
> > > +        out-names = "PWRON";
> > > +        out-masks = <0x20000 0x800000 0x400000 0x200000>;
> > > +        interrupts = <0x0 0xb2 0x4>;
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.17.1
> > >
