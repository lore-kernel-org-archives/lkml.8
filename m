Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE20C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11E321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBRKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:22:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbgBRKWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:22:39 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8861CB2F2C87A3264F37;
        Tue, 18 Feb 2020 18:22:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Feb 2020 18:22:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: avoid __GFP_NOFAIL in f2fs_bio_alloc
Date:   Tue, 18 Feb 2020 18:21:34 +0800
Message-ID: <20200218102136.32150-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__f2fs_bio_alloc() won't fail due to memory pool backend, remove unneeded
__GFP_NOFAIL flag in __f2fs_bio_alloc().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 12 ++++--------
 fs/f2fs/f2fs.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index baf12318ec64..3a4ece26928c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -54,17 +54,13 @@ static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
 }
 
-struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail)
+struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio)
 {
-	struct bio *bio;
-
-	if (no_fail) {
+	if (noio) {
 		/* No failure on bio allocation */
-		bio = __f2fs_bio_alloc(GFP_NOIO, npages);
-		if (!bio)
-			bio = __f2fs_bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
-		return bio;
+		return __f2fs_bio_alloc(GFP_NOIO, npages);
 	}
+
 	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
 		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
 		return NULL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5316ac3eacdf..65f569949d42 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3343,7 +3343,7 @@ void f2fs_destroy_checkpoint_caches(void);
  */
 int __init f2fs_init_bioset(void);
 void f2fs_destroy_bioset(void);
-struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail);
+struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio);
 int f2fs_init_bio_entry_cache(void);
 void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_bio(struct f2fs_sb_info *sbi,
-- 
2.18.0.rc1

