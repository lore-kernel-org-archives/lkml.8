Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84F1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B024658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgANVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:09:53 -0500
Received: from foss.arm.com ([217.140.110.172]:57494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgANVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:09:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EAD01435;
        Tue, 14 Jan 2020 13:09:52 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 166C53F534;
        Tue, 14 Jan 2020 13:09:50 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, ouwen210@hotmail.com,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2] sched/uclamp: reject negative values in cpu_uclamp_write
Date:   Tue, 14 Jan 2020 21:09:47 +0000
Message-Id: <20200114210947.14083-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112235217.26647-1-qais.yousef@arm.com>
References: <20200112235217.26647-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check to ensure that the new written value into cpu.uclamp.{min,max}
is within range, [0:100], wasn't working because of the signed
comparison

7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
7302                         req.ret = -ERANGE;
7303                         return req;
7304                 }

	# echo -1 > cpu.uclamp.min
	# cat cpu.uclamp.min
	42949671.96

Cast req.percent into u64 to force the comparison to be unsigned and
work as intended in capacity_from_percent().

	# echo -1 > cpu.uclamp.min
	sh: write error: Numerical result out of range

Fixes: 2480c093130f ("sched/uclamp: Extend CPU's cgroup controller")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

Changes in v2:
	- Improve the commit message as suggested by T. Zhou

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..e66b131e3aeb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7254,7 +7254,7 @@ capacity_from_percent(char *buf)
 					     &req.percent);
 		if (req.ret)
 			return req;
-		if (req.percent > UCLAMP_PERCENT_SCALE) {
+		if ((u64)req.percent > UCLAMP_PERCENT_SCALE) {
 			req.ret = -ERANGE;
 			return req;
 		}
-- 
2.17.1

