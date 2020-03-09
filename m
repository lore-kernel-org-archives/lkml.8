Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36020848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0lWcvhhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCIL7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:59:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCIL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:59:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id t11so10728573wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKmPOFNtNKhOUxrBtZH5/PcOP5JpmW7NzOHUh/0ofj4=;
        b=0lWcvhhenS7r9ioqD+cOH8VnAb/YTLj+dpwAVIlaLYoxMjz7tp2ZXBtMlNiJz81A3Y
         d2e1cUD205lLiuRQlTy879Qklwo3HwDmlpp4hyL2b7pVyyeFuo0w30VFwpE0SWU4pioR
         Kn8VsJbJQmBbnGv8sSsYq+n0lMtokU4rBDqHj18lVIYq87OqrGLhF/cGJnRgcFRSAkeY
         e+RUHW7V/6WZGW+MyshvLcbmpwfSLTtaHp6K1cAvGodnDMSBcfMmoowXKe2ndUIXuKJC
         Mp+rzoB/UYi8LdFW+KvUVTY1JU/RL4hWWMQzgOf6OUrZD587JvE9icooAHDb9Pps9H6D
         2B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKmPOFNtNKhOUxrBtZH5/PcOP5JpmW7NzOHUh/0ofj4=;
        b=gvvd6HsUrSaKFGejbQEltUiekSK51lhpIBcwOfr2oDvGIWdX49Mef4ZFpyZS+hoD8C
         rX3cG5uCBt031KHZdQ4wkyc7watQOU+wL1FkHMVvtERR30tcHf60/8PwGUTOyhqcYEDj
         ELDD5k4QA4i6O+wG9A/iLxhlWmRW+gdBPrQYcHKH9flR9KaUDzLQF+NmmDT9LsQW7sUp
         UJGkQH8/bSgQo8SCwvWQ97KYy5GYh4vOoyjIamMeYWtM8kle97bZd43TYWyIu5/nWi8o
         0VYb0S1dAdD1HsqIASuTq6DFxOK4QI0QZgxOtUASo4PoL2atnGpoJMWiOieSCh8GM820
         A0WA==
X-Gm-Message-State: ANhLgQ0W8/A8UTTN2EynCDi6jhWSbSA7VlP/MjRbNN4403Yb+Kb7q3Jv
        B7vnGjMnTEGOa/pfFZpcPU4BEHqsS6HSNDD2xCnUGA==
X-Google-Smtp-Source: ADFU+vv9DD16vHL5eDuYyG5Zfo7yZZUS+CSxVSUAykezHxmSIhC6p8Dq342GwdWFZ4WDvxJ2o4h4bAHnsmZC3HgcdWI=
X-Received: by 2002:a05:6000:4a:: with SMTP id k10mr19657020wrx.381.1583755146375;
 Mon, 09 Mar 2020 04:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200309110211.91130-1-anup.patel@wdc.com> <20200309110211.91130-3-anup.patel@wdc.com>
In-Reply-To: <20200309110211.91130-3-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Mar 2020 17:28:54 +0530
Message-ID: <CAAhSdy23nKn+DqVmmG+4Q4LXZ2qE8eLLUu=si9zO3y8usdA=HA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] RISC-V: Rename and move plic_find_hart_id() to
 arch directory
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Marc's email address.

On Mon, Mar 9, 2020 at 4:33 PM Anup Patel <anup.patel@wdc.com> wrote:
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
> index c34fb3ae0ff8..be05d13e30e8 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -236,20 +236,6 @@ static void plic_handle_irq(struct pt_regs *regs)
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
> @@ -328,7 +314,7 @@ static int __init plic_init(struct device_node *node,
>                 if (parent.args[0] != RV_IRQ_EXT)
>                         continue;
>
> -               hartid = plic_find_hart_id(parent.np);
> +               hartid = riscv_of_parent_hartid(parent.np);
>                 if (hartid < 0) {
>                         pr_warn("failed to parse hart ID for context %d.\n", i);
>                         continue;
> --
> 2.17.1
>
