Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341D1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E62073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgAQH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:59:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbgAQH7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:59:15 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0204531959F5A58760;
        Fri, 17 Jan 2020 15:59:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 15:59:06 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: fix to avoid NULL pointer dereference
Date:   Fri, 17 Jan 2020 15:59:03 +0800
Message-ID: <20200117075903.6157-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cluster has only one compressed page, race condition as below will
trigger NULL pointer dereference:

- f2fs_write_compressed_pages
 - cic->rpages[0] = cc->rpages[0];
 - f2fs_outplace_write_data
					- f2fs_compress_write_end_io
					 - WARN_ON(!cic->rpages[1]);
 - cic->rpages[1] = cc->rpages[1];

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 45a6f20ceb3e..d8a64be90a50 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -837,12 +837,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	set_cluster_writeback(cc);
 
+	for (i = 0; i < cc->cluster_size; i++)
+		cic->rpages[i] = cc->rpages[i];
+
 	for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++) {
 		block_t blkaddr;
 
 		blkaddr = datablock_addr(dn.inode, dn.node_page,
 							dn.ofs_in_node);
-		fio.page = cic->rpages[i] = cc->rpages[i];
+		fio.page = cic->rpages[i];
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */
-- 
2.18.0.rc1

