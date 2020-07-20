Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D29E2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGTIxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:53:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgGTIxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:53:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ACB9A97D3727E5A083E1;
        Mon, 20 Jul 2020 16:53:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 16:52:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: fix to avoid memory leak on cc->cpages
Date:   Mon, 20 Jul 2020 16:52:50 +0800
Message-ID: <20200720085250.47279-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated for storing compressed pages' poitner should be
released after f2fs_write_compressed_pages(), otherwise it will
cause memory leak issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3a847bc36748..a20c9f3272af 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1385,6 +1385,8 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 		err = f2fs_write_compressed_pages(cc, submitted,
 							wbc, io_type);
 		cops->destroy_compress_ctx(cc);
+		kfree(cc->cpages);
+		cc->cpages = NULL;
 		if (!err)
 			return 0;
 		f2fs_bug_on(F2FS_I_SB(cc->inode), err != -EAGAIN);
-- 
2.26.2

