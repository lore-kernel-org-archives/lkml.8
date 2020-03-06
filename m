Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32020C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FCC2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgCvO6dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:42:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:42:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so1323169wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PULHRHRv1NcS1DTXiOzReliOO1hrod8ode7xlT9JULk=;
        b=DgCvO6dN5zDCdrCXcq6dW8mRLManLpOzQ33A1BJTV5eiTptZ+cue1zNOPD+ZTklD8v
         19UcQfG+6+Hbrvw/hDDRyGUoJWa0B7PD7JbFHNXUVUaghiSoBfjnMeXswcTr/ctKZ4NR
         10C3et6PgvUWtnqYI7XDpaEXBVFEGCTa3bjIKRFbG0r2uIcw1VOqVFj/ihYuTdMuMexK
         jSFIPDjxnXxvxKwQyIeze1mRgJfenWu8CKE6OVQ3wjJhiogQaJm2vDuPk1mvCSmdptVV
         xjgqizhsYhwdL/uZ/YpW3ll15n9X2hXSM0Aicvp76WMjw6DBGTCqIFU+OQDSjMGGmTlv
         hHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PULHRHRv1NcS1DTXiOzReliOO1hrod8ode7xlT9JULk=;
        b=ZkrooxCzYnjL4zrBS5Vw84P2xQktSUKZ+12f8UoEm7sL303n0+ysOWjAyxJwa1XQkR
         ps7JARXn2CuvCPTfRpqcnjNGOFVq2Ibd/+I3Nt29NqAmcHOjxQRvRt9K8JS3bacU3dkg
         kbiNuSR5GSFc6OA1ES684r4x5O0VRgv52ZDa06o4A5iRxRU4uH9G5Hj0/zJq/ObENdRr
         j+hOh2sVbEvQtgCKh1Q/pUqqIfqk/R/jLJthx7BfaxhtPeGymsGLv17BQlWx3BpgJrgr
         yra5dYtnNb5YwAVtb+ATplEMSe4U/M+4JJr2Hjd97vqdNo7hunxcbxQYl/x9hjUrPyaf
         V7Wg==
X-Gm-Message-State: ANhLgQ14jahGbrwS2izsDUDjXHltyzy+Pd3y6Imgwl+0SCAO7LXBxMUv
        hqeCTgJTR4414g1EkkHzNqpnbg==
X-Google-Smtp-Source: ADFU+vtoZe1frf3LfiepiX+74lgZwKyIIOjjXZp6B6LocAqzor2pXHkd1GWHQiFJ8ozL54v3Ckr14A==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr2751372wrn.377.1583484132106;
        Fri, 06 Mar 2020 00:42:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d5d0:80d7:4f6f:54be])
        by smtp.gmail.com with ESMTPSA id a9sm1221948wrv.59.2020.03.06.00.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 00:42:11 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, zhout@vivaldi.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair : fix reordering of enqueue/dequeue_task_fair
Date:   Fri,  6 Mar 2020 09:42:08 +0100
Message-Id: <20200306084208.12583-1-vincent.guittot@linaro.org>
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

The same sequence can happen during dequeue when se moves to parent before
breaking in the 1st loop.

Note that the update of load_avg will effectively happen only once in order
to sync up to the throttled time. Next call for updating load_avg will stop
early because the clock stays unchanged.

Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Changes since v2:
- added similar changes into dequeue_task_fair as reported by Ben

 kernel/sched/fair.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..ea2748a132a2 100644
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
@@ -5529,16 +5529,17 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto dequeue_throttle;
+
 	}
 
 dequeue_throttle:
-- 
2.17.1

