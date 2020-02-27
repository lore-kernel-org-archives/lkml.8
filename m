Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFFC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C224697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xijMOUDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgB0Pl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:41:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34447 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgB0Pl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:41:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so3989590wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M3j40OKK4U6uWN06G/fYOLI3L3xxzuwlhzAGzzR43eg=;
        b=xijMOUDsBuXk4G6uzAtGxo1bbRbcKNtfBurzActX8rMDOgJd4jQ2A7AqlF2BuegX+/
         JYI79/zEcmdGDrBmECW4K6oJ9P+/7BdxYHHLmj3N5I1AYQyKeH9QdUAoY9x6gGWkvsuo
         5UoFoaKguZCKAXpmwqx0UsMPjOjmAKqVplkv/Pu9nHl1BgZNikyq6hVD0RP0YpDOQrQ3
         lNZQgAJpkCCf/P+rdu648zxUBsPrQowSPyrE6sCqBdmjVCx6AbteXrHH6u5UgJqUQ21Z
         wwlQFgHBk/xdp9+B69I/i0bEIABsgBMaLAdgafARkweJWNZRZE2+VbsTqQ1HaskNF+dc
         R2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M3j40OKK4U6uWN06G/fYOLI3L3xxzuwlhzAGzzR43eg=;
        b=W4rHmVHN+m0xq7/HNHMiK3OYjlBPzQO8I6DXKWFvdbaX1m7QU/NkIdo+/jvyC3VTuB
         XiUstwxA7he1a/rkakkdp/WTiC9K9d91K2PRCtwVjFdOvWjlmaY80zr3HWFD+IKayZjU
         zrvqrQyP/9thx+BivEASB0lEAH3+FilXBLbHwXsjP5p21a8foH0oz3+c05ORFBBhgGtO
         RONmxeDYI7kSYGIVH8hBJkwsDAwxrwgPOczOXJ6Hj6nmowpi4IgwLJG8wyivbrk1GdI2
         UNlS5GnZaYoi70qFWOgS+pGsbcVdeYrE9K62+0gUWxjzJYmAc4MTW4c+otY3yCNhbMSQ
         sWJw==
X-Gm-Message-State: APjAAAXKGpRKqGHrmth3MA0KsS7otZBKrBYpcpgBwFskSfMCTJ9skE0v
        5oYcqOl1AQJn9+u9fSFkjvFZHQ==
X-Google-Smtp-Source: APXvYqzJuiGaLB4hoVwocSFHzYwJq1BzbF6efJI6WmyTwG96sVfyqfxfFPQizw3LzCSQTReBGer5yA==
X-Received: by 2002:adf:cd88:: with SMTP id q8mr2589054wrj.286.1582818115124;
        Thu, 27 Feb 2020 07:41:55 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d4a1:5bd6:6f98:265b])
        by smtp.gmail.com with ESMTPSA id r3sm8414883wrn.34.2020.02.27.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 07:41:53 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, zhout@vivaldi.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix runnable_avg for throttled cfs
Date:   Thu, 27 Feb 2020 16:41:15 +0100
Message-Id: <20200227154115.8332-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs_rq is throttled, its group entity is dequeued and its running
tasks are removed. We must update runnable_avg with the old h_nr_running
and update group_se->runnable_weight with the new h_nr_running at each
level of the hierarchy.

Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
This patch applies on top of tip/sched/core

Changes since v1:
- update commit message
- add missing {}

 kernel/sched/fair.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..22d067279269 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4701,8 +4701,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (!se->on_rq)
 			break;
 
-		if (dequeue)
+		if (dequeue) {
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		} else {
+			update_load_avg(qcfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
@@ -4770,8 +4775,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			enqueue = 0;
 
 		cfs_rq = cfs_rq_of(se);
-		if (enqueue)
+		if (enqueue) {
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		} else {
+			update_load_avg(cfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
-- 
2.17.1

