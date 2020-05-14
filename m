Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C6D207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgENVDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:03:14 -0400
Received: from [66.170.99.2] ([66.170.99.2]:1733 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgENVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:03:11 -0400
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id 4F66DBA20CA; Fri, 15 May 2020 02:26:09 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     gregkh@linuxfoundation.org
Cc:     srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, csiddharth@vmware.com,
        siddharth@embedjournal.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: [PATCH v4.4] xfs: validate cached inodes are free when allocated
Date:   Fri, 15 May 2020 02:25:22 +0530
Message-Id: <76dad64209a2a477a757d6b235b461d78dadea43.1589486853.git.csiddharth@vmware.com>
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

commit afca6c5b2595fc44383919fba740c194b0b76aff upstream.

A recent fuzzed filesystem image cached random dcache corruption
when the reproducer was run. This often showed up as panics in
lookup_slow() on a null inode->i_ops pointer when doing pathwalks.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
....
Call Trace:
 lookup_slow+0x44/0x60
 walk_component+0x3dd/0x9f0
 link_path_walk+0x4a7/0x830
 path_lookupat+0xc1/0x470
 filename_lookup+0x129/0x270
 user_path_at_empty+0x36/0x40
 path_listxattr+0x98/0x110
 SyS_listxattr+0x13/0x20
 do_syscall_64+0xf5/0x280
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

but had many different failure modes including deadlocks trying to
lock the inode that was just allocated or KASAN reports of
use-after-free violations.

The cause of the problem was a corrupt INOBT on a v4 fs where the
root inode was marked as free in the inobt record. Hence when we
allocated an inode, it chose the root inode to allocate, found it in
the cache and re-initialised it.

We recently fixed a similar inode allocation issue caused by inobt
record corruption problem in xfs_iget_cache_miss() in commit
ee457001ed6c ("xfs: catch inode allocation state mismatch
corruption"). This change adds similar checks to the cache-hit path
to catch it, and turns the reproducer into a corruption shutdown
situation.

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-Off-By: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
[darrick: fix typos in comment]
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Siddharth Chandrasekaran <csiddharth@vmware.com>
---
 fs/xfs/xfs_icache.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index adbc1f5..7efeefb 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -135,6 +135,46 @@ xfs_inode_free(
 }
 
 /*
+ * If we are allocating a new inode, then check what was returned is
+ * actually a free, empty inode. If we are not allocating an inode,
+ * then check we didn't find a free inode.
+ *
+ * Returns:
+ *	0		if the inode free state matches the lookup context
+ *	-ENOENT		if the inode is free and we are not allocating
+ *	-EFSCORRUPTED	if there is any state mismatch at all
+ */
+static int
+xfs_iget_check_free_state(
+	struct xfs_inode	*ip,
+	int			flags)
+{
+	if (flags & XFS_IGET_CREATE) {
+		/* should be a free inode */
+		if (VFS_I(ip)->i_mode != 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx not marked free! (mode 0x%x)",
+				ip->i_ino, VFS_I(ip)->i_mode);
+			return -EFSCORRUPTED;
+		}
+
+		if (ip->i_d.di_nblocks != 0) {
+			xfs_warn(ip->i_mount,
+"Corruption detected! Free inode 0x%llx has blocks allocated!",
+				ip->i_ino);
+			return -EFSCORRUPTED;
+		}
+		return 0;
+	}
+
+	/* should be an allocated inode */
+	if (VFS_I(ip)->i_mode == 0)
+		return -ENOENT;
+
+	return 0;
+}
+
+/*
  * Check the validity of the inode we just found it the cache
  */
 static int
@@ -183,12 +223,12 @@ xfs_iget_cache_hit(
 	}
 
 	/*
-	 * If lookup is racing with unlink return an error immediately.
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
 	 */
-	if (ip->i_d.di_mode == 0 && !(flags & XFS_IGET_CREATE)) {
-		error = -ENOENT;
+	error = xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_error;
-	}
 
 	/*
 	 * If IRECLAIMABLE is set, we've torn down the VFS inode already.
@@ -298,10 +338,13 @@ xfs_iget_cache_miss(
 
 	trace_xfs_iget_miss(ip);
 
-	if ((ip->i_d.di_mode == 0) && !(flags & XFS_IGET_CREATE)) {
-		error = -ENOENT;
+	/*
+	 * Check the inode free state is valid. This also detects lookup
+	 * racing with unlinks.
+	 */
+	error = xfs_iget_check_free_state(ip, flags);
+	if (error)
 		goto out_destroy;
-	}
 
 	/*
 	 * Preload the radix tree so we can insert safely under the
-- 
2.7.4

