Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D7C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D820787
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCTM6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35575 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCTM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDu-0003hk-P5; Fri, 20 Mar 2020 13:58:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5DB991C22BF;
        Fri, 20 Mar 2020 13:58:02 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:02 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/optprobe: Fix OPTPROBE vs UACCESS
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
References: <20200305092130.GU2596@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158470908209.28353.9034754166916134439.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d8a738689794c42c3844284b99ddf165d10a724e
Gitweb:        https://git.kernel.org/tip/d8a738689794c42c3844284b99ddf165d10a724e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Mar 2020 10:21:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:22 +01:00

x86/optprobe: Fix OPTPROBE vs UACCESS

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
 arch/x86/include/asm/kprobes.h |  1 +
 arch/x86/kernel/kprobes/opt.c  | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 95b1f05..073eb7a 100644
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
index 3f45b5c..ea13f68 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -71,6 +71,21 @@ found:
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
+	/* Replace the NOP3 with CLAC */
+	addr[0] = 0x0f;
+	addr[1] = 0x01;
+	addr[2] = 0xca;
+}
+
 /* Insert a move instruction which sets a pointer to eax/rdi (1st arg). */
 static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 {
@@ -92,6 +107,9 @@ asm (
 			/* We don't bother saving the ss register */
 			"	pushq %rsp\n"
 			"	pushfq\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
@@ -111,6 +129,9 @@ asm (
 #else /* CONFIG_X86_32 */
 			"	pushl %esp\n"
 			"	pushfl\n"
+			".global optprobe_template_clac\n"
+			"optprobe_template_clac:\n"
+			ASM_NOP3
 			SAVE_REGS_STRING
 			"	movl %esp, %edx\n"
 			".global optprobe_template_val\n"
@@ -134,6 +155,8 @@ asm (
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
 
+#define TMPL_CLAC_IDX \
+	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)
 #define TMPL_CALL_IDX \
@@ -389,6 +412,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	op->optinsn.size = ret;
 	len = TMPL_END_IDX + op->optinsn.size;
 
+	synthesize_clac(buf + TMPL_CLAC_IDX);
+
 	/* Set probe information */
 	synthesize_set_arg1(buf + TMPL_MOVE_IDX, (unsigned long)op);
 
