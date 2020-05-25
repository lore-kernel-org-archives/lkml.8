Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC857C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2520787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgEYJXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:23:01 -0400
Received: from mail5.windriver.com ([192.103.53.11]:39394 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389334AbgEYJXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:23:01 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 04P9LqB3012563
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 25 May 2020 02:22:02 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 25 May 2020 02:21:34 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <markus.elfring@web.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] workqueue: Fix double kfree for rescuer
Date:   Mon, 25 May 2020 17:30:19 +0800
Message-ID: <20200525093019.2253-1-qiang.zhang@windriver.com>
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
was released for "rescuer" already, Thus delete a misplaced call
of the function "kfree".

Fixes: 6ba94429c8e7 ("workqueue: Reorder sysfs code")
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 v1->v2->v3:
 Only commit information modification.
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

