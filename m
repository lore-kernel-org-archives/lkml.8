Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7927C4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEB62072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgCKSRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbgCKSRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:17:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D561E1045;
        Wed, 11 Mar 2020 11:17:03 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1A4C3F6CF;
        Wed, 11 Mar 2020 11:17:02 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 7/9] sched/fair: Dissociate wakeup decisions from SD flag value
Date:   Wed, 11 Mar 2020 18:15:59 +0000
Message-Id: <20200311181601.18314-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFS wakeup code will only ever go through EAS / its fast path on
"regular" wakeups (i.e. not on forks or execs). These are currently gated
by a check against 'sd_flag', which would be SD_BALANCE_WAKE at wakeup.

However, we now have a flag that explicitly tells us whether a wakeup is a
"regular" one, so hinge those conditions on that flag instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 920c4e2ce0d1..f98dac0c7f82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6606,7 +6606,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		sd_flag = SD_BALANCE_EXEC;
 	}
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
 		if (sched_energy_enabled()) {
@@ -6643,9 +6643,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
-- 
2.24.0

