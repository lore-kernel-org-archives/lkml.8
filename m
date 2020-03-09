Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572EE222C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3uh9M6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCIQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:42:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCIQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=056cC6UExI7EITXmRveT4fgg6/iSJZHYBvWmw0x6Cbs=; b=d3uh9M6lDEjF6yzZgsEx7WDrpV
        6zsGeYCvl16po4Gdy+PrT5bqoT5OiHQAXMSLTou4Wfqd1+tVb0zMVK5YUv8nnmmyRGWEkBo7L/PHr
        fhkq1BzUAhm75EspaMqhbqHUCMkk7a9MMNUZyynxE5KtxHHl5fb2+LWHP4RNnNxUo1FyFagSGRBMU
        3PwF/DVaF8Unr8F8mZYoQatxW81pV2NJZDJyjoE5XU2SdJWe9Ar/GpOG4CbHcjRjyUB75Ka896BZJ
        /Fyxhvti8l0H2Zahl9JmwpEKseZfUlIJBz0QVUEM4gcQiouvyYEkp4cLwDUSsGrptkG2OyuAdEf+J
        gKQbuNtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBLUP-0000ZO-E2; Mon, 09 Mar 2020 16:42:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5CFE300F7A;
        Mon,  9 Mar 2020 17:42:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6724220137FA8; Mon,  9 Mar 2020 17:42:46 +0100 (CET)
Date:   Mon, 9 Mar 2020 17:42:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/optprobe: Fix OPTPROBE vs UACCESS
Message-ID: <20200309164246.GJ12561@hirez.programming.kicks-ass.net>
References: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
 <202003060834.DBgMQaJ6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003060834.DBgMQaJ6%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:56:15AM +0800, kbuild test robot wrote:

> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/kprobes/opt.o: warning: objtool: arch_prepare_optimized_kprobe()+0x156: unreachable instruction

Duh.. I changed it so.

---
Subject: x86/optprobe: Fix OPTPROBE vs UACCESS
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 5 Mar 2020 10:21:30 +0100

While looking at an objtool UACCESS warning, it suddenly occurred to me
that it is entirely possible to have an OPTPROBE right in the middle of
an UACCESS region.

In this case we must of course clear FLAGS.AC while running the KPROBE.
Luckily the trampoline already saves/restores [ER]FLAGS, so all we need
to do is inject a CLAC. Unfortunately we cannot use ALTERNATIVE() in the
trampoline text, so we have to frob that manually.

Fixes: ca0bbc70f147 ("sched/x86_64: Don't save flags on context switch")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200305092130.GU2596@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/kprobes.h |    1 +
 arch/x86/kernel/kprobes/opt.c  |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -36,6 +36,7 @@ typedef u8 kprobe_opcode_t;
 
 /* optinsn template addresses */
 extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_clac[];
 extern __visible kprobe_opcode_t optprobe_template_val[];
 extern __visible kprobe_opcode_t optprobe_template_call[];
 extern __visible kprobe_opcode_t optprobe_template_end[];
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -72,6 +72,20 @@ unsigned long __recover_optprobed_insn(k
 	return (unsigned long)buf;
 }
 
+static void synthesize_clac(kprobe_opcode_t *addr)
+{
+	/*
+	 * Can't be static_cpu_has() due to how objtool treats this feature bit.
+	 * This isn't a fast path anyway.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SMAP))
+		return;
+
+	addr[0] = 0x0f;
+	addr[1] = 0x01;
+	addr[2] = 0xca;
+}
+
 /* Insert a move instruction which sets a pointer to eax/rdi (1st arg). */
 static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 {
@@ -93,6 +107,9 @@ asm (
 			/* We don't bother saving the ss register */
 			"	pushq %rsp\n"
 			"	pushfq\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
@@ -112,6 +129,9 @@ asm (
 #else /* CONFIG_X86_32 */
 			"	pushl %esp\n"
 			"	pushfl\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movl %esp, %edx\n"
 			".global optprobe_template_val\n"
@@ -135,6 +155,8 @@ asm (
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
 
+#define TMPL_CLAC_IDX \
+	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)
 #define TMPL_CALL_IDX \
@@ -391,6 +413,8 @@ int arch_prepare_optimized_kprobe(struct
 	op->optinsn.size = ret;
 	len = TMPL_END_IDX + op->optinsn.size;
 
+	synthesize_clac(buf + TMPL_CLAC_IDX);
+
 	/* Set probe information */
 	synthesize_set_arg1(buf + TMPL_MOVE_IDX, (unsigned long)op);
 
