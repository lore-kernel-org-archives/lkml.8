Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2A20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDXFwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:52:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgDXFwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:52:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2B15ADEB;
        Fri, 24 Apr 2020 05:52:20 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     peterz@infradead.org, maz@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/5] rcuwait: Let rcuwait_wake_up() return whether or not a task was awoken
Date:   Thu, 23 Apr 2020 22:48:34 -0700
Message-Id: <20200424054837.5138-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200424054837.5138-1-dave@stgolabs.net>
References: <20200424054837.5138-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagating the return value of wake_up_process() back to the caller
can come in handy for future users, such as for statistics or
accounting purposes.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rcuwait.h | 2 +-
 kernel/exit.c           | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 2ffe1ee6d482..6ebb23258a27 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -25,7 +25,7 @@ static inline void rcuwait_init(struct rcuwait *w)
 	w->task = NULL;
 }
 
-extern void rcuwait_wake_up(struct rcuwait *w);
+extern int rcuwait_wake_up(struct rcuwait *w);
 
 /*
  * The caller is responsible for locking around rcuwait_wait_event(),
diff --git a/kernel/exit.c b/kernel/exit.c
index 9f9015f3f6b0..f3beb637acf7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -227,8 +227,9 @@ void release_task(struct task_struct *p)
 		goto repeat;
 }
 
-void rcuwait_wake_up(struct rcuwait *w)
+int rcuwait_wake_up(struct rcuwait *w)
 {
+	int ret = 0;
 	struct task_struct *task;
 
 	rcu_read_lock();
@@ -248,8 +249,10 @@ void rcuwait_wake_up(struct rcuwait *w)
 
 	task = rcu_dereference(w->task);
 	if (task)
-		wake_up_process(task);
+		ret = wake_up_process(task);
 	rcu_read_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rcuwait_wake_up);
 
-- 
2.16.4

