Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34BCC5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB31207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5H5rY0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBTALI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:11:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgBTALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582157467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F3SsN6p+uNC4ethAO9147Q7uUF+qPSk/DZbzWS2Tjtw=;
        b=h5H5rY0IJNqLM3hkd2ubof4ayc4CRYUNCbLfs2TOLrVoyXazkf47JlKnH9KcX8QumtZXY6
        7J+e9bIcVOE20ngeTzRWRzddzwUBKA/0QwqjtTEgmcQ+2Z+/1MJew4lmxsV4xGy9YPweqo
        HY0bMSzkwpAgKF6i8JFXFcdg3SXWQH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-r0mgnpazMIGOgXNGS-i7Fw-1; Wed, 19 Feb 2020 19:11:01 -0500
X-MC-Unique: r0mgnpazMIGOgXNGS-i7Fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F671922981;
        Thu, 20 Feb 2020 00:10:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 455BB8AC5B;
        Thu, 20 Feb 2020 00:10:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH] afs: Create a mountpoint through symlink() and remove
 through rmdir()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 00:10:57 +0000
Message-ID: <158215745745.386537.12978619503606431141.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If symlink() is given a magic prefix in the target string, turn it into a
mountpoint instead.

The prefix is "//_afs3_mount:".  POSIX says that a double slash at the
beginning of a filename is special:

    A pathname consisting of a single slash shall resolve to the root
    directory of the process.  A null pathname shall not be successfully
    resolved.  A pathname that begins with two successive slashes may be
    interpreted in an implementation-defined manner, although more than two
    leading slashes shall be treated as a single slash.

however, that might be validly interpreted by Windows as a UNC name.  So
the prefix is made a bit more than that to make that less likely.  The
prefix is then stripped off and a "." is added for transmission to the
server.

afs_mntpt_lookup() is removed so that the new dentry is marked as being an
autodir type.  afs_rmdir() then checks for this and switches over to
afs_unlink() to remove a mountpoint (as far as the server is concerned,
it's not a directory).  The unlink() system call can't be used to remove
the mountpoint without alteration to the core VFS as may_delete() throws an
error.  This allows rmdir() to remove an automount point (provided it's not
mounted over).

Note that this behaviour varies from other AFS implementations in that the
proposed symlink *could* be valid content (though it seems unlikely) and in
those implementations rmdir can't remove a mountpoint.  Since the Linux
symlink() system can handle a target string of 4095 characters, but AFS can
only handle a symlink of 1024 chars, it might be better to make the magic
prefix large enough to force the target string length over the server
limit.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c       |   38 +++++++++++++++++++++++++++++++++++---
 fs/afs/fsclient.c  |    9 +++++----
 fs/afs/internal.h  |    6 ++++--
 fs/afs/mntpt.c     |   15 ---------------
 fs/afs/yfsclient.c |    7 ++++---
 5 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5c794f4b051a..40552036cd6a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1365,6 +1365,9 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 	_enter("{%llx:%llu},{%pd}",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry);
 
+	if (d_is_autodir(dentry))
+		return afs_unlink(dir, dentry);
+
 	scb = kzalloc(sizeof(struct afs_status_cb), GFP_KERNEL);
 	if (!scb)
 		return -ENOMEM;
@@ -1721,17 +1724,21 @@ static int afs_link(struct dentry *from, struct inode *dir,
 	return ret;
 }
 
+static const char afs_mount_prefix[] = "//_afs3_mount:";
+
 /*
- * create a symlink in an AFS filesystem
+ * create a symlink or a mountpoint in an AFS filesystem
  */
 static int afs_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *content)
+		       const char *specified_content)
 {
 	struct afs_iget_data iget_data;
 	struct afs_fs_cursor fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct key *key;
+	char *content = (char *)specified_content;
+	bool is_mountpoint = false;
 	int ret;
 
 	_enter("{%llx:%llu},{%pd},%s",
@@ -1746,6 +1753,28 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 	if (strlen(content) >= AFSPATHMAX)
 		goto error;
 
+	if (memcmp(content, afs_mount_prefix,
+		   sizeof(afs_mount_prefix) - 1) == 0) {
+		/* This is going to be a mountpoint. */
+		char *p = content + sizeof(afs_mount_prefix) - 1, *c;
+		size_t clen = strlen(p);
+
+		if (clen < 2 ||
+		    (p[0] != '%' && p[0] != '#'))
+			goto error;
+
+		/* Snip off the prefix and append a dot */
+		ret = -ENOMEM;
+		c = kmalloc(clen + 2, GFP_KERNEL);
+		if (!c)
+			goto error;
+		memcpy(c, p, clen);
+		c[clen] = '.';
+		c[clen + 1] = 0;
+		content = c;
+		is_mountpoint = true;
+	}
+
 	ret = -ENOMEM;
 	scb = kcalloc(2, sizeof(struct afs_status_cb), GFP_KERNEL);
 	if (!scb)
@@ -1765,7 +1794,8 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
 			afs_prep_for_new_inode(&fc, &iget_data);
 			afs_fs_symlink(&fc, dentry->d_name.name, content,
-				       &scb[0], &iget_data.fid, &scb[1]);
+				       &scb[0], &iget_data.fid, &scb[1],
+				       is_mountpoint);
 		}
 
 		afs_check_for_remote_deletion(&fc, dvnode);
@@ -1794,6 +1824,8 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 error_scb:
 	kfree(scb);
 error:
+	if (content != specified_content)
+		kfree(content);
 	d_drop(dentry);
 	_leave(" = %d", ret);
 	return ret;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1f9c5d8e6fe5..e2a2abe3a9aa 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -896,14 +896,15 @@ static const struct afs_call_type afs_RXFSSymlink = {
 };
 
 /*
- * create a symbolic link
+ * Create a symbolic link or a mountpoint (differentiated by mode).
  */
 int afs_fs_symlink(struct afs_fs_cursor *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
 		   struct afs_fid *newfid,
-		   struct afs_status_cb *new_scb)
+		   struct afs_status_cb *new_scb,
+		   bool is_mountpoint)
 {
 	struct afs_vnode *dvnode = fc->vnode;
 	struct afs_call *call;
@@ -913,7 +914,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 
 	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
 		return yfs_fs_symlink(fc, name, contents, dvnode_scb,
-				      newfid, new_scb);
+				      newfid, new_scb, is_mountpoint);
 
 	_enter("");
 
@@ -959,7 +960,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 	*bp++ = htonl(dvnode->vfs_inode.i_mtime.tv_sec); /* mtime */
 	*bp++ = 0; /* owner */
 	*bp++ = 0; /* group */
-	*bp++ = htonl(S_IRWXUGO); /* unix mode */
+	*bp++ = htonl(is_mountpoint ? 0644 : S_IRWXUGO); /* unix mode */
 	*bp++ = 0; /* segment size */
 
 	afs_use_fs_server(call, fc->cbi);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1d81fc4c3058..70509f2ddd00 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -965,7 +965,8 @@ extern int afs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char
 extern int afs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
 extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
-			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
+			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *,
+			  bool);
 extern int afs_fs_rename(struct afs_fs_cursor *, const char *,
 			 struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
@@ -1370,7 +1371,8 @@ extern int yfs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char
 extern int yfs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
 extern int yfs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
-			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
+			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *,
+			  bool);
 extern int yfs_fs_rename(struct afs_fs_cursor *, const char *, struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
 extern int yfs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 79bc5f1338ed..b06ceed9b8f5 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -17,9 +17,6 @@
 #include "internal.h"
 
 
-static struct dentry *afs_mntpt_lookup(struct inode *dir,
-				       struct dentry *dentry,
-				       unsigned int flags);
 static int afs_mntpt_open(struct inode *inode, struct file *file);
 static void afs_mntpt_expiry_timed_out(struct work_struct *work);
 
@@ -29,7 +26,6 @@ const struct file_operations afs_mntpt_file_operations = {
 };
 
 const struct inode_operations afs_mntpt_inode_operations = {
-	.lookup		= afs_mntpt_lookup,
 	.readlink	= page_readlink,
 	.getattr	= afs_getattr,
 	.listxattr	= afs_listxattr,
@@ -46,17 +42,6 @@ static unsigned long afs_mntpt_expiry_timeout = 10 * 60;
 
 static const char afs_root_volume[] = "root.cell";
 
-/*
- * no valid lookup procedure on this sort of dir
- */
-static struct dentry *afs_mntpt_lookup(struct inode *dir,
-				       struct dentry *dentry,
-				       unsigned int flags)
-{
-	_enter("%p,%p{%pd2}", dir, dentry, dentry);
-	return ERR_PTR(-EREMOTE);
-}
-
 /*
  * no valid open procedure on this sort of dir
  */
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index a26126ac7bf1..5ff95d5643f5 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1080,14 +1080,15 @@ static const struct afs_call_type yfs_RXYFSSymlink = {
 };
 
 /*
- * Create a symbolic link.
+ * Create a symbolic link or a mountpoint (differentiated by mode).
  */
 int yfs_fs_symlink(struct afs_fs_cursor *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
 		   struct afs_fid *newfid,
-		   struct afs_status_cb *vnode_scb)
+		   struct afs_status_cb *vnode_scb,
+		   bool is_mountpoint)
 {
 	struct afs_vnode *dvnode = fc->vnode;
 	struct afs_call *call;
@@ -1125,7 +1126,7 @@ int yfs_fs_symlink(struct afs_fs_cursor *fc,
 	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
 	bp = xdr_encode_string(bp, name, namesz);
 	bp = xdr_encode_string(bp, contents, contents_sz);
-	bp = xdr_encode_YFSStoreStatus_mode(bp, S_IRWXUGO);
+	bp = xdr_encode_YFSStoreStatus_mode(bp, is_mountpoint ? 0644 : S_IRWXUGO);
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);


