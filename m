Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC39C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647622071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSL6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:58:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgCSL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:58:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A693FA6BF3FD5995D8B0;
        Thu, 19 Mar 2020 19:58:10 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 19:58:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: fix NULL pointer dereference in f2fs_verity_work()
Date:   Thu, 19 Mar 2020 19:57:59 +0800
Message-ID: <20200319115800.108926-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200319115800.108926-1-yuchao0@huawei.com>
References: <20200319115800.108926-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both compression and fsverity feature is on, generic/572 will
report below NULL pointer dereference bug.

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
 #PF: supervisor read access in kernel mode
 Workqueue: fsverity_read_queue f2fs_verity_work [f2fs]
 RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
 Call Trace:
  process_one_work+0x16c/0x3f0
  worker_thread+0x4c/0x440
  ? rescuer_thread+0x350/0x350
  kthread+0xf8/0x130
  ? kthread_unpark+0x70/0x70
  ret_from_fork+0x35/0x40

There are two issue in f2fs_verity_work():
- it needs to traverse and verify all pages in bio.
- if pages in bio belong to non-compressed cluster, accessing
decompress IO context stored in page private will cause NULL
pointer dereference.

Fix them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5c5db09324b7..66e49fc1056e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -187,12 +187,37 @@ static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
 
 static void f2fs_verify_bio(struct bio *bio)
 {
-	struct page *page = bio_first_page_all(bio);
-	struct decompress_io_ctx *dic =
-			(struct decompress_io_ctx *)page_private(page);
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+	struct decompress_io_ctx *dic, *pdic = NULL;
+
+	bio_for_each_segment_all(bv, bio, iter_all) {
+		struct page *page = bv->bv_page;
+
+		dic = (struct decompress_io_ctx *)page_private(page);
+
+		if (dic) {
+			if (dic != pdic) {
+				f2fs_verify_pages(dic->rpages,
+							dic->cluster_size);
+				f2fs_free_dic(dic);
+				pdic = dic;
+			}
+			continue;
+		}
+		pdic = dic;
 
-	f2fs_verify_pages(dic->rpages, dic->cluster_size);
-	f2fs_free_dic(dic);
+		if (bio->bi_status || PageError(page)) {
+			ClearPageUptodate(page);
+			ClearPageError(page);
+		} else {
+			if (fsverity_verify_page(page))
+				SetPageUptodate(page);
+			else
+				SetPageError(page);
+		}
+		unlock_page(page);
+	}
 }
 #endif
 
-- 
2.18.0.rc1

