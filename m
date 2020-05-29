Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6352A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="KY7QUkxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgE2AdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgE2AdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:33:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7037DC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:33:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so1218370wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI7CDCUbd5OO59gGqxpOHmDYgW2MbSqQ4kURqtenhT8=;
        b=KY7QUkxxkJAy9/MypVQr0cPw3LLVXtfvPShrn5e8LD5SgrqM0+9duZr3Ugyg6LVkxx
         intd2hXFaoa4Z6NWzfCZ6VeyBThOvUOQJIvOTazwlWc969YwG6phJuD4Dx/Ryu4muaYs
         lOYS5mUAuiTX4iIdKa1i63TZnmiW2wm/NTZB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI7CDCUbd5OO59gGqxpOHmDYgW2MbSqQ4kURqtenhT8=;
        b=QafOxHFbqWMk9ItvaiZJVUIB9+y9qQ3WyihMFrvFRAsNyyx724dLeXwFvqY8WObBk5
         al2jrD6299BfmqUDgaqAyCJnkEz6QaWJotVO8C30pJXj+Kx5U0ylVTzGpgmj7ePO9msB
         6fC4UqAM4W3yY/DKRPVjxeGmwm7zMFD82g85sh5NE8REaXvH1E2Pb/p5NBcCo7NlHCNU
         5BA7jak48YEI6aNevfOlBOm5DpY5KyH3vdrZjOLVPBhDtN/Wg7xn2cEORMjXTbEb7wuE
         0oSg9bs5SoFE3JkY8Efda+g7K7RgkkW0F2aznvR1rjVk1iAVWreSsmFs3+DfUdWixpSY
         cnpg==
X-Gm-Message-State: AOAM532afx9jBShphP9p6pf2oHaeHux+sE80Lh3xKCI/6AuSddMAsVQr
        fYo8JsTq3FMa3D24khSx97325wXsQQPEwSJDkxnpyPo=
X-Google-Smtp-Source: ABdhPJxSloc37vigWw1sS2KYBXlP/cfCpnCL/QUg9OmmggVEbx7A00NjmrfCHDBT8wvJcPx1K6nc+RlNFiEzCou/GkE=
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr5646353wme.31.1590712383067;
 Thu, 28 May 2020 17:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-6-anup.patel@wdc.com>
In-Reply-To: <20200521133301.816665-6-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 May 2020 17:32:52 -0700
Message-ID: <CAOnJCUKvPSPRwPFZg==A4jHXOursXy1=n9Pjsf-ntuqDwPRWTg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] RISC-V: Remove do_IRQ() function
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
> The only thing do_IRQ() does is call handle_arch_irq function
> pointer. We can very well call handle_arch_irq function pointer
> directly from assembly and remove do_IRQ() function hence this
> patch.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/entry.S | 4 +++-
>  arch/riscv/kernel/irq.c   | 6 ------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 56d071b2c0a1..cae7e6d4c7ef 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -106,7 +106,9 @@ _save_context:
>
>         /* Handle interrupts */
>         move a0, sp /* pt_regs */
> -       tail do_IRQ
> +       la a1, handle_arch_irq
> +       REG_L a1, (a1)
> +       jr a1
>  1:
>         /*
>          * Exceptions run with interrupts enabled or disabled depending on the
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index eb8777642ce6..7207fa08d78f 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -16,12 +16,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>         return 0;
>  }
>
> -asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
> -{
> -       if (handle_arch_irq)
> -               handle_arch_irq(regs);
> -}
> -
>  void __init init_IRQ(void)
>  {
>         irqchip_init();
> --
> 2.25.1
>
>


Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
