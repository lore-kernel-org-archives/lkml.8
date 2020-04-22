Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35BCC38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BF0206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVHAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:00:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgDVHAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:00:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26F8E9679C5DBB223AD5;
        Wed, 22 Apr 2020 15:00:18 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:00:10 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <ccaulfie@redhat.com>, <teigland@redhat.com>,
        <cluster-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] fs:dlm:remove unneeded semicolon in rcom.c
Date:   Wed, 22 Apr 2020 14:59:27 +0800
Message-ID: <1587538767-429386-1-git-send-email-wubo40@huawei.com>
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
fs/dlm/rcom.c:566:2-3: Unneeded semicolon

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/dlm/rcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index e3d9f72..4daf5dc 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -563,7 +563,7 @@ void dlm_receive_rcom(struct dlm_ls *ls, struct dlm_rcom *rc, int nodeid)
 		lock = 1;
 		reply = 1;
 		break;
-	};
+	}
 
 	spin_lock(&ls->ls_recover_lock);
 	status = ls->ls_recover_status;
-- 
1.8.3.1

