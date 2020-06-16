Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B9521532
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323146;
	bh=4nwhGh0JwW2X8vMqWBQ8XqkThbE4b7XZj/mOqH0gNC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mg6QKplWsEG3nyk7IF133SGfzh75tS2+0VW7hfNSpCoKnOSv2WNncO2OoGJmCdrls
	 rBI1OIoDGmqlUnnwiaNHevMY5+DbeZxFjijiRG7SMvB9nih3e1dqvYJ3nS1GdNk9Qr
	 XTx9exm4mxVVMQqN65NcH1SYvnv6kAaaqDZxAzcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgFPP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732987AbgFPP65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:58:57 -0400
Received: from localhost.localdomain (unknown [42.120.72.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B86721556;
        Tue, 16 Jun 2020 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323137;
        bh=4nwhGh0JwW2X8vMqWBQ8XqkThbE4b7XZj/mOqH0gNC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEqW0ZrDGOb8FQ9a3K5CD/GhugJaZnj88q/MLcIfLlfDpgBeFtZc2dTIzqyQW7pcH
         jKK+BkuT6zrrERJsfRGDMAusaDgUubGuWwc0q1albZ3WsmsQuDsj76ku6RwCUF4WmJ
         lv1FExtgYreRLEHt6S7CHkGYyu0wctAG0X+tgwf0=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, zong.li@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, tycho@tycho.ws, nickhu@andestech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/3] riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
Date:   Tue, 16 Jun 2020 15:57:01 +0000
Message-Id: <1592323021-98541-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592323021-98541-1-git-send-email-guoren@kernel.org>
References: <1592323021-98541-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Lockdep is needed by proving the spinlocks and rwlocks. To suupport
it, we need fixup TRACE_IRQFLAGS_SUPPORT in kernel/entry.S. This
patch follow Documentation/irqflags-tracing.txt.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig        |  3 +++
 arch/riscv/kernel/entry.S | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a31e1a4..550e0ec 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -170,6 +170,9 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT
 	default 2
 
+config LOCKDEP_SUPPORT
+	def_bool y
+
 source "arch/riscv/Kconfig.socs"
 
 menu "Platform type"
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56d071b..02c5b8e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -97,17 +97,25 @@ _save_context:
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
 	tail do_IRQ
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_on
+	REG_L s1, PT_STATUS(sp)
+#endif
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
 	 * state of SR_PIE in m/sstatus.
@@ -117,8 +125,23 @@ _save_context:
 	csrs CSR_STATUS, SR_IE
 
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+	REG_L a6, PT_A6(sp)
+	REG_L a7, PT_A7(sp)
+#endif
+	la ra, ret_from_exception
 	/* Handle syscalls */
 	li t0, EXC_SYSCALL
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	REG_L s4, PT_CAUSE(sp)
+#endif
 	beq s4, t0, handle_syscall
 
 	/* Handle other exceptions */
@@ -141,6 +164,9 @@ handle_syscall:
 	 * Advance SEPC to avoid executing the original
 	 * scall instruction on sret
 	 */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	REG_L s2, PT_EPC(sp)
+#endif
 	addi s2, s2, 0x4
 	REG_S s2, PT_EPC(sp)
 	/* Trace syscalls, but only if requested by the user. */
@@ -188,6 +214,9 @@ ret_from_syscall_rejected:
 ret_from_exception:
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_off
+#endif
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
 	li t0, SR_MPP
@@ -214,6 +243,16 @@ resume_userspace:
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

