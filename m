Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C97C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D229420792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="srkmkvhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgGVDzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgGVDzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 23:55:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CEAC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:55:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so480830wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFC4e1lyE7ts6QLvqBb4PFiSTT9NQBcFvnLiz1+hr48=;
        b=srkmkvhDKIkC7xQ+Erl9q+ptkCX3zSzRoCdUCdYWrtYxQgtdnbMIebHVIlnrXMuECG
         SlRnahF0UnWTSTGwaOSTKHTlLgKzRoMS0IW5PLwk/089WiaVhC7HDzMEs3HeK6eRkrE0
         ATmz2QKDy/y/DlIo+2cwk3NtTspyqAwzk7fP+H1sKOpzTaKI5x/kdGVgh0GHGQ9wZTdU
         wAp87P7cDy9vH2Dz8YnBjmaA4+fff3ouquN8cIASp9+HDaaGgv1Xv2Bb5Mm16InXgdJ+
         qMObXjMx+gTN/PngzgaIdoYF6LTreTu6hcGLIuU97b5KBh8+HWF/4R3FztO8TKb+hE0H
         SKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFC4e1lyE7ts6QLvqBb4PFiSTT9NQBcFvnLiz1+hr48=;
        b=CXWTWZS0GrSvCuVMmrfmp/NkxBSQKE6puZRGt3pUfSBDVzQ6bSiJwRv5dgWM9qiy5l
         IqlPP3P6QQ+WBweoBfOoQg8a9BdhB+dusqjBpVboeg08ueAoywLvGDrSoCafaeEPJ9Ej
         kqE0t0XnCvLOMBGasqQpRtc98Gik+fuh4M9cYkbuEcsAcPvrZG0DaKNPF2ZaUfvINNJo
         1zVQsFZMEYFOXya5S4qmxmhuZNaXcajyuW5CX4JMS0xR1HPK8aGwSnOBL1mrK+iLkDNY
         yHWY/yd7shS29ZN6J4jt3RBLdQVQFMGfQuLOL/RaoRWnvTLz6jHcBG/9qlrnvqdrK0iS
         Qwag==
X-Gm-Message-State: AOAM530xmb97FkuwEbSdL7NpPCxa02WGJsYRZIK9B/WlGKWylM8BlkKZ
        CC24MgDUOGDwOgxdsYUrgKPwWxcVS5np9A792Y8dig==
X-Google-Smtp-Source: ABdhPJwviiRhh8Ew5FwFPWSNY3nE65EKkh19UnrCdWqhsEpXCx9HCf/vqo6H6vcfqlvdohr7KotRJueK95xx91UgOUU=
X-Received: by 2002:adf:f247:: with SMTP id b7mr13963465wrp.128.1595390143363;
 Tue, 21 Jul 2020 20:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200717075101.263332-1-anup.patel@wdc.com> <20200717075101.263332-5-anup.patel@wdc.com>
 <CAOnJCULcffij3-d-TsQixj5TZdatBdUcC-y73L=W-+5h41ytKQ@mail.gmail.com>
 <CAAhSdy1cbKA9iwBPYMX5xaYFe_BxnB2Sm_ftHPPDq+96SeKbnA@mail.gmail.com> <b2d7b1d6-db33-7b40-9511-95de991e9ad6@gmail.com>
In-Reply-To: <b2d7b1d6-db33-7b40-9511-95de991e9ad6@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 22 Jul 2020 09:25:31 +0530
Message-ID: <CAAhSdy1Dx+oP0guRGvCFa61gL93R+pcQDYLdMpo+LaOjA5tvBQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: timer: Add CLINT bindings
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Emil Renner Berhing <kernel@esmil.dk>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 5:48 PM Sean Anderson <seanga2@gmail.com> wrote:
>
> On 7/20/20 9:15 PM, Atish Patra wrote:
> > On Fri, Jul 17, 2020 at 12:52 AM Anup Patel <anup.patel@wdc.com> wrote:
> >>
> >> We add DT bindings documentation for CLINT device.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> >> ---
> >>  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
> >>  1 file changed, 58 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >> new file mode 100644
> >> index 000000000000..8ad115611860
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >> @@ -0,0 +1,58 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: SiFive Core Local Interruptor
> >> +
> >> +maintainers:
> >> +  - Palmer Dabbelt <palmer@dabbelt.com>
> >> +  - Anup Patel <anup.patel@wdc.com>
> >> +
> >> +description:
> >> +  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
> >> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> >> +  interrupts. It directly connects to the timer and inter-processor interrupt
> >> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> >> +  interrupt controller is the parent interrupt controller for CLINT device.
> >> +  The clock frequency of CLINT is specified via "timebase-frequency" DT
> >> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> >> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: sifive,clint0
> >> +      - const: sifive,fu540-c000-clint
> >> +
> >> +    description:
> >> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
> >> +      Supported compatible strings are -
> >> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> >> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
> >> +      CLINT v0 IP block with no chip integration tweaks.
> >> +      Please refer to sifive-blocks-ip-versioning.txt for details
> >> +
> >
> > As the DT binding suggests that the clint device should be named as "sifive,**",
> > I think we should change the DT property in kendryte dts as well.
>
> The kendryte device is based on Rocket Chip, not any SiFive IP/device.
> If anything, the general binding should be "chipsalliance,clint" and the
> specific bindings should be "sifive,clint" and "kendryte,clint" (or
> "canaan,clint").

AFAIK, Palmer clearly mentioned in previous discussion that CLINT
spec is still owned by SiFive. No matter who implements CLINT device
in their SOC, we will need one compatible string to represent the
spec version (i.e. "sifive,clint0") and another compatible representing
specific implementation (for kendryte this can be "kendryte,k210-clint").

Regards,
Anup
