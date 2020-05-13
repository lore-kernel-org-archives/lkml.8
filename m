Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F09A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388470;
	bh=EGUfcltCzqJGbjEtMpr4o9DdaPYtdN4oqY3dM2UkolY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioKp/H/O4x8hkQheUnc3hCWccSZkCwiDX9baO9W3+ztib8OtdiGWP9zCpVL1g15EG
	 7GJ8Iz3yCtbalQ/+I5ugEr4pn5fLgyUeX68pS9KCaa+lCzialD3aiOEPPZb6awGeXs
	 z2l2TVhOw/0NkV+fzCzKJkruvlvXw4BO4FFfvx2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbgEMQrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389760AbgEMQrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:33 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74962065D;
        Wed, 13 May 2020 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388453;
        bh=EGUfcltCzqJGbjEtMpr4o9DdaPYtdN4oqY3dM2UkolY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buuuJbVeDzw096UM/5n5bYclZ9Tv0M1T0TiI25fpRThygLhVS1qZCIwb1yVlmUbaZ
         9pYWemSTTwHq6YhfVYkHceUE7quEr9R9KbPKxdAknUOg6I3MO/aR+WCYWml+l3nwls
         g1yanWkzmH4n5aoRBp5rJjYqHrHGhDIbzSL7UoR0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 07/10] rcu: Temporarily assume that nohz full CPUs might not be NOCB
Date:   Wed, 13 May 2020 18:47:11 +0200
Message-Id: <20200513164714.22557-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far nohz_full CPUs had to be nocb. This requirement may change
temporarily as we are working on preparing RCU to be able to toggle the
nocb state of a CPU. Once that is done and nohz_full can be toggled as
well dynamically, we'll restore that initial requirement.

Thus for now as a temporary state, make rcu_nohz_full_cpu() aware of
nohz_full CPUs that are not nocb so that they can handle the callbacks
locally.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree.h        | 2 +-
 kernel/rcu/tree_plugin.h | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc95419f6491..74b6798309ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3223,7 +3223,7 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
-	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
+	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu(rdp))
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dc2ec021da5..4b9643d9f5e0 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -451,7 +451,7 @@ do {									\
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 static void rcu_bind_gp_kthread(void);
-static bool rcu_nohz_full_cpu(void);
+static bool rcu_nohz_full_cpu(struct rcu_data *rdp);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 43ecc047af26..f19e81e0c691 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2532,13 +2532,14 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
  * The idea is to avoid waking up RCU core processing on such a
  * CPU unless the grace period has extended for too long.
  *
- * This code relies on the fact that all NO_HZ_FULL CPUs are also
- * CONFIG_RCU_NOCB_CPU CPUs.
+ * This code relies on the fact that NO_HZ_FULL CPUs might not
+ * be CONFIG_RCU_NOCB_CPU CPUs (temporary development state).
  */
-static bool rcu_nohz_full_cpu(void)
+static bool rcu_nohz_full_cpu(struct rcu_data *rdp)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_cpu(smp_processor_id()) &&
+	    rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    (!rcu_gp_in_progress() ||
 	     ULONG_CMP_LT(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
 		return true;
-- 
2.25.0

