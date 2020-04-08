Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2220936
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgDHMUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgDHMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gv-00064g-D0; Wed, 08 Apr 2020 14:20:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F29C1C0131;
        Wed,  8 Apr 2020 14:20:25 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:24 -0000
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Remove unused rq::last_load_update_tick
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com>
References: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <158634842452.28353.9568921110806315387.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     275b2f6723ab9173484e1055ae138d4c2dd9d7c5
Gitweb:        https://git.kernel.org/tip/275b2f6723ab9173484e1055ae138d4c2dd9d7c5
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Fri, 20 Mar 2020 13:21:35 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:23 +02:00

sched/core: Remove unused rq::last_load_update_tick

The following commit:

  5e83eafbfd3b ("sched/fair: Remove the rq->cpu_load[] update code")

eliminated the last use case for rq->last_load_update_tick, so remove
the field as well.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/1584710495-308969-1-git-send-email-vincent.donnefort@arm.com
---
 kernel/sched/core.c  | 1 -
 kernel/sched/sched.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3d12e3..3a61a3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6694,7 +6694,6 @@ void __init sched_init(void)
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
-		rq->last_load_update_tick = jiffies;
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cd00814..db3a576 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -888,7 +888,6 @@ struct rq {
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
-	unsigned long		last_load_update_tick;
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
 #endif /* CONFIG_SMP */
