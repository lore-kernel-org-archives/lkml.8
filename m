Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873E218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgAYKqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAYKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItq-0008N0-98; Sat, 25 Jan 2020 11:42:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E6BE1C1A76;
        Sat, 25 Jan 2020 11:42:43 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:43 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Clear .exp_hint only when deferred quiescent
 state has been reported
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896332.396.1777066129603404272.tip-bot2@tip-bot2>
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

Commit-ID:     2eeba5838fd8c5e19bb91e25624116936348e7af
Gitweb:        https://git.kernel.org/tip/2eeba5838fd8c5e19bb91e25624116936348e7af
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 01 Nov 2019 04:06:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:27:33 -08:00

rcu: Clear .exp_hint only when deferred quiescent state has been reported

Currently, the .exp_hint flag is cleared in rcu_read_unlock_special(),
which works, but which can also prevent subsequent rcu_read_unlock() calls
from helping expedite the quiescent state needed by an ongoing expedited
RCU grace period.  This commit therefore defers clearing of .exp_hint
from rcu_read_unlock_special() to rcu_preempt_deferred_qs_irqrestore(),
thus ensuring that intervening calls to rcu_read_unlock() have a chance
to help end the expedited grace period.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8cdce11..7487c79 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -444,6 +444,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
+	t->rcu_read_unlock_special.b.exp_hint = false;
 	t->rcu_read_unlock_special.b.deferred_qs = false;
 	if (special.b.need_qs) {
 		rcu_qs();
@@ -610,7 +611,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		t->rcu_read_unlock_special.b.exp_hint = false;
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
@@ -640,7 +640,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		local_irq_restore(flags);
 		return;
 	}
-	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
