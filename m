Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBBC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70DA24689
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAQKI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:08:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgAQKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYV-0005Rw-HZ; Fri, 17 Jan 2020 11:08:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A4E6A1C19D0;
        Fri, 17 Jan 2020 11:08:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:41 -0000
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: calculate delta runnable load only when
 it's needed
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200103114400.17668-1-rocking@linux.alibaba.com>
References: <20200103114400.17668-1-rocking@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <157925572151.396.5137433460252396733.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fe71bbb21ee14160f73f81b113d71145327a1c0d
Gitweb:        https://git.kernel.org/tip/fe71bbb21ee14160f73f81b113d71145327a1c0d
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Fri, 03 Jan 2020 19:44:00 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:21 +01:00

sched/fair: calculate delta runnable load only when it's needed

Move the code of calculation for delta_sum/delta_avg to where
it is really needed to be done.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20200103114400.17668-1-rocking@linux.alibaba.com
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d292883..32c5421 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3366,16 +3366,17 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 
 	runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
 	runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
-	delta_sum = runnable_load_sum - se_weight(se) * se->avg.runnable_load_sum;
-	delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
-
-	se->avg.runnable_load_sum = runnable_sum;
-	se->avg.runnable_load_avg = runnable_load_avg;
 
 	if (se->on_rq) {
+		delta_sum = runnable_load_sum -
+				se_weight(se) * se->avg.runnable_load_sum;
+		delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
 		add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
 		add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
 	}
+
+	se->avg.runnable_load_sum = runnable_sum;
+	se->avg.runnable_load_avg = runnable_load_avg;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
