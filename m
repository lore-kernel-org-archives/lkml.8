Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0401C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B525720B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888959;
	bh=s0UQPMKJq3+XFTaEAnL15Z0UFEnuaZrJl5aGoqcNctY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+IF+iFctmwK+QHVqxfhJCi9wNAx5HJ4shGp7SxAr4lM3Tib/4lvsktDJKBiSVBGu
	 FFMyGzlLp3tSVwXtdg88D5PW716v/1GU0Od5TdHm8E3VQP9PePKpcLqbxhqerwoku0
	 tjKIGaRbcSfgDEhtyYJ9In3Y2g63e+pdOmf0iZ8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbgDCEmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732382AbgDCEmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:13 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B79E208E4;
        Fri,  3 Apr 2020 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888932;
        bh=s0UQPMKJq3+XFTaEAnL15Z0UFEnuaZrJl5aGoqcNctY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBAnJxYL0Q+YZYzwZM07dykPpVWiA9tMoR90wy5dPhm2Uale00sJgLwoba0v1OAAm
         J3heT8p8OqqvJD7w/CKXehh+n/ZJfV99pZvv8WLIPRI+aI2gz7sljj4x21Avd07tCi
         Z1+rjYYB1TRhXTzRCP9S6pWpaNCZxFcGJcyWafPU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 04/11] csky: Implement ftrace with regs
Date:   Fri,  3 Apr 2020 12:41:43 +0800
Message-Id: <20200403044150.20562-4-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch implements FTRACE_WITH_REGS for csky, which allows a traced
function's arguments (and some other registers) to be captured into a
struct pt_regs, allowing these to be inspected and/or modified.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig               |  1 +
 arch/csky/abiv2/inc/abi/entry.h | 60 +++++++++++++++++++++++++++++++++
 arch/csky/abiv2/mcount.S        | 48 ++++++++++++++++++++++++++
 arch/csky/include/asm/ftrace.h  |  2 ++
 arch/csky/kernel/asm-offsets.c  |  1 +
 arch/csky/kernel/ftrace.c       | 11 ++++++
 6 files changed, 123 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 0e9b14367fa8..6cf169a15794 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -38,6 +38,7 @@ config CSKY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 94a7a58765df..6a404393d0f4 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -100,6 +100,66 @@
 	rte
 .endm
 
+.macro SAVE_REGS_FTRACE
+	subi    sp, 152
+	stw	tls, (sp, 0)
+	stw	lr, (sp, 4)
+
+	mfcr	lr, psr
+	stw	lr, (sp, 12)
+
+	addi    lr, sp, 152
+	stw	lr, (sp, 16)
+
+	stw     a0, (sp, 20)
+	stw     a0, (sp, 24)
+	stw     a1, (sp, 28)
+	stw     a2, (sp, 32)
+	stw     a3, (sp, 36)
+
+	addi	sp, 40
+	stm	r4-r13, (sp)
+
+	addi    sp, 40
+	stm     r16-r30, (sp)
+#ifdef CONFIG_CPU_HAS_HILO
+	mfhi	lr
+	stw	lr, (sp, 60)
+	mflo	lr
+	stw	lr, (sp, 64)
+	mfcr	lr, cr14
+	stw	lr, (sp, 68)
+#endif
+	subi	sp, 80
+.endm
+
+.macro	RESTORE_REGS_FTRACE
+	ldw	tls, (sp, 0)
+	ldw	a0, (sp, 16)
+	mtcr	a0, ss0
+
+#ifdef CONFIG_CPU_HAS_HILO
+	ldw	a0, (sp, 140)
+	mthi	a0
+	ldw	a0, (sp, 144)
+	mtlo	a0
+	ldw	a0, (sp, 148)
+	mtcr	a0, cr14
+#endif
+
+	ldw     a0, (sp, 24)
+	ldw     a1, (sp, 28)
+	ldw     a2, (sp, 32)
+	ldw     a3, (sp, 36)
+
+	addi	sp, 40
+	ldm	r4-r13, (sp)
+	addi    sp, 40
+	ldm     r16-r30, (sp)
+	addi    sp, 72
+	mfcr	sp, ss0
+.endm
+
 .macro SAVE_SWITCH_STACK
 	subi    sp, 64
 	stm	r4-r11, (sp)
diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 326402e65f9e..9331c7ed5958 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -3,6 +3,8 @@
 
 #include <linux/linkage.h>
 #include <asm/ftrace.h>
+#include <abi/entry.h>
+#include <asm/asm-offsets.h>
 
 /*
  * csky-gcc with -pg will put the following asm after prologue:
@@ -44,6 +46,22 @@
 	jmp	t1
 .endm
 
+.macro mcount_enter_regs
+	subi	sp, 8
+	stw	lr, (sp, 0)
+	stw	r8, (sp, 4)
+	SAVE_REGS_FTRACE
+.endm
+
+.macro mcount_exit_regs
+	RESTORE_REGS_FTRACE
+	ldw	t1, (sp, 0)
+	ldw	r8, (sp, 4)
+	ldw	lr, (sp, 8)
+	addi	sp, 12
+	jmp	t1
+.endm
+
 .macro save_return_regs
 	subi	sp, 16
 	stw	a0, (sp, 0)
@@ -122,6 +140,8 @@ ENTRY(ftrace_caller)
 	ldw	a0, (sp, 16)
 	subi	a0, 4
 	ldw	a1, (sp, 24)
+	lrw	a2, function_trace_op
+	ldw	a2, (a2, 0)
 
 	nop
 GLOBAL(ftrace_call)
@@ -157,3 +177,31 @@ ENTRY(return_to_handler)
 	jmp	lr
 END(return_to_handler)
 #endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+ENTRY(ftrace_regs_caller)
+	mcount_enter_regs
+
+	lrw	t1, PT_FRAME_SIZE
+	add	t1, sp
+
+	ldw	a0, (t1, 0)
+	subi	a0, 4
+	ldw	a1, (t1, 8)
+	lrw	a2, function_trace_op
+	ldw	a2, (a2, 0)
+	mov	a3, sp
+
+	nop
+GLOBAL(ftrace_regs_call)
+	nop32_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	nop
+GLOBAL(ftrace_graph_regs_call)
+	nop32_stub
+#endif
+
+	mcount_exit_regs
+ENDPROC(ftrace_regs_caller)
+#endif /* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index ba35d93ecda2..fae72b0b1374 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -10,6 +10,8 @@
 
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+
 #define MCOUNT_ADDR	((unsigned long)_mcount)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 9b48b1b1a61b..f8be348df9e4 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -72,6 +72,7 @@ int main(void)
 	DEFINE(PT_RLO,            offsetof(struct pt_regs, rlo));
 #endif
 	DEFINE(PT_USP,            offsetof(struct pt_regs, usp));
+	DEFINE(PT_FRAME_SIZE,     sizeof(struct pt_regs));
 
 	/* offsets into the irq_cpustat_t struct */
 	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t,
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index 44f4880179b7..b4502cd2eabe 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -126,6 +126,9 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	int ret = ftrace_modify_code((unsigned long)&ftrace_call,
 				(unsigned long)func, true, true);
+	if (!ret)
+		ret = ftrace_modify_code((unsigned long)&ftrace_regs_call,
+				(unsigned long)func, true, true);
 	return ret;
 }
 
@@ -135,6 +138,14 @@ int __init ftrace_dyn_arch_init(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		       unsigned long addr)
+{
+	return ftrace_modify_code(rec->ip, addr, true, true);
+}
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
-- 
2.17.0

