Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D13C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50392070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGQJth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:49:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgGQJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:49:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 353781F895A657737A23;
        Fri, 17 Jul 2020 17:49:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 17:49:09 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <hubcap@omnibond.com>, <martin@omnibond.com>
CC:     <devel@lists.orangefs.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] orangefs: remove unnecessary assignment to variable ret
Date:   Fri, 17 Jul 2020 17:52:59 +0800
Message-ID: <20200717095259.111076-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ret is guaranteed to be 0 in this if (). So we can remove
this assignement.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 fs/orangefs/orangefs-mod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 289b648ae196..74a3d6337ef4 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -149,7 +149,6 @@ static int __init orangefs_init(void)
 		pr_info("%s: module version %s loaded\n",
 			__func__,
 			ORANGEFS_VERSION);
-		ret = 0;
 		goto out;
 	}
 
-- 
2.17.1

