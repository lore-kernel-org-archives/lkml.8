Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F6820786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871723;
	bh=LDFnUwOht1bq6TZpOOZC8ylOHnKpb1HgN49AER6vNMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/PtA45QH3hbZMo7EEPxK9kpZCDJaYc4VgKh6ERFXntHAZVHVHr9RogQP4NsYCvR4
	 +Bx73xjPAClFKwMxOrZR9BerkfUOsPEPGxR8V+vNABSuYI+TiKPw1jb0gIoyUKSeB7
	 3e5SDynYbsLAKo4netDOA3H9UO5fsgRYdrVR3HAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgFWAWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbgFWAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1559120842;
        Tue, 23 Jun 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=LDFnUwOht1bq6TZpOOZC8ylOHnKpb1HgN49AER6vNMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKmkEyoB3QgJhf5Cc0HDNNaY327EqfKEwggi7+lFIi4LeM1kcsrJdxk03gSgggcYh
         pBsCDWJn1Pu0Zj3nljNB1x8cu0qnhRiVOZbV9BN7jgXSAjTAqe9h3Y+PFesdCvjIbq
         bytuAgVTGbIZYKooUZcwgoh0mGzEvNOeGrg53LuA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/26] rcu: No-CBs-related sleeps to idle priority
Date:   Mon, 22 Jun 2020 17:21:30 -0700
Message-Id: <20200623002147.25750-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the schedule_timeout_interruptible() call used by
RCU's no-CBs grace-period kthreads to schedule_timeout_idle().  This
conversion avoids polluting the load-average with RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 25296c1..982fc5b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2005,7 +2005,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_interruptible(1);
+		schedule_timeout_idle(1);
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
 		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
-- 
2.9.5

