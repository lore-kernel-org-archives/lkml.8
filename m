Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBBC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969FC2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgEKVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731998AbgEKU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2DC061A0C;
        Mon, 11 May 2020 13:59:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWb-0005sm-B2; Mon, 11 May 2020 22:59:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED7FA1C07EB;
        Mon, 11 May 2020 22:59:33 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:33 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Reinstate synchronize_rcu_mult()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077382.390.10553170501513229811.tip-bot2@tip-bot2>
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

Commit-ID:     b3d73156b075014ce5b2609f4f47723d6c0c23d6
Gitweb:        https://git.kernel.org/tip/b3d73156b075014ce5b2609f4f47723d6c0c23d6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 06 Mar 2020 13:58:27 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu: Reinstate synchronize_rcu_mult()

With the advent and likely usage of synchronize_rcu_rude(), there is
again a need to wait on multiple types of RCU grace periods, for
example, call_rcu_tasks() and call_rcu_tasks_rude().  This commit
therefore reinstates synchronize_rcu_mult() in order to allow these
grace periods to be straightforwardly waited on concurrently.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_wait.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index c0578ba..699b938 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -31,4 +31,23 @@ do {									\
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
 
+/**
+ * synchronize_rcu_mult - Wait concurrently for multiple grace periods
+ * @...: List of call_rcu() functions for different grace periods to wait on
+ *
+ * This macro waits concurrently for multiple types of RCU grace periods.
+ * For example, synchronize_rcu_mult(call_rcu, call_rcu_tasks) would wait
+ * on concurrent RCU and RCU-tasks grace periods.  Waiting on a given SRCU
+ * domain requires you to write a wrapper function for that SRCU domain's
+ * call_srcu() function, with this wrapper supplying the pointer to the
+ * corresponding srcu_struct.
+ *
+ * The first argument tells Tiny RCU's _wait_rcu_gp() not to
+ * bother waiting for RCU.  The reason for this is because anywhere
+ * synchronize_rcu_mult() can be called is automatically already a full
+ * grace period.
+ */
+#define synchronize_rcu_mult(...) \
+	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
+
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
