Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814AC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852AD206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYJZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:25:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgCYJZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:25:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D90EB79BF7B9AB480BF;
        Wed, 25 Mar 2020 17:25:20 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Mar 2020 17:25:11 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up dic->tpages assignment
Date:   Wed, 25 Mar 2020 17:25:07 +0800
Message-ID: <20200325092507.62977-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c82ebba26e75..9cc279ea3bfb 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1363,20 +1363,16 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 		goto out_free;
 
 	for (i = 0; i < dic->cluster_size; i++) {
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
+			dic->tpages[i] = cc->rpages[i];
 			continue;
+		}
 
 		dic->tpages[i] = f2fs_grab_page();
 		if (!dic->tpages[i])
 			goto out_free;
 	}
 
-	for (i = 0; i < dic->cluster_size; i++) {
-		if (dic->tpages[i])
-			continue;
-		dic->tpages[i] = cc->rpages[i];
-	}
-
 	return dic;
 
 out_free:
-- 
2.18.0.rc1

