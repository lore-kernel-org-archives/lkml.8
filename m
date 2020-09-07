Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C20C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C052078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIGJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:17:48 -0400
Received: from foss.arm.com ([217.140.110.172]:58392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgIGJR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:17:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 412D611D4;
        Mon,  7 Sep 2020 02:17:28 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D95AF3F66E;
        Mon,  7 Sep 2020 02:17:26 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 3/3] sched/autogroup: Change autogroup_path() into a static inline function
Date:   Mon,  7 Sep 2020 11:17:17 +0200
Message-Id: <20200907091717.26116-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907091717.26116-1-dietmar.eggemann@arm.com>
References: <20200907091717.26116-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_rq_tg_path() uses, besides cgroup_path(), autogroup_path() to
format the path of a taskgroup or autogroup respectively.

Provide autogroup_path() as a static inline function like cgroup_path()
so cfs_rq_tg_path() (from a tp-2-te converter) can use both in a kernel
module build.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/autogroup.c | 8 --------
 kernel/sched/autogroup.h | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2067080bb235..3c6c78d909dd 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -258,11 +258,3 @@ void proc_sched_autogroup_show_task(struct task_struct *p, struct seq_file *m)
 	autogroup_kref_put(ag);
 }
 #endif /* CONFIG_PROC_FS */
-
-int autogroup_path(struct task_group *tg, char *buf, int buflen)
-{
-	if (!task_group_is_autogroup(tg))
-		return 0;
-
-	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
-}
diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index b96419974a1f..001f4826d781 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -35,7 +35,13 @@ autogroup_task_group(struct task_struct *p, struct task_group *tg)
 	return tg;
 }
 
-extern int autogroup_path(struct task_group *tg, char *buf, int buflen);
+static inline int autogroup_path(struct task_group *tg, char *buf, int buflen)
+{
+	if (!task_group_is_autogroup(tg))
+		return 0;
+
+	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
+}
 
 #else /* !CONFIG_SCHED_AUTOGROUP */
 
-- 
2.17.1

