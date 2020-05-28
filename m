Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE96D207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="D4whbS/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437479AbgE1XJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437333AbgE1XJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:09:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBDDC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:09:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so967138wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpXkyS7vVv9FTAH7S5+DpOFQmjUaMM+ePrWJEGENvuo=;
        b=D4whbS/UshWlAvLJxUCbzHUeSluRxsQX+qSiJdSScDGH+1JBkWXskHDWLQCEWOohQN
         dJQK6J896u99oDKZWAkWmKb7J0seMtAJMbVZYqWUZGl/4JW1DGQ08QRCBqDzEqVtd4WQ
         +6/yQMoNotw8xQ1ZiD5bXcTlej/UFrAAhwe3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpXkyS7vVv9FTAH7S5+DpOFQmjUaMM+ePrWJEGENvuo=;
        b=MfKSIPFSpxBDJ7hL/gY1Q21JDp2PnBsJGuKPF9HqClj4rACnhIspELbUomw0Ai5xDP
         jinjbET/KdM1hZ7eR3W2vmzpBN6+UYJ+VntsZtqVBXaKjh6ZCiZfBYEv0jSYmbIUiz7y
         W62SEZvwOvKbnwabVYfCvwkdhuvi5dDtSVgc1NOP8JG+R4xGPo/Wc3Q8JupzcX2tb4dJ
         w7VMdgpSY4moZPAMkATTSfJ4rlbkMoRDgq5sK5r3o9XUMPr7hkg3Pc2fLSzFK+0mkQEW
         FQefl0w44o/qVVfP2cDPOYHQCKLfvpE/FRaZJH0pPHIsX7YrbpRSRrXBVbuWEnwODpth
         /M5Q==
X-Gm-Message-State: AOAM532U9CFIykh4AC+yCFFqBwUs/8xoSGaAhp77LrGufJuEwGVN0wCv
        mMTseUwXZZ7xU0DfciuHpzlL2nyo78JNAvayQ2G/
X-Google-Smtp-Source: ABdhPJziYtIixceIrIWS3U3B1fj6vDkMc+6p4dpoZVeXiGvP5uccTm4Fr5yvsPFiQvuuC0xwvZBKPLWBdMJOTYLSSgA=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr5395364wml.78.1590707377649;
 Thu, 28 May 2020 16:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-3-anup.patel@wdc.com>
In-Reply-To: <20200521133301.816665-3-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 May 2020 16:09:26 -0700
Message-ID: <CAOnJCUJJcerzrUjoJ-8gt3q8uMcetp4YyXHj-qucoQmfs+LGzg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] RISC-V: Rename and move plic_find_hart_id() to
 arch directory
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
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

On Thu, May 21, 2020 at 6:34 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The plic_find_hart_id() can be useful to other interrupt controller
> drivers (such as RISC-V local interrupt driver) so we rename this
> function to riscv_of_parent_hartid() and place it in arch directory
> along with riscv_of_processor_hartid().
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/processor.h |  1 +
>  arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c  | 16 +---------------
>  3 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3ddb798264f1..b1efd840003c 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -75,6 +75,7 @@ static inline void wait_for_interrupt(void)
>
>  struct device_node;
>  int riscv_of_processor_hartid(struct device_node *node);
> +int riscv_of_parent_hartid(struct device_node *node);
>
>  extern void riscv_fill_hwcap(void);
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40a3c442ac5f..6d59e6906fdd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -44,6 +44,22 @@ int riscv_of_processor_hartid(struct device_node *node)
>         return hart;
>  }
>
> +/*
> + * Find hart ID of the CPU DT node under which given DT node falls.
> + *
> + * To achieve this, we walk up the DT tree until we find an active
> + * RISC-V core (HART) node and extract the cpuid from it.
> + */
> +int riscv_of_parent_hartid(struct device_node *node)
> +{
> +       for (; node; node = node->parent) {
> +               if (of_device_is_compatible(node, "riscv"))
> +                       return riscv_of_processor_hartid(node);
> +       }
> +
> +       return -1;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>
>  static void print_isa(struct seq_file *f, const char *isa)
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index d9c53f85a68e..16d31d114c30 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -240,20 +240,6 @@ static void plic_handle_irq(struct pt_regs *regs)
>         csr_set(CSR_IE, IE_EIE);
>  }
>
> -/*
> - * Walk up the DT tree until we find an active RISC-V core (HART) node and
> - * extract the cpuid from it.
> - */
> -static int plic_find_hart_id(struct device_node *node)
> -{
> -       for (; node; node = node->parent) {
> -               if (of_device_is_compatible(node, "riscv"))
> -                       return riscv_of_processor_hartid(node);
> -       }
> -
> -       return -1;
> -}
> -
>  static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>  {
>         /* priority must be > threshold to trigger an interrupt */
> @@ -330,7 +316,7 @@ static int __init plic_init(struct device_node *node,
>                 if (parent.args[0] != RV_IRQ_EXT)
>                         continue;
>
> -               hartid = plic_find_hart_id(parent.np);
> +               hartid = riscv_of_parent_hartid(parent.np);
>                 if (hartid < 0) {
>                         pr_warn("failed to parse hart ID for context %d.\n", i);
>                         continue;
> --
> 2.25.1
>
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
