Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D4E2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgB1PcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:32:04 -0500
Received: from foss.arm.com ([217.140.110.172]:40166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgB1PcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:32:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B788E31B;
        Fri, 28 Feb 2020 07:32:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15DAD3F73B;
        Fri, 28 Feb 2020 07:32:00 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:31:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Message-ID: <20200228153158.GH36089@lakrids.cambridge.arm.com>
References: <20191225172625.69811b3e@xhacker.debian>
 <20191225173001.6c0e3fb2@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225173001.6c0e3fb2@xhacker.debian>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has been on my list to review for a while. Given Masami's comments,
I was waiting for a new version -- is there any plan to respin this?

Otherwise, I have some comments below.

On Wed, Dec 25, 2019 at 09:44:21AM +0000, Jisheng Zhang wrote:
> KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> eliminates the need for a trap, as well as the need to emulate or
> single-step instructions.

Where does this overhead matter?

> Tested on berlin arm64 platform.
> 
> ~ # mount -t debugfs debugfs /sys/kernel/debug/
> ~ # cd /sys/kernel/debug/
> /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> 
> before the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> 
> after the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009ff54  k  _do_fork+0x0    [DISABLED][FTRACE]

Just to check, how is the kprobe addresss expected to relate to the
function address? For any of {mcount, mfentry, patchable-function-entry}
there are some number of instructions prior to the call instruction.
Does the user have to provide that address? 

How does this work on other architectures?

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/include/asm/ftrace.h               |  1 +
>  arch/arm64/kernel/probes/Makefile             |  1 +
>  arch/arm64/kernel/probes/ftrace.c             | 78 +++++++++++++++++++
>  5 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> 
> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> index 4fae0464ddff..f9dd9dd91e0c 100644
> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |         c6x: | TODO |
>      |        csky: | TODO |
>      |       h8300: | TODO |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1b4476ddb83..92b9882889ac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -166,6 +166,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> +	select HAVE_KPROBES_ON_FTRACE

The rest of the code seems to presume FTRACE_WITH_REGS, but you haven't
made that dependency explicit here.

>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 91fa4baa1a93..875aeb839654 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -20,6 +20,7 @@
>  
>  /* The BL at the callsite's adjusted rec->ip */
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE

I'm confused by what exactly this is meant to represent. At runtime our
rec->ip is always the BL, so what exactly is this attempting to account
for?

How does this work when using mcount rather than
patchable-function-entry?

>  
>  #define FTRACE_PLT_IDX		0
>  #define FTRACE_REGS_PLT_IDX	1
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index 8e4be92e25b1..4020cfc66564 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>  				   simulate-insn.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>  				   simulate-insn.o
> +obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
> diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> new file mode 100644
> index 000000000000..0643aa2dacdb
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/ftrace.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Dynamic Ftrace based Kprobes Optimization
> + *
> + * Copyright (C) Hitachi Ltd., 2012
> + * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
> + *		      Synaptics Incorporated
> + */
> +
> +#include <linux/kprobes.h>
> +
> +/*
> + * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instructions:
> + * the lr saver and bl ftrace-entry. Both these instructions are claimed
> + * by ftrace and we should allow probing on either instruction.
> + */
> +int arch_check_ftrace_location(struct kprobe *p)
> +{
> +	if (ftrace_location((unsigned long)p->addr))
> +		p->flags |= KPROBE_FLAG_FTRACE;
> +	return 0;
> +}

What about when not using patchable-function-entry?

Why do we need to allow probing both?

> +
> +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	bool lr_saver = false;
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +
> +	/* Preempt is disabled by ftrace */
> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (!p) {
> +		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
> +		if (unlikely(!p) || kprobe_disabled(p))
> +			return;
> +		lr_saver = true;
> +	}

This complexity worries me. Is it really necessary to allow kprobing on
either instruction?

> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +
> +		if (lr_saver)
> +			ip -= MCOUNT_INSN_SIZE;
> +		instruction_pointer_set(regs, ip);
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

If you're going to mess with the PC then you also need to adjust the
hardware single-step state machine.

Thanks,
Mark.

> +		}
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
> 2.24.1
> 
