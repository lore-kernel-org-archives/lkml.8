Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52539206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l97a+cx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgGBOoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGBOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:44:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7965C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:44:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so26332336wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Wr6vKnMO3nR7PwYZXjk1oOIxaUj/saExnI4Slj9N4J4=;
        b=l97a+cx0TaM3AUxoe/kVnhNZqVBd29cWNPPbRefY08EOqrMLotzojrk61/VPlOd5bz
         nYJMvzjtdWwkKQ2diVfN5l9sHtQrIIEJsWxhZRbPY9R+POe2+ylz+xx92yk1aJiibiwa
         +y/xZPjkFWITRwTAHWpvwm0Q2EJ/gOTOnxZNRbewGYTvPDDinuOq0MDhuLgUtJnnO1B2
         XnBJn1gSEtFmzZA7G2OvvN1UbDJLNAgOePcrVrCrDCvDc0IxbVFQDUvCuxVK8IFY95Np
         xZ4N0cp4d79vhy/4lv9Vmxgy0gjgT3u9n9U9NGsZWf4CVZDJIFcjJekAlSOB77ePAOkc
         fZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wr6vKnMO3nR7PwYZXjk1oOIxaUj/saExnI4Slj9N4J4=;
        b=SEATWGi1xxwDs7G87TsqdM25XDs8N9mF+sb945gpwMm9ajI9l1lP9/JmRW5e+QtqYS
         wGB9ezKqyKJvDJzQNGgve9p5DomzDIkXWycr6oejnql7CISnfdq4QSc+pg9jmzVUHm8v
         t0MoYToMDRbCOPnLJDxZI2AvAAk7/pO+ta2fyyqPR2Zz0UTLyBrElkDJJVJHjUdbmONu
         IPr1fohxxF5NZJz1Lhv+VeBMVIA19QZHzvXtbQxUxBGfWUdhtgC23VSFp8Ihi4kAftfV
         jRHqGy7tLI58oeX/yjPR4zDSxy6OYr76wOhXXZam38fDrZvk5uQAfnsOObqCoJUkQ/rL
         AjSQ==
X-Gm-Message-State: AOAM531WO8q0y5szAway7cmIHve0KIgKNlaXz1T9d7Gy1ZhNOJeVeBJS
        tUjDUjvXwqgrTPNztUNvFDcmZA==
X-Google-Smtp-Source: ABdhPJybx8XsqLOkBz76AaU2hDNLpuFYcTTluIwV2Pj2KXMBhisRKBOb5KCUdQE8zHcrFMcI4PIYtw==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr30410770wra.47.1593701039345;
        Thu, 02 Jul 2020 07:43:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:20a3:2f17:1ded:77de])
        by smtp.gmail.com with ESMTPSA id 104sm11557438wrl.25.2020.07.02.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:43:58 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: handle case of task_h_load() returning 0
Date:   Thu,  2 Jul 2020 16:42:58 +0200
Message-Id: <20200702144258.19326-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_h_load() can return 0 in some situations like running stress-ng
mmapfork, which forks thousands of threads, in a sched group on a 224 cores
system. The load balance doesn't handle this correctly because
env->imbalance never decreases and it will stop pulling tasks only after
reaching loop_max, which can be equal to the number of running tasks of
the cfs. Make sure that imbalance will be decreased by at least 1.

misfit task is the other feature that doesn't handle correctly such
situation although it's probably more difficult to face the problem
because of the smaller number of CPUs and running tasks on heterogenous
system.

We can't simply ensure that task_h_load() returns at least one because it
would imply to handle underrun in other places.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6fab1d17c575..62747c24aa9e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	/*
+	 * Make sure that misfit_task_load will not be null even if
+	 * task_h_load() returns 0. misfit_task_load is only used to select
+	 * rq with highest load so adding 1 will not modify the result
+	 * of the comparison.
+	 */
+	rq->misfit_task_load = task_h_load(p) + 1;
 }
 
 #else /* CONFIG_SMP */
@@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
 			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
 				goto next;
 
+			/*
+			 * Depending of the number of CPUs and tasks and the
+			 * cgroup hierarchy, task_h_load() can return a null
+			 * value. Make sure that env->imbalance decreases
+			 * otherwise detach_tasks() will stop only after
+			 * detaching up to loop_max tasks.
+			 */
+			if (!load)
+				load = 1;
+
 			env->imbalance -= load;
 			break;
 
-- 
2.17.1

