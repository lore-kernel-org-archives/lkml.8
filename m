Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD00C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5076207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388459;
	bh=fXVMc41+BF20tf25fhOv6Fukw7SiXvQUSKJAPMH7QWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EdycWBC7SqZysY5lNruo0WlZsNEzmfisEoWHaTzPvJcl/zyTw9FdE/iYoGDjn1t/z
	 XLaiu/yK/JCJp0D6OV8V/eJyorffSfTBGjGYIFqpDw30+2JqnqCQvyteUib4YIJw7f
	 fIesoXkInuYKmjga+UX99StF84vG+9WfVS7Gme9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbgEMQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbgEMQrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:35 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA897207D0;
        Wed, 13 May 2020 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388455;
        bh=fXVMc41+BF20tf25fhOv6Fukw7SiXvQUSKJAPMH7QWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fN3l/l45gkg/6DoyGfw27BDYs8P3DswGOKutCnrN/Pkdxc6/dVXZdpiuFIv02LS/U
         UDJ6CwR59QWjK4MwbQFxCJbaD37EaqmxzddbQNF83PsNibzVAqvUCQ3lVjaboGqNFb
         aeDIalK8Hj1oUO0LEoc27ZaX+AiMxBaOGvHCrr8Q=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Date:   Wed, 13 May 2020 18:47:12 +0200
Message-Id: <20200513164714.22557-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a CPU's rdp to quit the callback offlined mode.
The switch happens on the target with IRQs disabled and rdp->nocb_lock
held to avoid races between local callbacks handling and kthread
offloaded callbacks handling.

nocb_cb kthread is first parked to avoid any future race with
concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
so that the nocb_gp kthread ignores this rdp.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcupdate.h   |  2 ++
 kernel/rcu/rcu_segcblist.c |  4 +--
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree_plugin.h   | 50 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2678a37c3169..1d3a4c37c3c1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -96,8 +96,10 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+void rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline void rcu_nocb_cpu_deoffload(int cpu) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /**
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index d8ea2bef5574..4bed48da7702 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -171,9 +171,9 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  * Mark the specified rcu_segcblist structure as offloaded.  This
  * structure must be empty.
  */
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-	rsclp->offloaded = 1;
+	rsclp->offloaded = offload;
 }
 #endif
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 4c1503a82492..8f7c6c34cb1b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -83,7 +83,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 #ifdef CONFIG_RCU_NOCB_CPU
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 #endif
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f19e81e0c691..c74a4df8d5f2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1943,6 +1943,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+		if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+			continue;
+		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -2176,6 +2180,50 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
+static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	unsigned long flags;
+	struct rcu_node *rnp = rdp->mynode;
+
+	printk("De-offloading %d\n", rdp->cpu);
+	kthread_park(rdp->nocb_cb_kthread);
+
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
+	raw_spin_lock_rcu_node(rnp);
+	rcu_segcblist_offload(&rdp->cblist, false);
+	raw_spin_unlock_rcu_node(rnp);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+}
+
+static long rcu_nocb_rdp_deoffload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	__rcu_nocb_rdp_deoffload(rdp);
+
+	return 0;
+}
+
+void rcu_nocb_cpu_deoffload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+		} else {
+			__rcu_nocb_rdp_deoffload(rdp);
+		}
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+}
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -2218,7 +2266,7 @@ void __init rcu_init_nohz(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
-		rcu_segcblist_offload(&rdp->cblist);
+		rcu_segcblist_offload(&rdp->cblist, true);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.25.0

