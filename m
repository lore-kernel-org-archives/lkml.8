Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14705C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA224246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCBJep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:34:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgCBJep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:34:45 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39D1753B58EB3F07568D;
        Mon,  2 Mar 2020 17:34:43 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 17:34:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid using uninitialized variable
Date:   Mon, 2 Mar 2020 17:34:27 +0800
Message-ID: <20200302093427.49796-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_vm_page_mkwrite(), if inode is compress one, and current mmapped
page locates in compressed cluster, we have to call f2fs_get_dnode_of_data()
to get its physical block address before f2fs_wait_on_block_writeback().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09164c6a1d39..caa7ca42791f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -106,10 +106,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		err = f2fs_get_block(&dn, page->index);
 		f2fs_put_dnode(&dn);
 		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
-		if (err) {
-			unlock_page(page);
-			goto out_sem;
-		}
+	}
+
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (!need_alloc) {
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+		f2fs_put_dnode(&dn);
+	}
+#endif
+	if (err) {
+		unlock_page(page);
+		goto out_sem;
 	}
 
 	f2fs_wait_on_page_writeback(page, DATA, false, true);
-- 
2.18.0.rc1

