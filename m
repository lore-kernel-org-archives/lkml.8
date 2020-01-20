Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EBC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CC624650
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAbWocw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATVMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:12:06 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:40170 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:12:05 -0500
Received: by mail-pf1-f177.google.com with SMTP id q8so316141pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFF4OgjJ9AHWL6dZ4qs0niBDfSa1JvK17IBZj0zoQVQ=;
        b=gAbWocw8ib11Jv4S6GnlbmEto18n48mwvF0emFv8fi2xsOikX6wiVyqfsF7rHuuEpo
         xV0y+sShFVGLy9cl8ja/4svDyGcaReNJNJVcoa4VEBa8xIZ3OmMJDu0a/9xyqsqYrdU9
         A3aa25tG2+cZtv5TZZ9RfJkopVBJJagAmiJD2yPsZ9B/oFM9Gjw7OIEwA5EdYtzfg8IK
         WJk33lkuvURDO2f3n1b7WCItXJYbObfXNSzH7xIkXMq5wUn3x664B48YGK83Sytga+4H
         Se4M5u6fsCDlU9ewaCERQ8Jw5LOMXWzWaWnMH1t6R2sC/GFjmkVGncffuKKWxor8AgyU
         edoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFF4OgjJ9AHWL6dZ4qs0niBDfSa1JvK17IBZj0zoQVQ=;
        b=H2yvnNxJ35pZMyKwJXGKG7apOsNVExcRHpaCYj6Mfxs+LO88bAcoECr1NG9WAkfwyx
         wKd8ff8Xjx79ZHWNtlrvwThI4SysZOZXybH7mWVVzt/Er8SEqIDiCRLlxO7OUNp9QRz4
         n1zCqmU8owTo1veAiwOExggMkRXvCdXh9WkkpMp5Bhxcg5SofCN+7PiIqhp1rCy9iibD
         JoQBNQD6zFZnDDgsJxCTd4r5vKEIujMhVEnTE5734C1jf4ajNInzCBEu5lxLG36d0mLL
         ZSudl60U1oiBZMZqSFEHII8VnfQTYA7Ln9ydgsjd4KLYwSXVZ5aExuJTBC1VmcIuIgIk
         9WPg==
X-Gm-Message-State: APjAAAXBfEYFiSDFO2xYqSj+UkvpT8EoDKYyoby6iJme68B03Z/XVLW1
        8/RvbK0X6CXeCuGiB0RBepf4l86Z
X-Google-Smtp-Source: APXvYqwCROm10dBDhyIJ7pYRapoCN8dj3BSFZLvubzFQd7W2gITGgQmkukGF5ggNhJv3+Ow8O304Jg==
X-Received: by 2002:a62:e318:: with SMTP id g24mr1055687pfh.218.1579554723756;
        Mon, 20 Jan 2020 13:12:03 -0800 (PST)
Received: from hephaestus.prv.suse.net (179.187.204.124.dynamic.adsl.gvt.net.br. [179.187.204.124])
        by smtp.gmail.com with ESMTPSA id h3sm40904826pfr.15.2020.01.20.13.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:12:02 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, fdmanana@suse.com, nborisov@suse.com,
        wqu@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [kernel PATCH 1/1] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Date:   Mon, 20 Jan 2020 18:14:51 -0300
Message-Id: <20200120211451.29681-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This ioctl will be responsible for deleting a subvolume using it's id.
This can be used when a system has a file system mounted from a
subvolume, rather than the root file system, like below:

/
|- @subvol1
|- @subvol2
\- @subvol_default
If only @subvol_default is mounted, we have no path to reach
@subvol1 and @subvol2, thus no way to delete them.
This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTORY_V2
to delete subvolume using subvolid.

Also in this patch, add BTRFS_SUBVOL_DELETE_BY_ID flag and add subvolid
as a union member of fd in struct btrfs_ioctl_vol_args_v2.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h           |  8 ++++
 fs/btrfs/export.c          |  4 +-
 fs/btrfs/ioctl.c           | 94 +++++++++++++++++++++++++++++++-------
 fs/btrfs/super.c           |  2 +-
 include/uapi/linux/btrfs.h | 12 ++++-
 5 files changed, 98 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 569931dd0ce5..421a2f57f9ec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
+char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					   u64 subvol_objectid);
 
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
@@ -3442,6 +3444,12 @@ int btrfs_reada_wait(void *handle);
 void btrfs_reada_detach(void *handle);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 
+/* export.c */
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+				       u64 root_objectid, u32 generation,
+				       int check_generation);
+struct dentry *btrfs_get_parent(struct dentry *child);
+
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 72e312cae69d..027411cdbae7 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -57,7 +57,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return type;
 }
 
-static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
+struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 				       u64 root_objectid, u32 generation,
 				       int check_generation)
 {
@@ -152,7 +152,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 	return btrfs_get_dentry(sb, objectid, root_objectid, generation, 1);
 }
 
-static struct dentry *btrfs_get_parent(struct dentry *child)
+struct dentry *btrfs_get_parent(struct dentry *child)
 {
 	struct inode *dir = d_inode(child);
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0fa1c386d020..a03ff335a250 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2836,7 +2836,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 }
 
 static noinline int btrfs_ioctl_snap_destroy(struct file *file,
-					     void __user *arg)
+					     void __user *arg,
+					     bool destroy_v2)
 {
 	struct dentry *parent = file->f_path.dentry;
 	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
@@ -2845,34 +2846,85 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *dest = NULL;
-	struct btrfs_ioctl_vol_args *vol_args;
+	struct btrfs_ioctl_vol_args *vol_args = NULL;
+	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
+	char *name, *name_ptr = NULL;
 	int namelen;
 	int err = 0;
 
-	if (!S_ISDIR(dir->i_mode))
-		return -ENOTDIR;
+	if (destroy_v2) {
+		vol_args2 = memdup_user(arg, sizeof(*vol_args2));
+		if (IS_ERR(vol_args2))
+			return PTR_ERR(vol_args2);
 
-	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args))
-		return PTR_ERR(vol_args);
+		if (vol_args2->subvolid == 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-	namelen = strlen(vol_args->name);
-	if (strchr(vol_args->name, '/') ||
-	    strncmp(vol_args->name, "..", namelen) == 0) {
-		err = -EINVAL;
-		goto out;
+		if (!(vol_args2->flags & BTRFS_SUBVOL_DELETE_BY_ID)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		dentry = btrfs_get_dentry(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
+					vol_args2->subvolid, 0, 0);
+		if (IS_ERR(dentry)) {
+			err = PTR_ERR(dentry);
+			goto out;
+		}
+
+		/* change the default parent since the subvolume being deleted
+		 * can be outside of the current mount point
+		 */
+		parent = btrfs_get_parent(dentry);
+
+		/* the only use of dentry was to get the parent, so we can
+		 * release it now. Later on the dentry will be queried again to
+		 * make sure the dentry will reside in the dentry cache
+		 */
+		dput(dentry);
+		if (IS_ERR(parent)) {
+			err = PTR_ERR(parent);
+			goto out;
+		}
+		dir = d_inode(parent);
+
+		name_ptr = get_subvol_name_from_objectid(fs_info, vol_args2->subvolid);
+		if (IS_ERR(name_ptr)) {
+			err = PTR_ERR(name_ptr);
+			goto free_parent;
+		}
+		name = (char *)kbasename(name_ptr);
+		namelen = strlen(name);
+	} else {
+		vol_args = memdup_user(arg, sizeof(*vol_args));
+		if (IS_ERR(vol_args))
+			return PTR_ERR(vol_args);
+
+		vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+		namelen = strlen(vol_args->name);
+		if (strchr(vol_args->name, '/') ||
+		    strncmp(vol_args->name, "..", namelen) == 0) {
+			err = -EINVAL;
+			goto out;
+		}
+		name = vol_args->name;
+	}
+
+	if (!S_ISDIR(dir->i_mode)) {
+		err = -ENOTDIR;
+		goto free_subvol_name;
 	}
 
 	err = mnt_want_write_file(file);
 	if (err)
-		goto out;
-
+		goto free_subvol_name;
 
 	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (err == -EINTR)
 		goto out_drop_write;
-	dentry = lookup_one_len(vol_args->name, parent, namelen);
+	dentry = lookup_one_len(name, parent, namelen);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock_dir;
@@ -2943,7 +2995,13 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_unlock(dir);
 out_drop_write:
 	mnt_drop_write_file(file);
+free_subvol_name:
+	kfree(name_ptr);
+free_parent:
+	if (destroy_v2)
+		dput(parent);
 out:
+	kfree(vol_args2);
 	kfree(vol_args);
 	return err;
 }
@@ -5452,7 +5510,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SUBVOL_CREATE_V2:
 		return btrfs_ioctl_snap_create_v2(file, argp, 1);
 	case BTRFS_IOC_SNAP_DESTROY:
-		return btrfs_ioctl_snap_destroy(file, argp);
+		return btrfs_ioctl_snap_destroy(file, argp, false);
+	case BTRFS_IOC_SNAP_DESTROY_V2:
+		return btrfs_ioctl_snap_destroy(file, argp, true);
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
 		return btrfs_ioctl_subvol_getflags(file, argp);
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a906315efd19..a448d2bb93e6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1024,7 +1024,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 	return error;
 }
 
-static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					   u64 subvol_objectid)
 {
 	struct btrfs_root *root = fs_info->tree_root;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..1be03082e49a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -42,11 +42,14 @@ struct btrfs_ioctl_vol_args {
 
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 
+#define BTRFS_SUBVOL_DELETE_BY_ID	(1ULL << 4)
+
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_CREATE_ASYNC |	\
 			BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
-			BTRFS_DEVICE_SPEC_BY_ID)
+			BTRFS_DEVICE_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_DELETE_BY_ID)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -108,7 +111,10 @@ struct btrfs_ioctl_qgroup_limit_args {
  */
 
 struct btrfs_ioctl_vol_args_v2 {
-	__s64 fd;
+	union {
+		__s64 fd;
+		__u64 subvolid;
+	};
 	__u64 transid;
 	__u64 flags;
 	union {
@@ -949,5 +955,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_vol_args_v2)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.24.0

