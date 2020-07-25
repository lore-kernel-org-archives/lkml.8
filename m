Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7242BC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4960E2065F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="WEHHTg4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGYFEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGYFEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:04:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D626C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:04:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so9554655wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0dV2iws6uddsenYWAYMkWA+zVZMQ5+yYDWKXhWbbSQ=;
        b=WEHHTg4beksBQ7vroTRmltI3g6curLkD166WwiL4Dxtfln8Ff3lGwkRIlGZuHvbSKu
         O5MNgM0tt+tB3+BsHpVnC9DCPAyDf1Vcqo7jzAtq64Nicz5DoPTqvSGbJ35TIantjMCM
         VuVttfjZ2WA6fzPWni1AP8D9p6+iKM8fhPtiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0dV2iws6uddsenYWAYMkWA+zVZMQ5+yYDWKXhWbbSQ=;
        b=H3mcC4Ome7GFRNQ8cFaGJNmW23YWm3/mbY200bpxAWxt0mlu9OS9L39IYNvRs5nHHi
         PMechrkRBYiYFcP5Bgx4MEYPltfYG7QiCozEUvrxnvVDHTUp0TefYgoDO54cCVv/VKJ+
         j7GVYkELYTMcxY2rGjOLxjCu27+WmPkKNjqSTYCrj9zTQZJZndD9pVBabLQGmjh9Yxk8
         8bhQAls0RLR+7SNWV95XccSk/p+Qhu3gCxWaCWhloiS+yDb4QtVRMYONI4B0V5ZQ2sBf
         MLHW5E5kaY8+Q0sGhEscdn4KshWWSWB1Xh6v7CfEauwXPPEww+Ry9VAdmg40pY46RaS1
         AIDw==
X-Gm-Message-State: AOAM532mAB/sY4HMZqj0MHjdBoA7MHsWRb237guBZSus2hsM9BlyrIWf
        IS44MJvtV6PS8DGtQcXiyr+hKt4bJwzXa6IWxYpI
X-Google-Smtp-Source: ABdhPJwowXforkH2kxs2VccCNf7vTEQdsTB93/wdFK6X6NUSYQbseWUxeAD3SlVT3geAqA1PlMFz5w+a7ix4YVgalLE=
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr11403103wmn.186.1595653482851;
 Fri, 24 Jul 2020 22:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071822.126758-1-anup.patel@wdc.com> <20200724071822.126758-5-anup.patel@wdc.com>
In-Reply-To: <20200724071822.126758-5-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jul 2020 22:04:31 -0700
Message-ID: <CAOnJCU+Hb5bvp19wOXOWD+3DQi7UG+E+k5TCheaZWHBWL153Gg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] dt-bindings: timer: Add CLINT bindings
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

On Fri, Jul 24, 2020 at 12:19 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add DT bindings documentation for CLINT device.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> new file mode 100644
> index 000000000000..2a0e9cd9fbcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -0,0 +1,60 @@
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
> +      - const: sifive,fu540-c000-clint
> +      - const: sifive,clint0
> +
> +    description:
> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
> +      CLINT v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    timer@2000000 {
> +      compatible = "sifive,fu540-c000-clint", "sifive,clint0";
> +      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> +                             &cpu2intc 3 &cpu2intc 7
> +                             &cpu3intc 3 &cpu3intc 7
> +                             &cpu4intc 3 &cpu4intc 7>;
> +       reg = <0x2000000 0x10000>;
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


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
