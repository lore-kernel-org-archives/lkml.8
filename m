Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C174FC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7EA20857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961774;
	bh=uqXe98ljwrxbZSCPd4V2gEIfqMpRkxKGc273CiblwSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JJJ619ZHFi62uTcDa3aP07Ux6BV5OxaW0eCarF13LKvwCRYDD/75/56ZUSSHTr5X4
	 RFWBDTHTYPCZh0eJguV+zYI0+AVunPiupq+ISMafF82znxb3SNndZ0Ewhm+H+j8is8
	 uem5NlsneFLOpRoSWYXkUfIKt0+HG1iAbCN7LB1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636751AbgDOOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394044AbgDOOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:58 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EA121744;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=uqXe98ljwrxbZSCPd4V2gEIfqMpRkxKGc273CiblwSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqGFTXuDq0FYrtajFT4T8XSs4/5VREON8Vdnrpt4mOGlisOCLpaLN52EqbDI56xIA
         4jRpXyi8POcxGjC9txIp7V2wdKWOQW0vBPpGAxlVkipj+F1oyMSQqw2wWSULSBgzOT
         gHi/Lvjw7Cp7dNc8AS+++9KEBrhh8O6Lap+F1onM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kOt-Gr; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 15/34] docs: filesystems: convert fiemap.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:28 +0200
Message-Id: <efd1f1ff140d14042116900f9245ba3af015175b.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{fiemap.txt => fiemap.rst}    | 133 +++++++++---------
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 69 insertions(+), 65 deletions(-)
 rename Documentation/filesystems/{fiemap.txt => fiemap.rst} (70%)

diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.rst
similarity index 70%
rename from Documentation/filesystems/fiemap.txt
rename to Documentation/filesystems/fiemap.rst
index ac87e6fda842..2a572e7edc08 100644
--- a/Documentation/filesystems/fiemap.txt
+++ b/Documentation/filesystems/fiemap.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ============
 Fiemap Ioctl
 ============
@@ -10,9 +12,9 @@ returns a list of extents.
 Request Basics
 --------------
 
-A fiemap request is encoded within struct fiemap:
+A fiemap request is encoded within struct fiemap::
 
-struct fiemap {
+  struct fiemap {
 	__u64	fm_start;	 /* logical offset (inclusive) at
 				  * which to start mapping (in) */
 	__u64	fm_length;	 /* logical length of mapping which
@@ -23,7 +25,7 @@ struct fiemap {
 	__u32	fm_extent_count; /* size of fm_extents array (in) */
 	__u32	fm_reserved;
 	struct fiemap_extent fm_extents[0]; /* array of mapped extents (out) */
-};
+  };
 
 
 fm_start, and fm_length specify the logical range within the file
@@ -51,12 +53,12 @@ nothing to prevent the file from changing between calls to FIEMAP.
 
 The following flags can be set in fm_flags:
 
-* FIEMAP_FLAG_SYNC
-If this flag is set, the kernel will sync the file before mapping extents.
+FIEMAP_FLAG_SYNC
+  If this flag is set, the kernel will sync the file before mapping extents.
 
-* FIEMAP_FLAG_XATTR
-If this flag is set, the extents returned will describe the inodes
-extended attribute lookup tree, instead of its data tree.
+FIEMAP_FLAG_XATTR
+  If this flag is set, the extents returned will describe the inodes
+  extended attribute lookup tree, instead of its data tree.
 
 
 Extent Mapping
@@ -75,18 +77,18 @@ complete the requested range and will not have the FIEMAP_EXTENT_LAST
 flag set (see the next section on extent flags).
 
 Each extent is described by a single fiemap_extent structure as
-returned in fm_extents.
+returned in fm_extents::
 
-struct fiemap_extent {
-	__u64	fe_logical;  /* logical offset in bytes for the start of
-			      * the extent */
-	__u64	fe_physical; /* physical offset in bytes for the start
-			      * of the extent */
-	__u64	fe_length;   /* length in bytes for the extent */
-	__u64	fe_reserved64[2];
-	__u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
-	__u32	fe_reserved[3];
-};
+    struct fiemap_extent {
+	    __u64	fe_logical;  /* logical offset in bytes for the start of
+				* the extent */
+	    __u64	fe_physical; /* physical offset in bytes for the start
+				* of the extent */
+	    __u64	fe_length;   /* length in bytes for the extent */
+	    __u64	fe_reserved64[2];
+	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
+	    __u32	fe_reserved[3];
+    };
 
 All offsets and lengths are in bytes and mirror those on disk.  It is valid
 for an extents logical offset to start before the request or its logical
@@ -114,26 +116,27 @@ worry about all present and future flags which might imply unaligned
 data. Note that the opposite is not true - it would be valid for
 FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
 
-* FIEMAP_EXTENT_LAST
-This is generally the last extent in the file. A mapping attempt past
-this extent may return nothing. Some implementations set this flag to
-indicate this extent is the last one in the range queried by the user
-(via fiemap->fm_length).
+FIEMAP_EXTENT_LAST
+  This is generally the last extent in the file. A mapping attempt past
+  this extent may return nothing. Some implementations set this flag to
+  indicate this extent is the last one in the range queried by the user
+  (via fiemap->fm_length).
 
-* FIEMAP_EXTENT_UNKNOWN
-The location of this extent is currently unknown. This may indicate
-the data is stored on an inaccessible volume or that no storage has
-been allocated for the file yet.
+FIEMAP_EXTENT_UNKNOWN
+  The location of this extent is currently unknown. This may indicate
+  the data is stored on an inaccessible volume or that no storage has
+  been allocated for the file yet.
 
-* FIEMAP_EXTENT_DELALLOC
-  - This will also set FIEMAP_EXTENT_UNKNOWN.
-Delayed allocation - while there is data for this extent, its
-physical location has not been allocated yet.
+FIEMAP_EXTENT_DELALLOC
+  This will also set FIEMAP_EXTENT_UNKNOWN.
 
-* FIEMAP_EXTENT_ENCODED
-This extent does not consist of plain filesystem blocks but is
-encoded (e.g. encrypted or compressed).  Reading the data in this
-extent via I/O to the block device will have undefined results.
+  Delayed allocation - while there is data for this extent, its
+  physical location has not been allocated yet.
+
+FIEMAP_EXTENT_ENCODED
+  This extent does not consist of plain filesystem blocks but is
+  encoded (e.g. encrypted or compressed).  Reading the data in this
+  extent via I/O to the block device will have undefined results.
 
 Note that it is *always* undefined to try to update the data
 in-place by writing to the indicated location without the
@@ -145,32 +148,32 @@ unmounted, and then only if the FIEMAP_EXTENT_ENCODED flag is
 clear; user applications must not try reading or writing to the
 filesystem via the block device under any other circumstances.
 
-* FIEMAP_EXTENT_DATA_ENCRYPTED
-  - This will also set FIEMAP_EXTENT_ENCODED
-The data in this extent has been encrypted by the file system.
+FIEMAP_EXTENT_DATA_ENCRYPTED
+  This will also set FIEMAP_EXTENT_ENCODED
+  The data in this extent has been encrypted by the file system.
 
-* FIEMAP_EXTENT_NOT_ALIGNED
-Extent offsets and length are not guaranteed to be block aligned.
+FIEMAP_EXTENT_NOT_ALIGNED
+  Extent offsets and length are not guaranteed to be block aligned.
 
-* FIEMAP_EXTENT_DATA_INLINE
+FIEMAP_EXTENT_DATA_INLINE
   This will also set FIEMAP_EXTENT_NOT_ALIGNED
-Data is located within a meta data block.
+  Data is located within a meta data block.
 
-* FIEMAP_EXTENT_DATA_TAIL
+FIEMAP_EXTENT_DATA_TAIL
   This will also set FIEMAP_EXTENT_NOT_ALIGNED
-Data is packed into a block with data from other files.
+  Data is packed into a block with data from other files.
 
-* FIEMAP_EXTENT_UNWRITTEN
-Unwritten extent - the extent is allocated but its data has not been
-initialized.  This indicates the extent's data will be all zero if read
-through the filesystem but the contents are undefined if read directly from
-the device.
+FIEMAP_EXTENT_UNWRITTEN
+  Unwritten extent - the extent is allocated but its data has not been
+  initialized.  This indicates the extent's data will be all zero if read
+  through the filesystem but the contents are undefined if read directly from
+  the device.
 
-* FIEMAP_EXTENT_MERGED
-This will be set when a file does not support extents, i.e., it uses a block
-based addressing scheme.  Since returning an extent for each block back to
-userspace would be highly inefficient, the kernel will try to merge most
-adjacent blocks into 'extents'.
+FIEMAP_EXTENT_MERGED
+  This will be set when a file does not support extents, i.e., it uses a block
+  based addressing scheme.  Since returning an extent for each block back to
+  userspace would be highly inefficient, the kernel will try to merge most
+  adjacent blocks into 'extents'.
 
 
 VFS -> File System Implementation
@@ -179,23 +182,23 @@ VFS -> File System Implementation
 File systems wishing to support fiemap must implement a ->fiemap callback on
 their inode_operations structure. The fs ->fiemap call is responsible for
 defining its set of supported fiemap flags, and calling a helper function on
-each discovered extent:
+each discovered extent::
 
-struct inode_operations {
+  struct inode_operations {
        ...
 
        int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
                      u64 len);
 
 ->fiemap is passed struct fiemap_extent_info which describes the
-fiemap request:
+fiemap request::
 
-struct fiemap_extent_info {
+  struct fiemap_extent_info {
 	unsigned int fi_flags;		/* Flags as passed from user */
 	unsigned int fi_extents_mapped;	/* Number of mapped extents */
 	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
 	struct fiemap_extent *fi_extents_start;	/* Start of fiemap_extent array */
-};
+  };
 
 It is intended that the file system should not need to access any of this
 structure directly. Filesystem handlers should be tolerant to signals and return
@@ -203,9 +206,9 @@ EINTR once fatal signal received.
 
 
 Flag checking should be done at the beginning of the ->fiemap callback via the
-fiemap_check_flags() helper:
+fiemap_check_flags() helper::
 
-int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
+  int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
 
 The struct fieinfo should be passed in as received from ioctl_fiemap(). The
 set of fiemap flags which the fs understands should be passed via fs_flags. If
@@ -216,10 +219,10 @@ ioctl_fiemap().
 
 
 For each extent in the request range, the file system should call
-the helper function, fiemap_fill_next_extent():
+the helper function, fiemap_fill_next_extent()::
 
-int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			    u64 phys, u64 len, u32 flags, u32 dev);
+  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
+			      u64 phys, u64 len, u32 flags, u32 dev);
 
 fiemap_fill_next_extent() will use the passed values to populate the
 next free extent in the fm_extents array. 'General' extent flags will
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 960e0cc29491..5514fd122619 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -27,6 +27,7 @@ algorithms work.
    dax
    devpts
    dnotify
+   fiemap
 
    automount-support
 
-- 
2.25.2

