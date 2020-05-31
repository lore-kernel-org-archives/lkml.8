Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3D720707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgEaLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:52:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:52:14 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jfMVf-0006jt-LR; Sun, 31 May 2020 11:52:11 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 2/4] seccomp: release filter after task is fully dead
Date:   Sun, 31 May 2020 13:50:29 +0200
Message-Id: <20200531115031.391515-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531115031.391515-1-christian.brauner@ubuntu.com>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The seccomp filter used to be released in free_task() which is called
asynchronously via call_rcu() and assorted mechanisms. Since we need
to inform tasks waiting on the seccomp notifier when a filter goes empty
we will notify them as soon as a task has been marked fully dead in
release_task(). To not split seccomp cleanup into two parts, move
filter release out of free_task() and into release_task() after we've
unhashed struct task from struct pid, exited signals, and unlinked it
from the threadgroups' thread list. We'll put the empty filter
notification infrastructure into it in a follow up patch.

This also renames put_seccomp_filter() to seccomp_filter_release() which
is a more descriptive name of what we're doing here especially once
we've added the empty filter notification mechanism in there.

We're also NULL-ing the task's filter tree entrypoint which seems
cleaner than leaving a dangling pointer in there. Note that this shouldn't
need any memory barriers since we're calling this when the task is in
release_task() which means it's EXIT_DEAD. So it can't modify it's seccomp
filters anymore. You can also see this from the point where we're calling
seccomp_filter_release(). It's after __exit_signal() and at this point,
tsk->sighand will already have been NULLed which is required for
thread-sync and filter installation alike.

Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matt Denton <mpdenton@google.com>
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Jann Horn <jannh@google.com>
Cc: Chris Palmer <palmer@google.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Robert Sesek <rsesek@google.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch introduced
---
 include/linux/seccomp.h |  4 +--
 kernel/exit.c           |  1 +
 kernel/fork.c           |  1 -
 kernel/seccomp.c        | 60 ++++++++++++++++++++++++-----------------
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4192369b8418..1644922af19a 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -82,10 +82,10 @@ static inline int seccomp_mode(struct seccomp *s)
 #endif /* CONFIG_SECCOMP */
 
 #ifdef CONFIG_SECCOMP_FILTER
-extern void put_seccomp_filter(struct task_struct *tsk);
+extern void seccomp_filter_release(struct task_struct *tsk);
 extern void get_seccomp_filter(struct task_struct *tsk);
 #else  /* CONFIG_SECCOMP_FILTER */
-static inline void put_seccomp_filter(struct task_struct *tsk)
+static inline void seccomp_filter_release(struct task_struct *tsk)
 {
 	return;
 }
diff --git a/kernel/exit.c b/kernel/exit.c
index ce2a75bc0ade..5490cc04f436 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -218,6 +218,7 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	seccomp_filter_release(p);
 	proc_flush_pid(thread_pid);
 	put_pid(thread_pid);
 	release_thread(p);
diff --git a/kernel/fork.c b/kernel/fork.c
index 48ed22774efa..b948a14da94f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -471,7 +471,6 @@ void free_task(struct task_struct *tsk)
 #endif
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
-	put_seccomp_filter(tsk);
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0ba2d6d0800f..55251b1fe03f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -367,6 +367,40 @@ static inline pid_t seccomp_can_sync_threads(void)
 	return 0;
 }
 
+static inline void seccomp_filter_free(struct seccomp_filter *filter)
+{
+	if (filter) {
+		bpf_prog_destroy(filter->prog);
+		kfree(filter);
+	}
+}
+
+static void __put_seccomp_filter(struct seccomp_filter *orig)
+{
+	/* Clean up single-reference branches iteratively. */
+	while (orig && refcount_dec_and_test(&orig->refs)) {
+		struct seccomp_filter *freeme = orig;
+		orig = orig->prev;
+		seccomp_filter_free(freeme);
+	}
+}
+
+/**
+ * seccomp_filter_release - Detach the task from its filter tree
+ *			    and drop its reference count during
+ *			    exit.
+ *
+ * This function should only be called when the task is exiting as
+ * it detaches it from its filter tree.
+ */
+void seccomp_filter_release(struct task_struct *tsk)
+{
+	struct seccomp_filter *cur = tsk->seccomp.filter;
+
+	tsk->seccomp.filter = NULL;
+	__put_seccomp_filter(cur);
+}
+
 /**
  * seccomp_sync_threads: sets all threads to use current's filter
  *
@@ -396,7 +430,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		 * current's path will hold a reference.  (This also
 		 * allows a put before the assignment.)
 		 */
-		put_seccomp_filter(thread);
+		__put_seccomp_filter(thread->seccomp.filter);
 		smp_store_release(&thread->seccomp.filter,
 				  caller->seccomp.filter);
 
@@ -567,30 +601,6 @@ void get_seccomp_filter(struct task_struct *tsk)
 	__get_seccomp_filter(orig);
 }
 
-static inline void seccomp_filter_free(struct seccomp_filter *filter)
-{
-	if (filter) {
-		bpf_prog_destroy(filter->prog);
-		kfree(filter);
-	}
-}
-
-static void __put_seccomp_filter(struct seccomp_filter *orig)
-{
-	/* Clean up single-reference branches iteratively. */
-	while (orig && refcount_dec_and_test(&orig->refs)) {
-		struct seccomp_filter *freeme = orig;
-		orig = orig->prev;
-		seccomp_filter_free(freeme);
-	}
-}
-
-/* put_seccomp_filter - decrements the ref count of tsk->seccomp.filter */
-void put_seccomp_filter(struct task_struct *tsk)
-{
-	__put_seccomp_filter(tsk->seccomp.filter);
-}
-
 static void seccomp_init_siginfo(kernel_siginfo_t *info, int syscall, int reason)
 {
 	clear_siginfo(info);
-- 
2.26.2

