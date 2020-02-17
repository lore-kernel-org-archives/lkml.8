Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19AC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A221206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgBQJrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:47:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgBQJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:47:23 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BE7A4C76B291BB35E5C;
        Mon, 17 Feb 2020 17:47:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Feb 2020 17:47:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add prefix for f2fs slab cache name
Date:   Mon, 17 Feb 2020 17:46:20 +0800
Message-ID: <20200217094620.106582-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid polluting global slab cache namespace.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/node.c    | 8 ++++----
 fs/f2fs/segment.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a877cc50a4c3..baf12318ec64 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3867,7 +3867,7 @@ void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi)
 
 int __init f2fs_init_bio_entry_cache(void)
 {
-	bio_entry_slab = f2fs_kmem_cache_create("bio_entry_slab",
+	bio_entry_slab = f2fs_kmem_cache_create("f2fs_bio_entry_slab",
 			sizeof(struct bio_entry));
 	if (!bio_entry_slab)
 		return -ENOMEM;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d5edbe2ce4a1..040ffb09a126 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3193,22 +3193,22 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 
 int __init f2fs_create_node_manager_caches(void)
 {
-	nat_entry_slab = f2fs_kmem_cache_create("nat_entry",
+	nat_entry_slab = f2fs_kmem_cache_create("f2fs_nat_entry",
 			sizeof(struct nat_entry));
 	if (!nat_entry_slab)
 		goto fail;
 
-	free_nid_slab = f2fs_kmem_cache_create("free_nid",
+	free_nid_slab = f2fs_kmem_cache_create("f2fs_free_nid",
 			sizeof(struct free_nid));
 	if (!free_nid_slab)
 		goto destroy_nat_entry;
 
-	nat_entry_set_slab = f2fs_kmem_cache_create("nat_entry_set",
+	nat_entry_set_slab = f2fs_kmem_cache_create("f2fs_nat_entry_set",
 			sizeof(struct nat_entry_set));
 	if (!nat_entry_set_slab)
 		goto destroy_free_nid;
 
-	fsync_node_entry_slab = f2fs_kmem_cache_create("fsync_node_entry",
+	fsync_node_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_node_entry",
 			sizeof(struct fsync_node_entry));
 	if (!fsync_node_entry_slab)
 		goto destroy_nat_entry_set;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1628bc8327f1..fb3e531a36d2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4832,22 +4832,22 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi)
 
 int __init f2fs_create_segment_manager_caches(void)
 {
-	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
+	discard_entry_slab = f2fs_kmem_cache_create("f2fs_discard_entry",
 			sizeof(struct discard_entry));
 	if (!discard_entry_slab)
 		goto fail;
 
-	discard_cmd_slab = f2fs_kmem_cache_create("discard_cmd",
+	discard_cmd_slab = f2fs_kmem_cache_create("f2fs_discard_cmd",
 			sizeof(struct discard_cmd));
 	if (!discard_cmd_slab)
 		goto destroy_discard_entry;
 
-	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
+	sit_entry_set_slab = f2fs_kmem_cache_create("f2fs_sit_entry_set",
 			sizeof(struct sit_entry_set));
 	if (!sit_entry_set_slab)
 		goto destroy_discard_cmd;
 
-	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
+	inmem_entry_slab = f2fs_kmem_cache_create("f2fs_inmem_page_entry",
 			sizeof(struct inmem_pages));
 	if (!inmem_entry_slab)
 		goto destroy_sit_entry_set;
-- 
2.18.0.rc1

