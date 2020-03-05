Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4A20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUWKVYQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCER3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:29:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCER3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:29:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id i9so7277541wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mSTmAp0rfR9J7Hed09IG7hx2tP1xp0jyfIKXVq+ZwgE=;
        b=sUWKVYQ40eLJIHnPchTFldewVKQFE3f8yjOdp9kDqduM2qpYf0aXWRJO5yopu+keCa
         kTKI+og9iuRbk3GSwj9NZRwU5rJc2hrFkZDajJMQ5EUZT3SDwR5a5jlnq+Yek/Dv5dC1
         qEJSbc6/o8kuDIXe87VDBT5YPj0OgLSsH9Io7JdnXmFLVf8Q4G7bXbCa0PL9DOihE0tf
         xiP+kQOsavuUC9vxOdwJN4ZCNdxbDT334H2YL/2ujL4L5hrZwWnGgx+9lc9rYKIAXut/
         RYkZv6FhdNBsxQ2HjLIFFtd0yucezhM/cobHYyAqjZEm84277DuvngCQ9pPrID190LYU
         MVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mSTmAp0rfR9J7Hed09IG7hx2tP1xp0jyfIKXVq+ZwgE=;
        b=mjgOV7qv8v7MrX6Hl+Hwd2JEKeQLZoWAQCmxlbhihA0OIlr86+FLn9ElYrMqrwCvYL
         IYwAkCZXNy2MXZnbk7MQnTp+fCGd+RizVH6ELna/CTudJf2wc1PZvqqvJ2v4yA6qkFLr
         81uiTVHRnsXkv+Sq9K6WzttEQC1LiW/4u6Z/FYRRz1XivOdZY1icThVH/sWaqRyzWc3F
         9RSdyiQg1S9nHzmAbFBmmEvkzuGP7GckUOu5EWSOfN5GonQoL3QhioU1vvFHQXTkRs5C
         pdRHnAnCpqTVwReAsuUyjTHEFvDdF9y6PTsUbMgUWC+6UzBgfYcxwlH97knXzdvST/kE
         H9Vw==
X-Gm-Message-State: ANhLgQ1plIqsIOu9ErvxkvX1gLvZStTDiizh1L1Pv2cahlCwzGTXdt6I
        6MxixeG0MN3jJtl2VAM0PMeexA==
X-Google-Smtp-Source: ADFU+vschCTogHqskxov+/kO32sj0Aak29Vzr+6W6mJMwbg79afXY6NZsPxeNXwXTIavWV9v6Dxdyg==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr10521999wmd.22.1583429371284;
        Thu, 05 Mar 2020 09:29:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d5d0:80d7:4f6f:54be])
        by smtp.gmail.com with ESMTPSA id q16sm30120305wrj.73.2020.03.05.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:29:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] sched/fair: fix enqueue_task_fair warning
Date:   Thu,  5 Mar 2020 18:29:21 +0100
Message-Id: <20200305172921.22743-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs rq is throttled, the latter and its child are removed from the
leaf list but their nr_running is not changed which includes staying higher
than 1. When a task is enqueued in this throttled branch, the cfs rqs must
be added back in order to ensure correct ordering in the list but this can
only happens if nr_running == 1.
When cfs bandwidth is used, we call unconditionnaly list_add_leaf_cfs_rq()
when enqueuing an entity to make sure that the complete branch will be
added.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org #v5.1+
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..bdc5bb72ab31 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4117,6 +4117,7 @@ static inline void check_schedstat_required(void)
 #endif
 }
 
+static inline bool cfs_bandwidth_used(void);
 
 /*
  * MIGRATION
@@ -4195,10 +4196,16 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
-	if (cfs_rq->nr_running == 1) {
+	/*
+	 * When bandwidth control is enabled, cfs might have been removed because of
+	 * a parent been throttled but cfs->nr_running > 1. Try to add it
+	 * unconditionnally.
+	 */
+	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
 		list_add_leaf_cfs_rq(cfs_rq);
+
+	if (cfs_rq->nr_running == 1)
 		check_enqueue_throttle(cfs_rq);
-	}
 }
 
 static void __clear_buddies_last(struct sched_entity *se)
-- 
2.17.1

