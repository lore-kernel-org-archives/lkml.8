Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA15206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgFAVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:36:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1721C061A0E;
        Mon,  1 Jun 2020 14:36:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfs6o-0007x4-G4; Mon, 01 Jun 2020 23:36:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 082BF1C0244;
        Mon,  1 Jun 2020 23:36:38 +0200 (CEST)
Date:   Mon, 01 Jun 2020 21:36:37 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/xen: Unbreak hypervisor callback on 32bit
Cc:     kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159104739784.17951.17560941713289773893.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4b1f63084d3ebd14c3ef2cd4e8732c25bcd8381d
Gitweb:        https://git.kernel.org/tip/4b1f63084d3ebd14c3ef2cd4e8732c25bcd8381d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 01 Jun 2020 21:33:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 01 Jun 2020 23:31:48 +02:00

x86/xen: Unbreak hypervisor callback on 32bit

The IDTENTRY conversion broke XEN on 32bit:

ld: arch/x86/xen/setup.o: in function `register_callback':                                                                                                                                                                                                                     
>> arch/x86/xen/setup.c:940: undefined reference to `xen_asm_exc_xen_hypervisor_callback'

The reason is that 32bit does not have the extra indirection of 64bit via
the XEN trampolines and 32bit never emitted an actual IDT entry function
for this.

 - Add and use IDTENTRY_XENCB so the ASM variant emits an entry point only
   for 64 bit.

 - Rename the 32bit ASM function to match the 64bit trampoline function name.

Fixup a few comments as well.

Fixes: 66a07b44e765 ("x86/entry: Switch XEN/PV hypercall entry to IDTENTRY")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/entry_32.S       |  7 +++++--
 arch/x86/include/asm/idtentry.h | 24 +++++++++++++++++++++++-
 arch/x86/xen/xen-asm_32.S       |  6 +++---
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 96fa462..2d29f77 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1167,8 +1167,11 @@ SYM_CODE_END(native_iret)
 #ifdef CONFIG_XEN_PV
 /*
  * See comment in entry_64.S for further explanation
+ *
+ * Note: This is not an actual IDT entry point. It's a XEN specific entry
+ * point and therefore named to match the 64-bit trampoline counterpart.
  */
-SYM_FUNC_START(exc_xen_hypervisor_callback)
+SYM_FUNC_START(xen_asm_exc_xen_hypervisor_callback)
 	/*
 	 * Check to see if we got the event in the critical
 	 * region in xen_iret_direct, after we've reenabled
@@ -1189,7 +1192,7 @@ SYM_FUNC_START(exc_xen_hypervisor_callback)
 	mov	%esp, %eax
 	call	xen_pv_evtchn_do_upcall
 	jmp	handle_exception_return
-SYM_FUNC_END(exc_xen_hypervisor_callback)
+SYM_FUNC_END(xen_asm_exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f8e2737..d203c54 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -283,6 +283,22 @@ __visible noinstr void func(struct pt_regs *regs)			\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
 
+/**
+ * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ *
+ * Maps to DECLARE_IDTENTRY(). Distinct entry point to handle the 32/64-bit
+ * difference
+ */
+#define DECLARE_IDTENTRY_XENCB(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -432,6 +448,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_DF(vector, func)				\
 	idtentry_df vector asm_##func func
 
+# define DECLARE_IDTENTRY_XENCB(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
@@ -442,6 +461,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
 /* No ASM emitted for DF as this goes through a C shim */
 # define DECLARE_IDTENTRY_DF(vector, func)
 
+/* No ASM emitted for XEN hypervisor callback */
+# define DECLARE_IDTENTRY_XENCB(vector, func)
+
 #endif
 
 /* No ASM code emitted for NMI */
@@ -558,7 +580,7 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 
 #ifdef CONFIG_XEN_PV
-DECLARE_IDTENTRY(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
+DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
 #endif
 
 /* Device interrupts common/spurious */
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index d0ff2dc..4757cec 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -113,7 +113,7 @@ iret_restore_end:
 	 * Events are masked, so jumping out of the critical region is
 	 * OK.
 	 */
-	je asm_exc_xen_hypervisor_callback
+	je xen_asm_exc_xen_hypervisor_callback
 
 1:	iret
 xen_iret_end_crit:
@@ -127,7 +127,7 @@ SYM_CODE_END(xen_iret)
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
 /*
- * This is called by exc_xen_hypervisor_callback in entry_32.S when it sees
+ * This is called by xen_asm_exc_xen_hypervisor_callback in entry_32.S when it sees
  * that the EIP at the time of interrupt was between
  * xen_iret_start_crit and xen_iret_end_crit.
  *
@@ -144,7 +144,7 @@ SYM_CODE_END(xen_iret)
  *	 eflags		}
  *	 cs		}  nested exception info
  *	 eip		}
- *	 return address	: (into asm_exc_xen_hypervisor_callback)
+ *	 return address	: (into xen_asm_exc_xen_hypervisor_callback)
  *
  * In order to deliver the nested exception properly, we need to discard the
  * nested exception frame such that when we handle the exception, we do it
