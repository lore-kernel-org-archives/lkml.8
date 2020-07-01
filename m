Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C518C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A0D206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U7vhJS9Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HANPVTNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGAIFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:05:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgGAIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:57 -0400
Date:   Wed, 01 Jul 2020 08:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP5Wpc2uSz2OcJ40AqJH5dzlA82IPYkFcHfCicFcDRA=;
        b=U7vhJS9Q3pgCFZ8aLCbZK7JHjHNYJEhRKT3R37/DMZmtr/HppTXq5c/3UwcPbxSar9ILh+
        Z5Px3WD8o16Cm9NbIbez5BYBGJtfHTCaZ2n9x0YGUQe3uIa+mjF4uuUOBHMmaSxWa7uhjF
        rwX6EZGKhASCzvLIef5nCjC2hER9giXNEvtFdmmb1+ZWtZkTMtkEu0AiZq+ELEd0Y5Ziwa
        nG00aAnIrcoKvdaUQicD2ReQWdFd8LRnnB34kJqQndWxiwzqH0ixzLHqKvBcqFNzq7bB+l
        QooH3POG+jP21SFEvvhOKbjWVPLu7lFdSpYFlZLpF31etqWq3Mr3Kti6TV6Grw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP5Wpc2uSz2OcJ40AqJH5dzlA82IPYkFcHfCicFcDRA=;
        b=HANPVTNOXzcRpyKcWCsdiWQDWgEuGMbRbGRdt1uSsiDfDpGcapPf4i0a91usuBnHFd0+Nz
        fbaINFp5tI+4XgAw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Assert that syscalls are on the right stack
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org>
References: <52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069277.4006.7142366313823999075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c9c26150e61de441ab58b25c1f64afc049ee0fee
Gitweb:        https://git.kernel.org/tip/c9c26150e61de441ab58b25c1f64afc049ee0fee
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:11 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:25 +02:00

x86/entry: Assert that syscalls are on the right stack

Now that the entry stack is a full page, it's too easy to regress the
system call entry code and end up on the wrong stack without noticing.
Assert that all system calls (SYSCALL64, SYSCALL32, SYSENTER, and INT80)
are on the right stack and have pt_regs in the right place.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org

---
 arch/x86/entry/common.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f141..ed8ccc8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -45,6 +45,15 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+/* Check that the stack and regs on entry from user mode are sane. */
+static void check_user_regs(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		WARN_ON_ONCE(!on_thread_stack());
+		WARN_ON_ONCE(regs != task_pt_regs(current));
+	}
+}
+
 #ifdef CONFIG_CONTEXT_TRACKING
 /**
  * enter_from_user_mode - Establish state when coming from user mode
@@ -127,9 +136,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	unsigned long ret = 0;
 	u32 work;
 
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-		BUG_ON(regs != task_pt_regs(current));
-
 	work = READ_ONCE(ti->flags);
 
 	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
@@ -346,6 +352,8 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -409,6 +417,8 @@ static void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
+	check_user_regs(regs);
+
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -460,6 +470,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
+	check_user_regs(regs);
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
