Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7319C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB90A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgELAJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:09:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:34698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgELAJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:09:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 717ECAE79;
        Tue, 12 May 2020 00:09:24 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, oleg@redhat.com, paulmck@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] kernel/sys: only rely on rcu for getpriority(2)
Date:   Mon, 11 May 2020 17:03:52 -0700
Message-Id: <20200512000353.23653-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200512000353.23653-1-dave@stgolabs.net>
References: <20200512000353.23653-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the tasklist_lock is shared mainly in order to observe
the list atomically for the PRIO_PGRP and PRIO_USER cases, as
the actual lookups are already rcu-safe, providing a stable task
pointer. By removing the lock, we can race with:

(i) fork (insertion), but this is benign as the child's nice
is inherited and the actual task is not observable by the user
yet either. The return semantics do not differ.

and;

(ii) exit (deletion), this window is small but if a task is
deleted with the highest nice and it is not observed this would
cause a change in return semantics. To further reduce the window
we ignore any tasks that are PF_EXITING in the 'old' version of
the list.

The case for PRIO_PROCESS does not need the lock at all as it only
looks up the pointer.

The following raw microbenchmark improvements on a 40-core box
were seen running the stressng-get workload, which pathologically
pounds on various syscalls that get information from the kernel.
Increasing thread counts of course shows more wins, albeit probably
not something that would be seen in a real workload.

			      5.7.0-rc3              5.7.0-rc3
						getpriority-v1
Hmean     get-1      3443.65 (   0.00%)     3314.08 *  -3.76%*
Hmean     get-2      7809.99 (   0.00%)     8547.60 *   9.44%*
Hmean     get-4     15498.01 (   0.00%)    17396.85 *  12.25%*
Hmean     get-8     28001.37 (   0.00%)    31137.53 *  11.20%*
Hmean     get-16    31460.88 (   0.00%)    40284.35 *  28.05%*
Hmean     get-32    30036.64 (   0.00%)    40657.88 *  35.36%*
Hmean     get-64    31429.86 (   0.00%)    41021.73 *  30.52%*
Hmean     get-80    31804.13 (   0.00%)    39188.55 *  23.22%*

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sys.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..0b72184f5e3e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -277,7 +277,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		return -EINVAL;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -296,6 +295,9 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		else
 			pgrp = task_pgrp(current);
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
+			if (unlikely(p->flags & PF_EXITING))
+				continue;
+
 			niceval = nice_to_rlimit(task_nice(p));
 			if (niceval > retval)
 				retval = niceval;
@@ -313,6 +315,9 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		}
 		do_each_thread(g, p) {
 			if (uid_eq(task_uid(p), uid) && task_pid_vnr(p)) {
+				if (unlikely(p->flags & PF_EXITING))
+					continue;
+
 				niceval = nice_to_rlimit(task_nice(p));
 				if (niceval > retval)
 					retval = niceval;
@@ -323,7 +328,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
 	return retval;
-- 
2.26.1

