Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99531C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840D8207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgESSo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgESSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377AFC08C5C1;
        Tue, 19 May 2020 11:44:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Dp-0006bl-Pq; Tue, 19 May 2020 20:44:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64D541C047E;
        Tue, 19 May 2020 20:44:13 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:13 -0000
From:   "tip-bot2 for Pavankumar Kondeti" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Fix requested task uclamp values
 shown in procfs
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
References: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Message-ID: <158991385330.17951.2679225516047950446.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ad32bb41fca67936c0c1d6d0bdd6d3e2e9c5432f
Gitweb:        https://git.kernel.org/tip/ad32bb41fca67936c0c1d6d0bdd6d3e2e9c5432f
Author:        Pavankumar Kondeti <pkondeti@codeaurora.org>
AuthorDate:    Sun, 10 May 2020 18:26:41 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:10 +02:00

sched/debug: Fix requested task uclamp values shown in procfs

The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
values to SCHED_DEBUG procfs") was to print requested and effective
task uclamp values. The requested values printed are read from p->uclamp,
which holds the last effective values. Fix this by printing the values
from p->uclamp_req.

Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/1589115401-26391-1-git-send-email-pkondeti@codeaurora.org
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a562df5..239970b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_est.enqueued);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
-	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
-	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
