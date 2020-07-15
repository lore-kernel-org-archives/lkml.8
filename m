Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC1C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413F42065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594845916;
	bh=gVhm0qHw2C0oU3jdc90/zh0vydyUyZwG4isb1i2FhXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Akml+7XRkgJlJTGx4ogVlqK1E8F+yAjnJrQIV8AqXROo00Y+pF05ts29e+rH7XZGk
	 /6SJrBbiMFb9FJ99AJ3G1X55npBOeYwk+FsbGaqCu60/2hbCMM/iMBFawsm77cjrmD
	 UWYes0CRRLuj2n7S9okN06QgToSbBSF232Q4hN5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGOUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgGOUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:45:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D37206F4;
        Wed, 15 Jul 2020 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594845904;
        bh=gVhm0qHw2C0oU3jdc90/zh0vydyUyZwG4isb1i2FhXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tL7O+hQTWBhARXWVboSckD7lRK5U9VcQyBFhkx1rluhuQ+DaILcqdRxoif3WtcviR
         FpyUOcwyM/uoC+hv6DIhRzATjkKSPknwLOpOt1XM/uXx8CVNxrkZknDpHqZQBQ3SIB
         FdjoQsK4qISURAaVwPQ85Fz0bj94v91hi+QP6WB8=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Date:   Wed, 15 Jul 2020 21:28:21 +0100
Message-Id: <20200715202821.12220-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715202821.12220-1-broonie@kernel.org>
References: <20200715202821.12220-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically architectures have had duplicated code in their stack trace
implementations for filtering what gets traced. In order to avoid this
duplication some generic code has been provided using a new interface
arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
factors all this out into the generic stack trace code. Convert arm64
to use this common infrastructure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/stacktrace.c | 79 ++++------------------------------
 2 files changed, 9 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d4f02b3dfe9..6ed4b6c6df95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 743cf11fbfca..a33fba048954 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -133,82 +133,19 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 NOKPROBE_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
 
-static bool save_trace(void *d, unsigned long addr)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
-	struct stack_trace_data *data = d;
-	struct stack_trace *trace = data->trace;
-
-	if (data->no_sched_functions && in_sched_functions(addr))
-		return false;
-	if (data->skip) {
-		data->skip--;
-		return false;
-	}
-
-	trace->entries[trace->nr_entries++] = addr;
-
-	return trace->nr_entries >= trace->max_entries;
-}
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	struct stack_trace_data data;
-	struct stackframe frame;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = 0;
-
-	start_backtrace(&frame, regs->regs[29], regs->pc);
-	walk_stackframe(current, &frame, save_trace, &data);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_regs);
-
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
-{
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	if (!try_get_task_stack(tsk))
-		return;
+	if (regs)
+		start_backtrace(&frame, regs->regs[29], regs->pc);
+	else
+		start_backtrace(&frame, thread_saved_fp(task),
+				thread_saved_pc(task));
 
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
-		start_backtrace(&frame, thread_saved_fp(tsk),
-				thread_saved_pc(tsk));
-	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
-		start_backtrace(&frame,
-				(unsigned long)__builtin_frame_address(0),
-				(unsigned long)__save_stack_trace);
-	}
-
-	walk_stackframe(tsk, &frame, save_trace, &data);
-
-	put_task_stack(tsk);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	__save_stack_trace(tsk, trace, 1);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	walk_stackframe(task, &frame, consume_entry, cookie);
 }
 
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
2.20.1

