Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D826C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1F12070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgDVHM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:12:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgDVHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:12:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3316C335695113F4E212;
        Wed, 22 Apr 2020 15:12:52 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:12:44 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] fs:ocfs2:remove unneeded variable 'o2dlm_flags'
Date:   Wed, 22 Apr 2020 15:12:01 +0800
Message-ID: <1587539521-461177-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags". 
Return "0" on line 84

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ocfs2/stack_o2cb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index dbf8b57..2da9633 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
 	}
 static int flags_to_o2dlm(u32 flags)
 {
-	int o2dlm_flags = 0;
-
 	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
 	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
 	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
@@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
 	/* map_flag() should have cleared every flag passed in */
 	BUG_ON(flags != 0);
 
-	return o2dlm_flags;
+	return 0;
 }
 #undef map_flag
 
-- 
1.8.3.1

