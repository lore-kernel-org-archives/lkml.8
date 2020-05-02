Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB85C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9920643
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEBDKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 23:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgEBDKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 23:10:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5398AEA2;
        Sat,  2 May 2020 03:09:59 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        mgorman@techsingularity.net, bp@suse.de, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] kernel/sys: do not use tasklist_lock to set/get scheduling priorities
Date:   Fri,  1 May 2020 20:05:39 -0700
Message-Id: <20200502030539.32581-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both setpriority(2) and getpriority(2) there's really no need
to be taking the tasklist_lock at all - for which both share it
for the entirety of the syscall. The tasklist_lock does not protect
reading/writing the p->static_prio and task lookups are already rcu
safe, providing a stable pointer.

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
 kernel/sys.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..12ade1a00a18 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -214,7 +214,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		niceval = MAX_NICE;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -252,7 +251,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 out:
 	return error;
@@ -277,7 +275,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		return -EINVAL;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -323,7 +320,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
 	return retval;
-- 
2.16.4

