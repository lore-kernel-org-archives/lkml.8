Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E56BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DCF20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gUQhoSQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFBUxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFBUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:53:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB2C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:53:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so4243330wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNdx3Mmpf3DrIzViCGyzis6VE+eW7LcGk/DvPm/aizg=;
        b=gUQhoSQGFIHa7ZtNQ/mcdet2GnsJdah69f2gfvdvdf3oal9ZbFaY5RBDmch2/JCwpo
         1ySrRPlo+q1t6qjbKXPFmySFIdIUeoYzuR+SDIhTteakfiGtW0pdZri/mG9znO4mjmE5
         VpRIxXI+2IPUmFBA+igDQybSrvkqI8sP+60yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNdx3Mmpf3DrIzViCGyzis6VE+eW7LcGk/DvPm/aizg=;
        b=Uj0aZ7/II4d67tbHks9Hdoc44NoHnncT3uodJBqP740m1+83rf72NZ1RH6ZDQYwAYY
         T793MXLJ+oVZ8s6GV9Gol/9HU4E5+MODWAamYTVAiE7t8XAz3fIgqLBADY5Kp971qjJ4
         WQkOxCBg9eaBxnMe/HSDG/xAroRh9J5f2dyTizSshbKgVrFwYaMAIqe6mfLw91NSk5g3
         b17bnCZ5WmmuLWQZD2FqUwQlrP500eq+mKy05E/9RJsjQDpYP65BaoKuT5wNPQne0v6t
         0tSyoRcZylK1UIXloBNWmvNKOiiH4/gz+xuQyP3biv7+DSma1jBbmoPamTa5OhZlE0ep
         memQ==
X-Gm-Message-State: AOAM531TLfT+HIg5yn55wsB6DZiwCRfv3AYQDxVahjhyjOBmbKbbkYiI
        z3YxR+Yv26j/z4nHqcKd+J5yI63VV6dkqzhYOCAadQ==
X-Google-Smtp-Source: ABdhPJwkj8NL5zp+q4S4GBVPgKweYcMhpEHQU9ScieMb1qOnyIRY9ZULyNPHba9ox1is5xBNjGQKqzly82AVsgTZlQM=
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr5862628wmh.111.1591131229682;
 Tue, 02 Jun 2020 13:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-4-james.quinlan@broadcom.com> <20200529174634.GA2630216@bogus>
In-Reply-To: <20200529174634.GA2630216@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 2 Jun 2020 16:53:37 -0400
Message-ID: <CA+-6iNwWBFYHVKiwwJ95DYQ5zmc5uBo1cgZzd6rpD++aQWgGpw@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb chips
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 1:46 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 26, 2020 at 03:12:42PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
> >   7211 (STB version of RPi4).
> > - add new property 'brcm,scb-sizes'
> > - add new property 'resets'
> > - add new property 'reset-names'
> > - allow 'ranges' and 'dma-ranges' to have more than one item and update
> >   the example to show this.
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 8680a0f86c5a..66a7df45983d 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -14,7 +14,13 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> > +    items:
> > +      - enum:
>
> Don't need items here. Just change the const to enum.
>
> > +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> > +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> > +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> >
> >    reg:
> >      maxItems: 1
> > @@ -34,10 +40,12 @@ properties:
> >        - const: msi
> >
> >    ranges:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 4
> >
> >    dma-ranges:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 6
> >
> >    clocks:
> >      maxItems: 1
> > @@ -58,8 +66,30 @@ properties:
> >
> >    aspm-no-l0s: true
> >
> > +  resets:
> > +    description: for "brcm,bcm7216-pcie", must be a valid reset
> > +      phandle pointing to the RESCAL reset controller provider node.
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +
> > +  reset-names:
> > +    items:
> > +      - const: rescal
>
> These are going to need to be an if/then schema if they only apply to
> certain compatible(s).

Why is that -- the code is general enough to handle its presence or
not (it is an optional compatibility)>

>
>
> > +
> > +  brcm,scb-sizes:
> > +    description: (u32, u32) tuple giving the 64bit PCIe memory
> > +      viewport size of a memory controller.  There may be up to
> > +      three controllers, and each size must be a power of two
> > +      with a size greater or equal to the amount of memory the
> > +      controller supports.
>
> This sounds like what dma-ranges should express?

There is some overlap but this contains information that is not in the
dma-ranges.  Believe me I tried.

>
> If not, we do have 64-bit size if that what you need.

IIRC I tried the 64-bit size but the YAML validator did not like it;
it wanted numbers like  <0x1122334455667788> while dtc wanted <
0x11223344 0x55667788>.  I gave up trying and switched to u32.

Thanks,
Jim

>
>
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - items:
> > +          minItems: 2
> > +          maxItems: 6
> > +
> >  required:
> >    - reg
> > +  - ranges
> >    - dma-ranges
> >    - "#interrupt-cells"
> >    - interrupts
> > @@ -93,7 +123,9 @@ examples:
> >                      msi-parent = <&pcie0>;
> >                      msi-controller;
> >                      ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
> > -                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
> > +                    dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
> > +                                 <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
> >                      brcm,enable-ssc;
> > +                    brcm,scb-sizes = <0x0 0x80000000 0x0 0x80000000>;
> >              };
> >      };
> > --
> > 2.17.1
> >
