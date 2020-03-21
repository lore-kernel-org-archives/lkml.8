Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7525C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B320757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584793433;
	bh=CLphnmsgUdhergwuL7TSo/4QUaTvu2i11XGuraVfcfM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VXitzy2p+KXNwUHNhiGfXDnwehD8UDoXLdG+btLWlYhFT/rmwgUlfzgHPlWbVHCll
	 wyn29Xn3I2eekL1sJF8MUMlkO7UeNqh613o23Jo+DNVy2LwQYVwSLPOZebKmcy6riV
	 nztvkCWw0QQlYk6yD8IglFnB/U/f2wRrXWrKzQLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCUMXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCUMXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:23:52 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB3B20722;
        Sat, 21 Mar 2020 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793431;
        bh=CLphnmsgUdhergwuL7TSo/4QUaTvu2i11XGuraVfcfM=;
        h=From:To:Cc:Subject:Date:From;
        b=qDGl6I5ValARktfRM5ZGaY1/IsvHQoZGLy0jwuPVkjVXk4gbZnWbaIjcPXg3YDy0w
         D06hW/4tHBdCcTCgpb5yHPpvjbjXaeB+jV7GIniNnWc83LKTizyvRsZd4mXl8JuQru
         wng+yST0rRDlle9MUr3Tnn3NunsFjZsAz/xP57/8=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't call fscrypt_get_encryption_info() explicitly in f2fs_tmpfile()
Date:   Sat, 21 Mar 2020 20:23:27 +0800
Message-Id: <20200321122327.22522-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In f2fs_tmpfile(), parent inode's encryption info is only used when
inheriting encryption context to its child inode, however, we have
already called fscrypt_get_encryption_info() in fscrypt_inherit_context()
to get the encryption info, so just removing unneeded one in
f2fs_tmpfile().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 95cfbce062e8..f54119da2217 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -874,12 +874,6 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) {
-		int err = fscrypt_get_encryption_info(dir);
-		if (err)
-			return err;
-	}
-
 	return __f2fs_tmpfile(dir, dentry, mode, NULL);
 }
 
-- 
2.22.0

