Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EED8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634C720732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392894AbgDOCNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:13:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387984AbgDOCN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:13:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6234E7247FE3D8DBD1C0;
        Wed, 15 Apr 2020 10:13:27 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 10:13:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to avoid page count leak
Date:   Wed, 15 Apr 2020 10:13:13 +0800
Message-ID: <20200415021313.95538-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_read_data_pages(), once we add page into radix tree, we need to
release reference count of that page, however when f2fs_read_multi_pages()
fails, we didn't handle that case correctly, fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add Fixes tag
- improve commit message a bit
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 6 +++++-
 fs/f2fs/f2fs.h     | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 498e0c2ba6ea..dbe3fa359a29 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -79,7 +79,7 @@ static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
 	}
 }
 
-static void f2fs_put_rpages(struct compress_ctx *cc)
+void f2fs_put_rpages(struct compress_ctx *cc)
 {
 	f2fs_drop_rpages(cc, cc->cluster_size, false);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1139d8cf4b8d..22a31e2401cf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2138,7 +2138,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		} else if (!PageUptodate(page)) {
 			continue;
 		}
-		unlock_page(page);
+		f2fs_put_page(page, 1);
 		cc->rpages[i] = NULL;
 		cc->nr_rpages--;
 	}
@@ -2303,6 +2303,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 				if (ret)
 					goto set_error_page;
@@ -2346,6 +2348,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da5e9dd747fa..94d044feffd0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3803,6 +3803,7 @@ static inline bool f2fs_post_read_required(struct inode *inode)
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 bool f2fs_is_compressed_page(struct page *page);
+void f2fs_put_rpages(struct compress_ctx *cc);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
-- 
2.18.0.rc1

