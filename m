Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7327C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67072082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgC0CdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:33:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48020 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgC0CcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHemz-003hQn-7t; Fri, 27 Mar 2020 02:32:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 01/22] x86 user stack frame reads: switch to explicit __get_user()
Date:   Fri, 27 Mar 2020 02:31:44 +0000
Message-Id: <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327023007.GS23230@ZenIV.linux.org.uk>
References: <20200327023007.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

rather than relying upon the magic in raw_copy_from_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/events/core.c         | 27 +++++++--------------------
 arch/x86/include/asm/uaccess.h |  9 ---------
 arch/x86/kernel/stacktrace.c   |  6 ++++--
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bb738f5a472..a619763e96e1 100644
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
index 61d93f062a36..ab8eab43a8a2 100644
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
index 2d6898c2cb64..6ad43fc44556 100644
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
 
-- 
2.11.0

