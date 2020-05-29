Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4682074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgE2G7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:59:16 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39758 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgE2G7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:59:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TzxreVj_1590735547;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzxreVj_1590735547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 14:59:07 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/4] workqueue: remove useless unlock() and lock() in series
Date:   Fri, 29 May 2020 06:59:02 +0000
Message-Id: <20200529065903.1758-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529065903.1758-1-laijs@linux.alibaba.com>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no point to unlock() and then lock() the same mutex
back to back.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c0cbe0de95d0..415893cfb074 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4383,13 +4383,11 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		spin_unlock_irq(&pwq->pool->lock);
 	}
 	mutex_unlock(&wq->mutex);
-	mutex_unlock(&wq_pool_mutex);
 
 	/*
 	 * wq list is used to freeze wq, remove from list after
 	 * flushing is complete in case freeze races us.
 	 */
-	mutex_lock(&wq_pool_mutex);
 	list_del_rcu(&wq->list);
 	mutex_unlock(&wq_pool_mutex);
 
-- 
2.20.1

