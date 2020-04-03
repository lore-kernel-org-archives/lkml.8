Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9532D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888950;
	bh=eDMGsS8rCCafqR0Hvq3T985K4ful1PBILGdwRvtShD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2iWQcsefU6IRSdp4ss+vUWckl98c7kOKTBRS3HnehoL6Hz54QQWKsr+GXUZGZsOuk
	 UXUuN/W9jf2AVFMpGK1JeOgF31b4D0NNSJge1z0wGWTH7uFlIB+86qZ7DKQNhgKN89
	 sddOV5J8r4QQI28GRjOxMYXi6KF2rHYXnfA/Vb2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgDCEm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733014AbgDCEmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:24 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C60206F8;
        Fri,  3 Apr 2020 04:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888943;
        bh=eDMGsS8rCCafqR0Hvq3T985K4ful1PBILGdwRvtShD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yR/Xn1GJ92kv6mN8GJux0575VaW2rR3asB8dBe0lrRdFWqxMolDET0bG6R06oAs02
         t/HeHwLPCKpBHL4agekKXwjr1e+bDnWbSB3iXuyWeMizaJ76zbiWUcMBD3K+NtITgx
         a5dHoPzQ5spVuS5UqDxigrwOwlUs8w5dAY+1hSgI=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 10/11] csky: Add uprobes support
Date:   Fri,  3 Apr 2020 12:41:49 +0800
Message-Id: <20200403044150.20562-10-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds support for uprobes on csky architecture.

Just like kprobe, it support single-step and simulate instructions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/Kconfig                   |   3 +
 arch/csky/include/asm/thread_info.h |   2 +
 arch/csky/include/asm/uprobes.h     |  33 ++++++
 arch/csky/kernel/entry.S            |   2 +-
 arch/csky/kernel/probes/Makefile    |   1 +
 arch/csky/kernel/probes/uprobes.c   | 150 ++++++++++++++++++++++++++++
 arch/csky/kernel/signal.c           |   3 +
 arch/csky/kernel/traps.c            |   8 ++
 8 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 arch/csky/include/asm/uprobes.h
 create mode 100644 arch/csky/kernel/probes/uprobes.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index f76c333758ca..94545d50d40f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -75,6 +75,9 @@ config CSKY
 config LOCKDEP_SUPPORT
 	def_bool y
 
+config ARCH_SUPPORTS_UPROBES
+	def_bool y if !CPU_CK610
+
 config CPU_HAS_CACHEV2
 	bool
 
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 0b546a55a8bf..442fedad0260 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -57,6 +57,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_TRACE	3	/* syscall trace active */
 #define TIF_SYSCALL_TRACEPOINT	4       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing */
+#define TIF_UPROBE		6	/* uprobe breakpoint or singlestep */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
@@ -68,6 +69,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
diff --git a/arch/csky/include/asm/uprobes.h b/arch/csky/include/asm/uprobes.h
new file mode 100644
index 000000000000..600388eb93c6
--- /dev/null
+++ b/arch/csky/include/asm/uprobes.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_CSKY_UPROBES_H
+#define __ASM_CSKY_UPROBES_H
+
+#include <asm/probes.h>
+
+#define MAX_UINSN_BYTES		4
+
+#define UPROBE_SWBP_INSN	USR_BKPT
+#define UPROBE_SWBP_INSN_SIZE	2
+#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+
+typedef u32 uprobe_opcode_t;
+
+struct arch_uprobe_task {
+	unsigned long   saved_trap_no;
+};
+
+struct arch_uprobe {
+	union {
+		u8 insn[MAX_UINSN_BYTES];
+		u8 ixol[MAX_UINSN_BYTES];
+	};
+	struct arch_probe_insn api;
+	unsigned long insn_size;
+	bool simulate;
+};
+
+int uprobe_breakpoint_handler(struct pt_regs *regs);
+int uprobe_single_step_handler(struct pt_regs *regs);
+
+#endif /* __ASM_CSKY_UPROBES_H */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 8b040a1b11d0..364819536f2e 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -221,7 +221,7 @@ ret_from_exception:
 	andn	r9, r10
 
 	ldw	r12, (r9, TINFO_FLAGS)
-	andi	r12, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED)
+	andi	r12, (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | _TIF_UPROBE)
 	cmpnei	r12, 0
 	bt	exit_work
 1:
diff --git a/arch/csky/kernel/probes/Makefile b/arch/csky/kernel/probes/Makefile
index 3a857d081958..1c7c6e6cb25b 100644
--- a/arch/csky/kernel/probes/Makefile
+++ b/arch/csky/kernel/probes/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
+obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
new file mode 100644
index 000000000000..b3a56c260e3e
--- /dev/null
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
+ */
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/uprobes.h>
+#include <asm/cacheflush.h>
+
+#include "decode-insn.h"
+
+#define UPROBE_TRAP_NR	UINT_MAX
+
+unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
+{
+	return instruction_pointer(regs);
+}
+
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
+		unsigned long addr)
+{
+	probe_opcode_t insn;
+
+	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+
+	auprobe->insn_size = is_insn32(insn) ? 4 : 2;
+
+	switch (csky_probe_decode_insn(&insn, &auprobe->api)) {
+	case INSN_REJECTED:
+		return -EINVAL;
+
+	case INSN_GOOD_NO_SLOT:
+		auprobe->simulate = true;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	utask->autask.saved_trap_no = current->thread.trap_no;
+	current->thread.trap_no = UPROBE_TRAP_NR;
+
+	instruction_pointer_set(regs, utask->xol_vaddr);
+
+	user_enable_single_step(current);
+
+	return 0;
+}
+
+int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	WARN_ON_ONCE(current->thread.trap_no != UPROBE_TRAP_NR);
+
+	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
+
+	user_disable_single_step(current);
+
+	return 0;
+}
+
+bool arch_uprobe_xol_was_trapped(struct task_struct *t)
+{
+	if (t->thread.trap_no != UPROBE_TRAP_NR)
+		return true;
+
+	return false;
+}
+
+bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	probe_opcode_t insn;
+	unsigned long addr;
+
+	if (!auprobe->simulate)
+		return false;
+
+	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	addr = instruction_pointer(regs);
+
+	if (auprobe->api.handler)
+		auprobe->api.handler(insn, addr, regs);
+
+	return true;
+}
+
+void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	/*
+	 * Task has received a fatal signal, so reset back to probbed
+	 * address.
+	 */
+	instruction_pointer_set(regs, utask->vaddr);
+
+	user_disable_single_step(current);
+}
+
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+		struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return regs->usp <= ret->stack;
+	else
+		return regs->usp < ret->stack;
+}
+
+unsigned long
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
+				  struct pt_regs *regs)
+{
+	unsigned long ra;
+
+	ra = regs->lr;
+
+	regs->lr = trampoline_vaddr;
+
+	return ra;
+}
+
+int arch_uprobe_exception_notify(struct notifier_block *self,
+				 unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
+int uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	if (uprobe_pre_sstep_notifier(regs))
+		return 1;
+
+	return 0;
+}
+
+int uprobe_single_step_handler(struct pt_regs *regs)
+{
+	if (uprobe_post_sstep_notifier(regs))
+		return 1;
+
+	return 0;
+}
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 3d6b728cbb72..9452d6570b7e 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -253,6 +253,9 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 	unsigned long thread_info_flags)
 {
+	if (thread_info_flags & _TIF_UPROBE)
+		uprobe_notify_resume(regs);
+
 	/* Handle pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index c6a40806977f..fcc3a69831ad 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -129,6 +129,10 @@ asmlinkage void trap_c(struct pt_regs *regs)
 #ifdef CONFIG_KPROBES
 		if (kprobe_single_step_handler(regs))
 			return;
+#endif
+#ifdef CONFIG_UPROBES
+		if (uprobe_single_step_handler(regs))
+			return;
 #endif
 		info.si_code = TRAP_TRACE;
 		sig = SIGTRAP;
@@ -138,6 +142,10 @@ asmlinkage void trap_c(struct pt_regs *regs)
 #ifdef CONFIG_KPROBES
 		if (kprobe_breakpoint_handler(regs))
 			return;
+#endif
+#ifdef CONFIG_UPROBES
+		if (uprobe_breakpoint_handler(regs))
+			return;
 #endif
 		die_if_kernel("Kernel mode ILLEGAL", regs, vector);
 #ifndef CONFIG_CPU_NO_USER_BKPT
-- 
2.17.0

