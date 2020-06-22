Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F38520738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgFVXqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54779 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbgFVXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:10 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8e-0005DO-6Y; Mon, 22 Jun 2020 23:46:08 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 08/17] fork: remove do_fork()
Date:   Tue, 23 Jun 2020 01:43:17 +0200
Message-Id: <20200622234326.906346-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures have been switched to use _do_fork() and the new
struct kernel_clone_args calling convention we can remove the legacy
do_fork() helper completely. The calling convention used to be brittle and
do_fork() didn't buy us anything. The only calling convention accepted
should be based on struct kernel_clone_args going forward. It's cleaner and
uniform.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 25 +------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ddce0ea515d1..9f03c44941fb 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -96,7 +96,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern long _do_fork(struct kernel_clone_args *kargs);
-extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9875aeb2ba41..0fd7eb1b38f9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2493,29 +2493,6 @@ long _do_fork(struct kernel_clone_args *args)
 	return nr;
 }
 
-#ifndef CONFIG_HAVE_COPY_THREAD_TLS
-/* For compatibility with architectures that call do_fork directly rather than
- * using the syscall entry points below. */
-long do_fork(unsigned long clone_flags,
-	      unsigned long stack_start,
-	      unsigned long stack_size,
-	      int __user *parent_tidptr,
-	      int __user *child_tidptr)
-{
-	struct kernel_clone_args args = {
-		.flags		= (lower_32_bits(clone_flags) & ~CSIGNAL),
-		.pidfd		= parent_tidptr,
-		.child_tid	= child_tidptr,
-		.parent_tid	= parent_tidptr,
-		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
-		.stack		= stack_start,
-		.stack_size	= stack_size,
-	};
-
-	return _do_fork(&args);
-}
-#endif
-
 /*
  * Create a kernel thread.
  */
@@ -2923,7 +2900,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*
- * functions used by do_fork() cannot be used here directly
+ * functions used by _do_fork() cannot be used here directly
  * because they modify an inactive task_struct that is being
  * constructed. Here we are modifying the current, active,
  * task_struct.
-- 
2.27.0

