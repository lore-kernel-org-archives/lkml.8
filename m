Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9686FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79785207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbgEZBmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:42:39 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46947 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388442AbgEZBmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:42:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Tzg711O_1590457355;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzg711O_1590457355)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 09:42:35 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH V2 5/7] x86/entry: don't shift stack on #DB
Date:   Tue, 26 May 2020 01:42:19 +0000
Message-Id: <20200526014221.2119-6-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526014221.2119-1-laijs@linux.alibaba.com>
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_enter() will disable #DB, there should be no recursive #DB.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        | 17 -----------------
 arch/x86/kernel/asm-offsets_64.c |  1 -
 2 files changed, 18 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 265ff97b3961..8ecaeee53653 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -396,11 +396,6 @@ SYM_CODE_END(\asmsym)
 	idtentry \vector asm_\cfunc \cfunc has_error_code=0
 .endm
 
-/*
- * MCE and DB exceptions
- */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
-
 /**
  * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
  * @vector:		Vector number
@@ -416,10 +411,6 @@ SYM_CODE_END(\asmsym)
  * If hits in kernel mode then it needs to go through the paranoid
  * entry as the exception can hit any random state. No preemption
  * check on exit to keep the paranoid path simple.
- *
- * If the trap is #DB then the interrupt stack entry in the IST is
- * moved to the second stack, so a potential recursion will have a
- * fresh IST.
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
@@ -445,16 +436,8 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
-	.if \vector == X86_TRAP_DB
-		subq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	call	\cfunc
 
-	.if \vector == X86_TRAP_DB
-		addq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	jmp	paranoid_exit
 
 	/* Switch to the regular task stack and use the noist entry point */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index c2a47016f243..472378330169 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -57,7 +57,6 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
 	DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
 	       offsetof(struct cea_exception_stacks, DB1_stack));
 	BLANK();
-- 
2.20.1

