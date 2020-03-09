Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598EC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDEE20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="g8S7dm5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCIUWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:22:53 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.72]:29439 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgCIUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:22:52 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id E4CEBEC12
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 15:22:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOvLj5XlDSl8qBOvLjgmcP; Mon, 09 Mar 2020 15:22:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jMunP9V0d2u36jTKl+ej5qOp8rIOFeGZYKT65z+gTFU=; b=g8S7dm5B0nbkMWqRAFALSxChfs
        RqzmZHbK/ljT7/LfvfOZKT8f166SHIXM/44h2aI2ypZXsCqaT3plrohRWk4KXZSl8y9Titmf5D09W
        fKfF067lg03NkOI3OYfOD0O6bPgRooJGpqbpk+76c6eG1B2L86Nwx8JskhzSKckOKL+xZWGzcmDFy
        wdj5+4Vgcpmbi8J3+6eczzV5iDRyEG9iZxLpjQnsBXY0oA1S9hbidLRcUGmpI77bXysNSG7XNlxBc
        xguXuLrjYTOjL0nZiTfgkZiTyLAL4yLqt2R74UYEx1gbycvN5jgR37b4j5/W2KZEu6WXKZqaMvkXR
        Wd9G8ljw==;
Received: from [201.162.168.201] (port=4007 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOvJ-0010Ml-SA; Mon, 09 Mar 2020 15:22:50 -0500
Date:   Mon, 9 Mar 2020 15:26:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] squashfs: squashfs_fs.h: Replace zero-length array
 with flexible-array member
Message-ID: <20200309202602.GA9219@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOvJ-0010Ml-SA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:4007
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/squashfs/squashfs_fs.h | 16 ++++++++--------
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
-- 
2.25.0

