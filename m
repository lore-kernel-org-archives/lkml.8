Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13678C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C4420801
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAYKmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgAYKmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItm-0008LA-5s; Sat, 25 Jan 2020 11:42:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 416401C1A72;
        Sat, 25 Jan 2020 11:42:41 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:41 -0000
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove the declaration of call_rcu() in tree.h
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896104.396.11564920961633969578.tip-bot2@tip-bot2>
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

Commit-ID:     4778339df0ee361dbf2cbdcb87abaec9dfbc841d
Gitweb:        https://git.kernel.org/tip/4778339df0ee361dbf2cbdcb87abaec9dfbc841d
Author:        Lai Jiangshan <jiangshanlai@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 10:28:46 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:38 -08:00

rcu: Remove the declaration of call_rcu() in tree.h

The call_rcu() function is an external RCU API that is declared in
include/linux/rcupdate.h.  There is thus no point in redeclaring it
in kernel/rcu/tree.h, so this commit removes that redundant declaration.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4dc5de..54ff989 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -413,7 +413,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_sched_clock_irq(int user);
-void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
