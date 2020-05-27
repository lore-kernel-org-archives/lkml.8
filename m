Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B512C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B23207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgE0Bng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:43:36 -0400
Received: from mail5.windriver.com ([192.103.53.11]:46558 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgE0Bng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:43:36 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 04R1gCto029090
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 26 May 2020 18:42:33 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Tue, 26 May 2020 18:42:08 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <markus.elfring@web.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] workqueue: Remove unnecessary kfree(NULL)
Date:   Wed, 27 May 2020 09:50:54 +0800
Message-ID: <20200527015054.34796-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

The callback function "rcu_free_wq" could be called after memory
was released for "wq->rescuer" already and assignment is empty. so
remove unnecessary kfree(NULL).

Fixes: def98c84b6cd ("workqueue: Fix spurious sanity check failures in destroy_workqueue()")
Fixes: 8efe1223d73c ("workqueue: Fix missing kfree(rescuer) in destroy_workqueue()")

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 v1->v2->v3->v4:
 Modify wrong submission information.

 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..a2451cdcd503 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3491,7 +3491,6 @@ static void rcu_free_wq(struct rcu_head *rcu)
 	else
 		free_workqueue_attrs(wq->unbound_attrs);
 
-	kfree(wq->rescuer);
 	kfree(wq);
 }
 
-- 
2.24.1

