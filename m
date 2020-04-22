Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1566FC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A4B20767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDVELw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:11:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgDVELt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:11:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E36AEAD82;
        Wed, 22 Apr 2020 04:11:46 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     bigeasy@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/5] rcuwait: Let rcuwait_wake_up() return whether or not a task was awoken
Date:   Tue, 21 Apr 2020 21:07:36 -0700
Message-Id: <20200422040739.18601-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422040739.18601-1-dave@stgolabs.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagating the return value of wake_up_process() back to the caller
can come in handy for future users, such as for statistics or
accounting purposes.

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

