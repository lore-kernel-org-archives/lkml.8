Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4378C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27420872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEST7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgEST7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C6C08C5C0;
        Tue, 19 May 2020 12:59:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OG-0000Gf-Gm; Tue, 19 May 2020 21:59:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A8F81C0868;
        Tue, 19 May 2020 21:58:49 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:49 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove the unused LOCKDEP_SYSEXIT cruft
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.061301403@linutronix.de>
References: <20200505134059.061301403@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832921.17951.14149459042864825104.tip-bot2@tip-bot2>
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

Commit-ID:     235f96a65b3be1ff5cea6e51c597fa7876f0efdd
Gitweb:        https://git.kernel.org/tip/235f96a65b3be1ff5cea6e51c597fa7876f0efdd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 05 Mar 2020 11:16:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 May 2020 20:03:05 +02:00

x86/entry: Remove the unused LOCKDEP_SYSEXIT cruft

No users left since two years due to commit 21d375b6b34f ("x86/entry/64:
Remove the SYSCALL64 fast path")

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.061301403@linutronix.de


---
 arch/x86/entry/thunk_64.S       |  5 -----
 arch/x86/include/asm/irqflags.h | 24 ------------------------
 2 files changed, 29 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index dbe4493..34f980c 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -42,10 +42,6 @@ SYM_FUNC_END(\name)
 	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
 #endif
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	THUNK lockdep_sys_exit_thunk,lockdep_sys_exit
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
@@ -54,7 +50,6 @@ SYM_FUNC_END(\name)
 #endif
 
 #if defined(CONFIG_TRACE_IRQFLAGS) \
- || defined(CONFIG_DEBUG_LOCK_ALLOC) \
  || defined(CONFIG_PREEMPTION)
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8a0e56e..e00f064 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -180,30 +180,6 @@ static inline int arch_irqs_disabled(void)
 #  define TRACE_IRQS_ON
 #  define TRACE_IRQS_OFF
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-#  ifdef CONFIG_X86_64
-#    define LOCKDEP_SYS_EXIT		call lockdep_sys_exit_thunk
-#    define LOCKDEP_SYS_EXIT_IRQ \
-	TRACE_IRQS_ON; \
-	sti; \
-	call lockdep_sys_exit_thunk; \
-	cli; \
-	TRACE_IRQS_OFF;
-#  else
-#    define LOCKDEP_SYS_EXIT \
-	pushl %eax;				\
-	pushl %ecx;				\
-	pushl %edx;				\
-	call lockdep_sys_exit;			\
-	popl %edx;				\
-	popl %ecx;				\
-	popl %eax;
-#    define LOCKDEP_SYS_EXIT_IRQ
-#  endif
-#else
-#  define LOCKDEP_SYS_EXIT
-#  define LOCKDEP_SYS_EXIT_IRQ
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif
