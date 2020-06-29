Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A16A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gKkqbViB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbgF2VGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgF2TMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB892C08C5EE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:28:19 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so6394890otl.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmoPe2SauK8cs9bRn6bTRLzxO3FPfMTTx1fSlCe95d8=;
        b=gKkqbViBG7WBVI5NjrSJyQpjokEKocyZ3xjP0GI/wEF4IAQ7TEArhrPTCE+86csn4t
         ztJcVsQFb2Orb6efdvOELarX0CiP0FF2xymfqPLneU0JpjIBn6WmXIplFSoK/jeHnG0W
         QOLquAkwHNFaNJBDm11vaWQpobVgNFAP61VOwdt7aqGlfRNUnW9u514s+inD30VQ4b6R
         30GBa2KaGsG4Lcrs82P7D3k9iiSws9rXH2MkssoFiSefo1r/OFakPuV0gEiPCcZbtJdr
         fqc9J32Vk9mDg9Swwavm1Y2ft01ftY/ulLiRRebj6eG6tThHnF7ciSywIQjkC/6ioRRN
         V1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmoPe2SauK8cs9bRn6bTRLzxO3FPfMTTx1fSlCe95d8=;
        b=QTlqsdzSqHDJiOtV/+yiRJYjkYNYEMQ6h6syLhgCiiucD4ADaCQv7aqWBGGR/OI/XQ
         NJGJNXDva6X+zmDh9v21rqrRNU2p68HwpUHBTiMGE6EzWng58fAXxwa6o451xRik04ZY
         X+Geis5UYlhJvDqmR/ouPivXfHqu/xkhSu/nI/lPTLJLAP6on9i0dkRuArZY5kb52TxE
         osWFEgvagiGRpBrv3e6OwHPY7AVjmGGe3Mmy2GgI6PgOhPdTOX046myKmoOKpVcaXGlX
         T3C8galNgOsr6+6vHv9+KsuoNU8+r4wAFskQ5hsA3t6zjOdmt28LEP4dpHLERlf7vgXW
         dxbA==
X-Gm-Message-State: AOAM531VqbyLo+zDRzmSY7gJVoyyLGIrRsawtb3W8ObgnUxAESbBrgB/
        ndmcvEBCgnM3fUt0aQsEHgV8PmgEH6df0BxL9hUec0erAIg=
X-Google-Smtp-Source: ABdhPJxuV9e/bdajpyOTCW3jUhfFs6GfvwaIjwyWuTWIcFYCNOoZ17sobH1l6CwPKbEcdycLek+MonZIX94hGVZ+Wls=
X-Received: by 2002:a9d:186:: with SMTP id e6mr12147068ote.33.1593404899159;
 Sun, 28 Jun 2020 21:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
 <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
In-Reply-To: <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 29 Jun 2020 12:28:08 +0800
Message-ID: <CANXhq0pV87oSzyAt80ySoXGRXp26bCnahPW0r27J+wjj5yc=nw@mail.gmail.com>
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

On Mon, Jun 29, 2020 at 12:09 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > Add device tree bindings for performance monitor unit. And it passes the
> > dt_binding_check verification.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > new file mode 100644
> > index 000000000000..f55ccbc6c685
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Performance Monitor Units
> > +
> > +maintainers:
> > +  - Zong Li <zong.li@sifive.com>
> > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: riscv,pmu
> > +
> > +  riscv,width-base-cntr:
> > +    description: The width of cycle and instret CSRs.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  riscv,width-event-cntr:
> > +    description: The width of hpmcounter CSRs.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> The terms "base" and "event" is confusing because
> we only have counters with no interrupt associated with it.
>
> The RISC-V spec defines 3 counters and rest are all
> implementation specific counters.

As I know, there are 2 counters of spec definition: cycle and instret.
What is the 3rd counter you mentioned?

>
> I suggest using the terms "spec counters" and "impl counters"
> instead of "base counters" and "event counters".

OK, they are good to me. Let me change it.


>
> Further, "riscv,width" properties are redundant because
> RISC-V spec clearly tells that counters are 64bit for both
> RV32 and RV64.
>
> > +
> > +  riscv,n-event-cntr:
> > +    description: The number of hpmcounter CSRs.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  riscv,hw-event-map:
> > +    description: The mapping of generic hardware events. Default is no mapping.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  riscv,hw-cache-event-map:
> > +    description: The mapping of generic hardware cache events.
> > +      Default is no mapping.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +required:
> > +  - compatible
> > +  - riscv,width-base-cntr
> > +  - riscv,width-event-cntr
> > +  - riscv,n-event-cntr
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pmu {
> > +      compatible = "riscv,pmu";
> > +      riscv,width-base-cntr = <64>;
> > +      riscv,width-event-cntr = <40>;
> > +      riscv,n-event-cntr = <2>;
> > +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> > +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> > +    };
> > +
> > +...
> > --
> > 2.27.0
> >
>
> Regards,
> Anup
