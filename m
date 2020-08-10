Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2FFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8D822BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073737;
	bh=eFV6/1DVxbuvKgaNF9KshFIO2aypYMCe3MCJB+UeSnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DELz9s4wLqk+kWxgyFXH1Z+YPsrYiU9MJxrul8vUEg7HSHdejo8awezq6iL+tsdMC
	 7EyAHkse+xp5TOBTz/s33/E1RFd2N9J/TBJHROpShmzteAEDxUwTJk4hIww1u/8WXu
	 Y/8PRsRd0KfrlCPV8M748lIbrDbgghOaQ3z9J15E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgHJPff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbgHJP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153DC22CF7;
        Mon, 10 Aug 2020 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073275;
        bh=eFV6/1DVxbuvKgaNF9KshFIO2aypYMCe3MCJB+UeSnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nxuv4+tVlj30SIrW9JNRWUYqwUDfZXN3PAkSGLGudHo7d+DmyFpL5jt2jaGSa2uo0
         BppYIxFSZCA9N18YtaqjmyEKFtMiRWPr420mQoGFUAc2aGqBXcTE7Wqmb1tblf5qDL
         0sO71FW7ulY03DEdmuNNRfFtM5yVNtDDeKAJe/l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 47/67] xattr: break delegations in {set,remove}xattr
Date:   Mon, 10 Aug 2020 17:21:34 +0200
Message-Id: <20200810151811.758822254@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank van der Linden <fllinden@amazon.com>

commit 08b5d5014a27e717826999ad20e394a8811aae92 upstream.

set/removexattr on an exported filesystem should break NFS delegations.
This is true in general, but also for the upcoming support for
RFC 8726 (NFSv4 extended attribute support). Make sure that they do.

Additionally, they need to grow a _locked variant, since callers might
call this with i_rwsem held (like the NFS server code).

Cc: stable@vger.kernel.org # v4.9+
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xattr.c            |   84 +++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/xattr.h |    2 +
 2 files changed, 79 insertions(+), 7 deletions(-)

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -204,10 +204,22 @@ int __vfs_setxattr_noperm(struct dentry
 	return error;
 }
 
-
+/**
+ * __vfs_setxattr_locked: set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - xattr name to set
+ *  @value - value to set @name to
+ *  @size - size of @value
+ *  @flags - flags to pass into filesystem operations
+ *  @delegated_inode - on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+__vfs_setxattr_locked(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -216,15 +228,40 @@ vfs_setxattr(struct dentry *dentry, cons
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_setxattr(dentry, name, value, size, flags);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
+
+int
+vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
+	    &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -378,8 +415,18 @@ __vfs_removexattr(struct dentry *dentry,
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
+/**
+ * __vfs_removexattr_locked: set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - name of xattr to remove
+ *  @delegated_inode - on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr_locked(struct dentry *dentry, const char *name,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -388,11 +435,14 @@ vfs_removexattr(struct dentry *dentry, c
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_removexattr(dentry, name);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_removexattr(dentry, name);
 
 	if (!error) {
@@ -401,12 +451,32 @@ vfs_removexattr(struct dentry *dentry, c
 	}
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
+
+int
+vfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_removexattr);
 
-
 /*
  * Extended attribute SET operations
  */
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, co
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
 int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
+int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_removexattr(struct dentry *, const char *);
+int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
 int vfs_removexattr(struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);


