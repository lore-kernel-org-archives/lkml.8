Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC1EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAEA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgE1DHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:07:07 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43327 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgE1DHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:07:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TzqvIMr_1590635223;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzqvIMr_1590635223)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 11:07:03 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/2] workqueue: remove useless POOL_MANAGER_ACTIVE
Date:   Thu, 28 May 2020 03:06:56 +0000
Message-Id: <20200528030657.1690-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200528030657.1690-1-laijs@linux.alibaba.com>
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
 <20200528030657.1690-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the same meaning as pool->manager now.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fde10a5dba82..8bc11075763b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -70,7 +70,6 @@ enum {
 	 * wq_pool_attach_mutex to avoid changing binding state while
 	 * worker_attach_to_pool() is in progress.
 	 */
-	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
 	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
 
 	/* worker flags */
@@ -798,7 +797,7 @@ static bool need_to_create_worker(struct worker_pool *pool)
 /* Do we have too many workers and should some go away? */
 static bool too_many_workers(struct worker_pool *pool)
 {
-	bool managing = pool->flags & POOL_MANAGER_ACTIVE;
+	bool managing = !!pool->manager;
 	int nr_idle = pool->nr_idle + managing; /* manager is considered idle */
 	int nr_busy = pool->nr_workers - nr_idle;
 
@@ -2132,7 +2131,7 @@ static bool manage_workers(struct worker *worker)
 					struct work_struct, entry);
 	struct pool_workqueue *pwq = get_work_pwq(work);
 
-	if (pool->flags & POOL_MANAGER_ACTIVE)
+	if (pool->manager)
 		return false;
 
 	/*
@@ -2143,13 +2142,11 @@ static bool manage_workers(struct worker *worker)
 	 */
 	get_pwq(pwq);
 
-	pool->flags |= POOL_MANAGER_ACTIVE;
 	pool->manager = worker;
 
 	maybe_create_worker(pool);
 
 	pool->manager = NULL;
-	pool->flags &= ~POOL_MANAGER_ACTIVE;
 	put_pwq(pwq);
 	return true;
 }
-- 
2.20.1

