Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F07C207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589388465;
	bh=XdTU1QCu9wvEeudPrv5d5VVXBttCnEKZypaCKnPJKU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=csh1CsDOwp4h7EePEigIGB9DWBwosHrt3CXw8oLNyUiQ5bcDE7CMoSbH/j9o3WAQZ
	 SVhJH9P1SEeMVUoe8nxGLGFGtrYRPktv6tgEPWkfhLF7mKsk8bCNdfDBlxIFTm0bpB
	 ypxr2+3HDwMhYghFMgIlIusNP+FtW9np9oLo258o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbgEMQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389771AbgEMQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:37 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0650207D8;
        Wed, 13 May 2020 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388457;
        bh=XdTU1QCu9wvEeudPrv5d5VVXBttCnEKZypaCKnPJKU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtSLr2i3TNN/6yMMyqC61pPjQTM08T08C7zTe8V2jYq4/uV4RrYxFEB7drnIF5xM4
         YI5vL0HBSmeB8NvpCAFZDp3W0E2NybF3Rb33drdQnlgl7zv8o1l158RRdtMmdAC8ER
         7vL9mJlK3tdmlxjMJWlRJbIzDLta55PL+8hqjKQ8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 09/10] rcu: Allow to re-offload a CPU that used to be nocb
Date:   Wed, 13 May 2020 18:47:13 +0200
Message-Id: <20200513164714.22557-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is essentially the reverse operation of de-offloading. For now it's
only supported on CPUs that used to be offloaded and therefore still have
the relevant nocb_cb/nocb_gp kthreads around.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcupdate.h |  2 ++
 kernel/rcu/tree_plugin.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1d3a4c37c3c1..ee95e49d675f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -96,9 +96,11 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+void rcu_nocb_cpu_offload(int cpu);
 void rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline void rcu_nocb_cpu_offload(int cpu) { }
 static inline void rcu_nocb_cpu_deoffload(int cpu) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c74a4df8d5f2..ae4b5e9f2fc5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2224,6 +2224,50 @@ void rcu_nocb_cpu_deoffload(int cpu)
 	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
+static void __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+{
+	unsigned long flags;
+	struct rcu_node *rnp = rdp->mynode;
+
+	printk("Offloading %d\n", rdp->cpu);
+
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	raw_spin_lock_rcu_node(rnp);
+	rcu_segcblist_offload(&rdp->cblist, true);
+	raw_spin_unlock_rcu_node(rnp);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+
+	kthread_unpark(rdp->nocb_cb_kthread);
+}
+
+static long rcu_nocb_rdp_offload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	__rcu_nocb_rdp_offload(rdp);
+
+	return 0;
+}
+
+void rcu_nocb_cpu_offload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) && rdp->nocb_cb_kthread) {
+		if (cpu_online(cpu)) {
+			work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+		} else {
+			__rcu_nocb_rdp_offload(rdp);
+		}
+		cpumask_set_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+}
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-- 
2.25.0

