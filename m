Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8772C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C763F2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593266310;
	bh=IWnZVZFkP2osi1vJUSnyhYIHj1OQga5bCNzMBDr1xHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q6L8xnn2rC3m0U/2Pos/xupBO2OqYWHgvhyqBFdZbVi2xaLzPURlNXJiz4PDeNAXT
	 WKgWSopXvmMVF53peslrrKcnhB7splowLz86qPoqpcvlcFFCt+j6Tfn4LjS4oWANbS
	 dozAIYpKlsp0erlq+vqmJnoD5BXwpVCUYskwNU+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgF0N62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgF0N6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:58:25 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B5421707;
        Sat, 27 Jun 2020 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593266304;
        bh=IWnZVZFkP2osi1vJUSnyhYIHj1OQga5bCNzMBDr1xHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLKMu16Z74LgpMSKnH2oMSg25TX2zeB4DVr3S/jJCyz7ByG4MEHzfIW3WU6ytk09X
         FfZR9JoAkJ6g981qLceTuj9MDewy4ZWu5GVSwkXbWI9zNcjvpjMboo2KAhuSXRhHWX
         Mnt0o80odJgEe+Y7DeRcQV/6zY/cXRvA/CSf54ew=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 3/3] riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
Date:   Sat, 27 Jun 2020 13:57:08 +0000
Message-Id: <1593266228-61125-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593266228-61125-1-git-send-email-guoren@kernel.org>
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Lockdep is needed by proving the spinlocks and rwlocks. To suupport
it, we need fixup TRACE_IRQFLAGS_SUPPORT in kernel/entry.S. This
patch follow Documentation/irqflags-tracing.txt.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig        |  3 +++
 arch/riscv/kernel/entry.S | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 58d6f66..d5d5100 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -179,6 +179,9 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT
 	default 2
 
+config LOCKDEP_SUPPORT
+	def_bool y
+
 source "arch/riscv/Kconfig.socs"
 
 menu "Platform type"
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index cae7e6d..45c81e4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -97,19 +97,26 @@ _save_context:
 	la gp, __global_pointer$
 .option pop
 
-	la ra, ret_from_exception
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_off
+#endif
 	/*
 	 * MSB of cause differentiates between
 	 * interrupts and exceptions
 	 */
 	bge s4, zero, 1f
 
+	la ra, ret_from_exception
+
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
 	la a1, handle_arch_irq
 	REG_L a1, (a1)
 	jr a1
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_on
+#endif
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
 	 * state of SR_PIE in m/sstatus.
@@ -119,6 +126,7 @@ _save_context:
 	csrs CSR_STATUS, SR_IE
 
 1:
+	la ra, ret_from_exception
 	/* Handle syscalls */
 	li t0, EXC_SYSCALL
 	beq s4, t0, handle_syscall
@@ -137,6 +145,17 @@ _save_context:
 	tail do_trap_unknown
 
 handle_syscall:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Recover a0 - a7 for system calls */
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+	REG_L a6, PT_A6(sp)
+	REG_L a7, PT_A7(sp)
+#endif
 	 /* save the initial A0 value (needed in signal handlers) */
 	REG_S a0, PT_ORIG_A0(sp)
 	/*
@@ -190,6 +209,9 @@ ret_from_syscall_rejected:
 ret_from_exception:
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_off
+#endif
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
 	li t0, SR_MPP
@@ -216,6 +238,16 @@ resume_userspace:
 	csrw CSR_SCRATCH, tp
 
 restore_all:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	REG_L s1, PT_STATUS(sp)
+	andi t0, s1, SR_PIE
+	beqz t0, 1f
+	call trace_hardirqs_on
+	j 2f
+1:
+	call trace_hardirqs_off
+2:
+#endif
 	REG_L a0, PT_STATUS(sp)
 	/*
 	 * The current load reservation is effectively part of the processor's
-- 
2.7.4

