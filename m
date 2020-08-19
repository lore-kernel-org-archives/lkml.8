Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D50206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841442;
	bh=2R5NjFBDYVtCErOgu/HmS4nfZ6UUJZq0QSSmV+zVHlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3xGSY2WEQ+ojrNPYL4VoGjrnpl4olHEh6YIxx+eZBIJ7Cj6Um1yqb6Df254Hn9UL
	 LiBtLeMkECjvr9Q68NXk3IoHlYEVDBXjhP0sjKhLb+VxC8OuDxW1pl7UsL75P6ayVy
	 U2HSNRB/9SZaY/TjSlEXFi1e6HLjiDDe1x/SAPZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHSMuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgHSMuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:50:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499A52076E;
        Wed, 19 Aug 2020 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597841410;
        bh=2R5NjFBDYVtCErOgu/HmS4nfZ6UUJZq0QSSmV+zVHlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6Q4GwdujH7YJo+xRo8v5OcNatKxrC5LNS5ZdJyUCvFZcrcR0KndpVSpwRSYAU5HB
         +5P4QTzu7+o52lC53W5IYvjqczR1/nrR3KQ+ePR0VK2idoKrgnTHerRyFUjTXcOiJ5
         zm9JTMRBKToC92/EsRl3t5AJmIANiaidqIhHZho4=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Date:   Wed, 19 Aug 2020 13:49:13 +0100
Message-Id: <20200819124913.37261-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819124913.37261-1-broonie@kernel.org>
References: <20200819124913.37261-1-broonie@kernel.org>
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
index 6d232837cbee..d1ba52e4b976 100644
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

