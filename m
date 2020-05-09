Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A3C54E7E
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EBA21473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgEIXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgEIXp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:45:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1036C061A0C;
        Sat,  9 May 2020 16:45:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRM-Em; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/20] FIEMAP: don't bother with access_ok()
Date:   Sun, 10 May 2020 00:45:41 +0100
Message-Id: <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we use copy_to_user() on that thing anyway (and always had).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/ioctl.c | 5 -----
 fs/ioctl.c      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cb..a0afd0338722 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -784,11 +784,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
 
-	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
-		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
-		return -EFAULT;
-
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f45..f8181e2c2168 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -215,11 +215,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
 
-	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
-		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
-		return -EFAULT;
-
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
-- 
2.11.0

