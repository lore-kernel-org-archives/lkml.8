Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B678C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4243620776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgDWJ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:57:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgDWJ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:57:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFD916E0DFCF0956272C;
        Thu, 23 Apr 2020 17:57:41 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 17:57:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix potential use-after-free issue
Date:   Thu, 23 Apr 2020 17:57:33 +0800
Message-ID: <20200423095733.7733-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error path of f2fs_read_multi_pages(), it should let last referrer
release decompress io context memory, otherwise, other referrer will
cause use-after-free issue.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4adf28bdd022..48a622b95b76 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2208,16 +2208,16 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
-				bio = NULL;
 				dic->failed = true;
 				if (refcount_sub_and_test(dic->nr_cpages - i,
-							&dic->ref))
+							&dic->ref)) {
 					f2fs_decompress_end_io(dic->rpages,
 							cc->cluster_size, true,
 							false);
-				f2fs_free_dic(dic);
+					f2fs_free_dic(dic);
+				}
 				f2fs_put_dnode(&dn);
-				*bio_ret = bio;
+				*bio_ret = NULL;
 				return ret;
 			}
 		}
-- 
2.18.0.rc1

