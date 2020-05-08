Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0428C54E4A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C74208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHJue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:50:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgEHJud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:50:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 583B52AEF2203F4EBEDC;
        Fri,  8 May 2020 17:50:31 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:50:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: shrink spinlock coverage
Date:   Fri, 8 May 2020 17:50:20 +0800
Message-ID: <20200508095020.41025-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_try_to_free_nids(), .nid_list_lock spinlock critical region will
increase as expected shrink number increase, to avoid spining other CPUs
for long time, we change to release nid caches with small batch each time
under .nid_list_lock coverage.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- shrink free nid caches in batch under spinlock coverage.
 fs/f2fs/node.c | 25 +++++++++++++++----------
 fs/f2fs/node.h |  3 +++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4da0d8713df5..1db8cabf727e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2488,7 +2488,6 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
@@ -2497,17 +2496,23 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	if (!mutex_trylock(&nm_i->build_lock))
 		return 0;
 
-	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 ||
-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
-			break;
+	while (nr_shrink && nm_i->nid_cnt[FREE_NID] > MAX_FREE_NIDS) {
+		struct free_nid *i, *next;
+		unsigned int batch = SHRINK_NID_BATCH_SIZE;
 
-		__remove_free_nid(sbi, i, FREE_NID);
-		kmem_cache_free(free_nid_slab, i);
-		nr_shrink--;
+		spin_lock(&nm_i->nid_list_lock);
+		list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
+			if (!nr_shrink || !batch ||
+				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
+				break;
+			__remove_free_nid(sbi, i, FREE_NID);
+			kmem_cache_free(free_nid_slab, i);
+			nr_shrink--;
+			batch--;
+		}
+		spin_unlock(&nm_i->nid_list_lock);
 	}
-	spin_unlock(&nm_i->nid_list_lock);
+
 	mutex_unlock(&nm_i->build_lock);
 
 	return nr - nr_shrink;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e05af5df5648..33d677f83569 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -15,6 +15,9 @@
 #define FREE_NID_PAGES	8
 #define MAX_FREE_NIDS	(NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES)
 
+/* size of free nid batch when shrinking */
+#define SHRINK_NID_BATCH_SIZE	8
+
 #define DEF_RA_NID_PAGES	0	/* # of nid pages to be readaheaded */
 
 /* maximum readahead size for node during getting data blocks */
-- 
2.18.0.rc1

