Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C2B246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgB0PNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:13:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgB0PNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:13:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7Kqk-00086w-Tr; Thu, 27 Feb 2020 16:13:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 85C001C2170;
        Thu, 27 Feb 2020 16:13:18 +0100 (CET)
Date:   Thu, 27 Feb 2020 15:13:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158281639829.28353.14112883202818177824.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     7c805795307b40af50a45b7db44dd09ac1700947
Gitweb:        https://git.kernel.org/tip/7c805795307b40af50a45b7db44dd09ac1700947
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Oct 2019 14:27:14 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Fri, 14 Feb 2020 16:04:35 +01:00

x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY

Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
is not only pointless, it's actually counterproductive:

 1) Context tracking code is invoked unconditionally before that flag is
    evaluated.

 2) If the flag is set the slow path is invoked for nothing due to #1

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/thread_info.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf43279..6cb9d1b 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -133,14 +133,10 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/*
- * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
- * enter_from_user_mode()
- */
+/* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_NOHZ)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
