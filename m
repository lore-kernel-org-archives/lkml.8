Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26106207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgE0HbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:17 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40204 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgE0HbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TznFciK_1590564672;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TznFciK_1590564672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:12 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/5] x86/entry: introduce macro idtentry_swapgs_and_switch_to_kernel_stack
Date:   Wed, 27 May 2020 07:31:03 +0000
Message-Id: <20200527073107.2127-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527073107.2127-1-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a portion of code to be a macro, and it will also be used in
next patch.

Just move around the code, no functionality changed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d983a0d4bc73..5e983506f82e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -698,28 +698,22 @@ SYM_CODE_END(\asmsym)
 #include <asm/idtentry.h>
 
 /*
- * Interrupt entry helper function.
+ * IDT entry helper macro for entering from userspace.
  *
  * Entry runs with interrupts off. Stack layout at entry:
- * +----------------------------------------------------+
- * | regs->ss						|
- * | regs->rsp						|
- * | regs->eflags					|
- * | regs->cs						|
- * | regs->ip						|
- * +----------------------------------------------------+
- * | regs->orig_ax = ~(interrupt number)		|
- * +----------------------------------------------------+
- * | return address					|
- * +----------------------------------------------------+
+ * +--------------------+
+ * | regs->ss		|
+ * | regs->rsp		|
+ * | regs->eflags	|
+ * | regs->cs		|
+ * | regs->ip		|
+ * | regs->orig_ax	|
+ * | return address	|
+ * +--------------------+
+ * The macro does swapgs and switches to current kernel stack with the
+ * same stack layout copied.
  */
-SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_IRET_REGS offset=16
-	ASM_CLAC
-	cld
-
-	testb	$3, CS-ORIG_RAX+8(%rsp)
-	jz	1f
+.macro idtentry_swapgs_and_switch_to_kernel_stack
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
 	/*
@@ -751,6 +745,34 @@ SYM_CODE_START(interrupt_entry)
 	pushq	8(%rdi)			/* return address */
 
 	movq	(%rdi), %rdi
+.endm
+
+/*
+ * Interrupt entry helper function.
+ *
+ * Entry runs with interrupts off. Stack layout at entry:
+ * +----------------------------------------------------+
+ * | regs->ss						|
+ * | regs->rsp						|
+ * | regs->eflags					|
+ * | regs->cs						|
+ * | regs->ip						|
+ * +----------------------------------------------------+
+ * | regs->orig_ax = ~(interrupt number)		|
+ * +----------------------------------------------------+
+ * | return address					|
+ * +----------------------------------------------------+
+ */
+SYM_CODE_START(interrupt_entry)
+	UNWIND_HINT_IRET_REGS offset=16
+	ASM_CLAC
+	cld
+
+	testb	$3, CS-ORIG_RAX+8(%rsp)
+	jz	1f
+
+	idtentry_swapgs_and_switch_to_kernel_stack
+
 	jmp	2f
 1:
 	FENCE_SWAPGS_KERNEL_ENTRY
-- 
2.20.1

