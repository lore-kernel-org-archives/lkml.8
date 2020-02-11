Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A7C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6178B20637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgBKMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46008 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBKMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1UxD-0007cl-0M; Tue, 11 Feb 2020 13:47:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 72B081C201A;
        Tue, 11 Feb 2020 13:47:49 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:49 -0000
From:   "tip-bot2 for Morten Rasmussen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove SD_BALANCE_WAKE on
 asymmetric capacity systems
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206191957.12325-3-valentin.schneider@arm.com>
References: <20200206191957.12325-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158142526917.411.14392005872156192791.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     38c6e4963b509c47c33539534b84195558c0376d
Gitweb:        https://git.kernel.org/tip/38c6e4963b509c47c33539534b84195558c0376d
Author:        Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate:    Thu, 06 Feb 2020 19:19:55 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:02:50 +01:00

sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems

SD_BALANCE_WAKE was previously added to lower sched_domain levels on
asymmetric CPU capacity systems by commit:

  9ee1cda5ee25 ("sched/core: Enable SD_BALANCE_WAKE for asymmetric capacity systems")

to enable the use of find_idlest_cpu() and friends to find an appropriate
CPU for tasks.

That responsibility has now been shifted to select_idle_sibling() and
friends, and hence the flag can be removed. Note that this causes
asymmetric CPU capacity systems to no longer enter the slow wakeup path
(find_idlest_cpu()) on wakeups - only on execs and forks (which is aligned
with all other mainline topologies).

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
[Changelog tweaks]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lkml.kernel.org/r/20200206191957.12325-3-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dfb64c0..0091188 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1374,18 +1374,9 @@ sd_init(struct sched_domain_topology_level *tl,
 	 * Convert topological properties into behaviour.
 	 */
 
-	if (sd->flags & SD_ASYM_CPUCAPACITY) {
-		struct sched_domain *t = sd;
-
-		/*
-		 * Don't attempt to spread across CPUs of different capacities.
-		 */
-		if (sd->child)
-			sd->child->flags &= ~SD_PREFER_SIBLING;
-
-		for_each_lower_domain(t)
-			t->flags |= SD_BALANCE_WAKE;
-	}
+	/* Don't attempt to spread across CPUs of different capacities. */
+	if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
+		sd->child->flags &= ~SD_PREFER_SIBLING;
 
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->imbalance_pct = 110;
