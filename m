Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D039C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BAC2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcTgBQBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDJWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:52:47 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:57720 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJWwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:52:47 -0400
Received: by mail-pj1-f73.google.com with SMTP id np3so3260609pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TmIZI9TKT7lpeEk8rdIESevHF4Y3KmeRZOML5Cjbcoo=;
        b=YcTgBQBc97ZnvmKzuQ1nw5UtfFGflk+DgqC4Sf44g4BgnrJ12h7U5NrA+H3u/TDrsr
         O8NaSIs/hv66VjYoFwpn9x71IkZ5/uOirTw4EH1sDLX0mzr+h5fCCJ4YU63S6Bf8IuoQ
         gG/QhhUIFaaqRjuV3MtnN04gOuYn8AmTXVnAYhvAFY4jRv/twYbI+SBNAm4n4g16NFXw
         cK3du3oFp2ikvUPTXpLxmzPVxOj96eRGFPOZAkGSiyLd+pYoDD1oQcgivHuUBAwqVuCl
         QqG7HjRStQVfjkon2azhobVAh65pRW79OFov+GEjtVo4K9tUit5+fo7MRBBDhy1Qr72B
         Galw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TmIZI9TKT7lpeEk8rdIESevHF4Y3KmeRZOML5Cjbcoo=;
        b=OdrzPLrAvyhaCQbD2L4ej2x6pOX1zQCXug6Dki7YkLdUbDZ6WhS0p87Ijk4c5j9tAv
         mZ1lMUdK0kiHM8PA4LL35ZqS2MUHua62opvvle4LQMF212CDk9MiKqAuRoixjjRkpJYi
         os6iFd8dx/5f2APSdBkqNkOBKHJsrLCGuUsrJPuJHuohPrR+/6KSB94q8H+cKNfeBHR7
         18VYmVbO/Ovh7hRhb10ahaCBZ99i692oUbwS0LJeFHNuNVWEeR5g/W4vhMeBUxmHyfOv
         pnvkmxBjYVj0fiEpVHIrrtYFy4O7s1uqo3EnKTPAF8unYgBOYSvsxgvhdwVpFoTDdY3A
         XHLA==
X-Gm-Message-State: AGi0PuYiLKyUhmfWqo+GXXqKqgmHY/u5uiIMRqy+60oTI53esYt0yHGy
        f09nMEE1ElmQCtlyd0T4Fos97tIcTN2d
X-Google-Smtp-Source: APiQypIQ1zvPjtacOPKpElUEuTgnIhqM2AYaVckwuzP/Cl52UlxYC2mjNrZQ8rRJTZTyD3nUWtVKRZBkMwG4
X-Received: by 2002:a17:90a:1954:: with SMTP id 20mr8315510pjh.106.1586559165180;
 Fri, 10 Apr 2020 15:52:45 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:52:08 -0700
In-Reply-To: <20200410225208.109717-1-joshdon@google.com>
Message-Id: <20200410225208.109717-3-joshdon@google.com>
Mime-Version: 1.0
References: <20200410225208.109717-1-joshdon@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 2/2] sched: remove distribute_running from CFS bandwidth
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Phil Auld <pauld@redhead.com>, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a revert of baa9be4ff.

The primary use of distribute_running was to determine whether to add
throttled entities to the head or the tail of the throttled list. Now
that we always add to the tail, we can remove this field.

The other use of distribute_running is in the slack_timer, so that we
don't start a distribution while one is already running. However, even
in the event that this race occurs, it is fine to have two distributions
running (especially now that distribute grabs the cfs_b->lock to
determine remaining quota before assigning).

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c  | 13 +------------
 kernel/sched/sched.h |  1 -
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3fb986c52825..24b5e12efb40 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4930,14 +4930,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
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
 
@@ -5051,10 +5049,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	cfs_b->slack_started = false;
-	if (cfs_b->distribute_running) {
-		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
-		return;
-	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
@@ -5064,9 +5058,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
 		runtime = cfs_b->runtime;
 
-	if (runtime)
-		cfs_b->distribute_running = 1;
-
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
@@ -5075,7 +5066,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	distribute_cfs_runtime(cfs_b);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
@@ -5217,7 +5207,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period_timer.function = sched_cfs_period_timer;
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
-	cfs_b->distribute_running = 0;
 	cfs_b->slack_started = false;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..7198683b2869 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -349,7 +349,6 @@ struct cfs_bandwidth {
 
 	u8			idle;
 	u8			period_active;
-	u8			distribute_running;
 	u8			slack_started;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
-- 
2.26.0.110.g2183baf09c-goog

