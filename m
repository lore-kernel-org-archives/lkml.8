Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B397C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B4206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Ce5+x++x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGUBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGUBPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:15:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CABC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:15:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so1219372wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m1PBDlf1LPTxPG0j6MS17W+ARPO8tVxYxjfZxGbckE=;
        b=Ce5+x++xkvWmQy5tV2ek8r7BcQsw1cnHjnq9IuBBj4ctIMLrk93iuc98LxUYPCK4Og
         jXE88z4QZFv4Ix7/4u8SyV5QyNcB5lOUWBtoMAEp9hnwWYnqxtvg2AUoepjjXtt6EOru
         t89VHWNOMR1jUPfsemv6niF42JiAx3scOvcV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m1PBDlf1LPTxPG0j6MS17W+ARPO8tVxYxjfZxGbckE=;
        b=JMzSBWYBHICemQeI5UszzTnZFS6Z/adbruTOOFdYMNQVOVeP7UfMSWI73WK8MA+/+C
         kh0KnN9bXDEyvDZ+X2FKMB0RHR370aZzRf0TAqkM+PoCEM3URsgQUwlsRFZVWDCGjJ7m
         btoNhpp9WzS4jvr5GNtC55e6eRacI+MEfUtkX/2WrATvTUTBstSDyf+RgyEXH/L4nS1l
         CR6jBMiGOjCinnnUqexzsRwgIY4lkp63qE7paHah8F9lLoaQ9nd2AXIhxkjxg2S+Qca9
         MyAR9vNDongMfSCFLFmXZl8PQYXeM1o5MNOdYbkdpZOi9YhJ/ARgWJjno7+g8ZNTbgFe
         RZ7Q==
X-Gm-Message-State: AOAM532avS8y978jfBDNrr6YCsRxTlyZLz1StyLlkqNaSvD1hZz2VsBg
        3/MylM5Tv+Xt/rvnL/h4RG4+phusZYPSjJcsJgE2
X-Google-Smtp-Source: ABdhPJzWQtySB01DNvPHDj45pwAGcvZh8S0h0KZzv1pnkzbL6e2npAV+4EXFSbg2gu+eHmxZCvo2HTCuKpZ05HmE5mI=
X-Received: by 2002:a1c:2095:: with SMTP id g143mr1620823wmg.78.1595294143811;
 Mon, 20 Jul 2020 18:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200717075101.263332-1-anup.patel@wdc.com> <20200717075101.263332-5-anup.patel@wdc.com>
In-Reply-To: <20200717075101.263332-5-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jul 2020 18:15:32 -0700
Message-ID: <CAOnJCULcffij3-d-TsQixj5TZdatBdUcC-y73L=W-+5h41ytKQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: timer: Add CLINT bindings
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:52 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add DT bindings documentation for CLINT device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> new file mode 100644
> index 000000000000..8ad115611860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Core Local Interruptor
> +
> +maintainers:
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> +  interrupts. It directly connects to the timer and inter-processor interrupt
> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> +  interrupt controller is the parent interrupt controller for CLINT device.
> +  The clock frequency of CLINT is specified via "timebase-frequency" DT
> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,clint0
> +      - const: sifive,fu540-c000-clint
> +
> +    description:
> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
> +      CLINT v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details
> +

As the DT binding suggests that the clint device should be named as "sifive,**",
I think we should change the DT property in kendryte dts as well.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    clint@2000000 {
> +      compatible = "sifive,clint0", "sifive,fu540-c000-clint";
> +      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> +                             &cpu2intc 3 &cpu2intc 7
> +                             &cpu3intc 3 &cpu3intc 7
> +                             &cpu4intc 3 &cpu4intc 7>;
> +       reg = <0x2000000 0x4000000>;
> +    };
> +...
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Otherwise,

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
