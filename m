Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE6C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8B7206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlOqfV63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBKRrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:47:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51175 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgBKRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so4722669wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iv4momfx4DeR2AHHXkQ3nXPbGtYSA+fYWPTobrkA6Ps=;
        b=PlOqfV63jbhC2/rzf1lgDorna98TtVwN6FQjQIQWzDMFSgbRApXRjdQ0qDfhCONhj4
         pdYUYY9A7pWuGxCYFpOSA/objnBKGXt9JCFpE8RFnOsFMFhMUhz9wF+oX+Lkp/mK00yv
         u9N9ceaOtrWtRBmkg5xUhGV6A14JQpw9Qu8JkOpZyBC2DmuVK6IZ+RwKEgfSP4HWsiq+
         WYc9InpZbVBspRUkYiOs9SQ5SV/0x7V4EnhEH0L7m4V7CZtDA3Pa5H4dznkOF18LJQKk
         D3Ear8rF4169Lsi8L+5K0NDlaxTmOOxzcpymXn44igedRZ2veLlKz1Ks4JVk068d2mWl
         lxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iv4momfx4DeR2AHHXkQ3nXPbGtYSA+fYWPTobrkA6Ps=;
        b=WN1J3HWIoUprMUNiMMAfFE5pRZ9TfFmedu6aGu/6JBjwNsF7mxp6bCPUGo7lcMTBng
         NzK35QTnNxQDR5qr7it6yffnE6cg8VauH6w4niTktSvDiQaMdefOUkTqrDqEwIeNjGQ2
         bjfckpznGwd1NQXL5Fs31oKqVuBMzkQ6y99k0+De1E4si7WQrP1T3WGC2QDfd46HEY3O
         TXWv+EcdjaiPGOLJN7G0in0SuE2tDR64yTWk2aNpOMW+CqZC/R8nzfaTEUFP6h/V7gYI
         j0BFzS6gTOMkt0CP38ijTHXlvE50jB+4InJwDTTUllmiv5ou5Qy2Q2uWOmfQYeTOOmD0
         dP+Q==
X-Gm-Message-State: APjAAAW/vYllK/bgXk7PVYlcIZTD+4hvHPjD/PTFizSu8u/T8O5HLw/z
        Yz6yBrPPk7+4YfZuAAqjPpJ5Pg==
X-Google-Smtp-Source: APXvYqzrFK2lF3Rw8Lut3c2VpLH4mC1t1em62YfaElCTSj8Fi0M9fzRifB7jxvuTGJBCoe0t2Arh8Q==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr7005393wmb.165.1581443224038;
        Tue, 11 Feb 2020 09:47:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39bd:f3e9:9eaa:e898])
        by smtp.gmail.com with ESMTPSA id s12sm6104764wrw.20.2020.02.11.09.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:47:02 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4] sched/fair: reorder enqueue/dequeue_task_fair path
Date:   Tue, 11 Feb 2020 18:46:48 +0100
Message-Id: <20200211174651.10330-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174651.10330-1-vincent.guittot@linaro.org>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The walk through the cgroup hierarchy during the enqueue/dequeue of a task
is split in 2 distinct parts for throttled cfs_rq without any added value
but making code less readable.

Change the code ordering such that everything related to a cfs_rq
(throttled or not) will be done in the same loop.

In addition, the same steps ordering is used when updating a cfs_rq:
- update_load_avg
- update_cfs_group
- update *h_nr_running

No functional and performance changes are expected and have been noticed
during tests.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a0ce83e835a..a1ea02b5362e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5259,32 +5259,31 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running increment below.
-		 */
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto enqueue_throttle;
+
 		flags = ENQUEUE_WAKEUP;
 	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		update_cfs_group(se);
+
+		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 	}
 
+enqueue_throttle:
 	if (!se) {
 		add_nr_running(rq, 1);
 		/*
@@ -5345,17 +5344,13 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running decrement below.
-		*/
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto dequeue_throttle;
+
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5373,16 +5368,19 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		update_cfs_group(se);
+
+		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 	}
 
+dequeue_throttle:
 	if (!se)
 		sub_nr_running(rq, 1);
 
-- 
2.17.1

