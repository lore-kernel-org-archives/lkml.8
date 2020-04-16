Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C36C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C2D20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKkD22rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503008AbgDPJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503156AbgDPJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:00:02 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BBC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:00:00 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id p16so1370580wro.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zYXTZFcfx+3CensArNPFNmiVclp57O43Gn/CFyzw2Uo=;
        b=RKkD22rb6Dzs2uaucfSqEkzpn0HhEKZCL5xRSJVQRCjvmF6gjSa+MTJl+xlpi2TDkC
         bQiuk/gS8BfTYSuGBDtYbw+GEivN6EyJLFV2SiilGvCu1pqNlQOvRNYI6O60CX8OhyPc
         NPUXPobg4JIXNwSCb98uUproTN5H8lF+titV2n6/INf5gA84sJYuhs/XDaurCZscX2IT
         gCCz1kmvaCdVrYRACn3tCTr7rXBUMZ3I711tDJ8x1WnWn2wfvT7X36NsT0dMDb0fhaq+
         FmcLwdqSqkUgiw4K8ICrhiRFrZZ+X16maJxVfuHqp8Y9UtVeNe+AAYfwTTHaG7YU/AmL
         acfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zYXTZFcfx+3CensArNPFNmiVclp57O43Gn/CFyzw2Uo=;
        b=UnFVq/dvWFdk70XE1ySjUMngyR9fPlimJYq8FjMQEzoFi+2JZ7LHCdMbZ0f+AwfOl9
         ywa9uFhGx/ND50rFtiCv0Gj/qn+V1gyY/mtsvSxNK2HsFxX4LiSUckKZpiDLiV3FmL98
         zLuI8xQYIMF8y6A3uICJgYKrdGiGmylow3hUyBv/x9bLqhmM1WKpmntrbKnKkT+vwjLt
         v1twOtuKSspwmMOF205tLrNPYp5h1h+hFwFWUFkuApqM8xyrldN3uYpxKbywnqz1mb0p
         oMKezA2JzKRvrI2XaR5yOBZ5gq5IUQD7jLwj1ZOFuZJEuS5FOgmQ/3whZgxefhem9B8t
         qSrw==
X-Gm-Message-State: AGi0Puba3VlkIioRZqSYeowxK5aVnvpatstC0TFignu+8+6okWgTtmvn
        UOzpsNdWTX89lg3rRaGU2eZUowiDxJPt
X-Google-Smtp-Source: APiQypLlmJYWXmx/JSoE63GJVL18iRgi9VtfgPiWUqZvjb7Syp0ZSad0LLsQREO6kuDj8yMmglS2NoQ4jTaM
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr33267035wrq.193.1587027599379;
 Thu, 16 Apr 2020 01:59:59 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:59:56 +0100
Message-Id: <20200416085956.217587-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2] sched/core: Fix reset-on-fork from RT with uclamp
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

Fix this by removing the unnecessary check on rt_task() in
uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
set.

Fixes: 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks")
Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
Reviewed-by: Patrick Bellasi <patrick.bellasi@matbug.net>
Signed-off-by: Quentin Perret <qperret@google.com>
---
Changes in v2:
 - Added missing 'Fixes:' tag (Patrick)
 - Removed unnecessary local variable (Doug, Patrick)
---
 kernel/sched/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..9a2fbf98fd6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1232,13 +1232,8 @@ static void uclamp_fork(struct task_struct *p)
 		return;
 
 	for_each_clamp_id(clamp_id) {
-		unsigned int clamp_value = uclamp_none(clamp_id);
-
-		/* By default, RT tasks always get 100% boost */
-		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
-
-		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
+		uclamp_se_set(&p->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
 	}
 }
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

