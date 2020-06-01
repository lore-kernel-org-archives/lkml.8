Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211FE206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgFAIow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:44:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33130 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgFAIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:44:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-CoY6h_1591001089;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-CoY6h_1591001089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 16:44:49 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/4] workqueue: add a BUILD_BUG_ON() to check the size of struct pool_workqueue
Date:   Mon,  1 Jun 2020 08:44:41 +0000
Message-Id: <20200601084442.8284-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601084442.8284-1-laijs@linux.alibaba.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the size of struct pool_workqueue is smaller than the
smellest requirement (1 << WORK_STRUCT_FLAG_BITS). When the size
of struct pool_workqueue is increasing in future development and
exceed the smellest requirement a little, it will be a big waste
due to alignment.

Add a check in case we don't skimp enough in future.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 35120b909234..1921c982f920 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5907,6 +5907,14 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	/*
+	 * If it complains when being built, there might be considerable
+	 * memory waste in struct pool_workqueue. Whatever the reason is,
+	 * an updated check here or a re-arrangement in
+	 * struct pool_workqueue is required.
+	 */
+	BUILD_BUG_ON(sizeof(struct pool_workqueue) > (1 << WORK_STRUCT_FLAG_BITS));
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
-- 
2.20.1

