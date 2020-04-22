Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC68C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DC8206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDVGwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:52:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2865 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVGwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:52:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA34F1F8295A51C6F2A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:52:43 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 14:52:36 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <mikulas@artax.karlin.mff.cuni.cz>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] fs:hpfs:remove unneeded semicolon in buffer.c
Date:   Wed, 22 Apr 2020 14:51:53 +0800
Message-ID: <1587538313-409999-1-git-send-email-wubo40@huawei.com>
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
fs/hpfs/buffer.c:56:2-3: Unneeded semicolon

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/hpfs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/buffer.c b/fs/hpfs/buffer.c
index e285d6b..d392468 100644
--- a/fs/hpfs/buffer.c
+++ b/fs/hpfs/buffer.c
@@ -53,7 +53,7 @@ void hpfs_prefetch_sectors(struct super_block *s, unsigned secno, int n)
 			return;
 		}
 		brelse(bh);
-	};
+	}
 
 	blk_start_plug(&plug);
 	while (n > 0) {
-- 
1.8.3.1

