Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB85C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C72065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jB71Ljjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgF2Uub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgF2TNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:35 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7CC08EB30
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:36:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l63so13478109oih.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6Di78aul04vs2kyIJtsqSNPWqTVlpseLwhNlVPJlCw=;
        b=jB71Ljjq1eBRRMow3ePRUvEUQNwMfHAqv9mcp0yegcgOVA2UsvNwiMG2zLfZ8JVZ/r
         f0CHXYLQ/yer0HIXZkBafxzwQhkWzsoZUNmApVOMiciGG2kr8AqjAF5JDOb0sNFgonkH
         BJqaXq71xyAFuJyeF2Ifg3SFLTBmmkI3SAgMT4b6kGScWcc5PZ0PukTdyhON7/07MRvf
         HlZdVMdh24gdrmnmh4Zp9VPjAVtiCbD7GN26cDy9LTiwY/F7ioVTN9UWztx+kQo0RyJn
         jY5SpKDwmkn2uWBOYXWmPbFka+EA1mC1mklgB62+SF12rIHoOQpCQRmNdKK9aup8EwJW
         fEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6Di78aul04vs2kyIJtsqSNPWqTVlpseLwhNlVPJlCw=;
        b=QsCPh6lYVenA4umKwEKvPkMYiF4parbZxtXoiakKGBu50TFDmSC6qVRHBaG0y5h9+y
         jDrg09UsnwRl9RDfmwKziGB/cMHTeKRvau/gut2F06OZGo5lO8NhgC4huxgUv37vPwHu
         DG3TySz9JRm173xfqCcOmDTVfMRg3NPfHblwCQUjQ1rc1jYLySOfiV50lVyW9eGyljC7
         NmTOXxs/Sxbo2eKJ0xK8dDZhZqZf6066lD9f1b35NUb8CQRBkJBaSEQJ/euFhI1FhVhi
         TVxZ9D5UrsWnJCyt8Nk4NCurxa4FeR6AcB2wkVqmYrpyTDbJqMs9jUq9kvuHwiCfpR/p
         61zg==
X-Gm-Message-State: AOAM532Qj136b8YFf6ir2aHb3awtqhMWOKpglaMGH1C9VFFR0YTUzYU4
        /dSQxF9qATu4r7cHVy68uRq416NxKawjC+BWwwTWzg==
X-Google-Smtp-Source: ABdhPJzIbZs7+pk8YdVbf5qeEsUHVykEwUvO7k68qMKB1IWotZJ8TOn/8j6yCa6Xn3TcRl1sAP8SWOGWhzF9MrmH88c=
X-Received: by 2002:a05:6808:919:: with SMTP id w25mr11077804oih.91.1593412566656;
 Sun, 28 Jun 2020 23:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
 <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
 <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com> <CAAhSdy3BUfPCS+LUWp9GKdnf960N-UkxtUtRArgkVd-1cGZxhQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3BUfPCS+LUWp9GKdnf960N-UkxtUtRArgkVd-1cGZxhQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 29 Jun 2020 14:35:55 +0800
Message-ID: <CANXhq0rvjJ6yAcOq=bc7O_rYGDcbRfp7DJhcM0RBQ8q2x7xH0A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: riscv: Add YAML documentation for PMU
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:38 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 29, 2020 at 9:58 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Mon, Jun 29, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > Add device tree bindings for performance monitor unit. And it passes the
> > > > dt_binding_check verification.
> > > >
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > ---
> > > >  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
> > > >  1 file changed, 59 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > new file mode 100644
> > > > index 000000000000..f55ccbc6c685
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > @@ -0,0 +1,59 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RISC-V Performance Monitor Units
> > > > +
> > > > +maintainers:
> > > > +  - Zong Li <zong.li@sifive.com>
> > > > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > > > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: riscv,pmu
> > > > +
> > > > +  riscv,width-base-cntr:
> > > > +    description: The width of cycle and instret CSRs.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +
> > > > +  riscv,width-event-cntr:
> > > > +    description: The width of hpmcounter CSRs.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > > The terms "base" and "event" is confusing because
> > > we only have counters with no interrupt associated with it.
> > >
> > > The RISC-V spec defines 3 counters and rest are all
> > > implementation specific counters.
> >
> > As I know, there are 2 counters of spec definition: cycle and instret.
> > What is the 3rd counter you mentioned?
>
> TIME is a counter CSR.
>
> >
> > >
> > > I suggest using the terms "spec counters" and "impl counters"
> > > instead of "base counters" and "event counters".
> >
> > OK, they are good to me. Let me change it.
> >
> >
> > >
> > > Further, "riscv,width" properties are redundant because
> > > RISC-V spec clearly tells that counters are 64bit for both
> > > RV32 and RV64.
> > >

Sorry for the lost replying. The maximum length of counters is 64, but
it doesn't require to implement all bits. A real case is that
unleashed board only implements 40 bit for mhpmcounters.

> > > > +
> > > > +  riscv,n-event-cntr:
> > > > +    description: The number of hpmcounter CSRs.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +
> > > > +  riscv,hw-event-map:
> > > > +    description: The mapping of generic hardware events. Default is no mapping.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +
> > > > +  riscv,hw-cache-event-map:
> > > > +    description: The mapping of generic hardware cache events.
> > > > +      Default is no mapping.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - riscv,width-base-cntr
> > > > +  - riscv,width-event-cntr
> > > > +  - riscv,n-event-cntr
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    pmu {
> > > > +      compatible = "riscv,pmu";
> > > > +      riscv,width-base-cntr = <64>;
> > > > +      riscv,width-event-cntr = <40>;
> > > > +      riscv,n-event-cntr = <2>;
> > > > +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> > > > +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> > > > +    };
> > > > +
> > > > +...
> > > > --
> > > > 2.27.0
> > > >
> > >
> > > Regards,
> > > Anup
