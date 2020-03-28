Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF71C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635CC20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC1LAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgC1LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C9-0003fn-Mv; Sat, 28 Mar 2020 12:00:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 42E3B1C04CF;
        Sat, 28 Mar 2020 12:00:02 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:00:01 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86 user stack frame reads: switch to explicit
 __get_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539320186.28353.832755417114718072.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c8e3dd86600a1a7b165478cc626d69bf07967c15
Gitweb:        https://git.kernel.org/tip/c8e3dd86600a1a7b165478cc626d69bf07967c15
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 11:28:09 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Sat, 15 Feb 2020 17:26:26 -05:00

x86 user stack frame reads: switch to explicit __get_user()

rather than relying upon the magic in raw_copy_from_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/events/core.c         | 27 +++++++--------------------
 arch/x86/include/asm/uaccess.h |  9 ---------
 arch/x86/kernel/stacktrace.c   |  6 ++++--
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bb738f..a619763 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2490,7 +2490,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	/* 32-bit process in 64-bit kernel. */
 	unsigned long ss_base, cs_base;
 	struct stack_frame_ia32 frame;
-	const void __user *fp;
+	const struct stack_frame_ia32 __user *fp;
 
 	if (!test_thread_flag(TIF_IA32))
 		return 0;
@@ -2501,18 +2501,12 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
 	while (entry->nr < entry->max_stack) {
-		unsigned long bytes;
-		frame.next_frame     = 0;
-		frame.return_address = 0;
-
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
 
-		bytes = __copy_from_user_nmi(&frame.next_frame, fp, 4);
-		if (bytes != 0)
+		if (__get_user(frame.next_frame, &fp->next_frame))
 			break;
-		bytes = __copy_from_user_nmi(&frame.return_address, fp+4, 4);
-		if (bytes != 0)
+		if (__get_user(frame.return_address, &fp->return_address))
 			break;
 
 		perf_callchain_store(entry, cs_base + frame.return_address);
@@ -2533,7 +2527,7 @@ void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
 	struct stack_frame frame;
-	const unsigned long __user *fp;
+	const struct stack_frame __user *fp;
 
 	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2546,7 +2540,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 	if (regs->flags & (X86_VM_MASK | PERF_EFLAGS_VM))
 		return;
 
-	fp = (unsigned long __user *)regs->bp;
+	fp = (void __user *)regs->bp;
 
 	perf_callchain_store(entry, regs->ip);
 
@@ -2558,19 +2552,12 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 
 	pagefault_disable();
 	while (entry->nr < entry->max_stack) {
-		unsigned long bytes;
-
-		frame.next_frame	     = NULL;
-		frame.return_address = 0;
-
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
 
-		bytes = __copy_from_user_nmi(&frame.next_frame, fp, sizeof(*fp));
-		if (bytes != 0)
+		if (__get_user(frame.next_frame, &fp->next_frame))
 			break;
-		bytes = __copy_from_user_nmi(&frame.return_address, fp + 1, sizeof(*fp));
-		if (bytes != 0)
+		if (__get_user(frame.return_address, &fp->return_address))
 			break;
 
 		perf_callchain_store(entry, frame.return_address);
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 61d93f0..ab8eab4 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -695,15 +695,6 @@ extern struct movsl_mask {
 #endif
 
 /*
- * We rely on the nested NMI work to allow atomic faults from the NMI path; the
- * nested NMI paths are careful to preserve CR2.
- *
- * Caller must use pagefault_enable/disable, or run in interrupt context,
- * and also do a uaccess_ok() check
- */
-#define __copy_from_user_nmi __copy_from_user_inatomic
-
-/*
  * The "unsafe" user accesses aren't really "unsafe", but the naming
  * is a big fat warning: you have to not only do the access_ok()
  * checking before using them, but you have to surround them with the
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2d6898c..6ad43fc 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -96,7 +96,8 @@ struct stack_frame_user {
 };
 
 static int
-copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
+copy_stack_frame(const struct stack_frame_user __user *fp,
+		 struct stack_frame_user *frame)
 {
 	int ret;
 
@@ -105,7 +106,8 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 
 	ret = 1;
 	pagefault_disable();
-	if (__copy_from_user_inatomic(frame, fp, sizeof(*frame)))
+	if (__get_user(frame->next_fp, &fp->next_fp) ||
+	    __get_user(frame->ret_addr, &fp->ret_addr))
 		ret = 0;
 	pagefault_enable();
 
