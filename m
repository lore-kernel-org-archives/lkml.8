Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096A522522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgAYKou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44361 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgAYKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuO-0000GL-TL; Sat, 25 Jan 2020 11:43:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 844401C1A94;
        Sat, 25 Jan 2020 11:42:58 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:58 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Substitute lookup for bit-twiddling in
 sync_rcu_exp_select_node_cpus()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897835.396.8404296707459413310.tip-bot2@tip-bot2>
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

Commit-ID:     aca2991a25da03ca96127b1d21e1f4aba41f81a6
Gitweb:        https://git.kernel.org/tip/aca2991a25da03ca96127b1d21e1f4aba41f81a6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 30 Oct 2019 06:51:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:57 -08:00

rcu: Substitute lookup for bit-twiddling in sync_rcu_exp_select_node_cpus()

The code in sync_rcu_exp_select_node_cpus() calculates the current
CPU's mask within its rcu_node structure's bitmasks, but this has
already been computed in the ->grpmask field of that CPU's rcu_data
structure.  This commit therefore just uses this ->grpmask field.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6a6f328..3b59c3e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -345,8 +345,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* Each pass checks a CPU for identity, offline, and idle. */
 	mask_ofl_test = 0;
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 		int snap;
 
 		if (raw_smp_processor_id() == cpu ||
@@ -373,8 +373,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
 		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
