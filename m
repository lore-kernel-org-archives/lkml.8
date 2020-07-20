Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A75221775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNv3clhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGTId6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:33:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:33:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so24280496wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jw8oYTOE5+FmaB1olMEI3hg+LM7MiO8WRk1wy4m9+B0=;
        b=BNv3clhdJiptUfJITPPZsM7T6qY+qFQrZCdBNGPftPjP/wy5wC2A7l/4GRy70WQfe1
         TiYLrNWdr2EWNDQMouVx16ipTTQ4ZCHUyEjf1su9I/eapo82I8fqq66I9ObX9rvcDELX
         IHmlTbL/6hhJpNRZAf32+6jSDBrO+de534qcp2FRIjXv+h1gdkhyPLht2Cb4CVJraeCF
         ul9cBOMNGv+mMESxhpZd7fH6+631fp/L693HjqglAnEjeACKR/wSw5J2xgx2wH8fGFrx
         fuKG36ymFdU7GzlwVF5d7/RdTx9Pi9OnS41J9XWQHbGBgW5R17HABpGcx17MO3tFDZx3
         v1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jw8oYTOE5+FmaB1olMEI3hg+LM7MiO8WRk1wy4m9+B0=;
        b=SD7tIRBS6mh7grNhGDxZkHQj0vCDuSkCLDB8OiheR7mmD6SFGnA/b1kIc7n32RV2eL
         gjmmtwwTDtaPpYPGr4+gNWh/Eglz1OITzJPD1axAXtgIjgbL4EHgDFbBLDIvQqxiwDSV
         THixqBrgR7m5+XtmmdnKkicgfVvgGYN3+eKtJ21gmeZ4VIQRs4NOL9XWQJpApE8Ypuz5
         AwQfFhdvuWnomN6BY5S682y9H2HYmJBuqz2fxkUC/VpvSedsO3cC15B8yc8ytIj7Vhts
         IyWO3m5FeXoOYQ+wqUzSt5o58Sm6DqiFst0WiKnP4FXXp3c5+Iui36MmPxEGd4ZApqZ0
         /ZmA==
X-Gm-Message-State: AOAM532XLSGxqSrYgbuJIX3T9GcotrU0QFsUy12X73/v1imMXB21qVzY
        /Xc7B0mDQfUMreA7nNs7yYXIEQ==
X-Google-Smtp-Source: ABdhPJxMevzjEd3r6udQLlC9T47NEWDvnrSpKsHVSp9SzXWAeTdwTtia8GnMb4hDRwtFxkhQV5dyVQ==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr19793759wmi.19.1595234035983;
        Mon, 20 Jul 2020 01:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7da7:684d:4a8a:3f66])
        by smtp.gmail.com with ESMTPSA id s4sm23515200wre.53.2020.07.20.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:33:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     valentin.schneider@arm.com, sashal@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5.4] sched/fair: handle case of task_h_load() returning 0
Date:   Mon, 20 Jul 2020 10:33:45 +0200
Message-Id: <20200720083345.22101-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 01cfcde9c26d8555f0e6e9aea9d6049f87683998 ]

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
would imply to handle underflow in other places.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: <stable@vger.kernel.org> # v5.4
cc: Sasha Levin <sashal@kernel.org>
Link: https://lkml.kernel.org/r/20200710152426.16981-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f81e4ae844e..9b16080093be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3824,7 +3824,11 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	/*
+	 * Make sure that misfit_task_load will not be null even if
+	 * task_h_load() returns 0.
+	 */
+	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
 }
 
 #else /* CONFIG_SMP */
@@ -7407,7 +7411,15 @@ static int detach_tasks(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		/*
+		 * Depending of the number of CPUs and tasks and the
+		 * cgroup hierarchy, task_h_load() can return a null
+		 * value. Make sure that env->imbalance decreases
+		 * otherwise detach_tasks() will stop only after
+		 * detaching up to loop_max tasks.
+		 */
+		load = max_t(unsigned long, task_h_load(p), 1);
+
 
 		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 			goto next;
-- 
2.17.1

