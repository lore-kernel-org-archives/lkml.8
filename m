Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC1C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D529820836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgEKVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732029AbgEKU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589BC061A0C;
        Mon, 11 May 2020 13:59:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWi-0005w4-EQ; Mon, 11 May 2020 22:59:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE04A1C0861;
        Mon, 11 May 2020 22:59:37 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:37 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Don't set nesting depth negative in
 rcu_preempt_deferred_qs()
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077786.390.1485983578500795487.tip-bot2@tip-bot2>
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

Commit-ID:     07b4a930fc44a537efecf73c1fd2b4937f64caaa
Gitweb:        https://git.kernel.org/tip/07b4a930fc44a537efecf73c1fd2b4937f64caaa
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Sat, 15 Feb 2020 14:37:26 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()

Now that RCU flavors have been consolidated, an RCU-preempt
rcu_read_unlock() in an interrupt or softirq handler cannot possibly
end the RCU read-side critical section.  Consider the old vulnerability
involving rcu_preempt_deferred_qs() being invoked within such a handler
that interrupted an extended RCU read-side critical section, in which
a wakeup might be invoked with a scheduler lock held.  Because
rcu_read_unlock_special() no longer does wakeups in such situations,
it is no longer necessary for rcu_preempt_deferred_qs() to set the
nesting level negative.

This commit therefore removes this recursion-protection code from
rcu_preempt_deferred_qs().

[ paulmck: Fix typo in commit log per Steve Rostedt. ]
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ccad776..263c766 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -569,16 +569,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
