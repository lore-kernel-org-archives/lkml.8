Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA8F2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406701AbgE1TjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406540AbgE1Ti5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:38:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409CC08C5C6;
        Thu, 28 May 2020 12:38:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeOMf-0007VO-Kh; Thu, 28 May 2020 21:38:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 270F11C0051;
        Thu, 28 May 2020 21:38:53 +0200 (CEST)
Date:   Thu, 28 May 2020 19:38:52 -0000
From:   "tip-bot2 for Jay Lang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ioperm: Prevent a memory leak when fork fails
Cc:     Jay Lang <jaytlang@mit.edu>, Thomas Gleixner <tglx@linutronix.de>,
        stable#@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200524162742.253727-1-jaytlang@mit.edu>
References: <20200524162742.253727-1-jaytlang@mit.edu>
MIME-Version: 1.0
Message-ID: <159069473297.17951.5698539330024737587.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4bfe6cce133cad82cea04490c308795275857782
Gitweb:        https://git.kernel.org/tip/4bfe6cce133cad82cea04490c308795275857782
Author:        Jay Lang <jaytlang@mit.edu>
AuthorDate:    Sun, 24 May 2020 12:27:39 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 May 2020 21:36:20 +02:00

x86/ioperm: Prevent a memory leak when fork fails

In the copy_process() routine called by _do_fork(), failure to allocate
a PID (or further along in the function) will trigger an invocation to
exit_thread(). This is done to clean up from an earlier call to
copy_thread_tls(). Naturally, the child task is passed into exit_thread(),
however during the process, io_bitmap_exit() nullifies the parent's
io_bitmap rather than the child's.

As copy_thread_tls() has been called ahead of the failure, the reference
count on the calling thread's io_bitmap is incremented as we would expect.
However, io_bitmap_exit() doesn't accept any arguments, and thus assumes
it should trash the current thread's io_bitmap reference rather than the
child's. This is pretty sneaky in practice, because in all instances but
this one, exit_thread() is called with respect to the current task and
everything works out.

A determined attacker can issue an appropriate ioctl (i.e. KDENABIO) to
get a bitmap allocated, and force a clone3() syscall to fail by passing
in a zeroed clone_args structure. The kernel handles the erroneous struct
and the buggy code path is followed, and even though the parent's reference
to the io_bitmap is trashed, the child still holds a reference and thus
the structure will never be freed.

Fix this by tweaking io_bitmap_exit() and its subroutines to accept a
task_struct argument which to operate on.

Fixes: ea5f1cd7ab49 ("x86/ioperm: Remove bitmap if all permissions dropped")
Signed-off-by: Jay Lang <jaytlang@mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable#@vger.kernel.org
Link: https://lkml.kernel.org/r/20200524162742.253727-1-jaytlang@mit.edu
---
 arch/x86/include/asm/io_bitmap.h |  4 ++--
 arch/x86/kernel/ioport.c         | 22 +++++++++++-----------
 arch/x86/kernel/process.c        |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 07344d8..ac1a99f 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -17,7 +17,7 @@ struct task_struct;
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 void io_bitmap_share(struct task_struct *tsk);
-void io_bitmap_exit(void);
+void io_bitmap_exit(struct task_struct *tsk);
 
 void native_tss_update_io_bitmap(void);
 
@@ -29,7 +29,7 @@ void native_tss_update_io_bitmap(void);
 
 #else
 static inline void io_bitmap_share(struct task_struct *tsk) { }
-static inline void io_bitmap_exit(void) { }
+static inline void io_bitmap_exit(struct task_struct *tsk) { }
 static inline void tss_update_io_bitmap(void) { }
 #endif
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index a53e7b4..e2fab3c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -33,15 +33,15 @@ void io_bitmap_share(struct task_struct *tsk)
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
-static void task_update_io_bitmap(void)
+static void task_update_io_bitmap(struct task_struct *tsk)
 {
-	struct thread_struct *t = &current->thread;
+	struct thread_struct *t = &tsk->thread;
 
 	if (t->iopl_emul == 3 || t->io_bitmap) {
 		/* TSS update is handled on exit to user space */
-		set_thread_flag(TIF_IO_BITMAP);
+		set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 	} else {
-		clear_thread_flag(TIF_IO_BITMAP);
+		clear_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 		/* Invalidate TSS */
 		preempt_disable();
 		tss_update_io_bitmap();
@@ -49,12 +49,12 @@ static void task_update_io_bitmap(void)
 	}
 }
 
-void io_bitmap_exit(void)
+void io_bitmap_exit(struct task_struct *tsk)
 {
-	struct io_bitmap *iobm = current->thread.io_bitmap;
+	struct io_bitmap *iobm = tsk->thread.io_bitmap;
 
-	current->thread.io_bitmap = NULL;
-	task_update_io_bitmap();
+	tsk->thread.io_bitmap = NULL;
+	task_update_io_bitmap(tsk);
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -102,7 +102,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 		if (!iobm)
 			return -ENOMEM;
 		refcount_set(&iobm->refcnt, 1);
-		io_bitmap_exit();
+		io_bitmap_exit(current);
 	}
 
 	/*
@@ -134,7 +134,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	}
 	/* All permissions dropped? */
 	if (max_long == UINT_MAX) {
-		io_bitmap_exit();
+		io_bitmap_exit(current);
 		return 0;
 	}
 
@@ -192,7 +192,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 	}
 
 	t->iopl_emul = level;
-	task_update_io_bitmap();
+	task_update_io_bitmap(current);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b2..35638f1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,7 +96,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 /*
- * Free current thread data structures etc..
+ * Free thread data structures etc..
  */
 void exit_thread(struct task_struct *tsk)
 {
@@ -104,7 +104,7 @@ void exit_thread(struct task_struct *tsk)
 	struct fpu *fpu = &t->fpu;
 
 	if (test_thread_flag(TIF_IO_BITMAP))
-		io_bitmap_exit();
+		io_bitmap_exit(tsk);
 
 	free_vm86(t);
 
