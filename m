Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4221C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE892077C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYKmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItl-0008KH-Is; Sat, 25 Jan 2020 11:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 631131C1A75;
        Sat, 25 Jan 2020 11:42:40 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:40 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Switch force_qs_rnp() to for_each_leaf_node_cpu_mask()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896018.396.6105075370440132665.tip-bot2@tip-bot2>
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

Commit-ID:     7441e7661d6586ae36329b7956e4d713d81e9903
Gitweb:        https://git.kernel.org/tip/7441e7661d6586ae36329b7956e4d713d81e9903
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 30 Oct 2019 09:37:11 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:51 -08:00

rcu: Switch force_qs_rnp() to for_each_leaf_node_cpu_mask()

Currently, force_qs_rnp() uses a for_each_leaf_node_possible_cpu()
loop containing a check of the current CPU's bit in ->qsmask.
This works, but this commit saves three lines by instead using
for_each_leaf_node_cpu_mask(), which combines the functionality of
for_each_leaf_node_possible_cpu() and leaf_node_cpu_bit().  This commit
also replaces the use of the local variable "bit" with rdp->grpmask.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bbb60ed..d950764 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2298,14 +2298,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			continue;
 		}
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
-			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
-			if ((rnp->qsmask & bit) != 0) {
-				rdp = per_cpu_ptr(&rcu_data, cpu);
-				if (f(rdp)) {
-					mask |= bit;
-					rcu_disable_urgency_upon_qs(rdp);
-				}
+		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			if (f(rdp)) {
+				mask |= rdp->grpmask;
+				rcu_disable_urgency_upon_qs(rdp);
 			}
 		}
 		if (mask != 0) {
