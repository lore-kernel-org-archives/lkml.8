Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD167C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A52467D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUbSXGIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgBNP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:27:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbgBNP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:27:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so11317583wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsG7nYRG2ez7Yu2vgAjQ2CySO/YYdEQuwwHAtfrdvuE=;
        b=xUbSXGIl5vB2+hyhqTnBfv7pJCX933FqucZ4uupnBMSqWMfswF8nmuWvd5UijDXCKr
         8A3b8uIYC39KDpSA/XdBSQpG6XodWVDMiSc+h0h8q2wCHzSOetD8Q0LnVFiz+MlCWvIq
         OMQ8A7165qqbQ4llDTNw/vNawkmFPHyX0G0dhqUQdispheBvDhFIvhoRypu6Cgkg7vnJ
         J4Ai9eszxNxAluVqJAjStzjkoBZjypPbdkBFP4vG0VWYU67T6VsCzijoYhc0VEUvx+pu
         +t98YgHDp0SvEmYjg7JgZCmo47qnDHQ2eFjTdOlp2j0/c/ve6Wm/Xvhn9dnsuFRwjqg/
         VLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsG7nYRG2ez7Yu2vgAjQ2CySO/YYdEQuwwHAtfrdvuE=;
        b=AslRMBuYbih4KYZrhDcVfk7cH6XqeU6J1avWeGu5kVDjEtDYaxNGf6vfOFJGaCEi95
         tQXAQJSimWwrBsp2OD7pZHLN0nw0nB89xkxjVmD0pcZlVnGPPiJ4qH6uFxeS6iKSfq3E
         Hs8V2HQ5LHvIN1P9DcChTDRNoTd5BXihLC+4D2yGBhiZibkTs3vm6XF59vEBd7vrw3nO
         cY2TZwSTje1ono5eF4xvB+nExuSa1pD9ZeCFupGb/Sg4pydjWgecn0sSjGdNiJsuY224
         usyAg3uxqSRY+YxkYv5NjN7wd3fG27/sVCt3afpRkgwewkZgOy2eBQ61nZQBi0e4aVB3
         hdpQ==
X-Gm-Message-State: APjAAAX8uNHoUyKjDgBv9zJPDWTDWtiSZDlM1SbQpM+/ufJ1ov3D0bIn
        xULKqUBCWNb7cDx+GijYQcKYIcYcxDeZww==
X-Google-Smtp-Source: APXvYqwz+A/zPC9fS92/sQ1izyYQlGEB+G/LNjzdpKdXtj2j2AqHdOkF78NxZjtrc8oWbgNYe9WASQ==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr4536214wrr.268.1581694061447;
        Fri, 14 Feb 2020 07:27:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b5b3:5d19:723a:398f])
        by smtp.gmail.com with ESMTPSA id c13sm7442963wrn.46.2020.02.14.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:27:40 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH  v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
Date:   Fri, 14 Feb 2020 16:27:25 +0100
Message-Id: <20200214152729.6059-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214152729.6059-1-vincent.guittot@linaro.org>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
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
index a7e11b1bb64c..27450c4ddc81 100644
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

