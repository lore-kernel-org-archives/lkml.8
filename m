Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7712068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgEZBzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:55:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388360AbgEZBzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:55:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2467D6357BB032DF03EB;
        Tue, 26 May 2020 09:55:13 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 26 May 2020 09:55:05 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: don't compress any datas after cp stop
Date:   Tue, 26 May 2020 09:55:02 +0800
Message-ID: <20200526015502.22313-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compressed data writeback, we need to drop dirty pages like we did
for non-compressed pages if cp stops, however it's not needed to compress
any data in such case, so let's detect cp stop condition in
cluster_may_compress() to avoid redundant compressing and let following
f2fs_write_raw_pages() drops dirty pages correctly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index bf152c0d79fe..a53578a89211 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -849,6 +849,8 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 		return false;
 	if (!f2fs_cluster_is_full(cc))
 		return false;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
+		return false;
 	return __cluster_may_compress(cc);
 }
 
-- 
2.18.0.rc1

