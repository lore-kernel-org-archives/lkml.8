Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5C9207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgFRNwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgFRNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD13C0613EE;
        Thu, 18 Jun 2020 06:51:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwT-0002il-PL; Thu, 18 Jun 2020 15:50:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A37361C032F;
        Thu, 18 Jun 2020 15:50:56 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:56 -0000
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825647.16989.1932041253802265049.tip-bot2@tip-bot2>
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

Commit-ID:     c82965f9e53005c1c62632c468968293262056cb
Gitweb:        https://git.kernel.org/tip/c82965f9e53005c1c62632c468968293262056cb
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 28 May 2020 16:13:57 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:04 +02:00

x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit

Without FSGSBASE, user space cannot change GSBASE other than through a
PRCTL. The kernel enforces that the user space GSBASE value is postive as
negative values are used for detecting the kernel space GSBASE value in the
paranoid entry code.

If FSGSBASE is enabled, user space can set arbitrary GSBASE values without
kernel intervention, including negative ones, which breaks the paranoid
entry assumptions.

To avoid this, paranoid entry needs to unconditionally save the current
GSBASE value independent of the interrupted context, retrieve and write the
kernel GSBASE and unconditionally restore the saved value on exit. The
restore happens either in paranoid_exit or in the special exit path of the
NMI low level code.

All other entry code pathes which use unconditional SWAPGS are not affected
as they do not depend on the actual content.

[ tglx: Massaged changelogs and comments ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1557309753-24073-13-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-12-sashal@kernel.org


---
 arch/x86/entry/calling.h  |   6 ++-
 arch/x86/entry/entry_64.S | 111 ++++++++++++++++++++++++++++---------
 2 files changed, 91 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 5c0cbb4..98e4d88 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -342,6 +342,12 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
+.macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	rdgsbase \save_reg
+	GET_PERCPU_BASE \scratch_reg
+	wrgsbase \scratch_reg
+.endm
+
 #else /* CONFIG_X86_64 */
 # undef		UNWIND_HINT_IRET_REGS
 # define	UNWIND_HINT_IRET_REGS
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 04d1eea..fb729f4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/frame.h>
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -426,10 +427,7 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS-ORIG_RAX(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
+	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 
 	UNWIND_HINT_REGS
@@ -458,10 +456,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
+	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
@@ -798,9 +793,14 @@ SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs. Return GSBASE related information
+ * in EBX depending on the availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GSBASE value at entry, must be restored in paranoid_exit
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
@@ -808,7 +808,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
-1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -826,6 +825,28 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/*
+	 * Handling GSBASE depends on the availability of FSGSBASE.
+	 *
+	 * Without FSGSBASE the kernel enforces that negative GSBASE
+	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
+	 * can be made about the GSBASE value when entering from user
+	 * space.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/*
+	 * Read the current GSBASE and store it in %rbx unconditionally,
+	 * retrieve and set the current CPUs kernel GSBASE. The stored value
+	 * has to be restored in paranoid_exit unconditionally.
+	 *
+	 * The MSR write ensures that no subsequent load is based on a
+	 * mispredicted GSBASE. No extra FENCE required.
+	 */
+	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	ret
+
+.Lparanoid_entry_checkgs:
 	/* EBX = 1 -> kernel GSBASE active, no restore required */
 	movl	$1, %ebx
 	/*
@@ -860,24 +881,45 @@ SYM_CODE_END(paranoid_entry)
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, we there's no good reason
- * to try to handle preemption here.
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ *
+ * R/EBX contains the GSBASE related information depending on the
+ * availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
-	/* If EBX is 0, SWAPGS is required */
-	testl	%ebx, %ebx
-	jnz	.Lparanoid_exit_no_swapgs
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	/*
+	 * The order of operations is important. RESTORE_CR3 requires
+	 * kernel GSBASE.
+	 *
+	 * NB to anyone to try to optimize this code: this code does
+	 * not execute at all for exceptions from user mode. Those
+	 * exceptions go through error_exit instead.
+	 */
+	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+
+	/* Handle the three GSBASE cases */
+	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/* With FSGSBASE enabled, unconditionally restore GSBASE */
+	wrgsbase	%rbx
+	jmp		restore_regs_and_return_to_kernel
+
+.Lparanoid_exit_checkgs:
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
+	testl		%ebx, %ebx
+	jnz		restore_regs_and_return_to_kernel
+
+	/* We are returning to a context with user GSBASE */
 	SWAPGS_UNSAFE_STACK
-	jmp	restore_regs_and_return_to_kernel
-.Lparanoid_exit_no_swapgs:
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-	jmp restore_regs_and_return_to_kernel
+	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
 /*
@@ -1282,10 +1324,27 @@ end_repeat_nmi:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/*
+	 * The above invocation of paranoid_entry stored the GSBASE
+	 * related information in R/EBX depending on the availability
+	 * of FSGSBASE.
+	 *
+	 * If FSGSBASE is enabled, restore the saved GSBASE value
+	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 */
+	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
+
+	wrgsbase	%rbx
+	jmp	nmi_restore
+
+nmi_no_fsgsbase:
+	/* EBX == 0 -> invoke SWAPGS */
+	testl	%ebx, %ebx
 	jnz	nmi_restore
+
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
+
 nmi_restore:
 	POP_REGS
 
