Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D901C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CE5206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT9AD4rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgEHEZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:25:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090A7C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 21:25:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so283428pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 21:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aPnXPt7XxoOAHSRq3riNhrJBZ4cY0JvXvcscvwLua8=;
        b=nT9AD4rnnixH0pJCyI1upyTuO3RTv/BWEt+OtPQw30nektDuqQ1H8zs8QNGUXzr+T6
         1irv0mLDdiNQqwPQPDepfsedknij6dLNPxTUFvk2sFkD6fQKS0XCA9oKSJF4TtPEolfX
         lhF/7CwgnKGcMyoe94rzkaCW2ED00oBxcWyKp9AQLOoy9Hin3mxd6OaFBraTAA1smQF+
         +wDNd9ii3FzlZXat1mDn3z7YBb8n1K0c9FSDdeILwIRDx0se8Oy7DvgUhOVtQQYa8XI0
         fykTjH9q7e5kY+oZ/dJqC2YVniUiVHuauEnjfmKDVMy6CMBZHSWP6ath2dRTuSBzaXz9
         9QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aPnXPt7XxoOAHSRq3riNhrJBZ4cY0JvXvcscvwLua8=;
        b=had8YlYb+UaxPj5MbeeRlTGzyCS91rmPv/7KpHNzkrQaTLBk7EYbJjJPYVzYexrzj8
         Tz64NpFSrykX5CRRe50UDE5TOgcL179BslMnfVu9y9a7lFxBw2BPi//QnSV6vtOF/41x
         EUX1XhX8IbSnblogx6UkvGvJo/qv9MLxM/g3Y3doHoHfiDcTMkyyXRaSKi/j/8d2VXK2
         BuhJQPrYv9oOQ7S+VTI73UGv2GviN0bL7zw6YUy8+TS6aw3VgorctrBi+q9iF+yEK7u/
         2uFyMZDhc+VNsPkDdCHtoEs/3EoRIzoNqI44vxlDFpz8u0kqQQL00escmmgmfR+naa/R
         88aQ==
X-Gm-Message-State: AGi0PuaBY+QGDz4Tpcok4CC7/SQC6ep6mxDXHfRqe1OD8AiylV5ppqCY
        IUMEgqyo+/P76IZs8KRwU70cMuegeBVIKg==
X-Google-Smtp-Source: APiQypLiVh2QiACIvK/iHw1HS29FOo73ZluYIhU0mxCSLQWlmpE4+h+bOhtKuKQF/zjKcZvO5mzyNg==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr561018pgh.6.1588911912044;
        Thu, 07 May 2020 21:25:12 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id j5sm348964pfh.58.2020.05.07.21.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 21:25:11 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: remove race condition in releasing cblocks
Date:   Fri,  8 May 2020 13:25:06 +0900
Message-Id: <20200508042506.143395-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Now, if writing pages and releasing compress blocks occur
simultaneously, and releasing cblocks is executed more than one time
to a file, then total block count of filesystem and block count of the
file could be incorrect and damaged.

We have to execute releasing compress blocks only one time for a file
without being interfered by writepages path.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4aab4b42d8ba..a92bc51b9b28 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	pgoff_t page_idx = 0, last_idx;
 	unsigned int released_blocks = 0;
 	int ret;
+	int writecount;
 
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
@@ -3509,13 +3510,29 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!IS_IMMUTABLE(inode)) {
-		F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
-		f2fs_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		f2fs_mark_inode_dirty_sync(inode, true);
+	writecount = atomic_read(&inode->i_writecount);
+	if ((filp->f_mode & FMODE_WRITE && writecount != 1) || writecount) {
+		ret = -EBUSY;
+		goto out;
 	}
 
+	if (IS_IMMUTABLE(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
+	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
+	f2fs_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
+
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 
@@ -3554,9 +3571,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
-
-	inode_unlock(inode);
 out:
+	inode_unlock(inode);
+
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.26.2.526.g744177e7f7-goog

