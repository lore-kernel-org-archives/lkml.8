Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA92465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685443;
	bh=9AZ9BxagyitRM0YNDbVWEI38GtxSwOXgWFLshHNpqmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VR5ZxAvrFMBpKjPV1yssB6/hP/2Az2bQF44AT9KXD3LUAnGU99qS7xRn6CLGaoJIs
	 M/305B7BublEDLgkHecpjDUn3HAt4+dYhBPtOKwwSrmEYoTQ261Dg79DXewDD2WXL3
	 PrKvWhxMKXecbn+84w9/Oes06oubvAGE+eYOQrGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgAVJam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbgAVJaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:30:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CAB24672;
        Wed, 22 Jan 2020 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685438;
        bh=9AZ9BxagyitRM0YNDbVWEI38GtxSwOXgWFLshHNpqmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=If1yd+xeNjhkY/HbpHFyex/01rg9OkIjezsuZ0MOaHqDPzF/x26FcU8YFENPAeR0N
         +89ecimS+nXQRtfeSMnjCXbWW/kNMMFYb/f8FFji2YDKXXmBhXH5Ot9B2N+KYTKnkF
         RzClOEUVt3vKAcjvhYnFb/JNUDjZYuW+FdX7SRcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Barret Rhoden <brho@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 15/76] ext4: fix use-after-free race with debug_want_extra_isize
Date:   Wed, 22 Jan 2020 10:28:31 +0100
Message-Id: <20200122092753.100629343@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barret Rhoden <brho@google.com>

commit 7bc04c5c2cc467c5b40f2b03ba08da174a0d5fa7 upstream.

When remounting with debug_want_extra_isize, we were not performing the
same checks that we do during a normal mount.  That allowed us to set a
value for s_want_extra_isize that reached outside the s_inode_size.

Fixes: e2b911c53584 ("ext4: clean up feature test macros with predicate functions")
Reported-by: syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Barret Rhoden <brho@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 4.4: The debug_want_extra_isize mount option is not
 supported]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |   56 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3169,6 +3169,36 @@ int ext4_calculate_overhead(struct super
 	return 0;
 }
 
+static void ext4_clamp_want_extra_isize(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+
+	/* determine the minimum size of new large inodes, if present */
+	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
+		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
+						     EXT4_GOOD_OLD_INODE_SIZE;
+		if (ext4_has_feature_extra_isize(sb)) {
+			if (sbi->s_want_extra_isize <
+			    le16_to_cpu(es->s_want_extra_isize))
+				sbi->s_want_extra_isize =
+					le16_to_cpu(es->s_want_extra_isize);
+			if (sbi->s_want_extra_isize <
+			    le16_to_cpu(es->s_min_extra_isize))
+				sbi->s_want_extra_isize =
+					le16_to_cpu(es->s_min_extra_isize);
+		}
+	}
+	/* Check if enough inode space is available */
+	if (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
+							sbi->s_inode_size) {
+		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
+						       EXT4_GOOD_OLD_INODE_SIZE;
+		ext4_msg(sb, KERN_INFO,
+			 "required extra inode space not available");
+	}
+}
+
 static void ext4_set_resv_clusters(struct super_block *sb)
 {
 	ext4_fsblk_t resv_clusters;
@@ -3991,29 +4021,7 @@ no_journal:
 	if (ext4_setup_super(sb, es, sb->s_flags & MS_RDONLY))
 		sb->s_flags |= MS_RDONLY;
 
-	/* determine the minimum size of new large inodes, if present */
-	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						     EXT4_GOOD_OLD_INODE_SIZE;
-		if (ext4_has_feature_extra_isize(sb)) {
-			if (sbi->s_want_extra_isize <
-			    le16_to_cpu(es->s_want_extra_isize))
-				sbi->s_want_extra_isize =
-					le16_to_cpu(es->s_want_extra_isize);
-			if (sbi->s_want_extra_isize <
-			    le16_to_cpu(es->s_min_extra_isize))
-				sbi->s_want_extra_isize =
-					le16_to_cpu(es->s_min_extra_isize);
-		}
-	}
-	/* Check if enough inode space is available */
-	if (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
-							sbi->s_inode_size) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						       EXT4_GOOD_OLD_INODE_SIZE;
-		ext4_msg(sb, KERN_INFO, "required extra inode space not"
-			 "available");
-	}
+	ext4_clamp_want_extra_isize(sb);
 
 	ext4_set_resv_clusters(sb);
 
@@ -4766,6 +4774,8 @@ static int ext4_remount(struct super_blo
 		goto restore_opts;
 	}
 
+	ext4_clamp_want_extra_isize(sb);
+
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
 		ext4_msg(sb, KERN_ERR, "changing journal_checksum "


