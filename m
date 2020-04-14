Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D3DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE49D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE40WOyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbgDNQNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388615AbgDNQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:13:25 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:13:24 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f15so9017656wrj.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=32Nk4yPycqu5U0xNKJFgggSPEJ2kI45tjBMiQl+YlNA=;
        b=mE40WOyH75uFRgF6wVIgUBWep7Ri5Ntb76JlyOq46CyKv4H4x1tSiyQsiDVJYfEH0B
         PUU2apk7coMOeSEqrsIZICCfJ4J37ROVKUK7U94JmzNd0C7pkreMZTRQIuo6UXtGL/g3
         YqU2bRic0wZVSeBaY+BJF+1+xwRll9gMxui/OnXIN6/TLAc4dqKPGVNlYouHRIbWY0W+
         Tz6S6s2icon2Z1V+YB/agukYvetCsmEhhoSHR9GCRN/qZVnzoa+rKJwRQpeKlDH+ZNZV
         l1ZXyUlo6qifGBodsmsS2ENWoJaSekGQ+CZoQLmhnJ4XxVSxQTXRynejRHqHcQGKLgk6
         IDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=32Nk4yPycqu5U0xNKJFgggSPEJ2kI45tjBMiQl+YlNA=;
        b=KgpTg7zuNV+bC3VWstwKfUg10UvjzW/lsUJ2BLhTCUVbGhckd7AD0UqCi/v7tMk2S6
         jG4sGcx1VfE9dQLfldILOPOTL8MOJtY5fFxd/O7XEnMt2uMlvQKDyhhC/niDyWXLC94S
         tyZ9kn2d7HYWPzOdPVSIG2cZymw1Ax+2eMqtbvegJFSvrmoyaTNOiJRQshEC8vQ5XsB6
         Zrd9baGMITSz0H5sAZHNQn7rHAoumj47yUxnDA/dWGXTGXUtUzGuqJnvaW0WAOG11VRH
         6iK4rucCeGSVoktC60BEe/gviluyYeUTtbiVrAIxzbQ7XtxDlaN/w0w499Ij4Z0rMhEn
         5isg==
X-Gm-Message-State: AGi0PuY0NDDHtXmd/HdTYRYqOGeXoD+8c0LOnNvDHWDiP4LOuWwqyPk1
        3K7kXXtqdR46vbRxnTwKKmRR50ZNxr4g
X-Google-Smtp-Source: APiQypKwAfnFzmYYa+L3bVNgwfMAQPIvFvcWx4Ta3qexNvUbtsUABlfhkQUSstih8SCkRqSQdtA7xqceZd13
X-Received: by 2002:adf:9321:: with SMTP id 30mr23209645wro.330.1586880802935;
 Tue, 14 Apr 2020 09:13:22 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:13:20 +0100
Message-Id: <20200414161320.251897-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uclamp_fork() resets the uclamp values to their default when the
reset-on-fork flag is set. It also checks whether the task has a RT
policy, and sets its uclamp.min to 1024 accordingly. However, during
reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
hence leading to an erroneous uclamp.min setting for the new task if it
was forked from RT.

Fix this by removing the unnecessary check on rt_policy() in
uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
set.

Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..9ea3e484eea2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
 	for_each_clamp_id(clamp_id) {
 		unsigned int clamp_value = uclamp_none(clamp_id);
 
-		/* By default, RT tasks always get 100% boost */
-		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
-
 		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
 	}
 }
-- 
2.26.0.110.g2183baf09c-goog

