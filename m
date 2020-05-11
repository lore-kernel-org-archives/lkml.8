Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA292082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SOO0YQg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEKByN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:54:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16772 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgEKByN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:54:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589162053; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sKT+oxTM1IiLkHUsa6WEuo4yedQX4JYSfJZMYeF+gSg=; b=SOO0YQg18W4wuJFwD8Um67oEI9Llhl05i6Di5mbZNYDsbzzZWpFSvuYcL/1Zc9TOQohK59pI
 qFAxJokL6vch9sDsZkwTZYwj4uysHiu50YscaUnD+tMljO8r8HjgY+m7XsV1ZgLj5y+P8XR8
 9/vbygyLMfxT58e+iqq0jNgebQc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb8b033.7ffa428a06c0-smtp-out-n02;
 Mon, 11 May 2020 01:53:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0585FC44791; Mon, 11 May 2020 01:53:53 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 924B4C433CB;
        Mon, 11 May 2020 01:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 924B4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2] sched/debug: Fix requested task uclamp values shown in procfs
Date:   Mon, 11 May 2020 07:23:30 +0530
Message-Id: <1589162011-4998-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
values to SCHED_DEBUG procfs") was to print requested and effective
task uclamp values. The requested values printed are read from p->uclamp,
which holds the last effective values. Fix this by printing the values
from p->uclamp_req.

Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
Tested-and-reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---

V2: Added "requested" prefix (suggested by Valentin)

 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a562df5..77ecebd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_est.enqueued);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
-	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
-	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("requested uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
+	__PS("requested uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
