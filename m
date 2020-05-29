Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2873C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B65208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2G7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:59:08 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45995 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgE2G7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:59:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tzy4LPf_1590735545;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy4LPf_1590735545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 14:59:05 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/4] workqueue: void unneeded requeuing the pwq in rescuer thread
Date:   Fri, 29 May 2020 06:58:59 +0000
Message-Id: <20200529065903.1758-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529065903.1758-1-laijs@linux.alibaba.com>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

008847f66c3 ("workqueue: allow rescuer thread to do more work.") made
the rescuer worker requeue the pwq immediately if there may be more
work items which need rescuing instead of waiting for the next mayday
timer expiration.  Unfortunately, it checks only whether the pool needs
help from rescuers, but it doesn't check whether the pwq has work items
in the pool (the real reason that this rescuer can help for the pool).

The patch adds the check and void unneeded requeuing.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7a1fc9fe6314..b2b15f1f0c8d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2529,7 +2529,7 @@ static int rescuer_thread(void *__rescuer)
 			 * being used to relieve memory pressure, don't
 			 * incur MAYDAY_INTERVAL delay inbetween.
 			 */
-			if (need_to_create_worker(pool)) {
+			if (pwq->nr_active && need_to_create_worker(pool)) {
 				spin_lock(&wq_mayday_lock);
 				/*
 				 * Queue iff we aren't racing destruction
-- 
2.20.1

