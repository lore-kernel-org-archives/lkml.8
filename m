Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B21C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFFA2074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMKzNPGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgHYM1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:26:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C913C061574;
        Tue, 25 Aug 2020 05:26:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g13so12216456ioo.9;
        Tue, 25 Aug 2020 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzcj8m5vFo9wtP7uviYdKc5PC5IJoO+QABXYTEcm/QQ=;
        b=QMKzNPGRrERw9HyuJHYh//aByTTYk6xved9OV+s/sN3XgKrdGYFCYUHeBvcE3n136J
         ZDiAPI314pmDApXJ5v/gF3jWHyLPdpayfQDDkEr18AB92xc/P56ZJOba1trauDK2Y9tz
         nywaxJwwsF1GdOh6yI68ObfqZb8rIzFXWucxmIQsWZAgcpvvMh56W265wRSQ9wLVXtcx
         nfnFxcy0uC39ywWv9ujRDOUxvETaJeNrPwUP6mJQTLRi0hK+hhgCPQZzSgcomUeVaQAr
         dDtzdBt98W/T6WByYwu+73euWPUHQ92ItBPAB+uQPkveTqdqmayB3pfRehukCFg3dlBe
         0wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzcj8m5vFo9wtP7uviYdKc5PC5IJoO+QABXYTEcm/QQ=;
        b=rSdaEZGx1VWFiQJpxrFWHGOnrbVoTxpyBqMmxsLlgjhSmkjVRNFM66zJzDWvoEopN7
         Cm2alG7Tk84OjqLxOE2WinUfX/Cc2j6jmRplK4DsiBCl7IBD2glqvux4aWmpHb426PF0
         /jIp4Tb/6s7qTDhFADUWeFLZk1l41rY+ADa9n9VAHFb9P/TOopn0WDHmgDa8ih05aJ5B
         pBKnafDv8L2bSdw/pj145GoQOT3eYgNlBpbwURzDBSoYBtpFXUp7qVm/iWvWmhqDbMCS
         srWbMf0fb7OCgBn79c0Sq5FHNEImCwx9KWmOrArMEvdZrCq8gwbdag4REwbFXJ9oTQNu
         31hQ==
X-Gm-Message-State: AOAM531UZoHew4Xk2dNKyW5uCWUPDfIJM0XikSfsWgp51QTyKucJdaDL
        s6hZRPzTMNX73uglP0tIUXj840JfK6DowbGPnuM=
X-Google-Smtp-Source: ABdhPJyGsUoC/LkI1d2bqGvQuY/p0TswaMdrh4UELE3XPT8OzGZIBRz06RutIQlDXcmCFjsUlnyiGQCLVwdzp0rcciA=
X-Received: by 2002:a02:ce32:: with SMTP id v18mr10452366jar.28.1598358417617;
 Tue, 25 Aug 2020 05:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-2-alcooperx@gmail.com>
 <20200824233040.GA3532378@bogus>
In-Reply-To: <20200824233040.GA3532378@bogus>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 25 Aug 2020 08:26:46 -0400
Message-ID: <CAOGqxeXWXkRD=agGL45D0sGe64TUBBq=OtibkX8AkiC5g0sWww@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
To:     Rob Herring <robh@kernel.org>
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

On Mon, Aug 24, 2020 at 7:30 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 12, 2020 at 04:20:16PM -0400, Al Cooper wrote:
> > Add DT bindings for the Broadcom USB pin map driver. This driver allows
> > some USB input and output signals to be mapped to any GPIO instead
> > of the normal dedicated pins to/from the XHCI controller.
>
> Is this a driver or h/w block because bindings are for h/w blocks?

This is a hardware block. I'll remove "driver" from the description.

>
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  .../bindings/usb/brcm,usb-pinmap.yaml         | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > new file mode 100644
> > index 000000000000..19cf6ad36373
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom USB pin map Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Al Cooper <alcooperx@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +      items:
> > +          - const: brcm,usb-pinmap
>
> 2 space indentation please.

Fixed.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Must be defined if any out-gpios are specified.
>
> 'dependencies' can express this in schema.

Okay.

>
> > +
> > +  in-gpios:
> > +    description: Array of one or more GPIO pins used for input signals.
>
> You need to define how many GPIOs are valid.

I tried to avoid doing this because there is a possibility that future
chips will have a few more signals added and the driver was written so
new signals can be added entirely in device tree without any changes
to the driver. If this is unacceptable, I can add the current max in
and out valid gpios.

>
> > +
> > +  in-names:
> > +    description: Array of input signal names, one per gpio in in-gpios.
>
> No, this isn't how we name GPIOs. The part before '-gpios' is how.

This is the meant to be a description of how each gpio is being used
to help with error messages in the driver.
What if I use "brcmstb,in-functions" instead?

>
> > +
> > +  in-masks:
> > +    description: Array of enable and mask pairs, one per gpio in-gpios.
>
> Needs a vendor prefix.

I'll change it to "brcmstb,in-masks"

>
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
> > +
> > +...
> > --
> > 2.17.1
> >
