Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF4C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B35224650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mieIz9k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgBZSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:16:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34177 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgBZSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:16:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id i10so4046153wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kEtj9OGTr22Vks60ZU1zaux1zdrNeTID9OslwV15BQc=;
        b=mieIz9k96KerE+V4iKD3mwJJ9CtVbovh3AcH1YTnH/svnH8IERTtlP9pq8kZuSgKgN
         UYyfVA5vNoNMNZ5wv/kd/H1PNmQdCfS+GUPRaGgcsgNp1MpdQ1xXGnMkCJXxlPaGsht+
         MdgB2MAGozpwE1ElszKlmfn+SNC6N5wTV1TZB7bu69q+/0qEwIWIWn1kUGL0NKW7OGn6
         rdv+pMIBFL/nXIjm5q2wVLMru2IwuJ0lfFkNBvCz+lo2wWTePsLRDYdaL0aGidXSs4+l
         +HpaWU+odZf6j3UrLHKJuYF7unHeeDAfd6V1svihXv9S6lGefieRP/QRAWVICPJcf8Ei
         /1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kEtj9OGTr22Vks60ZU1zaux1zdrNeTID9OslwV15BQc=;
        b=e2h0l4knpi+z1PTHCqOo9vrIzNeobasfry86cAsTiXOn63YqvjqotB9HI6XD/GrX4b
         sVO+3+OzRxwLP7qwVHPqUmg2gAvzc8L/RYQfsOkT3ieuVyPWMAJwk5ZLSn95fB2wcDI7
         EleI8iFONKJCCDWJnsr5cmggRe9xjRSd22ubteyZ/zo7EBV73Kgf5Z0QmwCUIOFrYlXG
         vMAdMbcg/ZHZhLHM3Z+mNeWlTx13W9gnFnLlEmDBsYPr9/f6olydB36LeddRGnPnrB+7
         Ywr0/dt1l6LitpOsSCbM+TEUR0kLeWeM5k7xe4p/4UCn2p602cGtGgnRe8yeJFfs/DLk
         BQPw==
X-Gm-Message-State: APjAAAUBUWShJsXYYiGL93mxyaAWOAvKEop6rSUaFLW/zu4JhSjFfQm9
        5Q4W6rB5tVy4Khy+cEbNYAJQLw==
X-Google-Smtp-Source: APXvYqxxH1TobAB/xV8rU4ZOc7LMLrZQlJ+1c9kv3YmkC06G5fV00cBnx9tIB3PYcQt7Hw1X0oP62A==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr134558wmd.39.1582741004862;
        Wed, 26 Feb 2020 10:16:44 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:41b:487e:9055:34c1])
        by smtp.gmail.com with ESMTPSA id o3sm4644638wme.36.2020.02.26.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:16:43 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, zhout@vivaldi.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix runnable_avg for throttled cfs
Date:   Wed, 26 Feb 2020 19:16:40 +0100
Message-Id: <20200226181640.21664-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs_rq is throttled, its group entity is dequeued and its running
tasks are removed. We must update runnable_avg with current h_nr_running
and update group_se->runnable_weight with new h_nr_running at each level
of the hierarchy.

Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
This patch applies on top of tip/sched/core

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..6d46974e9be7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		else {
+			update_load_avg(qcfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
@@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		cfs_rq = cfs_rq_of(se);
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		else {
+			update_load_avg(cfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
-- 
2.17.1

