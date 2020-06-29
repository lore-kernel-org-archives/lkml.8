Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5873C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F9020720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="v9Zl362z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbgF2Unj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgF2TOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BA6C00874B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:31:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so13161262wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0a0BV57yL5ficDtUjeioVVS7bAcbhc1pkjbiChvtOqw=;
        b=v9Zl362zUqiASgib07aYF9GS74MB9McYmwsWwm7+u0JHRuQpa3JpFxQp5HKSqBu5bV
         hME65OV8FA+Sv55A0o4GVkl+ixCjmwUWNfVgy2z+8TBssXcPIOrmWDGWt9+sbHHr66Cy
         dM9KjCpllKI8bYvqw4vjCkcohZDHEXPCojjgMyUv3H0v/ZQ/Ab2RvpAS/l5oLbHEdRCh
         Y8vGhsyLmEBHT1hNaD6YBQU0S1rBOZQIB71ttneeUsPFIOdHJQJWpRvbKjeQxIc/+3Jb
         UnGZ9ogeuxEtE7BFE+LdxkUttNlG6vIAePCjPL+gxVgRW3uY9YQM0VODgnxR7MZj68lM
         H9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0a0BV57yL5ficDtUjeioVVS7bAcbhc1pkjbiChvtOqw=;
        b=UTzH8TFN7RQmU/psLg2F9vjwRlQgRYEl4ghMHIqnto2HrooIYp1mijiK8D4ce+WB3D
         b3VMOPWb00Gpf1AZeQKm9vUV/4D+sv85+m4l5jCwCE1f8gdbiGe39qr+wBRBZmXC/+yA
         rylXfJqiJ8+fwNmo35l2Kp8o+ZI6EEQiW8y2y4wTClRKV0MJtO/zohw3GVWZpzrYP93N
         pdrsVtFqwwIHufjLkxwqmxyOAmemDcWvNQ2HNYqe89ADWUpA2RUwOZBJU4lh4UJtjl2F
         1O4Lxl0mQCRdxLmEc4dFYXAGTKVNg/OunDfCEPWB4/VbjkoJpp60xY5TUTWBvzeYGa5C
         VF9g==
X-Gm-Message-State: AOAM533b5Pv2FHmrrMuBPRiUVy312fmhD/L7/kh0xbDnkp9hfjSR0f2r
        lm3+8j+tDp15CU1D//yuntZrEMqhkM/NaXdO0/rJng==
X-Google-Smtp-Source: ABdhPJzYtZ0h83Rb5WNqf3L2Z5EidEEuCHUWCZ3RyjUvGssx1mKVKMQW6Z3EnvrO6S8+Wt/rD5qZ1q2bxYtlg5kacQY=
X-Received: by 2002:adf:aa90:: with SMTP id h16mr16128490wrc.356.1593419513242;
 Mon, 29 Jun 2020 01:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
 <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
 <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com>
 <CAAhSdy3BUfPCS+LUWp9GKdnf960N-UkxtUtRArgkVd-1cGZxhQ@mail.gmail.com> <CANXhq0rvjJ6yAcOq=bc7O_rYGDcbRfp7DJhcM0RBQ8q2x7xH0A@mail.gmail.com>
In-Reply-To: <CANXhq0rvjJ6yAcOq=bc7O_rYGDcbRfp7DJhcM0RBQ8q2x7xH0A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 14:01:41 +0530
Message-ID: <CAAhSdy1NE2yd1gGZBjEdUSt0cZy6b+pLH5sqLBmUafzryqd4iA@mail.gmail.com>
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

On Mon, Jun 29, 2020 at 12:06 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 29, 2020 at 12:38 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 9:58 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > On Mon, Jun 29, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > > > >
> > > > > Add device tree bindings for performance monitor unit. And it passes the
> > > > > dt_binding_check verification.
> > > > >
> > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > ---
> > > > >  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
> > > > >  1 file changed, 59 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..f55ccbc6c685
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > > > > @@ -0,0 +1,59 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: RISC-V Performance Monitor Units
> > > > > +
> > > > > +maintainers:
> > > > > +  - Zong Li <zong.li@sifive.com>
> > > > > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > > > > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    items:
> > > > > +      - const: riscv,pmu
> > > > > +
> > > > > +  riscv,width-base-cntr:
> > > > > +    description: The width of cycle and instret CSRs.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +
> > > > > +  riscv,width-event-cntr:
> > > > > +    description: The width of hpmcounter CSRs.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > > The terms "base" and "event" is confusing because
> > > > we only have counters with no interrupt associated with it.
> > > >
> > > > The RISC-V spec defines 3 counters and rest are all
> > > > implementation specific counters.
> > >
> > > As I know, there are 2 counters of spec definition: cycle and instret.
> > > What is the 3rd counter you mentioned?
> >
> > TIME is a counter CSR.
> >
> > >
> > > >
> > > > I suggest using the terms "spec counters" and "impl counters"
> > > > instead of "base counters" and "event counters".
> > >
> > > OK, they are good to me. Let me change it.
> > >
> > >
> > > >
> > > > Further, "riscv,width" properties are redundant because
> > > > RISC-V spec clearly tells that counters are 64bit for both
> > > > RV32 and RV64.
> > > >
>
> Sorry for the lost replying. The maximum length of counters is 64, but
> it doesn't require to implement all bits. A real case is that
> unleashed board only implements 40 bit for mhpmcounters.

The "3.1.11 Hardware Performance Monitor" clearly states that
all counters are 64bit

To take care of the unleashed board, the "riscv,width-xyz" DT properties
should be optional. Whenever these properties are not present, we
should assume 64bit counter width.

>
> > > > > +
> > > > > +  riscv,n-event-cntr:
> > > > > +    description: The number of hpmcounter CSRs.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +
> > > > > +  riscv,hw-event-map:
> > > > > +    description: The mapping of generic hardware events. Default is no mapping.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +
> > > > > +  riscv,hw-cache-event-map:
> > > > > +    description: The mapping of generic hardware cache events.
> > > > > +      Default is no mapping.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - riscv,width-base-cntr
> > > > > +  - riscv,width-event-cntr
> > > > > +  - riscv,n-event-cntr
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    pmu {
> > > > > +      compatible = "riscv,pmu";
> > > > > +      riscv,width-base-cntr = <64>;
> > > > > +      riscv,width-event-cntr = <40>;
> > > > > +      riscv,n-event-cntr = <2>;
> > > > > +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> > > > > +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> > > > > +    };
> > > > > +
> > > > > +...
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> > > > Regards,
> > > > Anup

Regards,
Anup
