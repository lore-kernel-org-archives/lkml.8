Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF471C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988AF2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261271;
	bh=sUOG9rffSGekvZ1pjLm7i1hfi3HowdlJF8EY5e/9Qjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IY+UKxVCXI9TxB5FNLfsSTsSNvdBBoscPosYFwzLe3BNN9ykDhqgqxK3J4YUkxe2Q
	 8APUzV2fx2sVUxmHFZv+RWJtbmHK+i6R5HfQea7ZGwBpYEeaRNp4pyGpt9zyX74lKi
	 Ib+79x/7Xv1HNS8Of4KdQOJNhvJ8jDNX49Krp4fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgHXIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgHXIwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54152072D;
        Mon, 24 Aug 2020 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259121;
        bh=sUOG9rffSGekvZ1pjLm7i1hfi3HowdlJF8EY5e/9Qjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fr9lcEfMhIonoEosTvjk4df2TKeGkW6NwFfWJmnhyu1vBqvmOfcDRVDIaWQuXA0Ba
         e3C2AprCw4SbnV3cDKE/JV3GMt610mOYVbFMt/TXwSxpvzE+03KS/TP2903OJHHhZp
         +pcJp/kTn1J30T7wWtK3Ql1epPT284raTQuDadH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/39] btrfs: export helpers for subvolume name/id resolution
Date:   Mon, 24 Aug 2020 10:31:08 +0200
Message-Id: <20200824082348.945938078@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[ Upstream commit c0c907a47dccf2cf26251a8fb4a8e7a3bf79ce84 ]

The functions will be used outside of export.c and super.c to allow
resolving subvolume name from a given id, eg. for subvolume deletion by
id ioctl.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ split from the next patch ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h  | 2 ++
 fs/btrfs/export.c | 8 ++++----
 fs/btrfs/export.h | 5 +++++
 fs/btrfs/super.c  | 8 ++++----
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2bc37d03d4075..abfc090510480 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3261,6 +3261,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 int btrfs_parse_options(struct btrfs_root *root, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
+char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					  u64 subvol_objectid);
 
 static inline __printf(2, 3)
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 2513a7f533342..92f80ed642194 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -55,9 +55,9 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return type;
 }
 
-static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
-				       u64 root_objectid, u32 generation,
-				       int check_generation)
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+				u64 root_objectid, u32 generation,
+				int check_generation)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root;
@@ -150,7 +150,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
 }
 
-static struct dentry *btrfs_get_parent(struct dentry *child)
+struct dentry *btrfs_get_parent(struct dentry *child)
 {
 	struct inode *dir = d_inode(child);
 	struct btrfs_root *root = BTRFS_I(dir)->root;
diff --git a/fs/btrfs/export.h b/fs/btrfs/export.h
index 074348a95841f..7a305e5549991 100644
--- a/fs/btrfs/export.h
+++ b/fs/btrfs/export.h
@@ -16,4 +16,9 @@ struct btrfs_fid {
 	u64 parent_root_objectid;
 } __attribute__ ((packed));
 
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+				u64 root_objectid, u32 generation,
+				int check_generation);
+struct dentry *btrfs_get_parent(struct dentry *child);
+
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9286603a6a98b..af5be060c651f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -948,8 +948,8 @@ out:
 	return error;
 }
 
-static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
-					   u64 subvol_objectid)
+char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					  u64 subvol_objectid)
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_root *fs_root;
@@ -1430,8 +1430,8 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 				goto out;
 			}
 		}
-		subvol_name = get_subvol_name_from_objectid(btrfs_sb(mnt->mnt_sb),
-							    subvol_objectid);
+		subvol_name = btrfs_get_subvol_name_from_objectid(
+					btrfs_sb(mnt->mnt_sb), subvol_objectid);
 		if (IS_ERR(subvol_name)) {
 			root = ERR_CAST(subvol_name);
 			subvol_name = NULL;
-- 
2.25.1



