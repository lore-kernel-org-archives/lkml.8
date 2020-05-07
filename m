Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F122C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1AC208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879175;
	bh=pczH5X9hYaUj/TTXPQCiXcI3lnF49aDvEKo2rF2Bp8w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=F7rnkz6uU2f0Z2cvz4eg65fMxCszOKdKKuk6CejFkbrh9YMnuMJXlSOmkOWijGjXQ
	 UdZEXkT+fp3f4pZE3JHD4ZUBYY5zCPt1Wh5vew2/JeQh8BK40iu6rbYuWvhfQ7Ru8i
	 TddMLJIPrdED/zPnQ6yBa6zEAZ9Xy/HLqstKzV+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgEGTTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:19:34 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4A3208D6;
        Thu,  7 May 2020 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879173;
        bh=pczH5X9hYaUj/TTXPQCiXcI3lnF49aDvEKo2rF2Bp8w=;
        h=Date:From:To:Cc:Subject:From;
        b=k3mdqsLR5vUpLosWBY6qEvRB8OufNEEXlANpQ34GCGfE6VQlEmbyzweoctwr0x3dd
         UyjpfPMCEmfgjfO8B9sA5QvhWAfz7UcuUUAsun1i2yiyH4vh1MJZnSLd+2JzPbEoNX
         ttSVVxIatbKPn9dCuRBibZaJfGoOCwmzE8FyWAm0=
Date:   Thu, 7 May 2020 14:24:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Squashfs: Replace zero-length array with flexible-array
Message-ID: <20200507192400.GA16423@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/squashfs/squashfs_fs.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 7187bd1a30ea..8d64edb80ebf 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -262,7 +262,7 @@ struct squashfs_dir_index {
 	__le32			index;
 	__le32			start_block;
 	__le32			size;
-	unsigned char		name[0];
+	unsigned char		name[];
 };
 
 struct squashfs_base_inode {
@@ -327,7 +327,7 @@ struct squashfs_symlink_inode {
 	__le32			inode_number;
 	__le32			nlink;
 	__le32			symlink_size;
-	char			symlink[0];
+	char			symlink[];
 };
 
 struct squashfs_reg_inode {
@@ -341,7 +341,7 @@ struct squashfs_reg_inode {
 	__le32			fragment;
 	__le32			offset;
 	__le32			file_size;
-	__le16			block_list[0];
+	__le16			block_list[];
 };
 
 struct squashfs_lreg_inode {
@@ -358,7 +358,7 @@ struct squashfs_lreg_inode {
 	__le32			fragment;
 	__le32			offset;
 	__le32			xattr;
-	__le16			block_list[0];
+	__le16			block_list[];
 };
 
 struct squashfs_dir_inode {
@@ -389,7 +389,7 @@ struct squashfs_ldir_inode {
 	__le16			i_count;
 	__le16			offset;
 	__le32			xattr;
-	struct squashfs_dir_index	index[0];
+	struct squashfs_dir_index	index[];
 };
 
 union squashfs_inode {
@@ -410,7 +410,7 @@ struct squashfs_dir_entry {
 	__le16			inode_number;
 	__le16			type;
 	__le16			size;
-	char			name[0];
+	char			name[];
 };
 
 struct squashfs_dir_header {
@@ -428,12 +428,12 @@ struct squashfs_fragment_entry {
 struct squashfs_xattr_entry {
 	__le16			type;
 	__le16			size;
-	char			data[0];
+	char			data[];
 };
 
 struct squashfs_xattr_val {
 	__le32			vsize;
-	char			value[0];
+	char			value[];
 };
 
 struct squashfs_xattr_id {

