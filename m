Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FBC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B820A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCXJRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgCXJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgP-0008Jq-67; Tue, 24 Mar 2020 10:17:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A28191C07FA;
        Tue, 24 Mar 2020 10:16:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:56 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141632.28353.6358567384722774731.tip-bot2@tip-bot2>
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

Commit-ID:     82dd8419e225958f01708cda8a3fc6c3c5356228
Gitweb:        https://git.kernel.org/tip/82dd8419e225958f01708cda8a3fc6c3c5356228
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 15 Dec 2019 11:38:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:21 -08:00

rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf

The for_each_leaf_node_cpu_mask() and for_each_leaf_node_possible_cpu()
macros must be invoked only on leaf rcu_node structures.  Failing to
abide by this restriction can result in infinite loops on systems with
more than 64 CPUs (or for more than 32 CPUs on 32-bit systems).  This
commit therefore adds WARN_ON_ONCE() calls to make misuse of these two
macros easier to debug.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 05f936e..f6ce173 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -325,7 +325,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * Iterate over all possible CPUs in a leaf RCU node.
  */
 #define for_each_leaf_node_possible_cpu(rnp, cpu) \
-	for ((cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = cpumask_next((cpu), cpu_possible_mask))
 
@@ -335,7 +336,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 #define rcu_find_next_bit(rnp, cpu, mask) \
 	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
 #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
-	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))
 
