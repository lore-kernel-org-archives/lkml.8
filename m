Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC5C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3A721655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgEINtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:49:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgEINtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:49:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DF4ECD001CE41F9D8CA;
        Sat,  9 May 2020 21:49:14 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 21:49:09 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <mhiramat@kernel.org>, <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and kprobes_restore_local_irqflag()
Date:   Sun, 10 May 2020 05:41:57 +0800
Message-ID: <20200509214159.19680-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200509214159.19680-1-liwei391@huawei.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSTATE.I and PSTATE.D are very important for single-step working.

Without disabling interrupt on local CPU, there is a chance of
interrupt occurrence in the period of exception return and start of
out-of-line single-step, that result in wrongly single stepping
into the interrupt handler. And if D bit is set then, it results into
undefined exception and when it's handler enables dbg then single-step
exception is generated, not as expected.

As they are maintained well in kprobes_save_local_irqflag() and
kprobes_restore_local_irqflag() for kprobe module, extract them as
kernel_prepare_single_step() and kernel_cleanup_single_step() for
general use.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h |  4 ++++
 arch/arm64/kernel/debug-monitors.c      | 26 +++++++++++++++++++++++
 arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..b62469f3475b 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -113,6 +113,10 @@ void user_fastforward_single_step(struct task_struct *task);
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_prepare_single_step(unsigned long *flags,
+						struct pt_regs *regs);
+void kernel_cleanup_single_step(unsigned long flags,
+						struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..25ce6b5a52d2 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -429,6 +429,32 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+/*
+ * Interrupts need to be disabled before single-step mode is set, and not
+ * reenabled until after single-step mode ends.
+ * Without disabling interrupt on local CPU, there is a chance of
+ * interrupt occurrence in the period of exception return and  start of
+ * out-of-line single-step, that result in wrongly single stepping
+ * into the interrupt handler.
+ */
+void kernel_prepare_single_step(unsigned long *flags,
+						struct pt_regs *regs)
+{
+	*flags = regs->pstate & DAIF_MASK;
+	regs->pstate |= PSR_I_BIT;
+	/* Unmask PSTATE.D for enabling software step exceptions. */
+	regs->pstate &= ~PSR_D_BIT;
+}
+NOKPROBE_SYMBOL(kernel_prepare_single_step);
+
+void kernel_cleanup_single_step(unsigned long flags,
+						struct pt_regs *regs)
+{
+	regs->pstate &= ~DAIF_MASK;
+	regs->pstate |= flags;
+}
+NOKPROBE_SYMBOL(kernel_cleanup_single_step);
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1c95dcf1d78..c655b6b543e3 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -168,30 +168,6 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
 	__this_cpu_write(current_kprobe, p);
 }
 
-/*
- * Interrupts need to be disabled before single-step mode is set, and not
- * reenabled until after single-step mode ends.
- * Without disabling interrupt on local CPU, there is a chance of
- * interrupt occurrence in the period of exception return and  start of
- * out-of-line single-step, that result in wrongly single stepping
- * into the interrupt handler.
- */
-static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
-						struct pt_regs *regs)
-{
-	kcb->saved_irqflag = regs->pstate & DAIF_MASK;
-	regs->pstate |= PSR_I_BIT;
-	/* Unmask PSTATE.D for enabling software step exceptions. */
-	regs->pstate &= ~PSR_D_BIT;
-}
-
-static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
-						struct pt_regs *regs)
-{
-	regs->pstate &= ~DAIF_MASK;
-	regs->pstate |= kcb->saved_irqflag;
-}
-
 static void __kprobes
 set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
 {
@@ -227,7 +203,7 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		set_ss_context(kcb, slot);	/* mark pending ss */
 
 		/* IRQs and single stepping do not mix well. */
-		kprobes_save_local_irqflag(kcb, regs);
+		kernel_prepare_single_step(&kcb->saved_irqflag, regs);
 		kernel_enable_single_step(regs);
 		instruction_pointer_set(regs, slot);
 	} else {
@@ -414,7 +390,7 @@ kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
 	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
 
 	if (retval == DBG_HOOK_HANDLED) {
-		kprobes_restore_local_irqflag(kcb, regs);
+		kernel_cleanup_single_step(kcb->saved_irqflag, regs);
 		kernel_disable_single_step();
 
 		post_kprobe_handler(kcb, regs);
-- 
2.17.1

