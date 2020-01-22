Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B138C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D790324686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686110;
	bh=KtrrXu75MH7hnqgW0jWNdTGlsUOIMEfHf/hMtBgrmos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRYozJPV63S6wWuMkav3sgDTApyhYhifJ4dP0cMgQoB+JJ5TQNKVI2Br0qE5LW9ub
	 ONMDHXIK0d70M81mqLahJr6dC9XCelYygcAn+GiyR/FiLFEGkJS/En0ZsRG8epM8Sj
	 +m5wIJR1AGWN4od4k7MclndWObfWeV276rJj9rV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAVJlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbgAVJli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B555B2468B;
        Wed, 22 Jan 2020 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686097;
        bh=KtrrXu75MH7hnqgW0jWNdTGlsUOIMEfHf/hMtBgrmos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVLZ1cB8VutDOqPJKJuQ+8VURxOZsIg8i+gWOj4rbs8UzNhgb2n+Br3GZ4Rw8ftQK
         RhRd1uQWEMDvFtioxINt3XDOhZu1TMC5GkfhjXw9VjZ14KDISWfzPYgOZgDiTW1fie
         hSVCPqXlIVCDP9e+RWsHaK11qGmcA58e+fYnfACY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/103] btrfs: rework arguments of btrfs_unlink_subvol
Date:   Wed, 22 Jan 2020 10:28:58 +0100
Message-Id: <20200122092810.213590198@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 045d3967b6920b663fc010ad414ade1b24143bd1 ]

btrfs_unlink_subvol takes the name of the dentry and the root objectid
based on what kind of inode this is, either a real subvolume link or a
empty one that we inherited as a snapshot.  We need to fix how we unlink
in the case for BTRFS_EMPTY_SUBVOL_DIR_OBJECTID in the future, so rework
btrfs_unlink_subvol to just take the dentry and handle getting the right
objectid given the type of inode this is.  There is no functional change
here, simply pushing the work into btrfs_unlink_subvol() proper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c |   46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4120,18 +4120,30 @@ out:
 }
 
 static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
-			       struct inode *dir, u64 objectid,
-			       const char *name, int name_len)
+			       struct inode *dir, struct dentry *dentry)
 {
 	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
+	const char *name = dentry->d_name.name;
+	int name_len = dentry->d_name.len;
 	u64 index;
 	int ret;
+	u64 objectid;
 	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
 
+	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
+		objectid = inode->root->root_key.objectid;
+	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
+		objectid = inode->location.objectid;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4373,8 +4385,7 @@ int btrfs_delete_subvolume(struct inode
 
 	btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
 
-	ret = btrfs_unlink_subvol(trans, dir, dest->root_key.objectid,
-				  dentry->d_name.name, dentry->d_name.len);
+	ret = btrfs_unlink_subvol(trans, dir, dentry);
 	if (ret) {
 		err = ret;
 		btrfs_abort_transaction(trans, ret);
@@ -4469,10 +4480,7 @@ static int btrfs_rmdir(struct inode *dir
 		return PTR_ERR(trans);
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		err = btrfs_unlink_subvol(trans, dir,
-					  BTRFS_I(inode)->location.objectid,
-					  dentry->d_name.name,
-					  dentry->d_name.len);
+		err = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
 	}
 
@@ -9471,7 +9479,6 @@ static int btrfs_rename_exchange(struct
 	u64 new_ino = btrfs_ino(BTRFS_I(new_inode));
 	u64 old_idx = 0;
 	u64 new_idx = 0;
-	u64 root_objectid;
 	int ret;
 	bool root_log_pinned = false;
 	bool dest_log_pinned = false;
@@ -9577,10 +9584,7 @@ static int btrfs_rename_exchange(struct
 
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		root_objectid = BTRFS_I(old_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, old_dir, root_objectid,
-					  old_dentry->d_name.name,
-					  old_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
@@ -9596,10 +9600,7 @@ static int btrfs_rename_exchange(struct
 
 	/* dest is a subvolume */
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		root_objectid = BTRFS_I(new_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, new_dir, root_objectid,
-					  new_dentry->d_name.name,
-					  new_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
@@ -9797,7 +9798,6 @@ static int btrfs_rename(struct inode *ol
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *old_inode = d_inode(old_dentry);
 	u64 index = 0;
-	u64 root_objectid;
 	int ret;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	bool log_pinned = false;
@@ -9905,10 +9905,7 @@ static int btrfs_rename(struct inode *ol
 				BTRFS_I(old_inode), 1);
 
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
-		root_objectid = BTRFS_I(old_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, old_dir, root_objectid,
-					old_dentry->d_name.name,
-					old_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else {
 		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
@@ -9927,10 +9924,7 @@ static int btrfs_rename(struct inode *ol
 		new_inode->i_ctime = current_time(new_inode);
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-			root_objectid = BTRFS_I(new_inode)->location.objectid;
-			ret = btrfs_unlink_subvol(trans, new_dir, root_objectid,
-						new_dentry->d_name.name,
-						new_dentry->d_name.len);
+			ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
 			ret = btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),


