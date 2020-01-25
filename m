Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9165C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B784324125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAYKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAYKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIto-0008Mm-Nh; Sat, 25 Jan 2020 11:42:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4003C1C0105;
        Sat, 25 Jan 2020 11:42:43 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:43 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Clear ->rcu_read_unlock_special only once
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896305.396.11466393272376454172.tip-bot2@tip-bot2>
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

Commit-ID:     3717e1e9f25ec7059e421ab6fc602cab7063c11c
Gitweb:        https://git.kernel.org/tip/3717e1e9f25ec7059e421ab6fc602cab7063c11c
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 01 Nov 2019 05:06:21 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:27:33 -08:00

rcu: Clear ->rcu_read_unlock_special only once

In rcu_preempt_deferred_qs_irqrestore(), ->rcu_read_unlock_special is
cleared one piece at a time.  Given that the "if" statements in this
function use the copy in "special", this commit removes the clearing
of the individual pieces in favor of clearing ->rcu_read_unlock_special
in one go just after it has been determined to be non-zero.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7487c79..c3a3271 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -444,16 +444,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
-	t->rcu_read_unlock_special.b.exp_hint = false;
-	t->rcu_read_unlock_special.b.deferred_qs = false;
-	if (special.b.need_qs) {
+	t->rcu_read_unlock_special.s = 0;
+	if (special.b.need_qs)
 		rcu_qs();
-		t->rcu_read_unlock_special.b.need_qs = false;
-		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
-			local_irq_restore(flags);
-			return;
-		}
-	}
 
 	/*
 	 * Respond to a request by an expedited grace period for a
@@ -461,17 +454,11 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (rdp->exp_deferred_qs) {
+	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
-		if (!t->rcu_read_unlock_special.s) {
-			local_irq_restore(flags);
-			return;
-		}
-	}
 
 	/* Clean up if blocked during RCU read-side critical section. */
 	if (special.b.blocked) {
-		t->rcu_read_unlock_special.b.blocked = false;
 
 		/*
 		 * Remove this task from the list it blocked on.  The task
