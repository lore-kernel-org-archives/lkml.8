Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ACC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AE5206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHQAp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 20:45:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgHQApY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0484ABF4;
        Mon, 17 Aug 2020 00:45:46 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     oleg@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] kernel/sys: only take tasklist_lock for get/setpriority(PRIO_PGRP)
Date:   Sun, 16 Aug 2020 17:31:47 -0700
Message-Id: <20200817003148.23691-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817003148.23691-1-dave@stgolabs.net>
References: <20200817003148.23691-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRIO_PGRP needs the tasklist_lock mainly to serialize vs setpgid(2),
to protect against any concurrent change_pid(PIDTYPE_PGID) that
can move the task from one hlist to another while iterating.

However, the remaining can only rely only on RCU:

PRIO_PROCESS only does the task lookup and never iterates over
tasklist and we already have an rcu-aware stable pointer.

PRIO_USER is already racy vs setuid(2) so with creds being rcu
protected, we can end up seeing stale data. When removing the
tasklist_lock there can be a race with (i) fork but this is benign
as the child's nice is inherited and the new task is not observable
by the user yet either, hence the return semantics do not differ.
And (ii) a race with exit, which is a small window and can cause
us to miss a task which was removed from the list and it had the
highest nice.

Similarly change the buggy do_each_thread/while_each_thread combo
in PRIO_USER for the rcu-safe for_each_process_thread flavor,
which doesn't make use of next_thread/p->thread_group.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sys.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index ca11af9d815d..4d4f17c01a4f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -214,7 +214,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		niceval = MAX_NICE;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -229,9 +228,11 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 			pgrp = find_vpid(who);
 		else
 			pgrp = task_pgrp(current);
+		read_lock(&tasklist_lock);
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 			error = set_one_prio(p, niceval, error);
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -243,16 +244,15 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 			if (!user)
 				goto out_unlock;	/* No processes for this user */
 		}
-		do_each_thread(g, p) {
+		for_each_process_thread(g, p) {
 			if (uid_eq(task_uid(p), uid) && task_pid_vnr(p))
 				error = set_one_prio(p, niceval, error);
-		} while_each_thread(g, p);
+		}
 		if (!uid_eq(uid, cred->uid))
 			free_uid(user);		/* For find_user() */
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 out:
 	return error;
@@ -277,7 +277,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		return -EINVAL;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -295,11 +294,13 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 			pgrp = find_vpid(who);
 		else
 			pgrp = task_pgrp(current);
+		read_lock(&tasklist_lock);
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 			niceval = nice_to_rlimit(task_nice(p));
 			if (niceval > retval)
 				retval = niceval;
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -311,19 +312,18 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 			if (!user)
 				goto out_unlock;	/* No processes for this user */
 		}
-		do_each_thread(g, p) {
+	        for_each_process_thread(g, p) {
 			if (uid_eq(task_uid(p), uid) && task_pid_vnr(p)) {
 				niceval = nice_to_rlimit(task_nice(p));
 				if (niceval > retval)
 					retval = niceval;
 			}
-		} while_each_thread(g, p);
+		}
 		if (!uid_eq(uid, cred->uid))
 			free_uid(user);		/* for find_user() */
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
 	return retval;
-- 
2.26.2

