Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62794C38A2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456032078A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgDMLi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:38:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729067AbgDMLiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:38:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E19F47D06B80F64DFC2E;
        Mon, 13 Apr 2020 19:38:22 +0800 (CST)
Received: from huawei.com (10.175.102.37) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 19:38:13 +0800
From:   Li Bin <huawei.libin@huawei.com>
To:     <dgilbert@interlog.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH] scsi: sg: fix memory leak in sg_build_indirect
Date:   Mon, 13 Apr 2020 19:32:32 +0800
Message-ID: <1586777552-17524-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a memory leak when there have failed, that we should free the pages
under the condition rem_sz > 0.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 drivers/scsi/sg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4e6af592..8441ac5 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1959,8 +1959,12 @@ static long sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned lon
 			 k, rem_sz));
 
 	schp->bufflen = blk_size;
-	if (rem_sz > 0)	/* must have failed */
+	if (rem_sz > 0)	{ /* must have failed */
+		for (i = 0; i < k; i++)
+			__free_pages(schp->pages[i], order);
+
 		return -ENOMEM;
+	}
 	return 0;
 out:
 	for (i = 0; i < k; i++)
-- 
1.7.12.4

