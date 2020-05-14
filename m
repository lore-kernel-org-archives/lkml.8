Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408D7205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqEKtvQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbgENAXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732946AbgENAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:23:35 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F24C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:23:34 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a11so489630uah.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DNHtoGN8AEBU2XRBN2d1pQMaWosnFgb+E454pWapuo=;
        b=hqEKtvQG5x4boOpMaDZ44lycvpN66hkdKuNeDQ0tCjH0g5wOLUw17Dtcq+EqvLhSVd
         2SOSmEn7GzfaIuaaWi1xblgxsLC0YsEBbsji3COXyd4KmUmEsQCx7nEtXWz1+SQMFtct
         zUz5+AuJ8JIgviULQP0sgLBVTlhkpMb8ehXPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DNHtoGN8AEBU2XRBN2d1pQMaWosnFgb+E454pWapuo=;
        b=YWPU7sz1Hb5K6CLgp0S6Wo8BeN2TTAWMxdW68S2B4GHf4ag4zLa45sEVBM7CeVvneS
         d63uVgzDWpzzW58jS3kggUWrCVkoXpci+54bVH6dv7OJWjJAFDQ9KgwnE+nsdNX06Zl3
         w//i/VHAVkvy+0L3O/MdOdn1rJoIUt6Ah/ZQEoiwXSPiL9+zblh4PV5+BqOludCxlpHq
         SraHW3cdy3P5VZ8cL04vLJvecbAIUDgCCzHkeWWwmyIPPmQDrxsTtCqS21TwxjDM3wKl
         SmXrZr+X/YT9UD44Tc9L2oPz4wgZwHPmGDXApICYmQMhsE22rRrNkJOSXlb/SIWK4aIp
         S/fQ==
X-Gm-Message-State: AOAM532I88o7bbzndIhXz6phXHXmuKnJYQDBoH1mivDzQqgCKUaNfIqh
        /EMiI/OR33d0sEeyx3U4EUiVmZpkYrY=
X-Google-Smtp-Source: ABdhPJxYAU0DLHZvNj7sKapJWC6NUq7X3qJ8a3wT7RI3RtTTdg0AHDpGS1jlFFbUlCd9yCbm0wRusg==
X-Received: by 2002:a9f:31cb:: with SMTP id w11mr1984516uad.128.1589415812641;
        Wed, 13 May 2020 17:23:32 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id e136sm345564vsc.9.2020.05.13.17.23.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:23:31 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id y10so497403uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:23:31 -0700 (PDT)
X-Received: by 2002:ab0:69cc:: with SMTP id u12mr1898920uaq.22.1589415810804;
 Wed, 13 May 2020 17:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <20200509214159.19680-5-liwei391@huawei.com>
In-Reply-To: <20200509214159.19680-5-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 17:23:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vb6=f=fr83-k0YH86k4v4G5LcfOGcks7RM9VxzxOnXsQ@mail.gmail.com>
Message-ID: <CAD=FV=Vb6=f=fr83-k0YH86k4v4G5LcfOGcks7RM9VxzxOnXsQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
To:     Wei Li <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>
> After fixing wrongly single-stepping into the irq handler, when we execute
> single-step in kdb/kgdb, we can see only the first step can work.
>
> Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
> i think PSTATE.SS=1 should be set each step for transferring the PE to the
> 'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
> since the second single-step.
>
> After the first single-step, the PE transferes to the 'Inactive' state,
> with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
> kernel_active_single_step()=true. Then the PE transferes to the
> 'Active-pending' state when ERET and returns to the debugger by step
> exception.
>
> Before this patch:
> * kdb:
> Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff80001014874c (printk)
>     is enabled   addr at ffff80001014874c, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to Breakpoint @ 0xffff80001014874c
> [3]kdb> ss
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
> [3]kdb> ss
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
> [3]kdb> ss
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 3 due to SS trap @ 0xffff800010148750
> [3]kdb>
>
> * kgdb:
> (gdb) target remote 127.1:23002
> Remote debugging using 127.1:23002
> arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
> 21              asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
> (gdb) b printk
> Breakpoint 1 at 0xffff80001014874c: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
> (gdb) c
> Continuing.
> [New Thread 277]
> [Switching to Thread 276]
>
> Thread 171 hit Breakpoint 1, printk (fmt=0xffff8000112fc130 "\001\066sysrq: HELP : ")
>     at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
> 2076    {
> (gdb) stepi
> 0xffff800010148750      2076    {
> (gdb) stepi
> 0xffff800010148750      2076    {
> (gdb) stepi
> 0xffff800010148750      2076    {
> (gdb)
>
> After this patch:
> * kdb:
> Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff80001014874c (printk)
>     is enabled   addr at ffff80001014874c, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to Breakpoint @ 0xffff80001014874c
> [2]kdb> ss
>
> Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148750
> [2]kdb> ss
>
> Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148754
> [2]kdb> ss
>
> Entering kdb (current=0xffff0000fa800040, pid 264) on processor 2 due to SS trap @ 0xffff800010148758
> [2]kdb>
>
> * kgdb:
> (gdb) target remote 127.1:23002
> Remote debugging using 127.1:23002
> arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
> 21              asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
> (gdb) b printk
> Breakpoint 1 at 0xffff80001014874c: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
> (gdb) c
> Continuing.
> [New Thread 281]
> [New Thread 280]
> [Switching to Thread 281]
>
> Thread 174 hit Breakpoint 1, printk (fmt=0xffff8000112fc138 "\001\066sysrq: HELP : ")
>     at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
> 2076    {
> (gdb) stepi
> 0xffff800010148750      2076    {
> (gdb) stepi
> 2080            va_start(args, fmt);
> (gdb) stepi
> 0xffff800010148758      2080            va_start(args, fmt);
> (gdb)
>
> Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 2 ++
>  arch/arm64/kernel/debug-monitors.c      | 2 +-
>  arch/arm64/kernel/kgdb.c                | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index b62469f3475b..a48b507c89ee 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -78,6 +78,8 @@ struct step_hook {
>         int (*fn)(struct pt_regs *regs, unsigned int esr);
>  };
>
> +void set_regs_spsr_ss(struct pt_regs *regs);
> +
>  void register_user_step_hook(struct step_hook *hook);
>  void unregister_user_step_hook(struct step_hook *hook);
>
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 25ce6b5a52d2..7a58233677de 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -141,7 +141,7 @@ postcore_initcall(debug_monitors_init);
>  /*
>   * Single step API and exception handling.
>   */
> -static void set_regs_spsr_ss(struct pt_regs *regs)
> +void set_regs_spsr_ss(struct pt_regs *regs)
>  {
>         regs->pstate |= DBG_SPSR_SS;
>  }
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 3910ac06c261..093ad9d2e5e6 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -230,7 +230,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>                         kernel_prepare_single_step(&per_cpu(kgdb_ss_flags,
>                                         raw_smp_processor_id()), linux_regs);
>                         kernel_enable_single_step(linux_regs);
> -               }
> +               } else
> +                       set_regs_spsr_ss(linux_regs);

One slight nit is that my personal preference is that if one half of
an "if/else" needs braces then both halves should have braces.  I
don't know what Catalin and Will's policies are, though.

Other than that, this seems right to me.  I will leave it to the
Catalin and Will folks to say if they'd rather have this call made
from a different place or if they're happy with where you've put it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
