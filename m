Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C19C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69D1206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCYJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:28:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgCYJ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:28:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E29A9AD761091BAF960F;
        Wed, 25 Mar 2020 17:28:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Mar 2020 17:27:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] f2fs: don't inline compressed inode
Date:   Wed, 25 Mar 2020 17:27:54 +0800
Message-ID: <20200325092754.63411-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_may_inline_data() only check compressed flag on current inode
rather than on parent inode, however at this time compressed flag
has not been inherited yet.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Jaegeuk,

I'm not sure about this, whether inline_data flag can be compatible with
compress flag, thoughts?

 fs/f2fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index f54119da2217..3807d1b4c4bc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -86,7 +86,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (test_opt(sbi, INLINE_XATTR))
 		set_inode_flag(inode, FI_INLINE_XATTR);
 
-	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
+	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode) &&
+					!f2fs_compressed_file(dir))
 		set_inode_flag(inode, FI_INLINE_DATA);
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(inode, FI_INLINE_DENTRY);
-- 
2.18.0.rc1

