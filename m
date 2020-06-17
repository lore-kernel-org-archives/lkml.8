Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4198320760
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQHwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:52:12 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:64730 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQHwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:52:12 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 4D4FFE0EC41DB517EA5B;
        Wed, 17 Jun 2020 15:52:08 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 05H7q6HC075292;
        Wed, 17 Jun 2020 15:52:06 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020061715522698-3977654 ;
          Wed, 17 Jun 2020 15:52:26 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] sched: Use kmem_cache_zalloc() instead of kmem_cache_alloc() with flag GFP_ZERO.
Date:   Wed, 17 Jun 2020 15:54:40 +0800
Message-Id: <1592380480-10548-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-06-17 15:52:27,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-06-17 15:52:09,
        Serialize complete at 2020-06-17 15:52:09
X-MAIL: mse-fl2.zte.com.cn 05H7q6HC075292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kmem_cache_zalloc instead of calling kmem_cache_alloc
with flag GFP_ZERO.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f36032..5aac3ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7024,7 +7024,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 {
 	struct task_group *tg;
 
-	tg = kmem_cache_alloc(task_group_cache, GFP_KERNEL | __GFP_ZERO);
+	tg = kmem_cache_zalloc(task_group_cache, GFP_KERNEL);
 	if (!tg)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.9.5

