Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD1E2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMkxg68p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGMDNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgGMDNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:13:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E18DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:13:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so4876778pld.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psxzbrOp99J5mngwlPoMiQAT+alHBEBXUBDoOJ1/0T0=;
        b=bMkxg68pIh+RvX2AC4XXKe6pe1QOex4aB1n7ujCqFRZd69+OnuEEgrE4tbSiQHzr2w
         HUONe3Rz9kqrSbjvW1EW7ygCDQ/aWO1wdWhs3MyPk8wX/x/ejLAIA2GGvf5BPpEdxpUK
         xboFHzonjwMPK3n9xEddAHBnE6DMrvun0X5PBgA59sAi87sum89ri+yl19ri98UFYIrz
         RhmOZAmNgecT2cwN+1+yJWn5QLeyeeBvAe85s+moYqIXda9vTBgiueAIHIYf70nqgLGB
         ABFcbyIbOa6l2P83EU6Ak68QAD2KGHrHF/zaKiPrPHqgGBnSirLubl0ZLyJMl4w+YAVF
         4oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psxzbrOp99J5mngwlPoMiQAT+alHBEBXUBDoOJ1/0T0=;
        b=mwiNdhgBBwyedhQfQ82Y6xVOJIC/22/WOYAQcAoQWshxC9T4dVEoRMDrMWK40OcFWg
         CYsFgksl3D6+at5QOvTH6a/AUYY5BHi+CKRWhx0a72t84O5JbZ0XPi3Ugmkxppbsjm3P
         /FiS8bil4EUGkz6oGFAKpt+Nuifr8Vqe5yc9jkxoc/cAAp/mRZoqKp+RnZk5qPeNpkGN
         4VzgADtozoBldktjBsjtU9zUGJuhzYlgxDmqGR88jdhLbyFfpzx1giPE0OI2MZbZuRv4
         oX3bPtydkr3heSLibD1Pu7JefAlgM8HsdlvH1F3RE+kkolWg5LoyKpMTrVN7V14DoYa+
         aMDQ==
X-Gm-Message-State: AOAM533pi3eBplZJAzEEymbPJaosWfieLtV3oyA1BZfXh+3J/LzJiNbS
        b5Ddr08fHD9IJc513YuAd52wUmCy
X-Google-Smtp-Source: ABdhPJwWlxM5jkFHf6rPbXsTiEijCyx0KGUV3hHGgDVb+KR9EnkUi27lPfgLbJA7ICFZ7bgXL6pYMQ==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr37221828plb.250.1594609980408;
        Sun, 12 Jul 2020 20:13:00 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([172.30.115.29])
        by smtp.gmail.com with ESMTPSA id cl17sm12635508pjb.50.2020.07.12.20.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 20:12:59 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: change the way of handling range.len in F2FS_IOC_SEC_TRIM_FILE
Date:   Mon, 13 Jul 2020 12:12:52 +0900
Message-Id: <20200713031252.3873546-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
 1. Added -1 value support for range.len to secure trim the whole blocks
    starting from range.start regardless of i_size.
 2. If the end of the range passes over the end of file, it means until
    the end of file (i_size).
 3. ignored the case of that range.len is zero to prevent the function
    from making end_addr zero and triggering different behaviour of
    the function.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
 - Changed -1 range.len option to mean the whole blocks starting from
   range.start regardless of i_size
---
 fs/f2fs/file.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 368c80f8e2a1..2485841e3b2d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	pgoff_t index, pg_end;
 	block_t prev_block = 0, len = 0;
 	loff_t end_addr;
-	bool to_end;
+	bool to_end = false;
 	int ret = 0;
 
 	if (!(filp->f_mode & FMODE_WRITE))
@@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
+			range.start >= inode->i_size) {
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (range.start >= inode->i_size) {
-		ret = -EINVAL;
+	if (range.len == 0)
 		goto err;
-	}
 
-	if (inode->i_size - range.start < range.len) {
-		ret = -E2BIG;
-		goto err;
+	if (inode->i_size - range.start > range.len) {
+		end_addr = range.start + range.len;
+	} else {
+		end_addr = range.len == (u64)-1 ?
+			sbi->sb->s_maxbytes : inode->i_size;
+		to_end = true;
 	}
-	end_addr = range.start + range.len;
 
-	to_end = (end_addr == inode->i_size);
 	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
 			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
 		ret = -EINVAL;
@@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 
-	ret = filemap_write_and_wait_range(mapping, range.start, end_addr - 1);
+	ret = filemap_write_and_wait_range(mapping, range.start,
+			to_end ? LLONG_MAX : end_addr - 1);
 	if (ret)
 		goto out;
 
-- 
2.27.0.383.g050319c2ae-goog

