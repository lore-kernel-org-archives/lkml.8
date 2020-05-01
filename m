Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C1C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B245D24961
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgEASX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730661AbgEASW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE90C08E859;
        Fri,  1 May 2020 11:22:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIj-0003bA-NP; Fri, 01 May 2020 20:22:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1806D1C0813;
        Fri,  1 May 2020 20:22:12 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:12 -0000
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove distribute_running from CFS bandwidth
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200410225208.109717-3-joshdon@google.com>
References: <20200410225208.109717-3-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <158835733205.8414.9136130857443620621.tip-bot2@tip-bot2>
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

Commit-ID:     ab93a4bc955b3980c699430bc0b633f0d8b607be
Gitweb:        https://git.kernel.org/tip/ab93a4bc955b3980c699430bc0b633f0d8b607be
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Fri, 10 Apr 2020 15:52:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:38 +02:00

sched/fair: Remove distribute_running from CFS bandwidth

This is mostly a revert of commit:

  baa9be4ffb55 ("sched/fair: Fix throttle_list starvation with low CFS quota")

The primary use of distribute_running was to determine whether to add
throttled entities to the head or the tail of the throttled list. Now
that we always add to the tail, we can remove this field.

The other use of distribute_running is in the slack_timer, so that we
don't start a distribution while one is already running. However, even
in the event that this race occurs, it is fine to have two distributions
running (especially now that distribute grabs the cfs_b->lock to
determine remaining quota before assigning).

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200410225208.109717-3-joshdon@google.com
---
 kernel/sched/fair.c  | 13 +------------
 kernel/sched/sched.h |  1 -
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c13a41..3d6ce75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4931,14 +4931,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	/*
 	 * This check is repeated as we release cfs_b->lock while we unthrottle.
 	 */
-	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
-		cfs_b->distribute_running = 1;
+	while (throttled && cfs_b->runtime > 0) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		distribute_cfs_runtime(cfs_b);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
-		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
 	}
 
@@ -5052,10 +5050,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	cfs_b->slack_started = false;
-	if (cfs_b->distribute_running) {
-		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
-		return;
-	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
@@ -5065,9 +5059,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
 		runtime = cfs_b->runtime;
 
-	if (runtime)
-		cfs_b->distribute_running = 1;
-
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
@@ -5076,7 +5067,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	distribute_cfs_runtime(cfs_b);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
@@ -5218,7 +5208,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
-	cfs_b->distribute_running = 0;
 	cfs_b->slack_started = false;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a576..7198683 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -349,7 +349,6 @@ struct cfs_bandwidth {
 
 	u8			idle;
 	u8			period_active;
-	u8			distribute_running;
 	u8			slack_started;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
