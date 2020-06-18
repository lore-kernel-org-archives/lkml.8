Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9037B207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgFRNvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgFRNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CCC0613ED;
        Thu, 18 Jun 2020 06:51:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwU-0002k1-2n; Thu, 18 Jun 2020 15:50:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 39A5D1C06E5;
        Thu, 18 Jun 2020 15:50:57 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:57 -0000
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-11-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-11-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825700.16989.16902415408601692499.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     96b2371413e8f636a5f25c42a933af21c35a2a41
Gitweb:        https://git.kernel.org/tip/96b2371413e8f636a5f25c42a933af21c35a2a41
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 28 May 2020 16:13:55 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:03 +02:00

x86/entry/64: Switch CR3 before SWAPGS in paranoid entry

When FSGSBASE is enabled, the GSBASE handling in paranoid entry will need
to retrieve the kernel GSBASE which requires that the kernel page table is
active.

As the CR3 switch to the kernel page tables (PTI is active) does not depend
on kernel GSBASE, move the CR3 switch in front of the GSBASE handling.

Comment the EBX content while at it.

No functional change.

[ tglx: Rewrote changelog and comments ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1557309753-24073-11-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-10-sashal@kernel.org


---
 arch/x86/entry/entry_64.S | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2a00c9..04d1eea 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -807,13 +807,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
 1:
 	/*
@@ -825,9 +818,29 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
 	 * unconditional CR3 write, even in the PTI case.  So do an lfence
@@ -835,6 +848,8 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
 
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
@@ -852,7 +867,8 @@ SYM_CODE_END(paranoid_entry)
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/* If EBX is 0, SWAPGS is required */
+	testl	%ebx, %ebx
 	jnz	.Lparanoid_exit_no_swapgs
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
