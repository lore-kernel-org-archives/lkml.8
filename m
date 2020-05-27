Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D44C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E842073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgE0Hbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:33 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39419 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729316AbgE0Hbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TzmtPzB_1590564673;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzmtPzB_1590564673)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:13 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/5] x86/entry: avoid calling into sync_regs() when entering from userspace
Date:   Wed, 27 May 2020 07:31:04 +0000
Message-Id: <20200527073107.2127-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527073107.2127-1-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com>
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

This is hot path, such overhead should be avoided. This patch
borrows the way how interrupt_entry handles it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5e983506f82e..e8817ae31390 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1321,19 +1321,13 @@ SYM_CODE_END(paranoid_exit)
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
-	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
+	idtentry_swapgs_and_switch_to_kernel_stack
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
+	ret
 
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
@@ -1357,6 +1351,8 @@ SYM_CODE_START_LOCAL(error_entry)
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

