Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B6BC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958EC2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCXGV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:21:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbgCXGV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:21:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 217FDB9B832C6BE91BF2;
        Tue, 24 Mar 2020 14:21:09 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Mar 2020 14:21:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid double unlock
Date:   Tue, 24 Mar 2020 14:20:57 +0800
Message-ID: <20200324062057.52222-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On image that has verity and compression feature, if compressed pages
and non-compressed pages are mixed in one bio, we may double unlock
non-compressed page in below flow:

- f2fs_post_read_work
 - f2fs_decompress_work
  - f2fs_decompress_bio
   - __read_end_io
    - unlock_page
 - fsverity_enqueue_verify_work
  - f2fs_verity_work
   - f2fs_verify_bio
    - unlock_page

So it should skip handling non-compressed page in f2fs_decompress_work()
if verity is on.

Besides, add missing dec_page_count() in f2fs_verify_bio().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0197b7b80d19..24643680489b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -139,6 +139,8 @@ static void __read_end_io(struct bio *bio, bool compr, bool verity)
 			f2fs_decompress_pages(bio, page, verity);
 			continue;
 		}
+		if (verity)
+			continue;
 #endif
 
 		/* PG_error was set if any post_read step failed */
@@ -216,6 +218,7 @@ static void f2fs_verify_bio(struct bio *bio)
 		ClearPageUptodate(page);
 		ClearPageError(page);
 unlock:
+		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
 		unlock_page(page);
 	}
 }
-- 
2.18.0.rc1

