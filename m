Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BBA2250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGTBqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:46:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:46:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADAE143B;
        Sun, 19 Jul 2020 18:46:41 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6307A3F66E;
        Sun, 19 Jul 2020 18:46:38 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 2/2] 9p: retrieve fid from file if it exists when getattr.
Date:   Mon, 20 Jul 2020 09:46:22 +0800
Message-Id: <20200720014622.37364-3-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720014622.37364-1-jianyong.wu@arm.com>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fid should be retrieved from file when it is not NULL in getattr.
it denotes that getattr is called by fdstat from userspace when
file is exist, which means we should get info from file context
not dentry to avoid the failure when the dentry has gone.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c      | 9 +++++++--
 fs/9p/vfs_inode_dotl.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c9255d399917..f562f5710eae 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1054,7 +1054,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 {
 	struct dentry *dentry = path->dentry;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid = NULL;
 	struct p9_wstat *st;
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
@@ -1063,7 +1063,12 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
-	fid = v9fs_fid_lookup(dentry);
+	if (stat->filp) {
+		fid = stat->filp->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..6b7cbe74b0bb 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -460,7 +460,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 {
 	struct dentry *dentry = path->dentry;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid = NULL;
 	struct p9_stat_dotl *st;
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
@@ -469,7 +469,12 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
-	fid = v9fs_fid_lookup(dentry);
+	if (stat->filp) {
+		fid = stat->filp->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
-- 
2.17.1

