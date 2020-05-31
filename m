Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF52C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77C020707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgEaLwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:52:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42751 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgEaLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:52:15 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jfMVg-0006jt-Ec; Sun, 31 May 2020 11:52:12 +0000
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
Subject: [PATCH v3 3/4] seccomp: notify about unused filter
Date:   Sun, 31 May 2020 13:50:30 +0200
Message-Id: <20200531115031.391515-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531115031.391515-1-christian.brauner@ubuntu.com>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been making heavy use of the seccomp notifier to intercept and
handle certain syscalls for containers. This patch allows a syscall
supervisor listening on a given notifier to be notified when a seccomp
filter has become unused.

A container is often managed by a singleton supervisor process the
so-called "monitor". This monitor process has an event loop which has
various event handlers registered. If the user specified a seccomp
profile that included a notifier for various syscalls then we also
register a seccomp notify even handler. For any container using a
separate pid namespace the lifecycle of the seccomp notifier is bound to
the init process of the pid namespace, i.e. when the init process exits
the filter must be unused.
If a new process attaches to a container we force it to assume a seccomp
profile. This can either be the same seccomp profile as the container
was started with or a modified one. If the attaching process makes use
of the seccomp notifier we will register a new seccomp notifier handler
in the monitor's event loop. However, when the attaching process exits
we can't simply delete the handler since other child processes could've
been created (daemons spawned etc.) that have inherited the seccomp
filter and so we need to keep the seccomp notifier fd alive in the event
loop. But this is problematic since we don't get a notification when the
seccomp filter has become unused and so we currently never remove the
seccomp notifier fd from the event loop and just keep accumulating fds
in the event loop. We've had this issue for a while but it has recently
become more pressing as more and larger users make use of this.

To fix this, we introduce a new "users" reference counter that tracks
any tasks and dependent filters making use of a filter. When a notifier is
registered waiting tasks will be notified that the filter is now empty by
receiving a (E)POLLHUP event.
The concept in this patch introduces is the same as for signal_struct,
i.e. reference counting for life-cycle management is decoupled from
reference counting taks using the object.

There's probably some trickery possible but the second counter is just
the correct way of doing this imho and has precedence. The patch also
lifts the waitqeue from struct notification into sruct seccomp_filter.
This is cleaner overall and let's us avoid having to take the notifier
mutex since we neither need to read nor modify the notifier specific
aspects of the seccomp filter. In the exit path I'd very much like to
avoid having to take the notifier mutex for each filter in the task's
filter hierarchy.

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
- Jann Horn <jannh@google.com>:
  - Use more descriptive instead of seccomp_filter_notify().
    (I went with seccomp_filter_release().)

/* v3 */
- Kees Cook <keescook@chromium.org>:
  - Rename counter from "live" to "users".
---
 kernel/seccomp.c | 68 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55251b1fe03f..45244f1ba148 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -94,13 +94,11 @@ struct seccomp_knotif {
  *           filter->notify_lock.
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
- * @wqh: A wait queue for poll.
  */
 struct notification {
 	struct semaphore request;
 	u64 next_id;
 	struct list_head notifications;
-	wait_queue_head_t wqh;
 };
 
 /**
@@ -116,6 +114,15 @@ struct notification {
  * @prog: the BPF program to evaluate
  * @notif: the struct that holds all notification related information
  * @notify_lock: A lock for all notification-related accesses.
+ * @wqh: A wait queue for poll if a notifier is in use.
+ * @users: A filter's @users count is incremented for each directly
+ *         attached task (filter installation, fork(), thread_sync),
+ *	   and once for the dependent filter (tracked in filter->prev).
+ *	   When it reaches zero it indicates that no direct or indirect
+ *	   users of that filter exist. No new tasks can get associated with
+ *	   this filter after reaching 0. The @users count is always smaller
+ *	   or equal to @refs. Hence, reaching 0 for @users does not mean
+ *	   the filter can be freed.
  *
  * seccomp_filter objects are organized in a tree linked via the @prev
  * pointer.  For any task, it appears to be a singly-linked list starting
@@ -134,6 +141,8 @@ struct seccomp_filter {
 	struct bpf_prog *prog;
 	struct notification *notif;
 	struct mutex notify_lock;
+	refcount_t users;
+	wait_queue_head_t wqh;
 };
 
 /* Limit any path through the tree to 256KB worth of instructions. */
@@ -375,6 +384,15 @@ static inline void seccomp_filter_free(struct seccomp_filter *filter)
 	}
 }
 
+static void __seccomp_filter_orphan(struct seccomp_filter *orig)
+{
+	while (orig && refcount_dec_and_test(&orig->users)) {
+		if (waitqueue_active(&orig->wqh))
+			wake_up_poll(&orig->wqh, EPOLLHUP);
+		orig = orig->prev;
+	}
+}
+
 static void __put_seccomp_filter(struct seccomp_filter *orig)
 {
 	/* Clean up single-reference branches iteratively. */
@@ -386,19 +404,23 @@ static void __put_seccomp_filter(struct seccomp_filter *orig)
 }
 
 /**
- * seccomp_filter_release - Detach the task from its filter tree
- *			    and drop its reference count during
- *			    exit.
+ * seccomp_filter_release - Detach the task from its filter tree,
+ *			    drop its reference count, and notify
+ *			    about unused filters
  *
  * This function should only be called when the task is exiting as
  * it detaches it from its filter tree.
  */
 void seccomp_filter_release(struct task_struct *tsk)
 {
-	struct seccomp_filter *cur = tsk->seccomp.filter;
+	struct seccomp_filter *orig = tsk->seccomp.filter;
 
+	/* Detach task from its filter tree. */
 	tsk->seccomp.filter = NULL;
-	__put_seccomp_filter(cur);
+	/* Notify about any unused filters in the task's former filter tree. */
+	__seccomp_filter_orphan(orig);
+	/* Finally drop all references to the task's former tree. */
+	__put_seccomp_filter(orig);
 }
 
 /**
@@ -419,18 +441,29 @@ static inline void seccomp_sync_threads(unsigned long flags)
 	/* Synchronize all threads. */
 	caller = current;
 	for_each_thread(caller, thread) {
+		struct seccomp_filter *cur = thread->seccomp.filter;
+
 		/* Skip current, since it needs no changes. */
 		if (thread == caller)
 			continue;
 
 		/* Get a task reference for the new leaf node. */
 		get_seccomp_filter(caller);
+
+		/*
+		 * Notify everyone as we're forcing the thread
+		 * to orphan its current filter tree.
+		 */
+		__seccomp_filter_orphan(cur);
+
 		/*
-		 * Drop the task reference to the shared ancestor since
-		 * current's path will hold a reference.  (This also
-		 * allows a put before the assignment.)
+		 * Drop the task's reference to the shared ancestor
+		 * since current's path will hold a reference.
+		 * (This also allows a put before the assignment.)
 		 */
-		__put_seccomp_filter(thread->seccomp.filter);
+		__put_seccomp_filter(cur);
+
+		/* Make our new filter tree visible. */
 		smp_store_release(&thread->seccomp.filter,
 				  caller->seccomp.filter);
 
@@ -497,6 +530,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	}
 
 	refcount_set(&sfilter->refs, 1);
+	refcount_set(&sfilter->users, 1);
+	init_waitqueue_head(&sfilter->wqh);
 
 	return sfilter;
 }
@@ -599,6 +634,7 @@ void get_seccomp_filter(struct task_struct *tsk)
 	if (!orig)
 		return;
 	__get_seccomp_filter(orig);
+	refcount_inc(&orig->users);
 }
 
 static void seccomp_init_siginfo(kernel_siginfo_t *info, int syscall, int reason)
@@ -768,7 +804,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	list_add(&n.list, &match->notif->notifications);
 
 	up(&match->notif->request);
-	wake_up_poll(&match->notif->wqh, EPOLLIN | EPOLLRDNORM);
+	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 	mutex_unlock(&match->notify_lock);
 
 	/*
@@ -1075,7 +1111,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	unotif.data = *(knotif->data);
 
 	knotif->state = SECCOMP_NOTIFY_SENT;
-	wake_up_poll(&filter->notif->wqh, EPOLLOUT | EPOLLWRNORM);
+	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
 	ret = 0;
 out:
 	mutex_unlock(&filter->notify_lock);
@@ -1211,7 +1247,7 @@ static __poll_t seccomp_notify_poll(struct file *file,
 	__poll_t ret = 0;
 	struct seccomp_knotif *cur;
 
-	poll_wait(file, &filter->notif->wqh, poll_tab);
+	poll_wait(file, &filter->wqh, poll_tab);
 
 	if (mutex_lock_interruptible(&filter->notify_lock) < 0)
 		return EPOLLERR;
@@ -1227,6 +1263,9 @@ static __poll_t seccomp_notify_poll(struct file *file,
 
 	mutex_unlock(&filter->notify_lock);
 
+	if (refcount_read(&filter->users) == 0)
+		ret |= EPOLLHUP;
+
 	return ret;
 }
 
@@ -1255,7 +1294,6 @@ static struct file *init_listener(struct seccomp_filter *filter)
 	sema_init(&filter->notif->request, 0);
 	filter->notif->next_id = get_random_u64();
 	INIT_LIST_HEAD(&filter->notif->notifications);
-	init_waitqueue_head(&filter->notif->wqh);
 
 	ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
 				 filter, O_RDWR);
-- 
2.26.2

