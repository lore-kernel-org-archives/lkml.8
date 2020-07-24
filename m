Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nXoaNHWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXC4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXC4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:56:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00BC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:56:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so2751337wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtmtjWywAWpjYkCnJwgMZyShNjYxCaF8KfigHWMZhhU=;
        b=nXoaNHWHDTCezdp5CpduMelSEcFsS/xXZFFJj7yT6pEpVyCUFKyrt3fvZXfzn5uZ0w
         YxhvKfAzaEEun8oxMcPODKbWEFiIWpJv5uUZuAEG3yBf0SXH8Dj4NOJRrwrrNdq3h+UM
         1pU8M69WeKOtqWcfh6H0UlM3+c8AcDiqRPGMcXGiu6JrYVimRr+oO4GfDp8ovLKAtpE1
         eplbQPmszATGctckqs6k2WKrOK8XU9bUbWbKz1LcU5bhzpBNcrQcm2dweXduv2HTtG99
         9+30OR+DxqdvdP5t1In8yZQwgzngwx0aYZPzwb3t3OMSdhZO6ELLnbrOQWmRflw3s1jn
         6Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtmtjWywAWpjYkCnJwgMZyShNjYxCaF8KfigHWMZhhU=;
        b=VL+hxn9xIepJYYc5Mt/ZQMYgJQzOs8QGJ7P6S6TfP0AO6ZJknr9hvlwHODcwgh9gJS
         bHCl20uobXUSnekWxF+beDvQ9Shr/HVLT5zBRWfSL0L6M4dB3cvtBkzMQQeGUBoHKTuq
         F5SCjlFhML4snx1RrJN91BZYPhnOeTxHqdZa5DS209ZnnhOMsOJ8V4IFdoMawsgC/q02
         X3frG0CzjtdJ7fh6+DScM7sr18f+V0opcc6KlxUCVq2k+bO8nTNm3mjxZk10q9papfJj
         6DzbfP6Xgk6a2HjNT2Ny8dC55j5Ncwg3PItvWiyFPrpwdRzXGngUWtjOFeLllFsi0vta
         f6hQ==
X-Gm-Message-State: AOAM533nzTkeWY9oLa1yG6K6xPDRCaqxZHhOoJ6nqfibtJS0/E3O6T3j
        r12XsWlPDVVElQlaqK4H1I25cTjg7RtZ06sXjrRD0djJ
X-Google-Smtp-Source: ABdhPJz7gHCgz3xS846jQtIQ7O74yrODpOHmRg9I3TY6YB258gHiQKrSSldHgTJt52Oo44AJgBXEEL5aWfj/KoNhfJg=
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr7119713wml.185.1595559370601;
 Thu, 23 Jul 2020 19:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200723142409.47057-1-anup.patel@wdc.com> <20200723142409.47057-5-anup.patel@wdc.com>
 <20200723170806.GA535824@bogus>
In-Reply-To: <20200723170806.GA535824@bogus>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 24 Jul 2020 08:25:58 +0530
Message-ID: <CAAhSdy0tvy65zYSqeSAq781gRA4P0v5Suad+PidNFgPYLd+U1w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] dt-bindings: timer: Add CLINT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Emil Renner Berhing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 23, 2020 at 07:54:09PM +0530, Anup Patel wrote:
> > We add DT bindings documentation for CLINT device.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> > ---
> >  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > new file mode 100644
> > index 000000000000..8ad115611860
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive Core Local Interruptor
> > +
> > +maintainers:
> > +  - Palmer Dabbelt <palmer@dabbelt.com>
> > +  - Anup Patel <anup.patel@wdc.com>
> > +
> > +description:
> > +  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
> > +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> > +  interrupts. It directly connects to the timer and inter-processor interrupt
> > +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> > +  interrupt controller is the parent interrupt controller for CLINT device.
> > +  The clock frequency of CLINT is specified via "timebase-frequency" DT
> > +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> > +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,clint0
> > +      - const: sifive,fu540-c000-clint
>
> Wrong order. Most specific goes first.

Okay, will update.

>
> > +
> > +    description:
> > +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
> > +      Supported compatible strings are -
> > +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> > +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
> > +      CLINT v0 IP block with no chip integration tweaks.
> > +      Please refer to sifive-blocks-ip-versioning.txt for details
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts-extended
>
> Add:
>
> additionalProperties: false

Okay, will add.

>
> > +
> > +examples:
> > +  - |
> > +    clint@2000000 {
>
> timer@...

Okay, will rename.

>
> > +      compatible = "sifive,clint0", "sifive,fu540-c000-clint";
> > +      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> > +                             &cpu2intc 3 &cpu2intc 7
> > +                             &cpu3intc 3 &cpu3intc 7
> > +                             &cpu4intc 3 &cpu4intc 7>;
> > +       reg = <0x2000000 0x4000000>;
>
> 64MB of register space? Doesn't matter much for 64-bit, but would waste
> lots of virtual space (low mem) on 32-bit.

This is a typo. The register space size is 64KB not 64MB. I will update.

>
> > +    };
> > +...
> > --
> > 2.25.1
> >

Regards,
Anup
