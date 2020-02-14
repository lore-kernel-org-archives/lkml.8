Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60516C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34620675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgBNJqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:46:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728807AbgBNJqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:46:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F33C2703F484B2A39113;
        Fri, 14 Feb 2020 17:46:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 17:45:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to wait all node page writeback
Date:   Fri, 14 Feb 2020 17:45:12 +0800
Message-ID: <20200214094512.13035-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200214094512.13035-1-yuchao0@huawei.com>
References: <20200214094512.13035-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition that we may miss to wait for all node pages
writeback, fix it.

- fsync()				- shrink
 - f2fs_do_sync_file
					 - __write_node_page
					  - set_page_writeback(page#0)
					  : remove DIRTY/TOWRITE flag
  - f2fs_fsync_node_pages
  : won't find page #0 as TOWRITE flag was removeD
  - f2fs_wait_on_node_pages_writeback
  : wont' wait page #0 writeback as it was not in fsync_node_list list.
					   - f2fs_add_fsync_node_entry

Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 332cebc2033c..9824f055a5bc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1561,15 +1561,16 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
-	set_page_writeback(page);
-	ClearPageError(page);
-
+	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(sbi, page)) {
 		seq = f2fs_add_fsync_node_entry(sbi, page);
 		if (seq_id)
 			*seq_id = seq;
 	}
 
+	set_page_writeback(page);
+	ClearPageError(page);
+
 	fio.old_blkaddr = ni.blk_addr;
 	f2fs_do_write_node_page(nid, &fio);
 	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
-- 
2.18.0.rc1

