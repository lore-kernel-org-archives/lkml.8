Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D9CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E362054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoxZeyCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbgEMNzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbgEMNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:55:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:55:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so20967098wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ro4/47F9waKSpnFpewvvgqwDEwks4O/QZAQ3zybYolI=;
        b=KoxZeyCl0MquxjpBtpVPCTxmRlo9/qkdZ5yoimjY8dggBtI9I0SUZj0OFgcpitMV+x
         q6FCjH+17XtfVp9SPd0YMNjqDoh4Weqw6JhNLGpbrTih9W4IO88V+WvWtMnn61DdPOHl
         mQw1MtCg1gWqgHeyScdizUWh19/QoUnNuzYbPNZtcSOUdlHQFOp+fqbN2gddKIsIPCdT
         1HajbY7BKPqdb4AVSwaW1r8nnPi8cqr3mWUxw+GlPP2NWyMgRgxz4fYHU5wDFTwtxckQ
         tMZq4WS4hv39M8WObHBAUknpNoDplqgAJyz1IvYSZNxvewhFLALuMhS+VVk/81xuLs59
         TKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ro4/47F9waKSpnFpewvvgqwDEwks4O/QZAQ3zybYolI=;
        b=FIDmlF7O8oqHhx5VNp3CMiIQT1chPKpkD0eBK/TGMBkZHjQU9udCd+aZV+C68N5B07
         WFvJGAv5rolFNkE/IEN43iNi4YJVYEoVOiYl41uR43pzkE4eytyH/tNu2Mf5xlMmLmvZ
         JlF/j0Fe2KrGX53MbdO0Gd5gO1GB0gV5XWSEE9sxUpHm06kVY6SfKIUsoK44bv1JwpTY
         FcnV5f1NXt5nOyjhh1Nzl7KYpf7JXlalyqONjTLEsMpzMh9wqk27p7YMsxtowQhoFJAA
         y4k8/meWIJNt19gfeRA+s0oIjJmLVOirLQTUxGJirK4OIumXju+g+nW8yh3QHAARuGpT
         BhoQ==
X-Gm-Message-State: AGi0PuZ/b6hlCzaq8BRdVcd6Snm4TOxUt5jRT3jKh6InI2J/jFVcsHT8
        WSdIE+BZYdzJAd85LuuucxWIUA==
X-Google-Smtp-Source: APiQypKOzHGD3/QzZbuX9NOKKZvOQa5sJE/yTtR3abF6UhLgskodLDJRBKv+W34QhnOVj16eJcOptQ==
X-Received: by 2002:adf:afe9:: with SMTP id y41mr13843907wrd.56.1589378133265;
        Wed, 13 May 2020 06:55:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e00f:4685:acf1:ea5e])
        by smtp.gmail.com with ESMTPSA id z1sm36031220wmf.15.2020.05.13.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:55:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, ouwen210@hotmail.com, pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Date:   Wed, 13 May 2020 15:55:28 +0200
Message-Id: <20200513135528.4742-1-vincent.guittot@linaro.org>
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

v3 changes:
  - remove the unused enqueue variable

 kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e12ba882663..9a58874ef104 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4792,7 +4792,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	int enqueue = 1;
 	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -4816,26 +4815,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -4844,7 +4861,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		list_add_leaf_cfs_rq(cfs_rq);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.17.1

