Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D9C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBCB20578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0KaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:30:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgC0KaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:30:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7F898749A64AA55676B8;
        Fri, 27 Mar 2020 18:30:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 18:29:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix to disable compression on directory
Date:   Fri, 27 Mar 2020 18:29:51 +0800
Message-ID: <20200327102953.104035-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to call f2fs_disable_compressed_file() to disable
compression on directory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 10 ++++++----
 fs/f2fs/file.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9274399d9505..4e80cbe130d9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3850,10 +3850,12 @@ static inline u64 f2fs_disable_compressed_file(struct inode *inode)
 
 	if (!f2fs_compressed_file(inode))
 		return 0;
-	if (get_dirty_pages(inode))
-		return 1;
-	if (fi->i_compr_blocks)
-		return fi->i_compr_blocks;
+	if (S_ISREG(inode->i_mode)) {
+		if (get_dirty_pages(inode))
+			return 1;
+		if (fi->i_compr_blocks)
+			return fi->i_compr_blocks;
+	}
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1476a3bc6317..6cb3c6cae7cd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1815,7 +1815,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	}
 
 	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
-		if (S_ISREG(inode->i_mode) && (masked_flags & F2FS_COMPR_FL)) {
+		if (masked_flags & F2FS_COMPR_FL) {
 			if (f2fs_disable_compressed_file(inode))
 				return -EINVAL;
 		}
-- 
2.18.0.rc1

