Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFEC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E58521775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4pO31Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGTIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:34:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9143C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:34:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so16972052wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NQ0TByaTMYGuIND8hZglNUNSd92F891BfsAU17IV3Es=;
        b=T4pO31UmMyzqx2qMpzkFtoXF19ZYw+k2zekVoaJTg9KWSyQR7wqjM5sIhpsYrkhi+Y
         sZtQOwDUt3iffbHLIxLwpS4yX8pYmSVWIlgcwtBtVVH/1mdwHWHtBZLo9sZVwObEDcna
         +rE1aqP4cr0i1kcqEdrlc+9FnNGFI5S15lALJizv4NXARKUdDmo+n4XbrvccZixmOyIj
         l+lpDfOih5/VJoLWBus67FuxgoToWVZdNxrwyXrPe0uS8/AI1yukwTW5ZkYJ4WQQJEA8
         rQ5QWdeeRC7OqPKL10nPa0+XZXk/Yr6sEd68AdmXNTeUF5v0KhGkyQWnQzwxHDJW4gRb
         uSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NQ0TByaTMYGuIND8hZglNUNSd92F891BfsAU17IV3Es=;
        b=N4xm5U/ajuXCdQtTbHLEOZHLNo3Ukae60eq0KQSas0Wv21q3vMmgOIj3BbBg8z7Y+e
         sOjzszvo6lgu5fQtB4szcqE/B0991Fw+CV6vN1lxWrA3xQo5bJP92tkCDuObyvx68QVH
         VlkbmmshJuc4ynGalhKfhofrytp21ub0Vce4hjgqiLfruVAgkJJHdHQpNLlOSC1oRDiw
         Xjy+gfVeGGV5jfyKSCSIvQ8O0imWfPOkPMRtvLtF0v7/f7HKUA3W01oQRIvTgyGkSXKd
         kuReEMgiXSnPRUPifPYVkbVBYxtOI/0tCfPO7yBif6Oju2lVJRtGiEFpYIrRBif4BCAN
         hqQg==
X-Gm-Message-State: AOAM530DPV5FDiUeriRu7wOb0H7Y4JBEWaLeMoo2rvPOyVoEdkS3k0pO
        sA5cwSso7o+0t5U9dfl6oFlfIw==
X-Google-Smtp-Source: ABdhPJyeRmjM6YW4smhNoddhd9H6Ani7/2lNJbdQ2aEYH9cTra5Q7pDpUmKJMR/9CQuCkQ/9g6ou6Q==
X-Received: by 2002:adf:82a5:: with SMTP id 34mr10385755wrc.266.1595234049333;
        Mon, 20 Jul 2020 01:34:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7da7:684d:4a8a:3f66])
        by smtp.gmail.com with ESMTPSA id b8sm405707wrv.4.2020.07.20.01.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:34:08 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     valentin.schneider@arm.com, sashal@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4.19] sched/fair: handle case of task_h_load() returning 0
Date:   Mon, 20 Jul 2020 10:34:01 +0200
Message-Id: <20200720083401.22164-1-vincent.guittot@linaro.org>
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

We can't simply ensure that task_h_load() returns at least one because it
would imply to handle underflow in other places.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[removed misfit part which was not implemented yet]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: <stable@vger.kernel.org> # v4.19 v4.14 v4.9 v4.4
cc: Sasha Levin <sashal@kernel.org>
Link: https://lkml.kernel.org/r/20200710152426.16981-1-vincent.guittot@linaro.org
---

This patch also applies on v4.14.188 v4.9.230 and v4.4.230

 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 92b1e71f13c8..d8c249e6dcb7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7337,7 +7337,15 @@ static int detach_tasks(struct lb_env *env)
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

