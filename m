Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88FAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F62220C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594726685;
	bh=kUD21ULp1F6LxK9iRvXydVm0jMPaqgfdFZqqqqj45AA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BTEa4wN318u4TK8X4QTb40msGqlW2db8QHC0jEyaEyxGWARaQpO4vfxOQVTP0X2gr
	 risFKRYdeLVb/OKCupkbIEhqPtUWfNwwUzzdZwp5dZ/dfbKcPk8rn0jWzksilcQDMH
	 6CW6Lu7lfe0GKdAq3G5lONsAgkT9GsWTq1ZA5W+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGNLiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgGNLiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:38:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCAE22201;
        Tue, 14 Jul 2020 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726682;
        bh=kUD21ULp1F6LxK9iRvXydVm0jMPaqgfdFZqqqqj45AA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXvHMXDhFllsXLpP26SE2A0JEWT4xoE5vZovA9jiqsYSlOJ/jsakD7FwkEJ6vfzRL
         E+VNZjokxgr9tUDX/N373fRRAKOlSy35KikdpyR3rRemHs8gz1wK4zUTkM6SnudxZ1
         o7BscwhdydZ64k5EkUtIbPhZ06595wyiw4Z9scig=
Date:   Tue, 14 Jul 2020 20:37:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        oleg@redhat.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, me@packi.ch, bjorn.topel@gmail.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH v3 6/7] riscv: Add KPROBES_ON_FTRACE supported
Message-Id: <20200714203757.512ce7fb5fa61a88b1dbb2f3@kernel.org>
In-Reply-To: <1594683562-68149-7-git-send-email-guoren@kernel.org>
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
        <1594683562-68149-7-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 23:39:21 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This patch adds support for kprobes on ftrace call sites to avoids
> much of the overhead with regular kprobes. Try it with simple
> steps:
> 
> 1. Get _do_fork ftrace call site.
> Dump of assembler code for function _do_fork:
>    0xffffffe00020af64 <+0>:     addi    sp,sp,-128
>    0xffffffe00020af66 <+2>:     sd      s0,112(sp)
>    0xffffffe00020af68 <+4>:     sd      ra,120(sp)
>    0xffffffe00020af6a <+6>:     addi    s0,sp,128
>    0xffffffe00020af6c <+8>:     sd      s1,104(sp)
>    0xffffffe00020af6e <+10>:    sd      s2,96(sp)
>    0xffffffe00020af70 <+12>:    sd      s3,88(sp)
>    0xffffffe00020af72 <+14>:    sd      s4,80(sp)
>    0xffffffe00020af74 <+16>:    sd      s5,72(sp)
>    0xffffffe00020af76 <+18>:    sd      s6,64(sp)
>    0xffffffe00020af78 <+20>:    sd      s7,56(sp)
>    0xffffffe00020af7a <+22>:    mv      s4,a0
>    0xffffffe00020af7c <+24>:    mv      a0,ra
>    0xffffffe00020af7e <+26>:    nop	<<<<<<<< here!
>    0xffffffe00020af82 <+30>:    nop
>    0xffffffe00020af86 <+34>:    ld      s3,0(s4)
> 
> 2. Set _do_fork+26 as the kprobe.
>   echo 'p:myprobe _do_fork+26 dfd=%a0 filename=%a1 flags=%a2 mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
>   echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>   cat /sys/kernel/debug/tracing/trace
>   tracer: nop
> 
>   entries-in-buffer/entries-written: 3/3   #P:1
> 
>                                _-----=> irqs-off
>                               / _----=> need-resched
>                              | / _---=> hardirq/softirq
>                              || / _--=> preempt-depth
>                              ||| /     delay
>             TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>                | |       |   ||||       |         |
>               sh-87    [000] ....   551.557031: myprobe: (_do_fork+0x1a/0x2e6) dfd=0xffffffe00020af7e filename=0xffffffe00020b34e flags=0xffffffe00101e7c0 mode=0x20af86ffffffe0
> 
>   cat /sys/kernel/debug/kprobes/list
> ffffffe00020af7e  k  _do_fork+0x1a    [FTRACE]
>                                        ^^^^^^

Hmm, this seems fentry is not supported on RISC-V yet. But anyway,
it will be useful for users (if they can find the offset).

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Björn Töpel <bjorn.topel@gmail.com>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> ---
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/kernel/probes/Makefile |  1 +
>  arch/riscv/kernel/probes/ftrace.c | 52 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 arch/riscv/kernel/probes/ftrace.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a41b785..0e9f5eb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -60,6 +60,7 @@ config RISCV
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
>  	select HAVE_KPROBES
> +	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index cb62991..7f0840d 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
>  obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
> +obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> new file mode 100644
> index 00000000..e0fe58a
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/ftrace.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kprobes.h>
> +
> +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +
> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		return;
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +		instruction_pointer_set(regs, ip);
> +
> +		__this_cpu_write(current_kprobe, p);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +			/*
> +			 * Emulate singlestep (and also recover regs->pc)
> +			 * as if there is a nop
> +			 */
> +			instruction_pointer_set(regs,
> +				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> +			if (unlikely(p->post_handler)) {
> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +				p->post_handler(p, regs, 0);
> +			}
> +			instruction_pointer_set(regs, orig_ip);
> +		}
> +
> +		/*
> +		 * If pre_handler returns !0, it changes regs->pc. We have to
> +		 * skip emulating post_handler.
> +		 */
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +	p->ainsn.api.insn = NULL;
> +	return 0;
> +}
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
