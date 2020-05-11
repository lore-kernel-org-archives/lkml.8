Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942D2C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCE4206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8BK764V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgEKTOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728613AbgEKTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:14:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6250C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:14:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so12370763wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HoHCXq7xs2z6+L+uw2r3eVgUV4COK06n/4D/FERFkig=;
        b=g8BK764VG8GD3CxE4YfxZFxfzJmL15XbOV1PShWIkBsENN2E/Dgs9ffW+1e9Yq6Z3d
         TdXB+RfPht+ksfcJZ4VMa7hEwk3X376v/HXuMuVrH4c1BpiG9AiC8YC0V+BmTkITzfwN
         jFOkKQzPl+IAspENhfMWctMXIb88ans9SElJ7nuVUHP0Txqw6A/q1zjR99YUefuemyAX
         TaNnGV5EzuIy6r/t/V0Hfi2BI7hVevNXPRO2Y4tImfgngejghkGTSR4ZXAiGb6zPau63
         L3gPToeZ6o6YBY6cakFXhZHqVKMvVLRzpG65Cr07CSS2gNi3fBEhMtCZuRY8XEGEStXP
         3l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HoHCXq7xs2z6+L+uw2r3eVgUV4COK06n/4D/FERFkig=;
        b=EIvI9ORuZIGkhpqJJzOtyYB85RV0ziUZbD1BrxFrUNYam3NOhGnwAwXQ9leuR4/wsk
         qhYx9+Vqo/xLzUeg3p6flhPX/YAt3yfm3+TQPEb5YF0+HvOVjz84proa9z5uaXqsAC9w
         0qxIA/pKTWKykfP0xMhgaPszo1++t+yCGgU+/4xEBAPumZdjBEcVRC/51FRLq3FEnrvm
         Kolov+Ekh6SHDFKBuW+JORtaWv3CMMOO3Nqis3FR5VjQWUwuZeCxj0PLJWtfCkjsQUv+
         aEcq8+vqwM1ibfeoHnkavhR4SCzunbHalKSZmJGoOS4pW6Szcn0FgP22p3Xr241hlcVW
         ePFw==
X-Gm-Message-State: AGi0PuZCY+HqH84h8jE2xC/XB4S+QECynos/wABHBSw9oXsJ9ihS4nH0
        5WmrR/m5T5A157QGrJmmS2lQAA==
X-Google-Smtp-Source: APiQypKzwVlG5mv65eC+f3pxsk2Vs6Yz84l2xi6UZozNCMOsC2xckaCVPQV+eUuE4Dix1bYGnhGXeg==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr19409712wrj.138.1589224452506;
        Mon, 11 May 2020 12:14:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6467:c897:33c1:f11e])
        by smtp.gmail.com with ESMTPSA id q74sm21428117wme.14.2020.05.11.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:14:11 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        ouwen210@hotmail.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Date:   Mon, 11 May 2020 21:13:20 +0200
Message-Id: <20200511191320.31854-1-vincent.guittot@linaro.org>
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

Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

This path applies on top of 20200507203612.GF19331@lorien.usersys.redhat.com
and fixes similar problem for unthrottle_cfs_rq()

 kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2450c2e0747..4b73518aa25c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4803,26 +4803,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
 
 	if (!se)
 		add_nr_running(rq, task_delta);
 
+unthrottle_throttle:
 	/*
 	 * The cfs_rq_throttled() breaks in the above iteration can result in
 	 * incomplete leaf list maintenance, resulting in triggering the
@@ -4831,7 +4849,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		list_add_leaf_cfs_rq(cfs_rq);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.17.1

