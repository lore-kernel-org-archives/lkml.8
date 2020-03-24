Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1AC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C7120658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IaZhsOzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCXMWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:22:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=liMsA2MAxIlsYTDANWQvSZB0v4lKqTD5HKkCQDGIdXE=; b=IaZhsOzI0hp4eV/p5oxyRmX/3v
        SpdPFrNFMZuR2ynt8y0oItD+u0ZIfbOpzMEXemPuWkT1fJsdXeJvnIkbCT7OuanBvNlMd4Bwn2gBA
        7iu/5SOehFjKMOfQ+B7/92CgEhsYUz9SJbojKN5CDahyp1OJi2NelzV/o6pBlQMmKMl+d4Qd7cIMY
        rY6ppvuPn6SIVxsLs60WpLKqRnhkxKtSiVhNnNnbLiujiioqHYAiIhTV3nuXShk4KDbu1eVySN1va
        yKZdQFjiCJFzMAJo/2PrgtwfRhZv/EatzQcK7y1d30UixmkomuudS4lyiaZChAEytUBHNmxkXBcGI
        5d8F435Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGiZ7-0000SO-9L; Tue, 24 Mar 2020 12:21:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D5EF300606;
        Tue, 24 Mar 2020 13:21:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D2852019B522; Tue, 24 Mar 2020 13:21:50 +0100 (CET)
Date:   Tue, 24 Mar 2020 13:21:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 05/13] perf/x86: Add perf text poke events for kprobes
Message-ID: <20200324122150.GN20696@hirez.programming.kicks-ass.net>
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304090633.420-6-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:06:25AM +0200, Adrian Hunter wrote:

> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index 67315fa3956a..13bb51a7789c 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -45,6 +45,8 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern void text_poke_sync(void);
>  extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
> +extern void __text_poke_bp(void *addr, const void *opcode, size_t len,
> +			   const void *emulate, const u8 *oldptr);
>  extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
>  
>  extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 737e7a842f85..c8cfc97abc9e 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1075,6 +1075,7 @@ static int tp_vec_nr;
>   * text_poke_bp_batch() -- update instructions on live kernel on SMP
>   * @tp:			vector of instructions to patch
>   * @nr_entries:		number of entries in the vector
> + * @oldptr:		pointer to original old insn byte
>   *
>   * Modify multi-byte instruction by using int3 breakpoint on SMP.
>   * We completely avoid stop_machine() here, and achieve the
> @@ -1092,7 +1093,8 @@ static int tp_vec_nr;
>   *		  replacing opcode
>   *	- sync cores
>   */
> -static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> +static void text_poke_bp_batch(struct text_poke_loc *tp,
> +			       unsigned int nr_entries, const u8 *oldptr)
>  {
>  	struct bp_patching_desc desc = {
>  		.vec = tp,
> @@ -1117,7 +1119,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * First step: add a int3 trap to the address that will be patched.
>  	 */
>  	for (i = 0; i < nr_entries; i++) {
> -		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
> +		tp[i].old = oldptr ? *oldptr : *(u8 *)text_poke_addr(&tp[i]);
>  		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
>  	}
>  
> @@ -1274,7 +1276,7 @@ static bool tp_order_fail(void *addr)
>  static void text_poke_flush(void *addr)
>  {
>  	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
> -		text_poke_bp_batch(tp_vec, tp_vec_nr);
> +		text_poke_bp_batch(tp_vec, tp_vec_nr, NULL);
>  		tp_vec_nr = 0;
>  	}
>  }
> @@ -1299,6 +1301,20 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
>  	text_poke_loc_init(tp, addr, opcode, len, emulate);
>  }
>  
> +void __ref __text_poke_bp(void *addr, const void *opcode, size_t len,
> +			  const void *emulate, const u8 *oldptr)
> +{
> +	struct text_poke_loc tp;
> +
> +	if (unlikely(system_state == SYSTEM_BOOTING)) {
> +		text_poke_early(addr, opcode, len);
> +		return;
> +	}
> +
> +	text_poke_loc_init(&tp, addr, opcode, len, emulate);
> +	text_poke_bp_batch(&tp, 1, oldptr);
> +}
> +
>  /**
>   * text_poke_bp() -- update instructions on live kernel on SMP
>   * @addr:	address to patch
> @@ -1310,15 +1326,8 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
>   * dynamically allocated memory. This function should be used when it is
>   * not possible to allocate memory.
>   */
> -void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> +void __ref text_poke_bp(void *addr, const void *opcode, size_t len,
> +			const void *emulate)
>  {
> -	struct text_poke_loc tp;
> -
> -	if (unlikely(system_state == SYSTEM_BOOTING)) {
> -		text_poke_early(addr, opcode, len);
> -		return;
> -	}
> -
> -	text_poke_loc_init(&tp, addr, opcode, len, emulate);
> -	text_poke_bp_batch(&tp, 1);
> +	return __text_poke_bp(addr, opcode, len, emulate, NULL);
>  }

So all of that ^, is needed for this v ??


> @@ -439,7 +447,8 @@ void arch_optimize_kprobes(struct list_head *oplist)
>  		insn_buff[0] = JMP32_INSN_OPCODE;
>  		*(s32 *)(&insn_buff[1]) = rel;
>  
> -		text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
> +		__text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL,
> +			       &op->kp.opcode);
>  
>  		list_del_init(&op->list);
>  	}

That seems 'unfortunate'...

We optimize only after having already installed a regular probe, that
is, what we're actually doing here is replacing INT3 with a JMP.d32. But
the above will make it appear as if we're replacing the original text
with a JMP.d32. Which doesn't make sense, since we've already poked an
INT3 there and that poke will have had a corresponding
perf_event_text_poke(), right? (except you didn't, see below)

At this point we'll already have constructed the optprobe trampoline,
which contains however much of the original instruction (in whole) as
will be overwritten by our 5 byte JMP.d32. And IIUC, we'll have a
perf_event_text_poke() event for the whole of that already -- except I
can't find that in the patches (again, see below).

> @@ -454,9 +463,16 @@ void arch_optimize_kprobes(struct list_head *oplist)
>   */
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
> +	u8 old[POKE_MAX_OPCODE_SIZE];
> +	u8 new[POKE_MAX_OPCODE_SIZE] = { op->kp.opcode, };
> +	size_t len = INT3_INSN_SIZE + DISP32_SIZE;
> +
> +	memcpy(old, op->kp.addr, len);
>  	arch_arm_kprobe(&op->kp);
>  	text_poke(op->kp.addr + INT3_INSN_SIZE,
>  		  op->optinsn.copied_insn, DISP32_SIZE);
> +	memcpy(new + INT3_INSN_SIZE, op->optinsn.copied_insn, DISP32_SIZE);

And then this is 'wrong' too. You've not written the original
instruction, you've just written an INT3.

> +	perf_event_text_poke(op->kp.addr, old, len, new, len);
>  	text_poke_sync();
>  }


So how about something like the below, with it you'll get 6 text_poke
events:

1:  old0 -> INT3

  // kprobe active

2:  NULL -> optprobe_trampoline
3:  INT3,old1,old2,old3,old4 -> JMP32

  // optprobe active

4:  JMP32 -> INT3,old1,old2,old3,old4
5:  optprobe_trampoline -> NULL

  // kprobe active

6:  INT3 -> old0



Masami, did I get this all right?


---
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -502,12 +502,18 @@ int arch_prepare_kprobe(struct kprobe *p
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
+	u8 int3 = INT3_INSN_OPCODE;
+
+	text_poke(p->addr, &int3, 1);
 	text_poke_sync();
+	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
+	u8 int3 = INT3_INSN_OPCODE;
+
+	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
 	text_poke_sync();
 }
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -356,8 +356,14 @@ int arch_within_optimized_kprobe(struct
 static
 void __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 {
-	if (op->optinsn.insn) {
-		free_optinsn_slot(op->optinsn.insn, dirty);
+	u8 *slot = op->optinsn.insn;
+	if (slot) {
+		int len = TMPL_END_IDX + op->optinsn.size + JMP32_INSN_SIZE;
+
+		if (dirty)
+			perf_event_text_poke(slot, slot, len, NULL, 0);
+
+		free_optinsn_slot(slot, dirty);
 		op->optinsn.insn = NULL;
 		op->optinsn.size = 0;
 	}
@@ -429,7 +435,9 @@ int arch_prepare_optimized_kprobe(struct
 	len += JMP32_INSN_SIZE;
 
 	/* We have to use text_poke() for instruction buffer because it is RO */
+	perf_event_text_poke(slot, NULL, 0, buf, len);
 	text_poke(slot, buf, len);
+
 	ret = 0;
 out:
 	kfree(buf);
@@ -481,10 +489,23 @@ void arch_optimize_kprobes(struct list_h
  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	arch_arm_kprobe(&op->kp);
-	text_poke(op->kp.addr + INT3_INSN_SIZE,
-		  op->optinsn.copied_insn, DISP32_SIZE);
+	u8 new[JMP32_INSN_SIZE] = { INT3_INSN_OPCODE, };
+	u8 old[JMP32_INSN_SIZE];
+	u8 *addr = op->kp.addr;
+
+	memcpy(old, op->kp.addr, JMP32_INSN_SIZE);
+	memcpy(new + INT3_INSN_SIZE,
+	       op->optinsn.copied_insn + INT3_INSN_SIZE,
+	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
+
+	text_poke(addr, new, INT3_INSN_SIZE);
+	text_poke_sync();
+	text_poke(addr + INT3_INSN_SIZE,
+		  new + INT3_INSN_SIZE,
+		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
 	text_poke_sync();
+
+	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
 
 /*
