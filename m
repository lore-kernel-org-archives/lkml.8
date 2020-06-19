Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33090C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E2720DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgFSShl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:37:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40208 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgFSShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:37:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLtS-0004KO-02; Fri, 19 Jun 2020 12:37:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLtR-0001qA-4j; Fri, 19 Jun 2020 12:37:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
Date:   Fri, 19 Jun 2020 13:33:19 -0500
In-Reply-To: <87pn9u6h8c.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 19 Jun 2020 13:30:27 -0500")
Message-ID: <87eeqa6h3k.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmLtR-0001qA-4j;;;mid=<87eeqa6h3k.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+KI2lJvwlCsNg7M5ExV7z+N31SkkoRnc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 2/2] exec: Rename group_exit_task group_exec_task and correct the Documentation
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rename group_exit_task to group_exec_task to make it clear this
field is only used during exec.

Update the comments for the fields group_exec_task and notify_count as
they are only used by exec.  Notifications to the execing task aka
group_exec_task happen at 0 and -1.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    |  8 ++++----
 include/linux/sched/signal.h | 13 +++++--------
 kernel/exit.c                |  4 ++--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..0bf8bde6edfd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,7 +1145,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
-	sig->group_exit_task = tsk;
+	sig->group_exec_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
@@ -1173,7 +1173,7 @@ static int de_thread(struct task_struct *tsk)
 			write_lock_irq(&tasklist_lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
-			 * exit_notify() can't miss ->group_exit_task
+			 * exit_notify() can't miss ->group_exec_task
 			 */
 			sig->notify_count = -1;
 			if (likely(leader->exit_state))
@@ -1240,7 +1240,7 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
 no_thread_group:
@@ -1253,7 +1253,7 @@ static int de_thread(struct task_struct *tsk)
 killed:
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 	read_unlock(&tasklist_lock);
 	return -EAGAIN;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 92c72f5db111..61019d8fe86b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -98,13 +98,10 @@ struct signal_struct {
 
 	/* thread group exit support */
 	int			group_exit_code;
-	/* overloaded:
-	 * - notify group_exit_task when ->count is equal to notify_count
-	 * - everyone except group_exit_task is stopped during signal delivery
-	 *   of fatal signals, group_exit_task processes the signal.
-	 */
+
+	/* exec support, notify group_exec_task when notify_count is 0 or -1 */
 	int			notify_count;
-	struct task_struct	*group_exit_task;
+	struct task_struct	*group_exec_task;
 
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
@@ -262,11 +259,11 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
-/* If true, all threads except ->group_exit_task have pending SIGKILL */
+/* If true, all threads except ->group_exec_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
 	return	(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
-		(sig->group_exit_task != NULL);
+		(sig->group_exec_task != NULL);
 }
 
 extern void flush_signals(struct task_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..4206d33b4904 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -115,7 +115,7 @@ static void __exit_signal(struct task_struct *tsk)
 		 * then notify it:
 		 */
 		if (sig->notify_count > 0 && !--sig->notify_count)
-			wake_up_process(sig->group_exit_task);
+			wake_up_process(sig->group_exec_task);
 
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
@@ -672,7 +672,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
 	/* mt-exec, de_thread() is waiting for group leader */
 	if (unlikely(tsk->signal->notify_count < 0))
-		wake_up_process(tsk->signal->group_exit_task);
+		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
-- 
2.20.1

