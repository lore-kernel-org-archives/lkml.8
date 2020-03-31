Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5937C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698258;
	bh=gCwXrdEhX/hO4ly1kF2TlnGDjgF0BV2xail5hm3LVmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qG0bOXKbofZNmAEhJlAMbyvyOfSaq9KHOH44l3UDnOulbRDF7bMS4HNaUnYmIgutE
	 uFBQS1WjvE0jqAo8jF9izBvE/MDMeslwqwN9MLkzgJe8EOLeNScMd2OWZJDKlFZYlb
	 6KmF4m4F037gBb7ZmeiMRuK90Ad030kr42H263gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgCaXoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCaXoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:44:17 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B576820772;
        Tue, 31 Mar 2020 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698256;
        bh=gCwXrdEhX/hO4ly1kF2TlnGDjgF0BV2xail5hm3LVmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NwbLRNkSX+EIlqDE/Svu2nUrIoFFL9n9beRtkVisjsMdbK/t79PjpTHVqWzoKjfEk
         O57brYtp/5TOiQU6bGBzbYlGJexwc3OHZy/I/+JDB8zbMkKaJAAczF50bpBTkLx3Z9
         XLHyCeoQfa9F7zcufoMvspBpEQoEbV2e/Z54bT7A=
Date:   Wed, 1 Apr 2020 08:44:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 05/13] perf/x86: Add perf text poke events for
 kprobes
Message-Id: <20200401084410.b243c7fbd503cc8aebee13a9@kernel.org>
In-Reply-To: <8eb2a113-f90d-856d-8e14-509d690a2989@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
        <20200304090633.420-6-adrian.hunter@intel.com>
        <20200324122150.GN20696@hirez.programming.kicks-ass.net>
        <20200326105805.0723cd10325ad301de061743@kernel.org>
        <07415abd-5084-f16c-cc62-6c9a237951f3@intel.com>
        <8eb2a113-f90d-856d-8e14-509d690a2989@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 10:36:09 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add perf text poke events for kprobes. That includes:
> 
>  - the replaced instruction(s) which are executed out-of-line
>    i.e. arch_copy_kprobe() and arch_remove_kprobe()
> 
>  - optimised kprobe function
>    i.e. arch_prepare_optimized_kprobe() and
>       __arch_remove_optimized_kprobe()
> 
>  - optimised kprobe
>    i.e. arch_optimize_kprobes() and arch_unoptimize_kprobe()
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
> 
> 
> Changes in V5:
> 
> 	Simplify optimized kprobes events (Peter)
> 
> 
>  arch/x86/include/asm/kprobes.h |  2 ++
>  arch/x86/kernel/kprobes/core.c | 15 +++++++++++++-
>  arch/x86/kernel/kprobes/opt.c  | 38 +++++++++++++++++++++++++++++-----
>  3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
> index 95b1f053bd96..ee669cdb5709 100644
> --- a/arch/x86/include/asm/kprobes.h
> +++ b/arch/x86/include/asm/kprobes.h
> @@ -65,6 +65,8 @@ struct arch_specific_insn {
>  	 */
>  	bool boostable;
>  	bool if_modifier;
> +	/* Number of bytes of text poked */
> +	int tp_len;
>  };
>  
>  struct arch_optimized_insn {
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 579d30e91a36..8513594bfed1 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -33,6 +33,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/preempt.h>
>  #include <linux/sched/debug.h>
> +#include <linux/perf_event.h>
>  #include <linux/extable.h>
>  #include <linux/kdebug.h>
>  #include <linux/kallsyms.h>
> @@ -470,6 +471,9 @@ static int arch_copy_kprobe(struct kprobe *p)
>  	/* Also, displacement change doesn't affect the first byte */
>  	p->opcode = buf[0];
>  
> +	p->ainsn.tp_len = len;
> +	perf_event_text_poke(p->ainsn.insn, NULL, 0, buf, len);
> +
>  	/* OK, write back the instruction(s) into ROX insn buffer */
>  	text_poke(p->ainsn.insn, buf, len);
>  
> @@ -501,12 +505,18 @@ int arch_prepare_kprobe(struct kprobe *p)
>  
>  void arch_arm_kprobe(struct kprobe *p)
>  {
> -	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
> +	u8 int3 = INT3_INSN_OPCODE;
> +
> +	text_poke(p->addr, &int3, 1);
>  	text_poke_sync();
> +	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
>  }
>  
>  void arch_disarm_kprobe(struct kprobe *p)
>  {
> +	u8 int3 = INT3_INSN_OPCODE;
> +
> +	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
>  	text_poke(p->addr, &p->opcode, 1);
>  	text_poke_sync();
>  }
> @@ -514,6 +524,9 @@ void arch_disarm_kprobe(struct kprobe *p)
>  void arch_remove_kprobe(struct kprobe *p)
>  {
>  	if (p->ainsn.insn) {
> +		/* Record the perf event before freeing the slot */
> +		perf_event_text_poke(p->ainsn.insn, p->ainsn.insn,
> +				     p->ainsn.tp_len, NULL, 0);
>  		free_insn_slot(p->ainsn.insn, p->ainsn.boostable);
>  		p->ainsn.insn = NULL;
>  	}
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 3f45b5c43a71..b1072c47b595 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) Hitachi Ltd., 2012
>   */
>  #include <linux/kprobes.h>
> +#include <linux/perf_event.h>
>  #include <linux/ptrace.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
> @@ -331,8 +332,15 @@ int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>  static
>  void __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
>  {
> -	if (op->optinsn.insn) {
> -		free_optinsn_slot(op->optinsn.insn, dirty);
> +	u8 *slot = op->optinsn.insn;
> +	if (slot) {
> +		int len = TMPL_END_IDX + op->optinsn.size + JMP32_INSN_SIZE;
> +
> +		/* Record the perf event before freeing the slot */
> +		if (dirty)
> +			perf_event_text_poke(slot, slot, len, NULL, 0);
> +
> +		free_optinsn_slot(slot, dirty);
>  		op->optinsn.insn = NULL;
>  		op->optinsn.size = 0;
>  	}
> @@ -401,8 +409,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>  			   (u8 *)op->kp.addr + op->optinsn.size);
>  	len += JMP32_INSN_SIZE;
>  
> +	/*
> +	 * Note	len = TMPL_END_IDX + op->optinsn.size + JMP32_INSN_SIZE is also
> +	 * used in __arch_remove_optimized_kprobe().
> +	 */
> +
>  	/* We have to use text_poke() for instruction buffer because it is RO */
> +	perf_event_text_poke(slot, NULL, 0, buf, len);
>  	text_poke(slot, buf, len);
> +
>  	ret = 0;
>  out:
>  	kfree(buf);
> @@ -454,10 +469,23 @@ void arch_optimize_kprobes(struct list_head *oplist)
>   */
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
> -	arch_arm_kprobe(&op->kp);
> -	text_poke(op->kp.addr + INT3_INSN_SIZE,
> -		  op->optinsn.copied_insn, DISP32_SIZE);
> +	u8 new[JMP32_INSN_SIZE] = { INT3_INSN_OPCODE, };
> +	u8 old[JMP32_INSN_SIZE];
> +	u8 *addr = op->kp.addr;
> +
> +	memcpy(old, op->kp.addr, JMP32_INSN_SIZE);
> +	memcpy(new + INT3_INSN_SIZE,
> +	       op->optinsn.copied_insn,
> +	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
> +
> +	text_poke(addr, new, INT3_INSN_SIZE);
>  	text_poke_sync();
> +	text_poke(addr + INT3_INSN_SIZE,
> +		  new + INT3_INSN_SIZE,
> +		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
> +	text_poke_sync();
> +
> +	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
>  }
>  
>  /*
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
