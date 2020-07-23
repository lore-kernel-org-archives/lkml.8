Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993CB20888
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P9E155vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgGXA1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:27:10 -0400
Received: from m12-14.163.com ([220.181.12.14]:45888 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgGXA1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t5tv0
        2B3pJAcad5nqGAAwIRnW8TEud7RLon8gV+w0Ic=; b=P9E155vIljT9pyTFVDYiZ
        qEtIf0mEQctrdU0GYlgHAOZ7PqCMysdHWwRsOOQtIkjZ+23P3OE/Oqcj26ZVL/pv
        kbm0EYKZiFSGvB0G6B7mObEV3DX26tM9COTx6P1Oq3tKTv9LvXHUw8ojAIOEIIxG
        paiWsrXfQwwJyItrdV+RCM=
Received: from localhost.localdomain (unknown [223.87.243.26])
        by smtp10 (Coremail) with SMTP id DsCowAAHC_COHxpfPbmoCg--.12793S2;
        Fri, 24 Jul 2020 07:38:55 +0800 (CST)
From:   Jiang Biao <humjb_1983@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
Date:   Fri, 24 Jul 2020 07:38:53 +0800
Message-Id: <20200723233853.48815-1-humjb_1983@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHC_COHxpfPbmoCg--.12793S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4xWr1xtw48CFW5Gr1rZwb_yoWDCrX_Ww
        s5Kr1qgr1Dtrs0qF4xC397Xrn5Wan2qFWvkw1Iy3yUJ3WDZ393A3sFkFyfur48JFWUJF9r
        JF90qFn0gr4UCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wSdDUUUUU==
X-Originating-IP: [223.87.243.26]
X-CM-SenderInfo: hkxpyurbrzmji6rwjhhfrp/1tbiPgBqDFxBinBGYAABsY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

Sched-idle CPU has been considered in select_idle_cpu and
select_idle_smt, it also needs to be considered in select_idle_core to
be consistent and keep the same *idle* policy.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..f430a9820d08 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6014,7 +6014,7 @@ void __update_idle_core(struct rq *rq)
 		if (cpu == core)
 			continue;
 
-		if (!available_idle_cpu(cpu))
+		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			goto unlock;
 	}
 
@@ -6045,7 +6045,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			if (!available_idle_cpu(cpu)) {
+			if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu)) {
 				idle = false;
 				break;
 			}
-- 
2.21.0


