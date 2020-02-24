Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422BC11D31
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8AA20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBXLUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:20:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgBXLUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:20:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A75C4EE6E982B2D97FEB;
        Mon, 24 Feb 2020 19:20:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 19:20:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/5] f2fs: fix to avoid NULL pointer dereference
Date:   Mon, 24 Feb 2020 19:20:17 +0800
Message-ID: <20200224112019.93829-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200224112019.93829-1-yuchao0@huawei.com>
References: <20200224112019.93829-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000000
PC is at f2fs_free_dic+0x60/0x2c8
LR is at f2fs_decompress_pages+0x3c4/0x3e8
f2fs_free_dic+0x60/0x2c8
f2fs_decompress_pages+0x3c4/0x3e8
__read_end_io+0x78/0x19c
f2fs_post_read_work+0x6c/0x94
process_one_work+0x210/0x48c
worker_thread+0x2e8/0x44c
kthread+0x110/0x120
ret_from_fork+0x10/0x18

In f2fs_free_dic(), we can not use f2fs_put_page(,1) to release dic->tpages[i],
as the page's mapping is NULL.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4ba65a3b0456..864035549329 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1133,7 +1133,8 @@ void f2fs_free_dic(struct decompress_io_ctx *dic)
 		for (i = 0; i < dic->cluster_size; i++) {
 			if (dic->rpages[i])
 				continue;
-			f2fs_put_page(dic->tpages[i], 1);
+			unlock_page(dic->tpages[i]);
+			put_page(dic->tpages[i]);
 		}
 		kfree(dic->tpages);
 	}
-- 
2.18.0.rc1

