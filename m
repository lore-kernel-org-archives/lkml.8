Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6BCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD121741
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583404811;
	bh=84fa8tVyCYdxI86PnjweZAUWon1XPBQF3MHSE58uqwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QSsTKuLDCThcSZNHPqgvzs7CqraOQqiHSQK2rs+Uk7cx00TTg9RE/X1azy0UtNgZq
	 cE6bM35vEImg8ArxcjArVetTYleyei09Fvd+b7VQrCBkNLLePnGGzVEhn329zfhAaA
	 9iwslackqBQoLWvN+ZpDzqZhwfc597ljmKci5hA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCEKkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCEKkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:40:10 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73642208CD;
        Thu,  5 Mar 2020 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583404809;
        bh=84fa8tVyCYdxI86PnjweZAUWon1XPBQF3MHSE58uqwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2uCVqc4nhhiaNMRPhOPR97puYXtbJJzKihOdDhrqn/K4gYdOEb0reOaoGBvIZ9u2H
         24nEfWWxYbitOBg9H5LP+wR0bRXK09tkMHDxEt82yDCjT41Y6gwzHB8QIlu7byqmkr
         yaUHujtD94o9sH5sW8ybftHel6T/al8Vxc06ZlKU=
Date:   Thu, 5 Mar 2020 19:40:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/optprobe: Fix OPTPROBE vs UACCESS
Message-Id: <20200305194006.e3c447159aa866ac95fd02de@kernel.org>
In-Reply-To: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
References: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, 5 Mar 2020 10:21:30 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> 
> While looking at an objtool UACCESS warning, it suddenly occurred to me
> that it is entirely possible to have an OPTPROBE right in the middle of
> an UACCESS region.
> 
> In this case we must of course clear FLAGS.AC while running the KPROBE.
> Luckily the trampoline already saves/restores [ER]FLAGS, so all we need
> to do is inject a CLAC. Unfortunately we cannot use ALTERNATIVE() in the
> trampoline text, so we have to frob that manually.

Good catch! so this prevents optprobe handler to access user space
avoiding SMAP feature.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Fixes: ca0bbc70f147 ("sched/x86_64: Don't save flags on context switch")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/kprobes.h |  1 +
>  arch/x86/kernel/kprobes/opt.c  | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
> index 95b1f053bd96..073eb7ad2f56 100644
> --- a/arch/x86/include/asm/kprobes.h
> +++ b/arch/x86/include/asm/kprobes.h
> @@ -36,6 +36,7 @@ typedef u8 kprobe_opcode_t;
>  
>  /* optinsn template addresses */
>  extern __visible kprobe_opcode_t optprobe_template_entry[];
> +extern __visible kprobe_opcode_t optprobe_template_clac[];
>  extern __visible kprobe_opcode_t optprobe_template_val[];
>  extern __visible kprobe_opcode_t optprobe_template_call[];
>  extern __visible kprobe_opcode_t optprobe_template_end[];
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 3f45b5c43a71..7a3416c9d0dc 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -92,6 +92,9 @@ asm (
>  			/* We don't bother saving the ss register */
>  			"	pushq %rsp\n"
>  			"	pushfq\n"
> +			".global optprobe_template_clac\n"
> +			"optprobe_template_clac:\n"
> +			ASM_NOP3
>  			SAVE_REGS_STRING
>  			"	movq %rsp, %rsi\n"
>  			".global optprobe_template_val\n"
> @@ -111,6 +114,9 @@ asm (
>  #else /* CONFIG_X86_32 */
>  			"	pushl %esp\n"
>  			"	pushfl\n"
> +			".global optprobe_template_clac\n"
> +			"optprobe_template_clac:\n"
> +			ASM_NOP3
>  			SAVE_REGS_STRING
>  			"	movl %esp, %edx\n"
>  			".global optprobe_template_val\n"
> @@ -134,6 +140,8 @@ asm (
>  void optprobe_template_func(void);
>  STACK_FRAME_NON_STANDARD(optprobe_template_func);
>  
> +#define TMPL_CLAC_IDX \
> +	((long)optprobe_template_clac - (long)optprobe_template_entry)
>  #define TMPL_MOVE_IDX \
>  	((long)optprobe_template_val - (long)optprobe_template_entry)
>  #define TMPL_CALL_IDX \
> @@ -389,6 +397,12 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>  	op->optinsn.size = ret;
>  	len = TMPL_END_IDX + op->optinsn.size;
>  
> +	if (static_cpu_has(X86_FEATURE_SMAP)) {
> +		buf[TMPL_CLAC_IDX+0] = 0x0f;
> +		buf[TMPL_CLAC_IDX+1] = 0x01;
> +		buf[TMPL_CLAC_IDX+2] = 0xca;
> +	}
> +
>  	/* Set probe information */
>  	synthesize_set_arg1(buf + TMPL_MOVE_IDX, (unsigned long)op);
>  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
