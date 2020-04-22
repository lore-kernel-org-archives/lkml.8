Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2447EC38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BC22075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDVELy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:11:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgDVELw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:11:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 850FFADE1;
        Wed, 22 Apr 2020 04:11:49 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     bigeasy@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/5] rcuwait: Introduce prepare_to and finish_rcuwait
Date:   Tue, 21 Apr 2020 21:07:37 -0700
Message-Id: <20200422040739.18601-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422040739.18601-1-dave@stgolabs.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further flexibility for some callers to implement
ad-hoc versions of the generic rcuwait_wait_event(). For example,
kvm will need this to maintain tracing semantics. The naming
is of course similar to what waitqueue apis offer.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rcuwait.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 6ebb23258a27..0c6a3d0d25ab 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -29,12 +29,25 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 
 /*
  * The caller is responsible for locking around rcuwait_wait_event(),
- * such that writes to @task are properly serialized.
+ * and prepare_to_rcuwait() such that writes to @task are properly
+ * serialized.
  */
+
+static inline void prepare_to_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, current);
+}
+
+static inline void finish_rcuwait(struct rcuwait *w)
+{
+	WRITE_ONCE(w->task, NULL);
+	__set_current_state(TASK_RUNNING);
+}
+
 #define rcuwait_wait_event(w, condition, state)				\
 ({									\
 	int __ret = 0;							\
-	rcu_assign_pointer((w)->task, current);				\
+	prepare_to_rcuwait(w);						\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
@@ -51,9 +64,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 									\
 		schedule();						\
 	}								\
-									\
-	WRITE_ONCE((w)->task, NULL);					\
-	__set_current_state(TASK_RUNNING);				\
+	finish_rcuwait(w);						\
 	__ret;								\
 })
 
-- 
2.16.4

