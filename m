Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58871CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3652A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHV0u0r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgEMMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbgEMMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:33:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:33:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so20672513wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7Tl+umAXxaFZmg+h3MiCh9BcwGGX463rT+HMe9WI5LA=;
        b=UHV0u0r/kHH4lbu6GZhNTqQ9tSIOrkGR3f8OXUawKg3g1tJ6mn3eZTxtmnY+VTqvGQ
         7LEovhQsVTCKSfVH+y3dWSaHYramda3shcZVjMARZhTy7KB5rsIH+mmpEDBw+gRvHHYZ
         EGQ0CxJrSlCAizFO2PuV9jnUSSo4Ko3MwjbRVT2SD+Up8U8jV+vJymRU/2K402yJITV1
         O59QELcxpp8pwUnFLSdlwV9ybvYZvq1Uc3xWiyZ+q9OG8ZLV6leBzBCrLKEeXLdmOlV2
         jxOkCeMHghOZvHzBKr+zMGYiBJuvUgXXi0GfF4L8TLeuyd93dapz0uxEmnr3MZ4SfeAi
         Je1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Tl+umAXxaFZmg+h3MiCh9BcwGGX463rT+HMe9WI5LA=;
        b=SWLyfJaP+1lZ8hcds85gWxWe+/Za5cfuXDGfouOVFE2w7iRSKlVsh5mQQmG5dJILYH
         CzCW+wncwsjxm8mrsVvCjC+D+h6XCYWNaNxpr8M9WAQoqmqgxWfm3tY7c+FdVabQwPB0
         jyiOXmih4E+6eF/RWS8SOdKTONLeB3WbMXnOv8wYBbvDS70GbL43u/+PEIT7FWl4ODft
         HG2EPqT3S9arwi3QtT6rDOmDWyGOsez1JZp4vi+DLO7/l/e1tDBcmRICNKahnWl5liUA
         isTnlMpTFjbSSJ8BmPz56g9kqv5mi5fFExS/LEyOJTSuMvT+n9LkN9uT7dupKsWKR+xG
         qaTg==
X-Gm-Message-State: AGi0PuZY7y8BCSogOY4PEh07tc5wC7yQgD2ScSKnDkXYbJUynEWqyu3a
        gzRz2nShyrlsYZmHgbCvLcRVPQ==
X-Google-Smtp-Source: APiQypJhCAbtd9K0Y8U+mVUBCdcWU2VqkBp4qNo26VbOChCtUCg6fR0LdzGitpUN5VhAopx9S0Q5Tw==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr32538857wrr.360.1589373219397;
        Wed, 13 May 2020 05:33:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e00f:4685:acf1:ea5e])
        by smtp.gmail.com with ESMTPSA id o205sm22065190wmo.32.2020.05.13.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:33:38 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, ouwen210@hotmail.com, pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: enqueue_task_fair optimization
Date:   Wed, 13 May 2020 14:33:35 +0200
Message-Id: <20200513123335.28122-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
throttled which means that se can't be NULL and we can skip the test.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v2 changes:
- Remove useless if statement

 kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0c690d57430..b51b12d63c39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5513,28 +5513,29 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                        list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-enqueue_throttle:
-	if (!se) {
-		add_nr_running(rq, 1);
-		/*
-		 * Since new tasks are assigned an initial util_avg equal to
-		 * half of the spare capacity of their CPU, tiny tasks have the
-		 * ability to cross the overutilized threshold, which will
-		 * result in the load balancer ruining all the task placement
-		 * done by EAS. As a way to mitigate that effect, do not account
-		 * for the first enqueue operation of new tasks during the
-		 * overutilized flag detection.
-		 *
-		 * A better way of solving this problem would be to wait for
-		 * the PELT signals of tasks to converge before taking them
-		 * into account, but that is not straightforward to implement,
-		 * and the following generally works well enough in practice.
-		 */
-		if (flags & ENQUEUE_WAKEUP)
-			update_overutilized_status(rq);
+	/* At this point se is NULL and we are at root level*/
+	add_nr_running(rq, 1);
+
+	/*
+	 * Since new tasks are assigned an initial util_avg equal to
+	 * half of the spare capacity of their CPU, tiny tasks have the
+	 * ability to cross the overutilized threshold, which will
+	 * result in the load balancer ruining all the task placement
+	 * done by EAS. As a way to mitigate that effect, do not account
+	 * for the first enqueue operation of new tasks during the
+	 * overutilized flag detection.
+	 *
+	 * A better way of solving this problem would be to wait for
+	 * the PELT signals of tasks to converge before taking them
+	 * into account, but that is not straightforward to implement,
+	 * and the following generally works well enough in practice.
+	 */
+	if (flags & ENQUEUE_WAKEUP)
+		update_overutilized_status(rq);
 
 	}
 
+enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
 		 * When bandwidth control is enabled; the cfs_rq_throttled()
-- 
2.17.1

