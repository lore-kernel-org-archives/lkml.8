Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD8B2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgF1CGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:06:25 -0400
Received: from foss.arm.com ([217.140.110.172]:58158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgF1CGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:06:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41DB11B3;
        Sat, 27 Jun 2020 19:06:23 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACCE33F73C;
        Sat, 27 Jun 2020 19:06:20 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 1/2] 9p: retrieve fid from file when file instance exist.
Date:   Sun, 28 Jun 2020 10:06:07 +0800
Message-Id: <20200628020608.36512-2-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628020608.36512-1-jianyong.wu@arm.com>
References: <20200628020608.36512-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setattr implementation in 9p, fid will always retrieved from
dentry no matter file instance exist or not when setattr. There will
be some info related to open file instance dropped. so it's better
to retrieve fid from file instance if file instance is passed to setattr.

for example:
fd=open("tmp", O_RDWR);
ftruncate(fd, 10);

the file context related with fd info will lost as fid will always be
retrieved from dentry, then the backend can't get the info of file context.
it is against the original intention of user and may lead to bug.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c      | 5 ++++-
 fs/9p/vfs_inode_dotl.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c9255d399917..010869389523 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1100,7 +1100,10 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	retval = -EPERM;
 	v9ses = v9fs_dentry2v9ses(dentry);
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE)
+		fid = iattr->ia_file->private_data;
+	else
+		fid = v9fs_fid_lookup(dentry);
 	if(IS_ERR(fid))
 		return PTR_ERR(fid);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..28fb04cbeb1a 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -560,7 +560,10 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 	p9attr.mtime_sec = iattr->ia_mtime.tv_sec;
 	p9attr.mtime_nsec = iattr->ia_mtime.tv_nsec;
 
-	fid = v9fs_fid_lookup(dentry);
+	if (iattr->ia_valid & ATTR_FILE)
+		fid = iattr->ia_file->private_data;
+	else
+		fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
 		return PTR_ERR(fid);
 
-- 
2.17.1

