Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB696C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B288B20757
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDJIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:51:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgDJIvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:51:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 75DFB55D413CE05A1BE4;
        Fri, 10 Apr 2020 16:51:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Apr 2020 16:51:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid page count leak
Date:   Fri, 10 Apr 2020 16:51:23 +0800
Message-ID: <20200410085123.55118-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In below error path, we missed to release reference count of pages
in compressed cluster, fix it.
- f2fs_mpage_readpages()
 - f2fs_read_multi_pages()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 6 +++++-
 fs/f2fs/f2fs.h     | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 25d72e18ac30..d83dfbe624b0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -88,7 +88,7 @@ static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
 	}
 }
 
-static void f2fs_put_rpages(struct compress_ctx *cc)
+void f2fs_put_rpages(struct compress_ctx *cc)
 {
 	f2fs_drop_rpages(cc, cc->cluster_size, false);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a829a89f596..896887c9febe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2115,7 +2115,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		} else if (!PageUptodate(page)) {
 			continue;
 		}
-		unlock_page(page);
+		f2fs_put_page(page, 1);
 		cc->rpages[i] = NULL;
 		cc->nr_rpages--;
 	}
@@ -2280,6 +2280,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 				if (ret)
 					goto set_error_page;
@@ -2323,6 +2325,8 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead, false);
+				if (ret)
+					f2fs_put_rpages(&cc);
 				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ed354af78966..25cc202adc50 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3790,6 +3790,7 @@ static inline bool f2fs_post_read_required(struct inode *inode)
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 bool f2fs_is_compressed_page(struct page *page);
+void f2fs_put_rpages(struct compress_ctx *cc);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
 			struct page **pagep, pgoff_t index, void **fsdata);
-- 
2.18.0.rc1

