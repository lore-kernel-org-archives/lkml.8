Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D593C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004020780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgDHL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:56:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgDHL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:56:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A437E85A62BF85AA41FC;
        Wed,  8 Apr 2020 19:56:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 19:56:09 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce mempool for {,de}compress intermediate page allocation
Date:   Wed, 8 Apr 2020 19:56:05 +0800
Message-ID: <20200408115605.15590-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compression feature is on, in scenario of no enough free memory,
page refault ratio is higher than before, the root cause is:
- {,de}compression flow needs to allocate intermediate pages to store
compressed data in cluster, so during their allocation, vm may reclaim
mmaped pages.
- if above reclaimed pages belong to compressed cluster, during its
refault, it may cause more intermediate pages allocation, result in
reclaiming more mmaped pages.

So this patch introduces a mempool for intermediate page allocation,
in order to avoid high refault ratio, by default, number of
preallocated page in pool is 512, user can change the number by
assigning 'num_compress_pages' parameter during module initialization.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 64 ++++++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h     |  4 +++
 fs/f2fs/super.c    |  6 +++++
 3 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 25d72e18ac30..ac265c6c40b5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -65,15 +65,6 @@ static void f2fs_set_compressed_page(struct page *page,
 	page->mapping = inode->i_mapping;
 }
 
-static void f2fs_put_compressed_page(struct page *page)
-{
-	set_page_private(page, (unsigned long)NULL);
-	ClearPagePrivate(page);
-	page->mapping = NULL;
-	unlock_page(page);
-	put_page(page);
-}
-
 static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
 {
 	int i;
@@ -476,17 +467,47 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
-static struct page *f2fs_grab_page(void)
+static mempool_t *compress_page_pool = NULL;
+int num_compress_pages = 512;
+module_param(num_compress_pages, uint, 0444);
+MODULE_PARM_DESC(num_compress_pages,
+		"Number of intermediate compress pages to preallocate");
+
+int f2fs_init_compress_mempool(void)
+{
+	compress_page_pool = mempool_create_page_pool(num_compress_pages, 0);
+	if (!compress_page_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void f2fs_destroy_compress_mempool(void)
+{
+	mempool_destroy(compress_page_pool);
+}
+
+static struct page *f2fs_compress_alloc_page(void)
 {
 	struct page *page;
 
-	page = alloc_page(GFP_NOFS);
-	if (!page)
-		return NULL;
+	page = mempool_alloc(compress_page_pool, GFP_NOFS);
 	lock_page(page);
+
 	return page;
 }
 
+void f2fs_compress_free_page(struct page *page)
+{
+	if (!page)
+		return;
+	set_page_private(page, (unsigned long)NULL);
+	ClearPagePrivate(page);
+	page->mapping = NULL;
+	unlock_page(page);
+	mempool_free(page, compress_page_pool);
+}
+
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
@@ -516,7 +537,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	}
 
 	for (i = 0; i < cc->nr_cpages; i++) {
-		cc->cpages[i] = f2fs_grab_page();
+		cc->cpages[i] = f2fs_compress_alloc_page();
 		if (!cc->cpages[i]) {
 			ret = -ENOMEM;
 			goto out_free_cpages;
@@ -561,7 +582,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	vunmap(cc->rbuf);
 
 	for (i = nr_cpages; i < cc->nr_cpages; i++) {
-		f2fs_put_compressed_page(cc->cpages[i]);
+		f2fs_compress_free_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
 	}
 
@@ -581,7 +602,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 out_free_cpages:
 	for (i = 0; i < cc->nr_cpages; i++) {
 		if (cc->cpages[i])
-			f2fs_put_compressed_page(cc->cpages[i]);
+			f2fs_compress_free_page(cc->cpages[i]);
 	}
 	kfree(cc->cpages);
 	cc->cpages = NULL;
@@ -1181,7 +1202,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 	if (unlikely(bio->bi_status))
 		mapping_set_error(cic->inode->i_mapping, -EIO);
 
-	f2fs_put_compressed_page(page);
+	f2fs_compress_free_page(page);
 
 	dec_page_count(sbi, F2FS_WB_DATA);
 
@@ -1342,7 +1363,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	for (i = 0; i < dic->nr_cpages; i++) {
 		struct page *page;
 
-		page = f2fs_grab_page();
+		page = f2fs_compress_alloc_page();
 		if (!page)
 			goto out_free;
 
@@ -1362,7 +1383,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 			continue;
 		}
 
-		dic->tpages[i] = f2fs_grab_page();
+		dic->tpages[i] = f2fs_compress_alloc_page();
 		if (!dic->tpages[i])
 			goto out_free;
 	}
@@ -1384,8 +1405,7 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 				continue;
 			if (!dic->tpages[i])
 				continue;
-			unlock_page(dic->tpages[i]);
-			put_page(dic->tpages[i]);
+			f2fs_compress_free_page(dic->tpages[i]);
 		}
 		kfree(dic->tpages);
 	}
@@ -1394,7 +1414,7 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 		for (i = 0; i < dic->nr_cpages; i++) {
 			if (!dic->cpages[i])
 				continue;
-			f2fs_put_compressed_page(dic->cpages[i]);
+			f2fs_compress_free_page(dic->cpages[i]);
 		}
 		kfree(dic->cpages);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ed354af78966..e0d520f2c142 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3798,6 +3798,8 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
+int f2fs_init_compress_mempool(void);
+void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
@@ -3831,6 +3833,8 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
 	WARN_ON_ONCE(1);
 	return ERR_PTR(-EINVAL);
 }
+static inline int f2fs_init_compress_mempool(void) { return 0; }
+static inline void f2fs_destroy_compress_mempool(void) { }
 #endif
 
 static inline void set_compress_context(struct inode *inode)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b83b17b54a0a..9ad927c4d259 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3889,7 +3889,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_bioset();
 	if (err)
 		goto free_bio_enrty_cache;
+	err = f2fs_init_compress_mempool();
+	if (err)
+		goto free_bioset;
 	return 0;
+free_bioset:
+	f2fs_destroy_bioset();
 free_bio_enrty_cache:
 	f2fs_destroy_bio_entry_cache();
 free_post_read:
@@ -3917,6 +3922,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_compress_mempool();
 	f2fs_destroy_bioset();
 	f2fs_destroy_bio_entry_cache();
 	f2fs_destroy_post_read_processing();
-- 
2.18.0.rc1

