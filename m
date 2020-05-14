Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4372320727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgENVDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:03:21 -0400
Received: from [66.170.99.2] ([66.170.99.2]:28972 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgENVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:03:11 -0400
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id BA2CABA20C8; Fri, 15 May 2020 02:26:07 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     gregkh@linuxfoundation.org
Cc:     srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, csiddharth@vmware.com,
        siddharth@embedjournal.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: [PATCH v4.9] xfs: More robust inode extent count validation
Date:   Fri, 15 May 2020 02:25:21 +0530
Message-Id: <bead24486cf51a007202b6b56d307a9a71d098da.1589486724.git.csiddharth@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589486724.git.csiddharth@vmware.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
In-Reply-To: <cover.1589486724.git.csiddharth@vmware.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

commit 23fcb3340d033d9f081e21e6c12c2db7eaa541d3 upstream.

When the inode is in extent format, it can't have more extents that
fit in the inode fork. We don't currenty check this, and so this
corruption goes unnoticed by the inode verifiers. This can lead to
crashes operating on invalid in-memory structures.

Attempts to access such a inode will now error out in the verifier
rather than allowing modification operations to proceed.

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
[darrick: fix a typedef, add some braces and breaks to shut up compiler warnings]
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Siddharth Chandrasekaran <csiddharth@vmware.com>
---
 fs/xfs/libxfs/xfs_format.h    |   3 ++
 fs/xfs/libxfs/xfs_inode_buf.c | 112 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 6b7579e..9967d30 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -979,6 +979,9 @@ typedef enum xfs_dinode_fmt {
 		XFS_DFORK_DSIZE(dip, mp) : \
 		XFS_DFORK_ASIZE(dip, mp))
 
+#define XFS_DFORK_MAXEXT(dip, mp, w) \
+	(XFS_DFORK_SIZE(dip, mp, w) / sizeof(struct xfs_bmbt_rec))
+
 /*
  * Return pointers to the data or attribute forks.
  */
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 37ee7f0..ee035a4 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -381,7 +381,48 @@ xfs_log_dinode_to_disk(
 	}
 }
 
-static bool
+static xfs_failaddr_t
+xfs_dinode_verify_fork(
+	struct xfs_dinode	*dip,
+	struct xfs_mount	*mp,
+	int			whichfork)
+{
+	uint32_t		di_nextents = XFS_DFORK_NEXTENTS(dip, whichfork);
+
+	switch (XFS_DFORK_FORMAT(dip, whichfork)) {
+	case XFS_DINODE_FMT_LOCAL:
+		/*
+		 * no local regular files yet
+		 */
+		if (whichfork == XFS_DATA_FORK) {
+			if (S_ISREG(be16_to_cpu(dip->di_mode)))
+				return __this_address;
+			if (be64_to_cpu(dip->di_size) >
+					XFS_DFORK_SIZE(dip, mp, whichfork))
+				return __this_address;
+		}
+		if (di_nextents)
+			return __this_address;
+		break;
+	case XFS_DINODE_FMT_EXTENTS:
+		if (di_nextents > XFS_DFORK_MAXEXT(dip, mp, whichfork))
+			return __this_address;
+		break;
+	case XFS_DINODE_FMT_BTREE:
+		if (whichfork == XFS_ATTR_FORK) {
+			if (di_nextents > MAXAEXTNUM)
+				return __this_address;
+		} else if (di_nextents > MAXEXTNUM) {
+			return __this_address;
+		}
+		break;
+	default:
+		return __this_address;
+	}
+	return NULL;
+}
+
+xfs_failaddr_t
 xfs_dinode_verify(
 	struct xfs_mount	*mp,
 	struct xfs_inode	*ip,
@@ -403,8 +444,73 @@ xfs_dinode_verify(
 		return false;
 
 	/* No zero-length symlinks/dirs. */
-	if ((S_ISLNK(mode) || S_ISDIR(mode)) && dip->di_size == 0)
-		return false;
+	if ((S_ISLNK(mode) || S_ISDIR(mode)) && di_size == 0)
+		return __this_address;
+
+	/* Fork checks carried over from xfs_iformat_fork */
+	if (mode &&
+	    be32_to_cpu(dip->di_nextents) + be16_to_cpu(dip->di_anextents) >
+			be64_to_cpu(dip->di_nblocks))
+		return __this_address;
+
+	if (mode && XFS_DFORK_BOFF(dip) > mp->m_sb.sb_inodesize)
+		return __this_address;
+
+	flags = be16_to_cpu(dip->di_flags);
+
+	if (mode && (flags & XFS_DIFLAG_REALTIME) && !mp->m_rtdev_targp)
+		return __this_address;
+
+	/* Do we have appropriate data fork formats for the mode? */
+	switch (mode & S_IFMT) {
+	case S_IFIFO:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFSOCK:
+		if (dip->di_format != XFS_DINODE_FMT_DEV)
+			return __this_address;
+		break;
+	case S_IFREG:
+	case S_IFLNK:
+	case S_IFDIR:
+		fa = xfs_dinode_verify_fork(dip, mp, XFS_DATA_FORK);
+		if (fa)
+			return fa;
+		break;
+	case 0:
+		/* Uninitialized inode ok. */
+		break;
+	default:
+		return __this_address;
+	}
+
+	if (XFS_DFORK_Q(dip)) {
+		fa = xfs_dinode_verify_fork(dip, mp, XFS_ATTR_FORK);
+		if (fa)
+			return fa;
+	} else {
+		/*
+		 * If there is no fork offset, this may be a freshly-made inode
+		 * in a new disk cluster, in which case di_aformat is zeroed.
+		 * Otherwise, such an inode must be in EXTENTS format; this goes
+		 * for freed inodes as well.
+		 */
+		switch (dip->di_aformat) {
+		case 0:
+		case XFS_DINODE_FMT_EXTENTS:
+			break;
+		default:
+			return __this_address;
+		}
+		if (dip->di_anextents)
+			return __this_address;
+	}
+
+	/* extent size hint validation */
+	fa = xfs_inode_validate_extsize(mp, be32_to_cpu(dip->di_extsize),
+			mode, flags);
+	if (fa)
+		return fa;
 
 	/* only version 3 or greater inodes are extensively verified here */
 	if (dip->di_version < 3)
-- 
2.7.4

