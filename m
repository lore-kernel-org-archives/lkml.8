Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD720870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FU1QoAct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCEJVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:21:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cl5TTZ3yy7OBvAp365keU2TNjUwqaC7AGMkrSVJ6Tyc=; b=FU1QoActXTjg2s9/0B+FdaQx2J
        mpeRpgLiqc7NYXB29KTa6QMQXlddg4sz+3Atgyp3a6/Yo3sYIcJ8wc/xd5gsGxx2oQSDqmpUMfzDq
        oRYj5wX4onbIc6Eo4t2G75A7byiy7hlAZFED8AohwVTcP0p5NN8XGjvCbndCsbWT3Q+fNWDoRT0RH
        yiByV9IqVFL7vspTBMuLzvlHkJ8xbPrYIr3m+927griaLlZ+F88iX4xP2VapurmVSgk49DAci+4hv
        PNBdWSOsH4enoTpILVNuGHspCXRlF9JZVQtV1GtAPNVRR4gEzOkoLBOW26/eXgBQOlpdP1yxXoQuO
        uNfV/uwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9mhB-0000ID-T4; Thu, 05 Mar 2020 09:21:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FC10300606;
        Thu,  5 Mar 2020 10:19:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C258D20137FD4; Thu,  5 Mar 2020 10:21:30 +0100 (CET)
Date:   Thu, 5 Mar 2020 10:21:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] x86/optprobe: Fix OPTPROBE vs UACCESS
Message-ID: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While looking at an objtool UACCESS warning, it suddenly occurred to me
that it is entirely possible to have an OPTPROBE right in the middle of
an UACCESS region.

In this case we must of course clear FLAGS.AC while running the KPROBE.
Luckily the trampoline already saves/restores [ER]FLAGS, so all we need
to do is inject a CLAC. Unfortunately we cannot use ALTERNATIVE() in the
trampoline text, so we have to frob that manually.

Fixes: ca0bbc70f147 ("sched/x86_64: Don't save flags on context switch")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/kprobes.h |  1 +
 arch/x86/kernel/kprobes/opt.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 95b1f053bd96..073eb7ad2f56 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -36,6 +36,7 @@ typedef u8 kprobe_opcode_t;
 
 /* optinsn template addresses */
 extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_clac[];
 extern __visible kprobe_opcode_t optprobe_template_val[];
 extern __visible kprobe_opcode_t optprobe_template_call[];
 extern __visible kprobe_opcode_t optprobe_template_end[];
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f45b5c43a71..7a3416c9d0dc 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -92,6 +92,9 @@ asm (
 			/* We don't bother saving the ss register */
 			"	pushq %rsp\n"
 			"	pushfq\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
@@ -111,6 +114,9 @@ asm (
 #else /* CONFIG_X86_32 */
 			"	pushl %esp\n"
 			"	pushfl\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movl %esp, %edx\n"
 			".global optprobe_template_val\n"
@@ -134,6 +140,8 @@ asm (
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
 
+#define TMPL_CLAC_IDX \
+	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)
 #define TMPL_CALL_IDX \
@@ -389,6 +397,12 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	op->optinsn.size = ret;
 	len = TMPL_END_IDX + op->optinsn.size;
 
+	if (static_cpu_has(X86_FEATURE_SMAP)) {
+		buf[TMPL_CLAC_IDX+0] = 0x0f;
+		buf[TMPL_CLAC_IDX+1] = 0x01;
+		buf[TMPL_CLAC_IDX+2] = 0xca;
+	}
+
 	/* Set probe information */
 	synthesize_set_arg1(buf + TMPL_MOVE_IDX, (unsigned long)op);
 
