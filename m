Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83042C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6355720872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgH1QjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:39:24 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:43128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728226AbgH1QjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9251618026A18;
        Fri, 28 Aug 2020 16:39:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: top58_310a62227077
X-Filterd-Recvd-Size: 3000
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 16:39:16 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ntfs3: Rename NTFS_FLAGS_LOG_REPLAING to NTFS_FLAGS_LOG_REPLAYING
Date:   Fri, 28 Aug 2020 09:39:05 -0700
Message-Id: <4434fdd9d747a0c911d8c0d45eb12e26c16ab7d6.1598632661.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598632661.git.joe@perches.com>
References: <cover.1598632661.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct spelling of REPLAY

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/frecord.c | 2 +-
 fs/ntfs3/fsntfs.c  | 4 ++--
 fs/ntfs3/inode.c   | 2 +-
 fs/ntfs3/ntfs_fs.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 77a9a46d1510..13454de34c21 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2177,7 +2177,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	upd_parent = ni->ni_flags & NI_FLAG_UPDATE_PARENT;
 	rec = ni->mi.mrec;
 
-	if (!is_rec_inuse(rec) || (sbi->flags & NTFS_FLAGS_LOG_REPLAING))
+	if (!is_rec_inuse(rec) || (sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		goto write_subrecords;
 
 	if (!inode->i_nlink)
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 9c489e8be91a..10cc86ee85b8 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -249,7 +249,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 		goto out;
 	}
 
-	sbi->flags |= NTFS_FLAGS_LOG_REPLAING;
+	sbi->flags |= NTFS_FLAGS_LOG_REPLAYING;
 
 	ref.low = cpu_to_le32(MFT_REC_MFT);
 	ref.high = 0;
@@ -309,7 +309,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 	}
 
 out:
-	sbi->flags &= ~NTFS_FLAGS_LOG_REPLAING;
+	sbi->flags &= ~NTFS_FLAGS_LOG_REPLAYING;
 
 	return err;
 }
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3e66ad89d2fd..2f443bd151b0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -75,7 +75,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	rec = ni->mi.mrec;
 
-	if (sbi->flags & NTFS_FLAGS_LOG_REPLAING) {
+	if (sbi->flags & NTFS_FLAGS_LOG_REPLAYING) {
 		;
 	} else if (ref->seq != rec->seq) {
 		err = -EINVAL;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 066c5d0549b1..0239fe7c6527 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -143,7 +143,7 @@ struct ntfs_index {
 };
 
 /* Set when $LogFile is replaying */
-#define NTFS_FLAGS_LOG_REPLAING 0x00000008
+#define NTFS_FLAGS_LOG_REPLAYING 0x00000008
 
 /* Set when we changed first MFT's which copy must be updated in $MftMirr */
 #define NTFS_FLAGS_MFTMIRR 0x00001000
-- 
2.26.0

