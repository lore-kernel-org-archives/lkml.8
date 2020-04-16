Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FBDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC02D2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048912;
	bh=vAtU5Xx99QfFj3XxBnnRT4MOmEgZ5p5mlNaETRiv7Lg=;
	h=Date:From:To:Subject:List-ID:From;
	b=XCilDY9NrwO90eQj3+EYr6kQmI5F75h7N7BKNcKDdEecLP181qWmlAcwuf7VWaxSf
	 y/k4F+E+0DBpJrjhk+6ZL2N6OlDji3oAJxbI/VJhu5lFGAS9My3+u2bDgqQRL0ZfLv
	 3ASplJGziRzRVykyUWYWK5VhstXQbQgqHhbN4DzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405120AbgDPOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408393AbgDPOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:54:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526A5206A2;
        Thu, 16 Apr 2020 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587048891;
        bh=vAtU5Xx99QfFj3XxBnnRT4MOmEgZ5p5mlNaETRiv7Lg=;
        h=Date:From:To:Subject:From;
        b=OFO9EfiT7kIcb3KhYvOZ1HgyGMRStA1+iVDnobHikOYr1ArMZWAOj4lOFcd8Q7CV9
         wULy62pmoEiouml3XE4+l/XyQVCPgvPXdtTwLdqn4b1pGTCzEW/58nPjypcmsX5TlG
         M7v28Mv1R5M6LaLXngHhOj/ActcLXwQoBawxlCms=
Date:   Thu, 16 Apr 2020 16:54:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: remove return value of debugfs_create_u32()
Message-ID: <20200416145448.GA1380878@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_u32(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.rst |  4 ++--
 fs/debugfs/file.c                     | 15 +++------------
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index db9ea0854040..6c032db235a5 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -79,8 +79,8 @@ created with any of::
 			   struct dentry *parent, u8 *value);
     void debugfs_create_u16(const char *name, umode_t mode,
 			    struct dentry *parent, u16 *value);
-    struct dentry *debugfs_create_u32(const char *name, umode_t mode,
-				      struct dentry *parent, u32 *value);
+    void debugfs_create_u32(const char *name, umode_t mode,
+			    struct dentry *parent, u32 *value);
     void debugfs_create_u64(const char *name, umode_t mode,
 			    struct dentry *parent, u64 *value);
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 2d357680094c..ae49a55bda00 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -506,20 +506,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
- * be returned.
  */
-struct dentry *debugfs_create_u32(const char *name, umode_t mode,
-				 struct dentry *parent, u32 *value)
+void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
+			u32 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u32,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u32,
 				   &fops_u32_ro, &fops_u32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u32);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index a274d95fa66e..63cb3606dea7 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -103,8 +103,8 @@ void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
 void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
 			u16 *value);
-struct dentry *debugfs_create_u32(const char *name, umode_t mode,
-				  struct dentry *parent, u32 *value);
+void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
+			u32 *value);
 void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
@@ -250,12 +250,8 @@ static inline void debugfs_create_u8(const char *name, umode_t mode,
 static inline void debugfs_create_u16(const char *name, umode_t mode,
 				      struct dentry *parent, u16 *value) { }
 
-static inline struct dentry *debugfs_create_u32(const char *name, umode_t mode,
-						struct dentry *parent,
-						u32 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_u32(const char *name, umode_t mode,
+				      struct dentry *parent, u32 *value) { }
 
 static inline void debugfs_create_u64(const char *name, umode_t mode,
 				      struct dentry *parent, u64 *value) { }
-- 
2.26.1

