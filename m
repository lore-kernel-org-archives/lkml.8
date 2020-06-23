Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA139C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50962072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944408;
	bh=2Ps/VK5Jxkta2/UYXjHu0YChiGmfbbEkbtfuZChj7bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxfwzzK7656LN6h5IIBvHGNfg/F/uN4H5bQOCyxBs9iw3TUIGXX5jRt5KCiEkbepL
	 KAdwA0EM3GR3KS/o/w3pbyKKfGNhy0dlfu+OrGmCvNiph9ZPVqEK9RSyldhltewkRA
	 CMqw970zjIHaVsnpJCNDoS67UyEjcVRwzIjduvns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgFWUd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391396AbgFWUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433362064B;
        Tue, 23 Jun 2020 20:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944396;
        bh=2Ps/VK5Jxkta2/UYXjHu0YChiGmfbbEkbtfuZChj7bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKM7pUUoJN5GFrGM1ByZjJbUxsVLgiW6N/8ETqYRM0zjfMP7lkE0cobRSfnv0MliS
         97MS2oqBI+UO1Uw8ZhK3aFRKfDCmKBeOHaNa8lUhS9wF+wdUJrE9X3uGfoiGHZce4v
         4lvC7U6yNmp0jP9RN4eYPjGI+EydxlNkjz8O8MFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        syzbot+bca9799bf129256190da@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 288/314] ext4: avoid race conditions when remounting with options that change dax
Date:   Tue, 23 Jun 2020 21:58:03 +0200
Message-Id: <20200623195352.713564142@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 829b37b8cddb1db75c1b7905505b90e593b15db1 ]

Trying to change dax mount options when remounting could allow mount
options to be enabled for a small amount of time, and then the mount
option change would be reverted.

In the case of "mount -o remount,dax", this can cause a race where
files would temporarily treated as DAX --- and then not.

Cc: stable@kernel.org
Reported-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 830160ad07a63..f7c20bb20da37 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2034,6 +2034,16 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 #endif
 	} else if (token == Opt_dax) {
 #ifdef CONFIG_FS_DAX
+		if (is_remount && test_opt(sb, DAX)) {
+			ext4_msg(sb, KERN_ERR, "can't mount with "
+				"both data=journal and dax");
+			return -1;
+		}
+		if (is_remount && !(sbi->s_mount_opt & EXT4_MOUNT_DAX)) {
+			ext4_msg(sb, KERN_ERR, "can't change "
+					"dax mount option while remounting");
+			return -1;
+		}
 		ext4_msg(sb, KERN_WARNING,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 		sbi->s_mount_opt |= m->mount_opt;
@@ -5367,12 +5377,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			err = -EINVAL;
 			goto restore_opts;
 		}
-		if (test_opt(sb, DAX)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "both data=journal and dax");
-			err = -EINVAL;
-			goto restore_opts;
-		}
 	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA) {
 		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
@@ -5388,12 +5392,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX) {
-		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
-			"dax flag with busy inodes while remounting");
-		sbi->s_mount_opt ^= EXT4_MOUNT_DAX;
-	}
-
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 		ext4_abort(sb, "Abort forced by user");
 
-- 
2.25.1



