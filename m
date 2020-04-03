Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C79C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B93208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888949;
	bh=kdfhPt1CbHjppk8R6NDcWaq3J3k6dCA/OPa1du6g/1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffFCVGjO98YDGyFNtIhr9JDCZ79+9oqa6g4aBHNf6d/KRij3jjq2rAc5yYUPKdCg1
	 DFfN0Xx6rqka16UjSZY25B/meXeNhDQkDCYDDglwjyLNsMvxZXMjE4pPIIWd1UAfT9
	 9KGDdozrlZgvVNJJPK5CJHn6xOZjhTBfoDDSqRy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgDCEm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbgDCEmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:24 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE6520CC7;
        Fri,  3 Apr 2020 04:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888941;
        bh=kdfhPt1CbHjppk8R6NDcWaq3J3k6dCA/OPa1du6g/1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU9j5s//Qfb3eIghbFm69c+a7j6J+W1/1FaBkfr0327bk1gc1ps64En1oeip091Pc
         yvHz6yyzn/dALpqtJVypp+PYWluWysZJenl35ulgnix+dZckbq6PpD4ZS1rsgTjtp/
         5go1GsJQRJixGaXXuLKBWw6zY9dVdGHQ9NUJeINI=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 09/11] csky: Add kprobes supported
Date:   Fri,  3 Apr 2020 12:41:48 +0800
Message-Id: <20200403044150.20562-9-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch enable kprobes, kretprobes, ftrace interface. It utilized
software breakpoint and single step debug exceptions, instructions
simulation on csky.

We use USR_BKPT replace origin instruction, and the kprobe handler
prepares an excutable memory slot for out-of-line execution with a
copy of the original instruction being probed. Most of instructions
could be executed by single-step, but some instructions need origin
pc value to execute and we need software simulate these instructions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/Kconfig                            |   3 +
 arch/csky/include/asm/Kbuild                 |   1 -
 arch/csky/include/asm/kprobes.h              |  48 ++
 arch/csky/include/asm/probes.h               |  24 +
 arch/csky/include/asm/ptrace.h               |   2 +
 arch/csky/kernel/Makefile                    |   1 +
 arch/csky/kernel/probes/Makefile             |   6 +
 arch/csky/kernel/probes/decode-insn.c        |  49 ++
 arch/csky/kernel/probes/decode-insn.h        |  20 +
 arch/csky/kernel/probes/ftrace.c             |  66 +++
 arch/csky/kernel/probes/kprobes.c            | 499 +++++++++++++++++++
 arch/csky/kernel/probes/kprobes_trampoline.S |  19 +
 arch/csky/kernel/probes/simulate-insn.c      | 398 +++++++++++++++
 arch/csky/kernel/probes/simulate-insn.h      |  49 ++
 arch/csky/kernel/traps.c                     |  10 +-
 arch/csky/mm/fault.c                         |   4 +
 16 files changed, 1197 insertions(+), 2 deletions(-)
 create mode 100644 arch/csky/include/asm/kprobes.h
 create mode 100644 arch/csky/include/asm/probes.h
 create mode 100644 arch/csky/kernel/probes/Makefile
 create mode 100644 arch/csky/kernel/probes/decode-insn.c
 create mode 100644 arch/csky/kernel/probes/decode-insn.h
 create mode 100644 arch/csky/kernel/probes/ftrace.c
 create mode 100644 arch/csky/kernel/probes/kprobes.c
 create mode 100644 arch/csky/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/csky/kernel/probes/simulate-insn.c
 create mode 100644 arch/csky/kernel/probes/simulate-insn.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 998188f44fd7..f76c333758ca 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -46,6 +46,9 @@ config CSKY
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
+	select HAVE_KPROBES if !CPU_CK610
+	select HAVE_KPROBES_ON_FTRACE if !CPU_CK610
+	select HAVE_KRETPROBES if !CPU_CK610
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 4130e3eaa766..59d3186578fd 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kprobes.h
 generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
diff --git a/arch/csky/include/asm/kprobes.h b/arch/csky/include/asm/kprobes.h
new file mode 100644
index 000000000000..b647bbde4d6d
--- /dev/null
+++ b/arch/csky/include/asm/kprobes.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_CSKY_KPROBES_H
+#define __ASM_CSKY_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+
+#ifdef CONFIG_KPROBES
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/percpu.h>
+
+#define __ARCH_WANT_KPROBES_INSN_SLOT
+#define MAX_INSN_SIZE			1
+
+#define flush_insn_slot(p)		do { } while (0)
+#define kretprobe_blacklist_size	0
+
+#include <asm/probes.h>
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+};
+
+/* Single step context for kprobe */
+struct kprobe_step_ctx {
+	unsigned long ss_pending;
+	unsigned long match_addr;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	unsigned long saved_sr;
+	struct prev_kprobe prev_kprobe;
+	struct kprobe_step_ctx ss_ctx;
+};
+
+void arch_remove_kprobe(struct kprobe *p);
+int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
+int kprobe_breakpoint_handler(struct pt_regs *regs);
+int kprobe_single_step_handler(struct pt_regs *regs);
+void kretprobe_trampoline(void);
+void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
+
+#endif /* CONFIG_KPROBES */
+#endif /* __ASM_CSKY_KPROBES_H */
diff --git a/arch/csky/include/asm/probes.h b/arch/csky/include/asm/probes.h
new file mode 100644
index 000000000000..5e526334e6f9
--- /dev/null
+++ b/arch/csky/include/asm/probes.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_PROBES_H
+#define __ASM_CSKY_PROBES_H
+
+typedef u32 probe_opcode_t;
+typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
+
+/* architecture specific copy of original instruction */
+struct arch_probe_insn {
+	probe_opcode_t *insn;
+	probes_handler_t *handler;
+	/* restore address after simulation */
+	unsigned long restore;
+};
+
+#ifdef CONFIG_KPROBES
+typedef u32 kprobe_opcode_t;
+struct arch_specific_insn {
+	struct arch_probe_insn api;
+};
+#endif
+
+#endif /* __ASM_CSKY_PROBES_H */
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index f16ca256e007..aae5aa96cf54 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -13,6 +13,8 @@
 
 #define PS_S	0x80000000 /* Supervisor Mode */
 
+#define USR_BKPT	0x1464
+
 #define arch_has_single_step() (1)
 #define current_pt_regs() \
 ({ (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1; })
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 071d659f37b7..fd6d9dc8b7f3 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -4,6 +4,7 @@ extra-y := head.o vmlinux.lds
 obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o
 obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o dumpstack.o
+obj-y += probes/
 
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_SMP)			+= smp.o
diff --git a/arch/csky/kernel/probes/Makefile b/arch/csky/kernel/probes/Makefile
new file mode 100644
index 000000000000..3a857d081958
--- /dev/null
+++ b/arch/csky/kernel/probes/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
+
+CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/probes/decode-insn.c b/arch/csky/kernel/probes/decode-insn.c
new file mode 100644
index 000000000000..bbc4edc25dc9
--- /dev/null
+++ b/arch/csky/kernel/probes/decode-insn.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <asm/sections.h>
+
+#include "decode-insn.h"
+#include "simulate-insn.h"
+
+/* Return:
+ *   INSN_REJECTED     If instruction is one not allowed to kprobe,
+ *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
+ */
+enum probe_insn __kprobes
+csky_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
+{
+	probe_opcode_t insn = le32_to_cpu(*addr);
+
+	CSKY_INSN_SET_SIMULATE(br16,		insn);
+	CSKY_INSN_SET_SIMULATE(bt16,		insn);
+	CSKY_INSN_SET_SIMULATE(bf16,		insn);
+	CSKY_INSN_SET_SIMULATE(jmp16,		insn);
+	CSKY_INSN_SET_SIMULATE(jsr16,		insn);
+	CSKY_INSN_SET_SIMULATE(lrw16,		insn);
+	CSKY_INSN_SET_SIMULATE(pop16,		insn);
+
+	CSKY_INSN_SET_SIMULATE(br32,		insn);
+	CSKY_INSN_SET_SIMULATE(bt32,		insn);
+	CSKY_INSN_SET_SIMULATE(bf32,		insn);
+	CSKY_INSN_SET_SIMULATE(jmp32,		insn);
+	CSKY_INSN_SET_SIMULATE(jsr32,		insn);
+	CSKY_INSN_SET_SIMULATE(lrw32,		insn);
+	CSKY_INSN_SET_SIMULATE(pop32,		insn);
+
+	CSKY_INSN_SET_SIMULATE(bez32,		insn);
+	CSKY_INSN_SET_SIMULATE(bnez32,		insn);
+	CSKY_INSN_SET_SIMULATE(bnezad32,	insn);
+	CSKY_INSN_SET_SIMULATE(bhsz32,		insn);
+	CSKY_INSN_SET_SIMULATE(bhz32,		insn);
+	CSKY_INSN_SET_SIMULATE(blsz32,		insn);
+	CSKY_INSN_SET_SIMULATE(blz32,		insn);
+	CSKY_INSN_SET_SIMULATE(bsr32,		insn);
+	CSKY_INSN_SET_SIMULATE(jmpi32,		insn);
+	CSKY_INSN_SET_SIMULATE(jsri32,		insn);
+
+	return INSN_GOOD;
+}
diff --git a/arch/csky/kernel/probes/decode-insn.h b/arch/csky/kernel/probes/decode-insn.h
new file mode 100644
index 000000000000..9c4ad48fee0d
--- /dev/null
+++ b/arch/csky/kernel/probes/decode-insn.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __CSKY_KERNEL_KPROBES_DECODE_INSN_H
+#define __CSKY_KERNEL_KPROBES_DECODE_INSN_H
+
+#include <asm/sections.h>
+#include <asm/kprobes.h>
+
+enum probe_insn {
+	INSN_REJECTED,
+	INSN_GOOD_NO_SLOT,
+	INSN_GOOD,
+};
+
+#define is_insn32(insn) ((insn & 0xc000) == 0xc000)
+
+enum probe_insn __kprobes
+csky_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
+
+#endif /* __CSKY_KERNEL_KPROBES_DECODE_INSN_H */
diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
new file mode 100644
index 000000000000..5264763d05be
--- /dev/null
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kprobes.h>
+
+int arch_check_ftrace_location(struct kprobe *p)
+{
+	if (ftrace_location((unsigned long)p->addr))
+		p->flags |= KPROBE_FLAG_FTRACE;
+	return 0;
+}
+
+/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	bool lr_saver = false;
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	/* Preempt is disabled by ftrace */
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (!p) {
+		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
+		if (unlikely(!p) || kprobe_disabled(p))
+			return;
+		lr_saver = true;
+	}
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip = instruction_pointer(regs);
+
+		if (lr_saver)
+			ip -= MCOUNT_INSN_SIZE;
+		instruction_pointer_set(regs, ip);
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->pc)
+			 * as if there is a nop
+			 */
+			instruction_pointer_set(regs,
+				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			instruction_pointer_set(regs, orig_ip);
+		}
+		/*
+		 * If pre_handler returns !0, it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn = NULL;
+	return 0;
+}
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
new file mode 100644
index 000000000000..f0f733b7ac5a
--- /dev/null
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/kprobes.h>
+#include <linux/extable.h>
+#include <linux/slab.h>
+#include <linux/stop_machine.h>
+#include <asm/ptrace.h>
+#include <linux/uaccess.h>
+#include <asm/sections.h>
+#include <asm/cacheflush.h>
+
+#include "decode-insn.h"
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+static void __kprobes
+post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
+
+struct csky_insn_patch {
+	kprobe_opcode_t	*addr;
+	u32		opcode;
+	atomic_t	cpu_count;
+};
+
+static int __kprobes patch_text_cb(void *priv)
+{
+	struct csky_insn_patch *param = priv;
+	unsigned int addr = (unsigned int)param->addr;
+
+	if (atomic_inc_return(&param->cpu_count) == 1) {
+		*(u16 *) addr = cpu_to_le16(param->opcode);
+		dcache_wb_range(addr, addr + 2);
+		atomic_inc(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+	}
+
+	icache_inv_range(addr, addr + 2);
+
+	return 0;
+}
+
+static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
+{
+	struct csky_insn_patch param = { addr, opcode, ATOMIC_INIT(0) };
+
+	return stop_machine_cpuslocked(patch_text_cb, &param, cpu_online_mask);
+}
+
+static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
+{
+	unsigned long offset = is_insn32(p->opcode) ? 4 : 2;
+
+	p->ainsn.api.restore = (unsigned long)p->addr + offset;
+
+	patch_text(p->ainsn.api.insn, p->opcode);
+}
+
+static void __kprobes arch_prepare_simulate(struct kprobe *p)
+{
+	p->ainsn.api.restore = 0;
+}
+
+static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (p->ainsn.api.handler)
+		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
+
+	post_kprobe_handler(kcb, regs);
+}
+
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
+{
+	unsigned long probe_addr = (unsigned long)p->addr;
+
+	if (probe_addr & 0x1) {
+		pr_warn("Address not aligned.\n");
+		return -EINVAL;
+	}
+
+	/* copy instruction */
+	p->opcode = le32_to_cpu(*p->addr);
+
+	/* decode instruction */
+	switch (csky_probe_decode_insn(p->addr, &p->ainsn.api)) {
+	case INSN_REJECTED:	/* insn not supported */
+		return -EINVAL;
+
+	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
+		p->ainsn.api.insn = NULL;
+		break;
+
+	case INSN_GOOD:	/* instruction uses slot */
+		p->ainsn.api.insn = get_insn_slot();
+		if (!p->ainsn.api.insn)
+			return -ENOMEM;
+		break;
+	}
+
+	/* prepare the instruction */
+	if (p->ainsn.api.insn)
+		arch_prepare_ss_slot(p);
+	else
+		arch_prepare_simulate(p);
+
+	return 0;
+}
+
+/* install breakpoint in text */
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	patch_text(p->addr, USR_BKPT);
+}
+
+/* remove breakpoint from text */
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
+{
+	patch_text(p->addr, p->opcode);
+}
+
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+}
+
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+}
+
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+}
+
+static void __kprobes set_current_kprobe(struct kprobe *p)
+{
+	__this_cpu_write(current_kprobe, p);
+}
+
+/*
+ * Interrupts need to be disabled before single-step mode is set, and not
+ * reenabled until after single-step mode ends.
+ * Without disabling interrupt on local CPU, there is a chance of
+ * interrupt occurrence in the period of exception return and  start of
+ * out-of-line single-step, that result in wrongly single stepping
+ * into the interrupt handler.
+ */
+static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
+						struct pt_regs *regs)
+{
+	kcb->saved_sr = regs->sr;
+	regs->sr &= ~BIT(6);
+}
+
+static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
+						struct pt_regs *regs)
+{
+	regs->sr = kcb->saved_sr;
+}
+
+static void __kprobes
+set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct kprobe *p)
+{
+	unsigned long offset = is_insn32(p->opcode) ? 4 : 2;
+
+	kcb->ss_ctx.ss_pending = true;
+	kcb->ss_ctx.match_addr = addr + offset;
+}
+
+static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
+{
+	kcb->ss_ctx.ss_pending = false;
+	kcb->ss_ctx.match_addr = 0;
+}
+
+#define TRACE_MODE_SI		BIT(14)
+#define TRACE_MODE_MASK		~(0x3 << 14)
+#define TRACE_MODE_RUN		0
+
+static void __kprobes setup_singlestep(struct kprobe *p,
+				       struct pt_regs *regs,
+				       struct kprobe_ctlblk *kcb, int reenter)
+{
+	unsigned long slot;
+
+	if (reenter) {
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p);
+		kcb->kprobe_status = KPROBE_REENTER;
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+	}
+
+	if (p->ainsn.api.insn) {
+		/* prepare for single stepping */
+		slot = (unsigned long)p->ainsn.api.insn;
+
+		set_ss_context(kcb, slot, p);	/* mark pending ss */
+
+		/* IRQs and single stepping do not mix well. */
+		kprobes_save_local_irqflag(kcb, regs);
+		regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_SI;
+		instruction_pointer_set(regs, slot);
+	} else {
+		/* insn simulation */
+		arch_simulate_insn(p, regs);
+	}
+}
+
+static int __kprobes reenter_kprobe(struct kprobe *p,
+				    struct pt_regs *regs,
+				    struct kprobe_ctlblk *kcb)
+{
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SSDONE:
+	case KPROBE_HIT_ACTIVE:
+		kprobes_inc_nmissed_count(p);
+		setup_singlestep(p, regs, kcb, 1);
+		break;
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		pr_warn("Unrecoverable kprobe detected.\n");
+		dump_kprobe(p);
+		BUG();
+		break;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+
+	return 1;
+}
+
+static void __kprobes
+post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+
+	if (!cur)
+		return;
+
+	/* return addr restore if non-branching insn */
+	if (cur->ainsn.api.restore != 0)
+		regs->pc = cur->ainsn.api.restore;
+
+	/* restore back original saved kprobe variables and continue */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		return;
+	}
+
+	/* call post handler */
+	kcb->kprobe_status = KPROBE_HIT_SSDONE;
+	if (cur->post_handler)	{
+		/* post_handler can hit breakpoint and single step
+		 * again, so we enable D-flag for recursive exception.
+		 */
+		cur->post_handler(cur, regs, 0);
+	}
+
+	reset_current_kprobe();
+}
+
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the ip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->pc = (unsigned long) cur->addr;
+		if (!instruction_pointer(regs))
+			BUG();
+
+		if (kcb->kprobe_status == KPROBE_REENTER)
+			restore_previous_kprobe(kcb);
+		else
+			reset_current_kprobe();
+
+		break;
+	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SSDONE:
+		/*
+		 * We increment the nmissed count for accounting,
+		 * we can also use npre/npostfault count for accounting
+		 * these specific fault cases.
+		 */
+		kprobes_inc_nmissed_count(cur);
+
+		/*
+		 * We come here because instructions in the pre/post
+		 * handler caused the page_fault, this could happen
+		 * if handler tries to access user space by
+		 * copy_from_user(), get_user() etc. Let the
+		 * user-specified handler try to fix it first.
+		 */
+		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+			return 1;
+
+		/*
+		 * In case the user-specified fault handler returned
+		 * zero, try to fix up.
+		 */
+		if (fixup_exception(regs))
+			return 1;
+	}
+	return 0;
+}
+
+int __kprobes
+kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	struct kprobe *p, *cur_kprobe;
+	struct kprobe_ctlblk *kcb;
+	unsigned long addr = instruction_pointer(regs);
+
+	kcb = get_kprobe_ctlblk();
+	cur_kprobe = kprobe_running();
+
+	p = get_kprobe((kprobe_opcode_t *) addr);
+
+	if (p) {
+		if (cur_kprobe) {
+			if (reenter_kprobe(p, regs, kcb))
+				return 1;
+		} else {
+			/* Probe hit */
+			set_current_kprobe(p);
+			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+			/*
+			 * If we have no pre-handler or it returned 0, we
+			 * continue with normal processing.  If we have a
+			 * pre-handler and it returned non-zero, it will
+			 * modify the execution path and no need to single
+			 * stepping. Let's just reset current kprobe and exit.
+			 *
+			 * pre_handler can hit a breakpoint and can step thru
+			 * before return.
+			 */
+			if (!p->pre_handler || !p->pre_handler(p, regs))
+				setup_singlestep(p, regs, kcb, 0);
+			else
+				reset_current_kprobe();
+		}
+		return 1;
+	}
+
+	/*
+	 * The breakpoint instruction was removed right
+	 * after we hit it.  Another cpu has removed
+	 * either a probepoint or a debugger breakpoint
+	 * at this address.  In either case, no further
+	 * handling of this interrupt is appropriate.
+	 * Return back to original instruction, and continue.
+	 */
+	return 0;
+}
+
+int __kprobes
+kprobe_single_step_handler(struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if ((kcb->ss_ctx.ss_pending)
+	    && (kcb->ss_ctx.match_addr == instruction_pointer(regs))) {
+		clear_ss_context(kcb);	/* clear pending ss */
+
+		kprobes_restore_local_irqflag(kcb, regs);
+		regs->sr = (regs->sr & TRACE_MODE_MASK) | TRACE_MODE_RUN;
+
+		post_kprobe_handler(kcb, regs);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
+ * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
+ */
+int __init arch_populate_kprobe_blacklist(void)
+{
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					(unsigned long)__irqentry_text_end);
+	return ret;
+}
+
+void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head, empty_rp;
+	struct hlist_node *tmp;
+	unsigned long flags, orig_ret_address = 0;
+	unsigned long trampoline_address =
+		(unsigned long)&kretprobe_trampoline;
+	kprobe_opcode_t *correct_ret_addr = NULL;
+
+	INIT_HLIST_HEAD(&empty_rp);
+	kretprobe_hash_lock(current, &head, &flags);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because multiple functions in the call path have
+	 * return probes installed on them, and/or more than one
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always pushed into the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *	 function, the (chronologically) first instance's ret_addr
+	 *	 will be the real return address, and all the rest will
+	 *	 point to kretprobe_trampoline.
+	 */
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+
+	correct_ret_addr = ri->ret_addr;
+	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (ri->rp && ri->rp->handler) {
+			__this_cpu_write(current_kprobe, &ri->rp->kp);
+			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
+			ri->ret_addr = correct_ret_addr;
+			ri->rp->handler(ri, regs);
+			__this_cpu_write(current_kprobe, NULL);
+		}
+
+		recycle_rp_inst(ri, &empty_rp);
+
+		if (orig_ret_address != trampoline_address)
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+	}
+
+	kretprobe_hash_unlock(current, &flags);
+
+	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
+		hlist_del(&ri->hlist);
+		kfree(ri);
+	}
+	return (void *)orig_ret_address;
+}
+
+void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
+				      struct pt_regs *regs)
+{
+	ri->ret_addr = (kprobe_opcode_t *)regs->lr;
+	regs->lr = (unsigned long) &kretprobe_trampoline;
+}
+
+int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+{
+	return 0;
+}
+
+int __init arch_init_kprobes(void)
+{
+	return 0;
+}
diff --git a/arch/csky/kernel/probes/kprobes_trampoline.S b/arch/csky/kernel/probes/kprobes_trampoline.S
new file mode 100644
index 000000000000..b1fe3af24f03
--- /dev/null
+++ b/arch/csky/kernel/probes/kprobes_trampoline.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <linux/linkage.h>
+
+#include <abi/entry.h>
+
+ENTRY(kretprobe_trampoline)
+	SAVE_REGS_FTRACE
+
+	mov	a0, sp /* pt_regs */
+
+	jbsr	trampoline_probe_handler
+
+	/* use the result as the return-address */
+	mov	lr, a0
+
+	RESTORE_REGS_FTRACE
+	rts
+ENDPROC(kretprobe_trampoline)
diff --git a/arch/csky/kernel/probes/simulate-insn.c b/arch/csky/kernel/probes/simulate-insn.c
new file mode 100644
index 000000000000..4e464fed52ec
--- /dev/null
+++ b/arch/csky/kernel/probes/simulate-insn.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+
+#include "decode-insn.h"
+#include "simulate-insn.h"
+
+static inline bool csky_insn_reg_get_val(struct pt_regs *regs,
+					 unsigned long index,
+					 unsigned long *ptr)
+{
+	if (index < 14)
+		*ptr = *(&regs->a0 + index);
+
+	if (index > 15 && index < 31)
+		*ptr = *(&regs->exregs[0] + index - 16);
+
+	switch (index) {
+	case 14:
+		*ptr = regs->usp;
+		break;
+	case 15:
+		*ptr = regs->lr;
+		break;
+	case 31:
+		*ptr = regs->tls;
+		break;
+	default:
+		goto fail;
+	}
+
+	return true;
+fail:
+	return false;
+}
+
+static inline bool csky_insn_reg_set_val(struct pt_regs *regs,
+					 unsigned long index,
+					 unsigned long val)
+{
+	if (index < 14)
+		*(&regs->a0 + index) = val;
+
+	if (index > 15 && index < 31)
+		*(&regs->exregs[0] + index - 16) = val;
+
+	switch (index) {
+	case 14:
+		regs->usp = val;
+		break;
+	case 15:
+		regs->lr = val;
+		break;
+	case 31:
+		regs->tls = val;
+		break;
+	default:
+		goto fail;
+	}
+
+	return true;
+fail:
+	return false;
+}
+
+void __kprobes
+simulate_br16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	instruction_pointer_set(regs,
+		addr + sign_extend32((opcode & 0x3ff) << 1, 9));
+}
+
+void __kprobes
+simulate_br32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	instruction_pointer_set(regs,
+		addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+}
+
+void __kprobes
+simulate_bt16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	if (regs->sr & 1)
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0x3ff) << 1, 9));
+	else
+		instruction_pointer_set(regs, addr + 2);
+}
+
+void __kprobes
+simulate_bt32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	if (regs->sr & 1)
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	else
+		instruction_pointer_set(regs, addr + 4);
+}
+
+void __kprobes
+simulate_bf16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	if (!(regs->sr & 1))
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0x3ff) << 1, 9));
+	else
+		instruction_pointer_set(regs, addr + 2);
+}
+
+void __kprobes
+simulate_bf32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	if (!(regs->sr & 1))
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	else
+		instruction_pointer_set(regs, addr + 4);
+}
+
+void __kprobes
+simulate_jmp16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = (opcode >> 2) & 0xf;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	instruction_pointer_set(regs, tmp & 0xfffffffe);
+}
+
+void __kprobes
+simulate_jmp32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	instruction_pointer_set(regs, tmp & 0xfffffffe);
+}
+
+void __kprobes
+simulate_jsr16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = (opcode >> 2) & 0xf;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	regs->lr = addr + 2;
+
+	instruction_pointer_set(regs, tmp & 0xfffffffe);
+}
+
+void __kprobes
+simulate_jsr32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	regs->lr = addr + 4;
+
+	instruction_pointer_set(regs, tmp & 0xfffffffe);
+}
+
+void __kprobes
+simulate_lrw16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long val;
+	unsigned long tmp = (opcode & 0x300) >> 3;
+	unsigned long offset = ((opcode & 0x1f) | tmp) << 2;
+
+	tmp = (opcode & 0xe0) >> 5;
+
+	val = *(unsigned int *)(instruction_pointer(regs) + offset);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_lrw32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long val;
+	unsigned long offset = (opcode & 0xffff0000) >> 14;
+	unsigned long tmp = opcode & 0x0000001f;
+
+	val = *(unsigned int *)
+		((instruction_pointer(regs) + offset) & 0xfffffffc);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_pop16(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long *tmp = (unsigned long *)regs->usp;
+	int i;
+
+	for (i = 0; i < (opcode & 0xf); i++) {
+		csky_insn_reg_set_val(regs, i + 4, *tmp);
+		tmp += 1;
+	}
+
+	if (opcode & 0x10) {
+		csky_insn_reg_set_val(regs, 15, *tmp);
+		tmp += 1;
+	}
+
+	regs->usp = (unsigned long)tmp;
+
+	instruction_pointer_set(regs, regs->lr);
+}
+
+void __kprobes
+simulate_pop32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long *tmp = (unsigned long *)regs->usp;
+	int i;
+
+	for (i = 0; i < ((opcode & 0xf0000) >> 16); i++) {
+		csky_insn_reg_set_val(regs, i + 4, *tmp);
+		tmp += 1;
+	}
+
+	if (opcode & 0x100000) {
+		csky_insn_reg_set_val(regs, 15, *tmp);
+		tmp += 1;
+	}
+
+	for (i = 0; i < ((opcode & 0xe00000) >> 21); i++) {
+		csky_insn_reg_set_val(regs, i + 16, *tmp);
+		tmp += 1;
+	}
+
+	if (opcode & 0x1000000) {
+		csky_insn_reg_set_val(regs, 29, *tmp);
+		tmp += 1;
+	}
+
+	regs->usp = (unsigned long)tmp;
+
+	instruction_pointer_set(regs, regs->lr);
+}
+
+void __kprobes
+simulate_bez32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	if (tmp == 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+}
+
+void __kprobes
+simulate_bnez32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+
+	csky_insn_reg_get_val(regs, tmp, &tmp);
+
+	if (tmp != 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+}
+
+void __kprobes
+simulate_bnezad32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+	unsigned long val;
+
+	csky_insn_reg_get_val(regs, tmp, &val);
+
+	val -= 1;
+
+	if (val > 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_bhsz32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+	unsigned long val;
+
+	csky_insn_reg_get_val(regs, tmp, &val);
+
+	if (val >= 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_bhz32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+	unsigned long val;
+
+	csky_insn_reg_get_val(regs, tmp, &val);
+
+	if (val > 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_blsz32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+	unsigned long val;
+
+	csky_insn_reg_get_val(regs, tmp, &val);
+
+	if (val <= 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_blz32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp = opcode & 0x1f;
+	unsigned long val;
+
+	csky_insn_reg_get_val(regs, tmp, &val);
+
+	if (val < 0) {
+		instruction_pointer_set(regs,
+			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
+	} else
+		instruction_pointer_set(regs, addr + 4);
+
+	csky_insn_reg_set_val(regs, tmp, val);
+}
+
+void __kprobes
+simulate_bsr32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long tmp;
+
+	tmp = (opcode & 0xffff) << 16;
+	tmp |= (opcode & 0xffff0000) >> 16;
+
+	instruction_pointer_set(regs,
+		addr + sign_extend32((tmp & 0x3ffffff) << 1, 15));
+
+	regs->lr = addr + 4;
+}
+
+void __kprobes
+simulate_jmpi32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long val;
+	unsigned long offset = ((opcode & 0xffff0000) >> 14);
+
+	val = *(unsigned int *)
+		((instruction_pointer(regs) + offset) & 0xfffffffc);
+
+	instruction_pointer_set(regs, val);
+}
+
+void __kprobes
+simulate_jsri32(u32 opcode, long addr, struct pt_regs *regs)
+{
+	unsigned long val;
+	unsigned long offset = ((opcode & 0xffff0000) >> 14);
+
+	val = *(unsigned int *)
+		((instruction_pointer(regs) + offset) & 0xfffffffc);
+
+	regs->lr = addr + 4;
+
+	instruction_pointer_set(regs, val);
+}
diff --git a/arch/csky/kernel/probes/simulate-insn.h b/arch/csky/kernel/probes/simulate-insn.h
new file mode 100644
index 000000000000..ba4cb7ef062e
--- /dev/null
+++ b/arch/csky/kernel/probes/simulate-insn.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __CSKY_KERNEL_PROBES_SIMULATE_INSN_H
+#define __CSKY_KERNEL_PROBES_SIMULATE_INSN_H
+
+#define __CSKY_INSN_FUNCS(name, mask, val)				\
+static __always_inline bool csky_insn_is_##name(probe_opcode_t code)	\
+{									\
+	BUILD_BUG_ON(~(mask) & (val));					\
+	return (code & (mask)) == (val);				\
+}									\
+void simulate_##name(u32 opcode, long addr, struct pt_regs *regs);
+
+#define CSKY_INSN_SET_SIMULATE(name, code)				\
+	do {								\
+		if (csky_insn_is_##name(code)) {			\
+			api->handler = simulate_##name;			\
+			return INSN_GOOD_NO_SLOT;			\
+		}							\
+	} while (0)
+
+__CSKY_INSN_FUNCS(br16,		0xfc00, 0x0400)
+__CSKY_INSN_FUNCS(bt16,		0xfc00, 0x0800)
+__CSKY_INSN_FUNCS(bf16,		0xfc00, 0x0c00)
+__CSKY_INSN_FUNCS(jmp16,	0xffc3, 0x7800)
+__CSKY_INSN_FUNCS(jsr16,	0xffc3, 0x7801)
+__CSKY_INSN_FUNCS(lrw16,	0xfc00, 0x1000)
+__CSKY_INSN_FUNCS(pop16,	0xffe0, 0x1480)
+
+__CSKY_INSN_FUNCS(br32,		0x0000ffff, 0x0000e800)
+__CSKY_INSN_FUNCS(bt32,		0x0000ffff, 0x0000e860)
+__CSKY_INSN_FUNCS(bf32,		0x0000ffff, 0x0000e840)
+__CSKY_INSN_FUNCS(jmp32,	0xffffffe0, 0x0000e8c0)
+__CSKY_INSN_FUNCS(jsr32,	0xffffffe0, 0x0000e8e0)
+__CSKY_INSN_FUNCS(lrw32,	0x0000ffe0, 0x0000ea80)
+__CSKY_INSN_FUNCS(pop32,	0xfe00ffff, 0x0000ebc0)
+
+__CSKY_INSN_FUNCS(bez32,	0x0000ffe0, 0x0000e900)
+__CSKY_INSN_FUNCS(bnez32,	0x0000ffe0, 0x0000e920)
+__CSKY_INSN_FUNCS(bnezad32,	0x0000ffe0, 0x0000e820)
+__CSKY_INSN_FUNCS(bhsz32,	0x0000ffe0, 0x0000e9a0)
+__CSKY_INSN_FUNCS(bhz32,	0x0000ffe0, 0x0000e940)
+__CSKY_INSN_FUNCS(blsz32,	0x0000ffe0, 0x0000e960)
+__CSKY_INSN_FUNCS(blz32,	0x0000ffe0, 0x0000e980)
+__CSKY_INSN_FUNCS(bsr32,	0x0000fc00, 0x0000e000)
+__CSKY_INSN_FUNCS(jmpi32,	0x0000ffff, 0x0000eac0)
+__CSKY_INSN_FUNCS(jsri32,	0x0000ffff, 0x0000eae0)
+
+#endif /* __CSKY_KERNEL_PROBES_SIMULATE_INSN_H */
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index 63715cb90ee9..c6a40806977f 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -14,6 +14,7 @@
 #include <linux/kallsyms.h>
 #include <linux/rtc.h>
 #include <linux/uaccess.h>
+#include <linux/kprobes.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -109,7 +110,6 @@ void buserr(struct pt_regs *regs)
 	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc);
 }
 
-#define USR_BKPT 0x1464
 asmlinkage void trap_c(struct pt_regs *regs)
 {
 	int sig;
@@ -126,11 +126,19 @@ asmlinkage void trap_c(struct pt_regs *regs)
 		break;
 	/* ptrace */
 	case VEC_TRACE:
+#ifdef CONFIG_KPROBES
+		if (kprobe_single_step_handler(regs))
+			return;
+#endif
 		info.si_code = TRAP_TRACE;
 		sig = SIGTRAP;
 		break;
 	case VEC_ILLEGAL:
 		tsk->thread.trap_no = vector;
+#ifdef CONFIG_KPROBES
+		if (kprobe_breakpoint_handler(regs))
+			return;
+#endif
 		die_if_kernel("Kernel mode ILLEGAL", regs, vector);
 #ifndef CONFIG_CPU_NO_USER_BKPT
 		if (*(uint16_t *)instruction_pointer(regs) != USR_BKPT)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 562c7f708749..d3c61b83e195 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
+#include <linux/kprobes.h>
 
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
@@ -53,6 +54,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	int fault;
 	unsigned long address = mmu_meh & PAGE_MASK;
 
+	if (kprobe_page_fault(regs, tsk->thread.trap_no))
+		return;
+
 	si_code = SEGV_MAPERR;
 
 #ifndef CONFIG_CPU_HAS_TLBI
-- 
2.17.0

