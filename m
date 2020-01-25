Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44267C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32BB20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAYKm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgAYKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItr-0008LB-6Q; Sat, 25 Jan 2020 11:42:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B5C411C1A73;
        Sat, 25 Jan 2020 11:42:41 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:41 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix tracepoint tracking RCU CPU kthread utilization
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896139.396.8043787419911538929.tip-bot2@tip-bot2>
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

Commit-ID:     2488a5e695564897a0f8ea42cd3af71647cd26d2
Gitweb:        https://git.kernel.org/tip/2488a5e695564897a0f8ea42cd3af71647cd26d2
Author:        Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 10:23:57 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:31 -08:00

rcu: Fix tracepoint tracking RCU CPU kthread utilization

In the call to trace_rcu_utilization() at the start of the loop in
rcu_cpu_kthread(), "rcu_wait" is incorrect, plus this trace event needs
to be hoisted above the loop to balance with either the "rcu_wait" or
"rcu_yield", depending on how the loop exits.  This commit therefore
makes these changes.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dd8cfc3..ba154a3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2474,8 +2474,8 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
 	int spincnt;
 
+	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
-		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
