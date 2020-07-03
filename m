Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D20C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EFF2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCIUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:20:31 -0400
Received: from foss.arm.com ([217.140.110.172]:36058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:20:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEA82F;
        Fri,  3 Jul 2020 01:20:30 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6624A3F73C;
        Fri,  3 Jul 2020 01:20:27 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [PATCH v3] 9p: retrieve fid from file when file instance exist.
Date:   Fri,  3 Jul 2020 16:20:18 +0800
Message-Id: <20200703082018.8160-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setattr implementation in 9p, fid is always retrieved
from dentry no matter file instance exists or not. Thus, there may be
some info related to opened file instance dropped. So it's better
to retrieve fid from file instance when it has passed to setattr.

for example:
fd=open("tmp", O_RDWR);
ftruncate(fd, 10);

The file context related with the fd will be lost as fid is
retrieved from dentry, then the backend can't get the info of
file context. It is against the original intention of user and
may lead to bug.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c      | 7 ++++++-
 fs/9p/vfs_inode_dotl.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c9255d399917..7cd4b67c345b 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1100,7 +1100,12 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	retval = -EPERM;
 	v9ses = v9fs_dentry2v9ses(dentry);
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if(IS_ERR(fid))
 		return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..dc53fb6b3b31 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -560,7 +560,12 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 	p9attr.mtime_sec = iattr->ia_mtime.tv_sec;
 	p9attr.mtime_nsec = iattr->ia_mtime.tv_nsec;
 
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE) {
+		fid = iattr->ia_file->private_data;
+		WARN_ON(!fid);
+	}
+	if (!fid)
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
-- 
2.17.1

