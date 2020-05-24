Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA807C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E66720787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbgEXQay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:30:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52695 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727899AbgEXQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:30:53 -0400
Received: from localhost.localdomain (d28-23-45-10.dim.wideopenwest.com [23.28.10.45])
        (authenticated bits=0)
        (User authenticated as jaytlang@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04OGSl7C011682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 May 2020 12:28:57 -0400
From:   Jay Lang <jaytlang@mit.edu>
Cc:     jaytlang@mit.edu, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        yu kuai <yukuai3@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ioperm: fix a memory leak bug
Date:   Sun, 24 May 2020 12:27:39 -0400
Message-Id: <20200524162742.253727-1-jaytlang@mit.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
task_struct argument which to operate on. This may not be the most elegant
solution, but it mitigates the trigger described above on an x86_64 kernel.

Signed-off-by: Jay Lang <jaytlang@mit.edu>
---
 arch/x86/include/asm/io_bitmap.h |  4 ++--
 arch/x86/kernel/ioport.c         | 22 +++++++++++-----------
 arch/x86/kernel/process.c        |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 07344d82e88e..ac1a99ffbd8d 100644
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
index a53e7b4a7419..e2fab3ceb09f 100644
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
index 9da70b279dad..35638f1c5791 100644
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
 
-- 
2.25.1

