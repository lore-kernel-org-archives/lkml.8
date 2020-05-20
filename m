Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAAD20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETIBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:01:34 -0400
Received: from mail.windriver.com ([147.11.1.11]:56565 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:01:34 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 04K80btf009933
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 20 May 2020 01:00:38 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 01:00:31 -0700
From:   <qiang.zhang@windriver.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/rt: Add borrowing time condition
Date:   Wed, 20 May 2020 16:09:11 +0800
Message-ID: <20200520080911.27367-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Add priority judgment to determine whether to borrow time from neighbors,
ensure that the rt_runntime of rt_rq with higher priority tasks is not
reduced

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 kernel/sched/rt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4043abe45459..d2a1acad6687 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -711,8 +711,10 @@ static void do_balance_runtime(struct rt_rq *rt_rq)
 			diff = div_u64((u64)diff, weight);
 			if (rt_rq->rt_runtime + diff > rt_period)
 				diff = rt_period - rt_rq->rt_runtime;
-			iter->rt_runtime -= diff;
-			rt_rq->rt_runtime += diff;
+			if (rt_rq->highest_prio.curr < iter->highest_prio.curr) {
+				iter->rt_runtime -= diff;
+				rt_rq->rt_runtime += diff;
+			}
 			if (rt_rq->rt_runtime == rt_period) {
 				raw_spin_unlock(&iter->rt_runtime_lock);
 				break;
-- 
2.17.0

