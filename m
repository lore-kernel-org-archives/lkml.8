Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD983C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CD720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DbOoHUOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbgF2UmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731667AbgF2TOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2FC08C5F5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:38:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so15119721wrm.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5TN/E+I/toiXQHven0Tzugxh2KMUYh+rGvqZtXPFqc=;
        b=DbOoHUOmfQBZBfBNFane+FwAaHv/bwA4VJs02OP7/NQNzlgmAGGz8UAXpjyqJYWkWO
         lm3GQYeLEBYB3MeEeqbQ8mIgKzaeoKai8O7tfiiBvcCtspXG+x/4tAOj78h5r6vHLvJi
         yWpC08Obs+4iBuqHftKl3Bn3SfBNIuigiw29OI0yJdgRBhoTj+or98IuAdcphVqfYb3m
         HGv2tyNo26cQpy9n3zw2l/Zt7w/Z/D9LFKvVh10U+JkrO8gIm2hm18bn7L1OyF4/x29E
         2bMCmsg58kYdvLQ7G4AexzjVTQyP9usYuuFQhVnufbsrxs7ANsbczV299xhg5jKhi7hE
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5TN/E+I/toiXQHven0Tzugxh2KMUYh+rGvqZtXPFqc=;
        b=npYs03amu7Yl+dP9dUp4Bg6SsRC71nEGlqLTHklyK95Ls8cTH3KtuWzOdxWKvPh1Gj
         AsAw4UiUNW3K0BrTj4qapwGN/WXvNDacfE2GcUW7BH1lvD7m76qYUU24Jzmqv5x+CjXm
         J/UpPwAicF395700Hbmpg/eDBK9qEN74LbKGggJIMsDnCX8otAC1afwap2Na/oi4yIjs
         dGz2bAvPJM/loExiQ5rx6a9xV81JVTrcE0ZRUPhchlK/OWPHAklAtFwd6YtfR7jeMmQg
         6KZDJB3OZKXp9myXGUkT4YezSuWqBf9gmsBIWOveI5L9TQbQF3qfYg3WHUBmwN4Nv70j
         6gVA==
X-Gm-Message-State: AOAM5321rUyJRSPXa1DV+jhT0pIZrUPHZJAjU7OqGZvM1GEpLEf5FG/t
        Cc6tqBnrNfj6fXxT0T5VG7XvGILg12pfBZxkYwpi/g==
X-Google-Smtp-Source: ABdhPJy4WGmlk07GX6E9BZevxe5hBGPhKL9rkFE7Ij8SPwuxHaxD6xGk7gGNB8l0qXzYGYzsZnvtJDPKE2OVK9ewiCA=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr15738900wrp.144.1593405491943;
 Sun, 28 Jun 2020 21:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
 <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com> <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com>
In-Reply-To: <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 10:07:57 +0530
Message-ID: <CAAhSdy3BUfPCS+LUWp9GKdnf960N-UkxtUtRArgkVd-1cGZxhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: riscv: Add YAML documentation for PMU
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 9:58 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 29, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > Add device tree bindings for performance monitor unit. And it passes the
> > > dt_binding_check verification.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
> > >  1 file changed, 59 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > new file mode 100644
> > > index 000000000000..f55ccbc6c685
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > @@ -0,0 +1,59 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V Performance Monitor Units
> > > +
> > > +maintainers:
> > > +  - Zong Li <zong.li@sifive.com>
> > > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: riscv,pmu
> > > +
> > > +  riscv,width-base-cntr:
> > > +    description: The width of cycle and instret CSRs.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  riscv,width-event-cntr:
> > > +    description: The width of hpmcounter CSRs.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > The terms "base" and "event" is confusing because
> > we only have counters with no interrupt associated with it.
> >
> > The RISC-V spec defines 3 counters and rest are all
> > implementation specific counters.
>
> As I know, there are 2 counters of spec definition: cycle and instret.
> What is the 3rd counter you mentioned?

TIME is a counter CSR.

>
> >
> > I suggest using the terms "spec counters" and "impl counters"
> > instead of "base counters" and "event counters".
>
> OK, they are good to me. Let me change it.
>
>
> >
> > Further, "riscv,width" properties are redundant because
> > RISC-V spec clearly tells that counters are 64bit for both
> > RV32 and RV64.
> >
> > > +
> > > +  riscv,n-event-cntr:
> > > +    description: The number of hpmcounter CSRs.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  riscv,hw-event-map:
> > > +    description: The mapping of generic hardware events. Default is no mapping.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +
> > > +  riscv,hw-cache-event-map:
> > > +    description: The mapping of generic hardware cache events.
> > > +      Default is no mapping.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +
> > > +required:
> > > +  - compatible
> > > +  - riscv,width-base-cntr
> > > +  - riscv,width-event-cntr
> > > +  - riscv,n-event-cntr
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    pmu {
> > > +      compatible = "riscv,pmu";
> > > +      riscv,width-base-cntr = <64>;
> > > +      riscv,width-event-cntr = <40>;
> > > +      riscv,n-event-cntr = <2>;
> > > +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> > > +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.27.0
> > >
> >
> > Regards,
> > Anup
