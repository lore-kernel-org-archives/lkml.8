Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C900C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021AA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586975012;
	bh=INgabvAlb4AsrKfzNR+JKWk0ecQAVyupAhHILsJUC60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=so8KYecyX/gRuMay0xxbGCpcfJj2qcRqk8Rj+mEZDXEdcIgSuMd4qFzZyMIgkO3r+
	 n+/sUKeGnQBsknJXdSZDGpwX+5Di3hXkdQVeq0UR1cMbX4gtXLYnEoB5tWh4fTlAQm
	 6yhmTr2oXpV10R606HP9Rq59/a25ggU7naO0f7Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416687AbgDOSXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441384AbgDOSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A072192A;
        Wed, 15 Apr 2020 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974791;
        bh=INgabvAlb4AsrKfzNR+JKWk0ecQAVyupAhHILsJUC60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAwH/b+RnqlJe6lre+2kLnwFXw1kLNV0HwkoxebcZ7JejAKW4pbsMYuZKqfkGDADj
         UK9gs6M15Y2ZRDZWklWUoYs4tb3ca0ftUgjo+5AuS3hwAvwQFEf1Oa3RzcR5vz/QaF
         FVBu1Noz4ZpkdW0OdgCMHvcWZ80p3LDtU3RE95/A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 22/38] rcu-tasks: Add a grace-period start time for throttling and debug
Date:   Wed, 15 Apr 2020 11:19:25 -0700
Message-Id: <20200415181941.11653-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a place to record the grace-period start in jiffies.
This will be used by later commits for debugging purposes and to throttle
IPIs early in the grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2ec82f4..199f87a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,6 +46,7 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	int gp_state;
 	unsigned long gp_jiffies;
+	unsigned long gp_start;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -200,6 +201,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		// Wait for one grace period.
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
-- 
2.9.5

