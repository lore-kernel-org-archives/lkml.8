Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BDC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B616208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/guVyXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCEHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:48:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54288 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCEHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:48:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so5039853wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FFJ6o1zjl9jLzzbJM7PqpJMDWRb06GhMduYAoUnF2u4=;
        b=P/guVyXOhD1+yV+IQUrHP3KolJl76FWNpM6xPtlp2/zifZPUhUhBRXxiGcn+ET3GQF
         yCqZN1chQ3BE939FVaOi3GN6EUlwLTV1ED1pIn16hFXila0fPh6ySyMIb58Jx04maGKV
         QUvyp1ezPf3DNF/PXalI+ORR+E5DNqwSIhHbgEAj2ibbWFvVVXzenL7Xs99URkYhQ4TV
         MA/NniO6LSsF5KLIHz4IS8NNRttHQwL8104SM0VOlTZt/6x8qlLiUG+6urd6JMGcoCtX
         XRg5jZcMVZPYb6MFQdzHE5dUva0ewtM1lvDiFoCGiTqXT2jlED1r7FN1OS1PrtZOm8E8
         ISEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FFJ6o1zjl9jLzzbJM7PqpJMDWRb06GhMduYAoUnF2u4=;
        b=l4DmmPyZyPaGIXhJzoNA81ESC5/FE9qW3nrLezKt9Mxw6LHMy+Bz1fOfijt3jxMH3e
         gIWkVOkr6PeHMICeuca9ZFkffM3lg7IN4Nh2CoB2A4X8gn12IbRQ8nNtaXZzQWyhKErS
         jdUfEpNTJ/rviOrC6cLBwB8mQGJMuv6+KcW/KdI6hz9oe59QDTaOKJL1SAIfTQHmJ5qM
         JAmWbniOzrfUckm63N6fQdAwzX8sHYYX6gFoBGMplaw1PqaBmYhpM0oxWyStXwyoak/M
         DTHzvQwg1/IKQf/6wtgE4qj++6ScBH12wdpyUjtseoJS0Gy7z+8t6X1zlk+jy8MFUOrr
         v51Q==
X-Gm-Message-State: ANhLgQ3ZNNLtEGF3PTfHsETN7omQ4uCtKR5zqU4rLSgxNm0gtQibSLIm
        pj/6VdmbAjNXEACmLTODCAAEd+k2cGA=
X-Google-Smtp-Source: ADFU+vsSY43WfTWUna1yPvCmao0xMwnFjBtB5SR/R1mWbNhb6cVMosfLeGGQSfkLAFAROiua3reVYQ==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr7815132wmf.162.1583394514710;
        Wed, 04 Mar 2020 23:48:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3151:b3b6:32b9:e36c])
        by smtp.gmail.com with ESMTPSA id l83sm1616814wmf.43.2020.03.04.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 23:48:33 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, zhout@vivaldi.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair : fix reordering of enqueue_task_fair
Date:   Thu,  5 Mar 2020 08:48:29 +0100
Message-Id: <20200305074829.22792-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when a cgroup is throttled, the group se of a child cgroup can still
be enqueued and its gse->on_rq stays true. When a task is enqueued on such
child, we still have to update the load_avg and increase
h_nr_running of the throttled cfs. Nevertheless, the 1st
for_each_sched_entity loop is skipped because of gse->on_rq == true and the
2nd loop because the cfs is throttled whereas we have to update both
load_avg with the old h_nr_running and increase h_nr_running in such case.
Note that the update of load_avg will effectively happen only once in order
to sync up to the throttled time. Next call for updating load_avg will stop
early because the clock stays unchanged.

Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..5b232d261842 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5431,16 +5431,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto enqueue_throttle;
 	}
 
 enqueue_throttle:
-- 
2.17.1

