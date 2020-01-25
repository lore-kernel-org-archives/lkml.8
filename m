Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0244C24687
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgAYKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgAYKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIts-0008P6-Me; Sat, 25 Jan 2020 11:42:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED55D1C0105;
        Sat, 25 Jan 2020 11:42:44 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:44 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add multiple in-flight batches of kfree_rcu() work
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896478.396.2239574946078408927.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0392bebebf26f09434e6c7ca4c09c014efeef76a
Gitweb:        https://git.kernel.org/tip/0392bebebf26f09434e6c7ca4c09c014efeef76a
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 19 Sep 2019 14:58:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:24:31 -08:00

rcu: Add multiple in-flight batches of kfree_rcu() work

During testing, it was observed that amount of memory consumed due
kfree_rcu() batching is 300-400MB. Previously we had only a single
head_free pointer pointing to the list of rcu_head(s) that are to be
freed after a grace period. Until this list is drained, we cannot queue
any more objects on it since such objects may not be ready to be
reclaimed when the worker thread eventually gets to drainin g the
head_free list.

We can do better by maintaining multiple lists as done by this patch.
Testing shows that memory consumption came down by around 100-150MB with
just adding another list. Adding more than 1 additional list did not
show any improvement.

Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Code style and initialization handling. ]
[ paulmck: Fix field name, reported by kbuild test robot <lkp@intel.com>. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 51 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6106b9e..a40fd58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2686,12 +2686,25 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_N_BATCHES 2
 
 /**
- * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
+ * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @krcp: Pointer to @kfree_rcu_cpu structure
+ */
+
+struct kfree_rcu_cpu_work {
+	struct rcu_work rcu_work;
+	struct rcu_head *head_free;
+	struct kfree_rcu_cpu *krcp;
+};
+
+/**
+ * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @head_free: List of kfree_rcu() objects already waiting for a grace period
+ * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
@@ -2703,9 +2716,8 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * the interactions with the slab allocators.
  */
 struct kfree_rcu_cpu {
-	struct rcu_work rcu_work;
 	struct rcu_head *head;
-	struct rcu_head *head_free;
+	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
@@ -2723,11 +2735,14 @@ static void kfree_rcu_work(struct work_struct *work)
 	unsigned long flags;
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
+	struct kfree_rcu_cpu_work *krwp;
 
-	krcp = container_of(to_rcu_work(work), struct kfree_rcu_cpu, rcu_work);
+	krwp = container_of(to_rcu_work(work),
+			    struct kfree_rcu_cpu_work, rcu_work);
+	krcp = krwp->krcp;
 	spin_lock_irqsave(&krcp->lock, flags);
-	head = krcp->head_free;
-	krcp->head_free = NULL;
+	head = krwp->head_free;
+	krwp->head_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// List "head" is now private, so traverse locklessly.
@@ -2747,17 +2762,25 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	int i;
+	struct kfree_rcu_cpu_work *krwp = NULL;
+
 	lockdep_assert_held(&krcp->lock);
+	for (i = 0; i < KFREE_N_BATCHES; i++)
+		if (!krcp->krw_arr[i].head_free) {
+			krwp = &(krcp->krw_arr[i]);
+			break;
+		}
 
 	// If a previous RCU batch is in progress, we cannot immediately
 	// queue another one, so return false to tell caller to retry.
-	if (krcp->head_free)
+	if (!krwp)
 		return false;
 
-	krcp->head_free = krcp->head;
+	krwp->head_free = krcp->head;
 	krcp->head = NULL;
-	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krcp->rcu_work);
+	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krwp->rcu_work);
 	return true;
 }
 
@@ -2863,7 +2886,8 @@ void __init kfree_rcu_scheduler_running(void)
 			continue;
 		}
 		krcp->monitor_todo = true;
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_work_on(cpu, &krcp->monitor_work,
+					 KFREE_DRAIN_JIFFIES);
 		spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
@@ -3732,11 +3756,14 @@ struct workqueue_struct *rcu_par_gp_wq;
 static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
+	int i;
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
+		for (i = 0; i < KFREE_N_BATCHES; i++)
+			krcp->krw_arr[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
