Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A05C35245
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B8220880
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAYKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAYKmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItl-0008K9-V9; Sat, 25 Jan 2020 11:42:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D73F1C0105;
        Sat, 25 Jan 2020 11:42:39 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:39 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused stop-machine #include
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994895908.396.10457171877689560364.tip-bot2@tip-bot2>
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

Commit-ID:     f6105fc2a9c0ea5be6b9e5c19b2551af0b8b4eac
Gitweb:        https://git.kernel.org/tip/f6105fc2a9c0ea5be6b9e5c19b2551af0b8b4eac
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 11:36:07 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:52 -08:00

rcu: Remove unused stop-machine #include

Long ago, RCU used the stop-machine mechanism to implement expedited
grace periods, but no longer does so.  This commit therefore removes
the no-longer-needed #includes of linux/stop_machine.h.

Link: https://lwn.net/Articles/805317/
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 kernel/rcu/tree.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d950764..878f62f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -43,7 +43,6 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
-#include <linux/stop_machine.h>
 #include <linux/random.h>
 #include <linux/trace_events.h>
 #include <linux/suspend.h>
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9d5986a..ce90c68 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -16,7 +16,6 @@
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
 #include <linux/swait.h>
-#include <linux/stop_machine.h>
 #include <linux/rcu_node_tree.h>
 
 #include "rcu_segcblist.h"
