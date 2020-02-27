Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E9724691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgB0LaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:30:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728846AbgB0LaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:30:21 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A92B6C192E6CC6BD8603;
        Thu, 27 Feb 2020 19:30:18 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 19:30:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: remove i_sem lock coverage in f2fs_setxattr()
Date:   Thu, 27 Feb 2020 19:30:04 +0800
Message-ID: <20200227113005.127729-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200227113005.127729-1-yuchao0@huawei.com>
References: <20200227113005.127729-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_inode.xattr_ver field was gone after commit d260081ccf37
("f2fs: change recovery policy of xattr node block"), remove i_sem
lock coverage in f2fs_setxattr()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index e46a10eb0e42..5c3e82e7c0bb 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -777,12 +777,9 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-	/* protect xattr_ver */
-	down_write(&F2FS_I(inode)->i_sem);
 	down_write(&F2FS_I(inode)->i_xattr_sem);
 	err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
 	up_write(&F2FS_I(inode)->i_xattr_sem);
-	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_unlock_op(sbi);
 
 	f2fs_update_time(sbi, REQ_TIME);
-- 
2.18.0.rc1

