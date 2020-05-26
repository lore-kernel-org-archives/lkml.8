Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E37C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1FC207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEZEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:35:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60945 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgEZEfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:35:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TzgeTgw_1590467713;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzgeTgw_1590467713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 12:35:13 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/entry: always flush user CR3 in RESTORE_CR3
Date:   Tue, 26 May 2020 04:35:07 +0000
Message-Id: <20200526043507.51977-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526043507.51977-1-laijs@linux.alibaba.com>
References: <20200526043507.51977-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RESTORE_CR3 is called when CPL==0 or #DF, it is unlikely
CPL==0&cr3==userCR3 and #DF itself is unlikely case.
There is no much overhead to always flush userCR3.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h  | 27 ++++++---------------------
 arch/x86/entry/entry_64.S |  6 +++---
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 505246185624..ff26e4eb7063 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -265,33 +265,18 @@ For 32-bit we have the following conventions - kernel is built with
 .Ldone_\@:
 .endm
 
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro RESTORE_CR3 save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
 	/*
 	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
+	 *
+	 * RESTORE_CR3 is called when CPL==0 or #DF, it is unlikely
+	 * CPL==0&cr3==userCR3 and #DF itself is unlikely case.
+	 * There is no much overhead to always flush userCR3.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
 	jnc	.Lend_\@
-
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
-	/*
-	 * Check if there's a pending flush for the user ASID we're
-	 * about to set.
-	 */
-	movq	\save_reg, \scratch_reg
-	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
-	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
-
-.Lnoflush_\@:
-	SET_NOFLUSH_BIT \save_reg
-
-.Lwrcr3_\@:
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
@@ -306,7 +291,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro RESTORE_CR3 save_reg:req
 .endm
 
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d983a0d4bc73..46efa842a45e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1283,13 +1283,13 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	RESTORE_CR3	save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	restore_regs_and_return_to_kernel
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
 	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	RESTORE_CR3	save_reg=%r14
 	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
@@ -1703,7 +1703,7 @@ end_repeat_nmi:
 	call	exc_nmi
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
+	RESTORE_CR3 save_reg=%r14
 
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	nmi_restore
-- 
2.20.1

