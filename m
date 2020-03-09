Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C34BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6CC208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583771809;
	bh=gXQ/aRf3BZDqLJ033WDSJtoYaIabgkXf2alXZNm+QJQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ElnkkVHXNrr02jsP3PXOFPaEWdiGkaJpjDt3NsXgQ2cv9oZAblWp4J6bS8dTIDwsV
	 b42zC448BkCUGHHYnHOrVZNwR4e/TeddF8Jwr5Mfh/2dQw9QxXvMkFhjGs096oVtFC
	 +IA4De6bRhLGff3lpSrJvvit6Uxe3een/jBI6Mfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCIQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgCIQgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:36:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC98208C3;
        Mon,  9 Mar 2020 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583771807;
        bh=gXQ/aRf3BZDqLJ033WDSJtoYaIabgkXf2alXZNm+QJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Y168vkus4gwNbR7h7YnTZmpSc7a2tIMeywI/MS42aZlLLgL70tVvR/ogIh785uRoQ
         5g31Z89XnC/dOFjKFuA/VL7j0bg+37LVgp7vE8PNSROcs0N4yBD2XU94k7MIR+E7bn
         QKFxXOXnVhvS++EMrhvhKUx3rm7ge8qjq3UjOavc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] debugfs: remove return value of debugfs_create_file_size()
Date:   Mon,  9 Mar 2020 17:36:40 +0100
Message-Id: <20200309163640.237984-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_file_size, as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  8 ++++----
 fs/debugfs/inode.c                    | 18 ++++--------------
 include/linux/debugfs.h               | 20 +++++++++-----------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 8e235384e5ff..9c9c484e70d7 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -55,10 +55,10 @@ missing.
 Create a file with an initial size, the following function can be used
 instead:
 
-    struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
-				struct dentry *parent, void *data,
-				const struct file_operations *fops,
-				loff_t file_size);
+    void debugfs_create_file_size(const char *name, umode_t mode,
+				  struct dentry *parent, void *data,
+				  const struct file_operations *fops,
+				  loff_t file_size);
 
 file_size is the initial file size. The other parameters are the same
 as the function debugfs_create_file.
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e742dfc66933..b7f2e971ecbc 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -501,26 +501,16 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * wide range of flexibility in creating a file, or a directory (if you want
  * to create a directory, the debugfs_create_dir() function is
  * recommended to be used instead.)
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.
  */
-struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
-					const struct file_operations *fops,
-					loff_t file_size)
+void debugfs_create_file_size(const char *name, umode_t mode,
+			      struct dentry *parent, void *data,
+			      const struct file_operations *fops,
+			      loff_t file_size)
 {
 	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
 
 	if (de)
 		d_inode(de)->i_size = file_size;
-	return de;
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_size);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c9f5262098a1..2ffe674d80cb 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -67,10 +67,10 @@ struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
 
-struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
-					const struct file_operations *fops,
-					loff_t file_size);
+void debugfs_create_file_size(const char *name, umode_t mode,
+			      struct dentry *parent, void *data,
+			      const struct file_operations *fops,
+			      loff_t file_size);
 
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 
@@ -181,13 +181,11 @@ static inline struct dentry *debugfs_create_file_unsafe(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
-					const struct file_operations *fops,
-					loff_t file_size)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_file_size(const char *name, umode_t mode,
+					    struct dentry *parent, void *data,
+					    const struct file_operations *fops,
+					    loff_t file_size)
+{ }
 
 static inline struct dentry *debugfs_create_dir(const char *name,
 						struct dentry *parent)
-- 
2.25.1

