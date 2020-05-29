Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D42C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA37B207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2I03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:26:29 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57601 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgE2I02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:26:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tzy5mwR_1590740784;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy5mwR_1590740784)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 16:26:24 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 1/4] x86/entry: avoid calling into sync_regs() when entering from userspace
Date:   Fri, 29 May 2020 08:26:14 +0000
Message-Id: <20200529082618.1697-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529082618.1697-1-laijs@linux.alibaba.com>
References: <87mu5roov6.fsf@nanos.tec.linutronix.de>
 <20200529082618.1697-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
made a change that when any exception happens on userspace, the
entry code will save the pt_regs on the sp0 stack, and then copy it
to the thread stack via sync_regs() and switch to thread stack
afterward.

And recent x86/entry work makes interrupt also use idtentry
and makes all the interrupt code save the pt_regs on the sp0 stack
and then copy it to the thread stack like exception.

This is hot path (page fault, ipi), such overhead should be avoided.
This patch borrows the way how original interrupt_entry handles it.
It switches to the thread stack directly right away when comes
from userspace.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 43 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 265ff97b3961..b524ff3499d0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -878,19 +878,42 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
-	testb	$3, CS+8(%rsp)
+	testb	$3, CS-ORIG_RAX+8(%rsp)
 	jz	.Lerror_kernelspace
 
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
+	/*
+	 * Switch to the thread stack. The IRET frame and orig_ax are
+	 * on the stack, as well as the return address. RDI..R12 are
+	 * not (yet) on the stack and space has not (yet) been
+	 * allocated for them.
+	 */
+	pushq	%rdx
+
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
+	movq	%rsp, %rdx
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	 /*
+	  * We have RDX, return address, and orig_ax on the stack on
+	  * top of the IRET frame. That means offset=24
+	  */
+	UNWIND_HINT_IRET_REGS base=%rdx offset=24
+
+	pushq	7*8(%rdx)		/* regs->ss */
+	pushq	6*8(%rdx)		/* regs->rsp */
+	pushq	5*8(%rdx)		/* regs->eflags */
+	pushq	4*8(%rdx)		/* regs->cs */
+	pushq	3*8(%rdx)		/* regs->ip */
+	pushq	2*8(%rdx)		/* regs->orig_ax */
+	pushq	8(%rdx)			/* return address */
+	UNWIND_HINT_FUNC
+
+	PUSH_AND_CLEAR_REGS rdx=(%rdx), save_ret=1
+	ENCODE_FRAME_POINTER 8
+	ret
 
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
@@ -914,6 +937,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
-- 
2.20.1

