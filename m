Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B416A207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iiUu+qSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgEZHDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731486AbgEZHDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so8272721plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4bU7vauCgcRU4qDIIQvupvXCbmtbwJO1l4oKS1vQZI=;
        b=iiUu+qSEH6wk5w9aicUQs8/SMoRnR1oZmPPdA1uyS8Tzf4MIr/HpFLjlfM+pKlHGfX
         ir9JyRhQkgbMjsCTpspebjl/TJx//ODQ3rhjv5JPqW1Kifi0lWi57wRjiLsE5jVJkgS4
         e3OV+jliJq1uWyNlv7G4I9p5eCNjNefBqWSn1ZIpcHoYe7ov0pnaP0eB4PMoK1/EMhE4
         XiaxnYqM0hDd7tXhJXH9WRQs0r1WntrP8sMCNyyv3unl8FABOAK3YVDU7+S6BhIbx+N8
         3StGCgGN3qZozeV7lK9q/Dekgw7o//52teOMiyQEeR4LMACYZwNpZbLZ/xuZRXa8L6c1
         yKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4bU7vauCgcRU4qDIIQvupvXCbmtbwJO1l4oKS1vQZI=;
        b=exdM9eRG/5iQRsy7CrQlRTUHArchKV+PXfckYY/K9Vmd4HQ1cgzPLGUV6+Fotl5+3J
         yAPDHmso3vXdpXZBy90mmVZiFVPNLx2YBLvT9WLhPm0l6X6nayQxWlfGgTbbk07YlHQ/
         wE4mkWxoguSWV7wOLk1paC+UQs6TwbGUVaoNOLBqyAEuhjgu7g2osIR0ghJeQhiMLEr0
         DIlMNrZnkGM9x87FVhr0cmvRfvejITSujRhEww4LWvy8Te9xb/ecqmrXFsDTyLCYgwGs
         fCG8Z4myIhgz5aGdaVlN8fUj3osfc4eDoBQFTHGfscC2CiWlf+Sz1WFOwjVNvifoY+/j
         Gi7A==
X-Gm-Message-State: AOAM531wIUs+hmD0KqHegaznWE0DaMJKkXH9VnV7wdvsZ5m+Hh0tO4Ii
        Cxjosn76M86fCIS/oR4VGlMgDA==
X-Google-Smtp-Source: ABdhPJzd/RofuRZa9mGzgSW1lCPPxep9t+2qu4UQZl2L43Vd4BthXtPXmZ005YprR3Udi7Q/hz2yKA==
X-Received: by 2002:a17:90b:789:: with SMTP id l9mr24363918pjz.111.1590476590620;
        Tue, 26 May 2020 00:03:10 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:10 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     Nick Knight <nick.knight@sifive.com>
Subject: [RFC PATCH v4 10/13] riscv: Add task switch support for vector
Date:   Tue, 26 May 2020 15:02:39 +0800
Message-Id: <10df8031a761f950e4989f9402d3f4856c1ca56e.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds task switch support for vector. It supports lazy
save and restore mechanism. It also supports all lengths of vlen.

[greentime.hu@sifive.com: add support for dynamic vlen, fix
__vstate_clean() and lazy save/restore bug]
[nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen and
code refine]
Signed-off-by: Nick Knight <nick.knight@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/switch_to.h | 71 +++++++++++++++++++++++++
 arch/riscv/kernel/Makefile         |  1 +
 arch/riscv/kernel/process.c        | 40 ++++++++++++++
 arch/riscv/kernel/vector.S         | 84 ++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+)
 create mode 100644 arch/riscv/kernel/vector.S

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index b9234e7178d0..a047dd75e09d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -6,10 +6,12 @@
 #ifndef _ASM_RISCV_SWITCH_TO_H
 #define _ASM_RISCV_SWITCH_TO_H
 
+#include <linux/slab.h>
 #include <linux/sched/task_stack.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -63,6 +65,73 @@ extern bool has_fpu;
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+extern bool has_vector;
+extern unsigned long riscv_vsize;
+extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
+extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
+
+static inline void __vstate_clean(struct pt_regs *regs)
+{
+	regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
+}
+
+static inline void vstate_off(struct task_struct *task,
+			      struct pt_regs *regs)
+{
+	regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
+}
+
+static inline void vstate_save(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
+		struct __riscv_v_state *vstate = &(task->thread.vstate);
+
+		/* Allocate space for vector registers. */
+		if (!vstate->datap) {
+			vstate->datap = kzalloc(riscv_vsize, GFP_KERNEL);
+			vstate->size = riscv_vsize;
+		}
+		__vstate_save(vstate, vstate->datap);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void vstate_restore(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) != SR_VS_OFF) {
+		struct __riscv_v_state *vstate = &(task->thread.vstate);
+
+		/* Allocate space for vector registers. */
+		if (!vstate->datap) {
+			vstate->datap = kzalloc(riscv_vsize, GFP_KERNEL);
+			vstate->size = riscv_vsize;
+		}
+		__vstate_restore(vstate, vstate->datap);
+		__vstate_clean(regs);
+	}
+}
+
+static inline void __switch_to_vector(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+	if (unlikely(regs->status & SR_SD))
+		vstate_save(prev, regs);
+	vstate_restore(next, task_pt_regs(next));
+}
+
+#else
+#define has_vector false
+#define vstate_save(task, regs) do { } while (0)
+#define vstate_restore(task, regs) do { } while (0)
+#define __switch_to_vector(__prev, __next) do { } while (0)
+#endif
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -72,6 +141,8 @@ do {							\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
 		__switch_to_fpu(__prev, __next);	\
+	if (has_vector)					\
+		__switch_to_vector(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 86c83081044f..dee489a1a526 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= clint.o traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_VECTOR)		+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 610c11e91606..fc8761c04e9f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -76,6 +76,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 		 */
 		fstate_restore(current, regs);
 	}
+
+	if (has_vector) {
+		regs->status |= SR_VS_INITIAL;
+		/*
+		 * Restore the initial value to the vector register
+		 * before starting the user program.
+		 */
+		vstate_restore(current, regs);
+	}
+
 	regs->epc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -92,15 +102,45 @@ void flush_thread(void)
 	fstate_off(current, task_pt_regs(current));
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
+#ifdef CONFIG_VECTOR
+	/* Reset vector state */
+	vstate_off(current, task_pt_regs(current));
+	memset(&current->thread.vstate, 0, sizeof(current->thread.vstate));
+#endif
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	fstate_save(src, task_pt_regs(src));
+	if (has_vector)
+		/* To make sure every dirty vector context is saved. */
+		vstate_save(src, task_pt_regs(src));
 	*dst = *src;
+	if (has_vector) {
+		/* Copy vector context to the forked task from parent. */
+		if ((task_pt_regs(src)->status & SR_VS) != SR_VS_OFF) {
+			unsigned long size = src->thread.vstate.size;
+
+			dst->thread.vstate.datap = kzalloc(size, GFP_KERNEL);
+			/* Failed to allocate memory. */
+			if (!dst->thread.vstate.datap)
+				return -ENOMEM;
+			/* Copy the src vector context to dst. */
+			memcpy(dst->thread.vstate.datap,
+			       src->thread.vstate.datap, size);
+		}
+	}
+
 	return 0;
 }
 
+void arch_release_task_struct(struct task_struct *tsk)
+{
+	/* Free the vector context of datap. */
+	if (has_vector)
+		kfree(tsk->thread.vstate.datap);
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	unsigned long arg, struct task_struct *p, unsigned long tls)
 {
diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
new file mode 100644
index 000000000000..91d5dd29cd0f
--- /dev/null
+++ b/arch/riscv/kernel/vector.S
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2019 Alibaba Group Holding Limited
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/asm-offsets.h>
+
+#define vstatep  a0
+#define datap    a1
+#define x_vstart t0
+#define x_vtype  t1
+#define x_vl     t2
+#define x_vcsr   t3
+#define incr     t4
+#define m_one    t5
+#define status   t6
+
+ENTRY(__vstate_save)
+	li      status, SR_VS
+	csrs    sstatus, status
+
+	csrr    x_vstart, CSR_VSTART
+	csrr    x_vtype, CSR_VTYPE
+	csrr    x_vl, CSR_VL
+	csrr    x_vcsr, CSR_VCSR
+	li      m_one, -1
+	vsetvli incr, m_one, e8, m8
+	vse.v   v0, (datap)
+	add     datap, datap, incr
+	vse.v   v8, (datap)
+	add     datap, datap, incr
+	vse.v   v16, (datap)
+	add     datap, datap, incr
+	vse.v   v24, (datap)
+
+	REG_S   x_vstart, RISCV_V_STATE_VSTART(vstatep)
+	REG_S   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
+	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
+	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
+
+	csrc	sstatus, status
+	ret
+ENDPROC(__vstate_save)
+
+ENTRY(__vstate_restore)
+	li      status, SR_VS
+	csrs    sstatus, status
+
+	li      m_one, -1
+	vsetvli incr, m_one, e8, m8
+	vle.v   v0, (datap)
+	add     datap, datap, incr
+	vle.v   v8, (datap)
+	add     datap, datap, incr
+	vle.v   v16, (datap)
+	add     datap, datap, incr
+	vle.v   v24, (datap)
+
+	REG_L   x_vstart, RISCV_V_STATE_VSTART(vstatep)
+	REG_L   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
+	REG_L   x_vl, RISCV_V_STATE_VL(vstatep)
+	REG_L   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
+	vsetvl  x0, x_vl, x_vtype
+	csrw    CSR_VSTART, x_vstart
+	csrw    CSR_VCSR, x_vcsr
+
+	csrc	sstatus, status
+	ret
+ENDPROC(__vstate_restore)
-- 
2.26.2

