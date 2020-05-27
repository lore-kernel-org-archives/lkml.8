Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EC82073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgE0HbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:21 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:43157 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgE0HbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TznDKwe_1590564675;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TznDKwe_1590564675)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:16 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 3/5] x86/entry: directly switch to kernel stack when .Lerror_bad_iret
Date:   Wed, 27 May 2020 07:31:05 +0000
Message-Id: <20200527073107.2127-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527073107.2127-1-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly copy pt_regs to kernel stack when .Lerror_bad_iret.
Directly switch to kernel stack when .Lerror_bad_iret.

We can see that entry_64.S do the following things back to back
when .Lerror_bad_iret:
	call fixup_bad_iret(), switch to sp0 stack with pt_regs copied
	call sync_regs(), switch to kernel stack with pt_regs copied

So we can do the all things together in fixup_bad_iret().

After this patch, fixup_bad_iret() is restored to the behavior before
7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 13 ++-----------
 arch/x86/kernel/traps.c   |  9 ++++-----
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e8817ae31390..c5db048e5bed 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1329,16 +1329,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	ENCODE_FRAME_POINTER 8
 	ret
 
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
-	ret
-
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
 .Lerror_entry_done:
@@ -1392,7 +1382,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	mov	%rsp, %rdi
 	call	fixup_bad_iret
 	mov	%rax, %rsp
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	ENCODE_FRAME_POINTER 8
+	ret
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_exit)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9e5d81cb94ba..3bef95934644 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -666,13 +666,12 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	/*
 	 * This is called from entry_64.S early in handling a fault
 	 * caused by a bad iret to user mode.  To handle the fault
-	 * correctly, we want to move our stack frame to where it would
-	 * be had we entered directly on the entry stack (rather than
-	 * just below the IRET frame) and we want to pretend that the
-	 * exception came from the IRET target.
+	 * correctly, we want to move our stack frame to kernel stack
+	 * (rather than just below the IRET frame) and we want to
+	 * pretend that the exception came from the IRET target.
 	 */
 	struct bad_iret_stack tmp, *new_stack =
-		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		(struct bad_iret_stack *)__this_cpu_read(cpu_current_top_of_stack) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
 	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
-- 
2.20.1

