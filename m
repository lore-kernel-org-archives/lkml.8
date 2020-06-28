Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7471720899
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgF1Hnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:43:49 -0400
Received: from foss.arm.com ([217.140.110.172]:59688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgF1Hns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:43:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E6F9D6E;
        Sun, 28 Jun 2020 00:43:48 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FC1D3F6CF;
        Sun, 28 Jun 2020 00:43:44 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [PATCH] 9p: remove unused code in 9p
Date:   Sun, 28 Jun 2020 15:43:37 +0800
Message-Id: <20200628074337.45895-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codes have been commented out since 2007 and lay in kernel
since then. So, it's better to remove them.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/9p/vfs_inode.c | 53 -----------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 010869389523..23aed9047efe 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -368,59 +368,6 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 	return inode;
 }
 
-/*
-static struct v9fs_fid*
-v9fs_clone_walk(struct v9fs_session_info *v9ses, u32 fid, struct dentry *dentry)
-{
-	int err;
-	int nfid;
-	struct v9fs_fid *ret;
-	struct v9fs_fcall *fcall;
-
-	nfid = v9fs_get_idpool(&v9ses->fidpool);
-	if (nfid < 0) {
-		eprintk(KERN_WARNING, "no free fids available\n");
-		return ERR_PTR(-ENOSPC);
-	}
-
-	err = v9fs_t_walk(v9ses, fid, nfid, (char *) dentry->d_name.name,
-		&fcall);
-
-	if (err < 0) {
-		if (fcall && fcall->id == RWALK)
-			goto clunk_fid;
-
-		PRINT_FCALL_ERROR("walk error", fcall);
-		v9fs_put_idpool(nfid, &v9ses->fidpool);
-		goto error;
-	}
-
-	kfree(fcall);
-	fcall = NULL;
-	ret = v9fs_fid_create(v9ses, nfid);
-	if (!ret) {
-		err = -ENOMEM;
-		goto clunk_fid;
-	}
-
-	err = v9fs_fid_insert(ret, dentry);
-	if (err < 0) {
-		v9fs_fid_destroy(ret);
-		goto clunk_fid;
-	}
-
-	return ret;
-
-clunk_fid:
-	v9fs_t_clunk(v9ses, nfid);
-
-error:
-	kfree(fcall);
-	return ERR_PTR(err);
-}
-*/
-
-
 /**
  * v9fs_clear_inode - release an inode
  * @inode: inode to release
-- 
2.17.1

