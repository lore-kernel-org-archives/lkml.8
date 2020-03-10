Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B46C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9BA2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgCJNa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:30:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728363AbgCJMuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A97E54CF64383DF3605;
        Tue, 10 Mar 2020 20:50:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 20:50:14 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: allow to clear F2FS_COMPR_FL flag
Date:   Tue, 10 Mar 2020 20:50:09 +0800
Message-ID: <20200310125009.12966-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200310125009.12966-1-yuchao0@huawei.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regular inode has no compressed cluster, allow using 'chattr -c'
to remove its compress flag, recovering it to a non-compressed file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 08c19ab81c80..e04a31e21448 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1822,10 +1822,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	}
 
 	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
-		if (S_ISREG(inode->i_mode) &&
-			(masked_flags & F2FS_COMPR_FL || i_size_read(inode) ||
-						F2FS_HAS_BLOCKS(inode)))
-			return -EINVAL;
+		if (S_ISREG(inode->i_mode) && (masked_flags & F2FS_COMPR_FL)) {
+			if (f2fs_disable_compressed_file(inode))
+				return -EINVAL;
+		}
 		if (iflags & F2FS_NOCOMP_FL)
 			return -EINVAL;
 		if (iflags & F2FS_COMPR_FL) {
-- 
2.18.0.rc1

