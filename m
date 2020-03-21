Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643F5C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AA120724
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584793345;
	bh=/3nPfZXBKwKIY++A+xEYIPUcMBEvmjAt1f4xiG8QQQU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yOTpYtVbBzQc9beyPAgSs0A7mf6pIO7PUOKdeDdkHgkxjDHx8Fr48UuuQCW1VbqKs
	 39HzjdYA/OeDXAoOPara+PsxS84SkdR1X+bIYzO26/rWRQ0ApfFvWlkDub4eDmTZAC
	 Z3YQ83kn/IagIw/aQ+l+Bkbo476A6qkoFA3klj7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCUMWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:22:23 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83F720722;
        Sat, 21 Mar 2020 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793343;
        bh=/3nPfZXBKwKIY++A+xEYIPUcMBEvmjAt1f4xiG8QQQU=;
        h=From:To:Cc:Subject:Date:From;
        b=JFmljKSM8w9/MneocFtCjszq19tzQLUtntTjEkg7r6wBDNMD7T8A1AbIhFWOu1Wpn
         yRFtKKuUiHqvhVhVePJR3SwyRBbZNEBzcJAiT4PkEBPC5aevrhdPPOm7Y/Uk/6+Uzn
         Z9HwnHUPCi+NZeILt1EwiwSm9T+SMUoFLuJpmesw=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/4] f2fs: fix NULL pointer dereference in f2fs_verity_work()
Date:   Sat, 21 Mar 2020 20:21:53 +0800
Message-Id: <20200321122153.22424-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
v2:
- fix error path of f2fs_verify_bio pointed out by Eric
 fs/f2fs/data.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5c5db09324b7..d5b1eda21519 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -187,12 +187,39 @@ static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
 
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
 
-	f2fs_verify_pages(dic->rpages, dic->cluster_size);
-	f2fs_free_dic(dic);
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
+
+		if (bio->bi_status || PageError(page))
+			goto clear_uptodate;
+
+		if (fsverity_verify_page(page)) {
+			SetPageUptodate(page);
+			goto unlock;
+		}
+clear_uptodate:
+		ClearPageUptodate(page);
+		ClearPageError(page);
+unlock:
+		unlock_page(page);
+	}
 }
 #endif
 
-- 
2.22.0

