Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73FC35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC80F24125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgAYKqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgAYKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItr-0008LH-N7; Sat, 25 Jan 2020 11:42:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03D6B1C1A74;
        Sat, 25 Jan 2020 11:42:42 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:41 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix harmless omission of "CONFIG_" from #if condition
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896181.396.7434875004503665801.tip-bot2@tip-bot2>
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

Commit-ID:     822175e72995a9ff7eeef4f5cd3f945f2697b67d
Gitweb:        https://git.kernel.org/tip/822175e72995a9ff7eeef4f5cd3f945f2697b67d
Author:        Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 10:23:56 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:13 -08:00

rcu: Fix harmless omission of "CONFIG_" from #if condition

The C preprocessor macros SRCU and TINY_RCU should instead be CONFIG_SRCU
and CONFIG_TINY_RCU, respectively in the #f in kernel/rcu/rcu.h. But
there is no harm when "TINY_RCU" is wrongly used, which are always
non-defined, which makes "!defined(TINY_RCU)" always true, which means
the code block is always included, and the included code block doesn't
cause any compilation error so far in CONFIG_TINY_RCU builds.  It is
also the reason this change should not be taken in -stable.

This commit adds the needed "CONFIG_" prefix to both macros.

Not for -stable.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fb..4732594 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -281,7 +281,7 @@ void rcu_test_sync_prims(void);
  */
 extern void resched_cpu(int cpu);
 
-#if defined(SRCU) || !defined(TINY_RCU)
+#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
 
 #include <linux/rcu_node_tree.h>
 
@@ -418,7 +418,7 @@ do {									\
 #define raw_lockdep_assert_held_rcu_node(p)				\
 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
 
-#endif /* #if defined(SRCU) || !defined(TINY_RCU) */
+#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
 #ifdef CONFIG_SRCU
 void srcu_init(void);
