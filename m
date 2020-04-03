Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F9C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD372080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjOpPRkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbgDCI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:56:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgDCI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:56:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id v23so280628pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8lWvt493O2I6tDg+eQVWHrCT6h+J28ya8injBt/6hk8=;
        b=GjOpPRkX00Yt1nDjdASEGeDpVeibhF8xzYkinQqP86YaDYdCfTgUJub9JOAHSj93fi
         KAR7hGLkUJ1u4PcRnaTXa/U6SO1HLeCPeBcNK/HqKenbuULvK+P3vzw/Sng02CGM84ZX
         +ouR4UoVtSnUltimRnPno7g/ara4MxOCd7Hxecwp7Uey3LSY0lwmwieDhLjLQK4kBs1g
         2oTh5Vue4j5BPmsL9MdujWp6LnFTkmvOIr/BKm5wGC/2b1yUM4Ijo92MegiGwG9LlOkr
         9uN/1TXfrl6JcwrHRVfAz9eBWuqN2TojO6i9AzchxyOidoL9F9X+mofXkGXHO7c8eFdu
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8lWvt493O2I6tDg+eQVWHrCT6h+J28ya8injBt/6hk8=;
        b=UkHqgVmkOLXUuXj8MPyf1fKx52nmlDe4jm2e5+c6HhfjDW38bvNHgQwAbDKHouz8Gv
         rlng86AHbHxesTauNcDoTkjFMdbnQv/45cfJoTblCRmBvYYfiKmo5cpFKd5fAezP8UWD
         hmgC2BcdpvlnvBuywsXIDdZGy4N3AIXdSFHW+BCD4T6HN8XF825IGLMPpIALwoAeoSNq
         OYuckFW09/ResGMlZYXHkgKDIfoThfk33A+B59GAXU7ZyL0sdosxODq4o7WX8EAzHkTs
         qaSRz03HgKsQPIhQ0gWacOgaikXjgKY3PzNmv0CrnQIYeFNsvycvAv6WgPID7SNhpl+B
         RdLA==
X-Gm-Message-State: AGi0PubVHQrmrIoOoP2UaTUwbfL59NeHcBya+eR0Av+RXwyqEr7szEba
        RPJhurBn41MCg1GoHjU0tr4=
X-Google-Smtp-Source: APiQypKLPMgaL/rodf2glmeCJL5XtyQPNLF9R2cKmGDiddkoJxwH+igmg6UGJzx/w3feWxnfnLJDng==
X-Received: by 2002:a63:cf:: with SMTP id 198mr7452255pga.447.1585904202794;
        Fri, 03 Apr 2020 01:56:42 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e8sm5180980pjt.26.2020.04.03.01.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:56:41 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] psi: fix randomized calculation in record_times()
Date:   Fri,  3 Apr 2020 04:55:25 -0400
Message-Id: <1585904125-2819-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In record_times() we use 'now' and groupc->state_start to calculate the
delta as bellow,
	delta = now - groupc->state_start;
But note that groupc->state_start may be not initialized yet, IOW, the
state_start may be 0 currently. If state_start is 0, this calculation is
same with assigning the lower 32-bit of 'now' to delta, that is a random
value. To fix this value, we should initialize groupc->state_start before.

After we calculate the delta, we will assign 'now' to
groupc->state_start then,
	groupc->state_start = now;
This will cause the same issue if groupc->state_start will not be used in a
long period. Let's take an example. We create a cgroup foo and run tasks
in it. Some of these tasks enter into memstall and state_start is set.
Then we move all of these tasks out of cgroup foo for more than (1 << 32)
nsecs, and then move them in. That will cause the same issue as above.

The root cause of these issues is that we don't initialize the state_start
properly. To fix it, we should record how many tasks in this per cpu
psi_group. If there's no task in it, we just set state_start and don't
calculate the delta, that means it is the begin of the pressure. To
avoid redundant calculating the total number of tasks in this per cpu
psi_group, a new member 'total_tasks' is introduced in struct
psi_group_cpu, which is the sum of array members in tasks[].

Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/psi_types.h |  2 ++
 kernel/sched/psi.c        | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 4b7258495a04..b42cbfdb15e9 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -69,6 +69,8 @@ struct psi_group_cpu {
 
 	/* States of the tasks belonging to this group */
 	unsigned int tasks[NR_PSI_TASK_COUNTS];
+	/* Sum of above array members */
+	unsigned int total_tasks;
 
 	/* Aggregate pressure state derived from the tasks */
 	u32 state_mask;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8f45cdb6463b..7061529dc406 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -690,7 +690,10 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu, false);
+	if (groupc->total_tasks)
+		record_times(groupc, cpu, false);
+	else
+		groupc->state_start = cpu_clock(cpu);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -703,11 +706,15 @@ static void psi_group_change(struct psi_group *group, int cpu,
 			psi_bug = 1;
 		}
 		groupc->tasks[t]--;
+		groupc->total_tasks--;
 	}
 
-	for (t = 0; set; set &= ~(1 << t), t++)
-		if (set & (1 << t))
+	for (t = 0; set; set &= ~(1 << t), t++) {
+		if (set & (1 << t)) {
 			groupc->tasks[t]++;
+			groupc->total_tasks++;
+		}
+	}
 
 	/* Calculate state mask representing active states */
 	for (s = 0; s < NR_PSI_STATES; s++) {
-- 
2.18.2

