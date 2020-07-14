Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA287C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93C220BED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594726995;
	bh=cVmijVoFVzbUvu8fDT/dJyJnUDFjkjRUgn8Ctil7QrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MFXDi2XazjEexvxLUHRBk1cHl0yBRMNE7cWFscrGZZnjxbRMoOGXEfbyqpYp9yGJ7
	 BnwSvJesStYpZ0hofW5a0BS1hcC9NojYRi9flTpt9F2hcZ5GWvkoJuGCa/NSgOjqOj
	 7NGHzKB/C/SbG9/ocWpCZqvBVULUE896dkcZGkWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGNLnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgGNLnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:43:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9958D20BED;
        Tue, 14 Jul 2020 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726990;
        bh=cVmijVoFVzbUvu8fDT/dJyJnUDFjkjRUgn8Ctil7QrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tE0u9TlAoXY3svJF3yeRIYYYcEzsS2duKcVk5vMd62IsQrVixbg63cI1xTh0aCFYA
         UtbBHxPX6ThWFG2vjLypD7C+yUbAG0G9qL4NbODpZdsdLrr575vmJILb7RwZGW0Eus
         EeWMpfWFpBnKNVCZkWWALc57eUAzndusdm8nSojk=
Date:   Tue, 14 Jul 2020 20:43:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        oleg@redhat.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, me@packi.ch, bjorn.topel@gmail.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v3 7/7] riscv: Add support for function error injection
Message-Id: <20200714204305.89ee1183f7c3fc4400e6d7c6@kernel.org>
In-Reply-To: <1594683562-68149-8-git-send-email-guoren@kernel.org>
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
        <1594683562-68149-8-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Mon, 13 Jul 2020 23:39:22 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Inspired by the commit 42d038c4fb00 ("arm64: Add support for function
> error injection"), this patch supports function error injection for
> riscv.
> 
> This patch mainly support two functions: one is regs_set_return_value()
> which is used to overwrite the return value; the another function is
> override_function_with_return() which is to override the probed
> function returning and jump to its caller.
> 
> Test log:
>  cd /sys/kernel/debug/fail_function
>  echo sys_clone > inject
>  echo 100 > probability
>  echo 1 > interval
>  ls /
> [  313.176875] FAULT_INJECTION: forcing a failure.
> [  313.176875] name fail_function, interval 1, probability 100, space 0, times 1
> [  313.184357] CPU: 0 PID: 87 Comm: sh Not tainted 5.8.0-rc5-00007-g6a758cc #117
> [  313.187616] Call Trace:
> [  313.189100] [<ffffffe0002036b6>] walk_stackframe+0x0/0xc2
> [  313.191626] [<ffffffe00020395c>] show_stack+0x40/0x4c
> [  313.193927] [<ffffffe000556c60>] dump_stack+0x7c/0x96
> [  313.194795] [<ffffffe0005522e8>] should_fail+0x140/0x142
> [  313.195923] [<ffffffe000299ffc>] fei_kprobe_handler+0x2c/0x5a
> [  313.197687] [<ffffffe0009e2ec4>] kprobe_breakpoint_handler+0xb4/0x18a
> [  313.200054] [<ffffffe00020357e>] do_trap_break+0x36/0xca
> [  313.202147] [<ffffffe000201bca>] ret_from_exception+0x0/0xc
> [  313.204556] [<ffffffe000201bbc>] ret_from_syscall+0x0/0x2
> -sh: can't fork: Invalid argument

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ptrace.h |  6 ++++++
>  arch/riscv/lib/Makefile         |  2 ++
>  arch/riscv/lib/error-inject.c   | 10 ++++++++++
>  4 files changed, 19 insertions(+)
>  create mode 100644 arch/riscv/lib/error-inject.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0e9f5eb..ad73174 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -58,6 +58,7 @@ config RISCV
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_EBPF_JIT if MMU
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
> +	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
>  	select HAVE_KPROBES
>  	select HAVE_KPROBES_ON_FTRACE
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index 23372bb..cb4abb6 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -109,6 +109,12 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->a0;
>  }
>  
> +static inline void regs_set_return_value(struct pt_regs *regs,
> +					 unsigned long val)
> +{
> +	regs->a0 = val;
> +}
> +
>  extern int regs_query_register_offset(const char *name);
>  extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
>  					       unsigned int n);
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 0d0db80..04baa93 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -4,3 +4,5 @@ lib-y			+= memcpy.o
>  lib-y			+= memset.o
>  lib-y			+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o
> +
> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> diff --git a/arch/riscv/lib/error-inject.c b/arch/riscv/lib/error-inject.c
> new file mode 100644
> index 00000000..d667ade
> --- /dev/null
> +++ b/arch/riscv/lib/error-inject.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/error-injection.h>
> +#include <linux/kprobes.h>
> +
> +void override_function_with_return(struct pt_regs *regs)
> +{
> +	instruction_pointer_set(regs, regs->ra);
> +}
> +NOKPROBE_SYMBOL(override_function_with_return);
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
