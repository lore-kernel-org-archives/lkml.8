Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2971C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97CD20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgBKMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgBKMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux9-0007b5-Qy; Tue, 11 Feb 2020 13:47:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7455D1C2018;
        Tue, 11 Feb 2020 13:47:47 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:47 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix kernel-doc warning in
 attach_entity_load_avg()
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org>
References: <cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org>
MIME-Version: 1.0
Message-ID: <158142526720.411.14848051383270906553.tip-bot2@tip-bot2>
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

Commit-ID:     e9f5490c3574b435ce7fe7a71724aa3866babc7f
Gitweb:        https://git.kernel.org/tip/e9f5490c3574b435ce7fe7a71724aa3866babc7f
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 09 Feb 2020 19:29:12 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:05:10 +01:00

sched/fair: Fix kernel-doc warning in attach_entity_load_avg()

Fix kernel-doc warning in kernel/sched/fair.c, caused by a recent
function parameter removal:

  ../kernel/sched/fair.c:3526: warning: Excess function parameter 'flags' description in 'attach_entity_load_avg'

Fixes: a4f9a0e51bbf ("sched/fair: Remove redundant call to cpufreq_update_util()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org
---
 kernel/sched/fair.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 94c3b84..3c8a379 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3516,7 +3516,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
- * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
