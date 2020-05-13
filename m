Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F9CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB94220659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd2IYNlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgEMMe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgEMMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:34:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28FCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:34:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so28329329wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Uq9qKVIIPRYpr+ZQGu650yVuCDvwMsaOv+GcVNz90vE=;
        b=Qd2IYNlukTFWmwSZruZbofPgqNrcrOGxY8Cyjg7avgLFsvHQbTXXbphDYj2nNEEEkU
         bCaBVOGqK0DBq4pbDZXrmoDiKPFvfsqeUVWNX8wiFmAgJDsMZf9dHSoU6/hDcSIH3EFN
         qVvsb1EfFhiclSEYlwzR+orrCg0DfiPa+n0hrr4Smrw5cZhLrdGxyIBDr8bDOWQvLHd+
         zbgdSc1sYYzP0Jq7fbuJuT0FbhbFP0W3IFcYHWHHE9H3p8expaX9YqM0aly+SPjixeiI
         c4NBAW7AIYkPC1NWW3JReGqMLQVHC/8+HUgKG2eRuARe3/StauupQhMdyK+ZGbzPUvah
         GUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uq9qKVIIPRYpr+ZQGu650yVuCDvwMsaOv+GcVNz90vE=;
        b=VybI5lVVN1A7DCCDkhnrU70X6Zm6vMkYc/NDXV3ZO5qyNapvIdlUg0Kcx0xxv3fUhi
         t/QCFu/+4BuQGuExE2jtgAPz6q790UPD+kc7vuGTLkv09nuvpkOoUOt9rjUuEn+B5zPl
         OgTuRyvBuJo/PWbTMxGXpO1xGD/YAn73c9+des2q2tDbOYWcS1Jqvs7XYnsyKZafQJJx
         WXrADDXarvzt37S2/SGT96NSG6Pr0YKB+b9n7GsEZDEjwFG/uRDW+fng7fP8gCuZUIsS
         aahMbzs/nRDfWLe2X1mbqZP9F+KFM9uHmC5VWyYdXEzj1Qe0BT1T6aGbHDa66bac137f
         4oJA==
X-Gm-Message-State: AGi0PuYBydUnO1s9px07TYEkzyNDDeFr6G/T4n1HnkmCcK56q6hCRBu5
        dwsVHLoIfdqBdOscr/0xzy/Qww==
X-Google-Smtp-Source: APiQypKFoZv4Q26EIKFT7igUjecCo6aufRUX6mUQ50Zt7X4aP03lMS11ETsM++gsF0NLwCW06DvaZA==
X-Received: by 2002:a7b:c253:: with SMTP id b19mr22468669wmj.110.1589373266511;
        Wed, 13 May 2020 05:34:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e00f:4685:acf1:ea5e])
        by smtp.gmail.com with ESMTPSA id r14sm11742080wmb.2.2020.05.13.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:34:25 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, ouwen210@hotmail.com, pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Date:   Wed, 13 May 2020 14:34:22 +0200
Message-Id: <20200513123422.28299-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
are quite close and follow the same sequence for enqueuing an entity in the
cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
enqueue_task_fair(). This fixes a problem already faced with the latter and
add an optimization in the last for_each_sched_entity loop.

Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v2 changes:
- Remove useless if statement

 kernel/sched/fair.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e12ba882663..a0c690d57430 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4816,26 +4816,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
-			enqueue = 0;
+			break;
+		cfs_rq = cfs_rq_of(se);
+		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 
+		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
+
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto unthrottle_throttle;
+	}
+
+	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		if (enqueue) {
-			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
-		} else {
-			update_load_avg(cfs_rq, se, 0);
-			se_update_runnable(se);
-		}
+
+		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
+
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto unthrottle_throttle;
+
+		/*
+		 * One parent has been throttled and cfs_rq removed from the
+		 * list. Add it back to not break the leaf list.
+		 */
+		if (throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-	if (!se)
-		add_nr_running(rq, task_delta);
+	/* At this point se is NULL and we are at root level*/
+	add_nr_running(rq, task_delta);
 
+unthrottle_throttle:
 	/*
 	 * The cfs_rq_throttled() breaks in the above iteration can result in
 	 * incomplete leaf list maintenance, resulting in triggering the
@@ -4844,7 +4862,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		list_add_leaf_cfs_rq(cfs_rq);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.17.1

