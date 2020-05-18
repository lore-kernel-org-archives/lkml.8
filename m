Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDEDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632BF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826236;
	bh=X5VBS3TNvKUYBPPMPcwvJy24E0JjcB+EjIgcktLfkgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RR4WqYNvZkDIVgAv878ouBfe6reJAY1k3AQyW2QVvlW5icgbIa/iO7+xeONaiRnJO
	 k4xis2Dz7J1FtWX6vBYxGJVzE+zccnRsEfqoj9T9NPY9oMleHw5pXW0t/wsk0f2FtS
	 8ZgJitjslHdS4BIvYBlsmudFXoWBC9lSk86jZejY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgERRsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbgERRsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDF620674;
        Mon, 18 May 2020 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824112;
        bh=X5VBS3TNvKUYBPPMPcwvJy24E0JjcB+EjIgcktLfkgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs502BWXdyFb17+s2moBRej5gynSPv9ChDDop3sqVXN10VXtfQVi4ZbfEaXVKK11y
         64cFDLWxuZSP4eGSWP969B6Xb/d2KihfM0vxaz1anyvlTusRjikVDs4wKT/Dk6EUyu
         UXT43m5ywiOhJokEzXW4V9qnjupgkh2682+LNpvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 043/114] f2fs: introduce read_inline_xattr
Date:   Mon, 18 May 2020 19:36:15 +0200
Message-Id: <20200518173511.191263897@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

commit a5f433f7410530ae6bb907ebc049547d9dce665b upstream.

Commit ba38c27eb93e ("f2fs: enhance lookup xattr") introduces
lookup_all_xattrs duplicating from read_all_xattrs, which leaves
lots of similar codes in between them, so introduce new help
read_inline_xattr to clean up redundant codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/xattr.c |   59 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -241,6 +241,29 @@ static struct f2fs_xattr_entry *__find_i
 	return entry;
 }
 
+static int read_inline_xattr(struct inode *inode, struct page *ipage,
+							void *txattr_addr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int inline_size = inline_xattr_size(inode);
+	struct page *page = NULL;
+	void *inline_addr;
+
+	if (ipage) {
+		inline_addr = inline_xattr_addr(ipage);
+	} else {
+		page = get_node_page(sbi, inode->i_ino);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		inline_addr = inline_xattr_addr(page);
+	}
+	memcpy(txattr_addr, inline_addr, inline_size);
+	f2fs_put_page(page, 1);
+
+	return 0;
+}
+
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
@@ -263,21 +286,9 @@ static int lookup_all_xattrs(struct inod
 
 	/* read from inline xattr */
 	if (inline_size) {
-		struct page *page = NULL;
-		void *inline_addr;
-
-		if (ipage) {
-			inline_addr = inline_xattr_addr(ipage);
-		} else {
-			page = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(page)) {
-				err = PTR_ERR(page);
-				goto out;
-			}
-			inline_addr = inline_xattr_addr(page);
-		}
-		memcpy(txattr_addr, inline_addr, inline_size);
-		f2fs_put_page(page, 1);
+		err = read_inline_xattr(inode, ipage, txattr_addr);
+		if (err)
+			goto out;
 
 		*xe = __find_inline_xattr(txattr_addr, &last_addr,
 						index, len, name);
@@ -339,21 +350,9 @@ static int read_all_xattrs(struct inode
 
 	/* read from inline xattr */
 	if (inline_size) {
-		struct page *page = NULL;
-		void *inline_addr;
-
-		if (ipage) {
-			inline_addr = inline_xattr_addr(ipage);
-		} else {
-			page = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(page)) {
-				err = PTR_ERR(page);
-				goto fail;
-			}
-			inline_addr = inline_xattr_addr(page);
-		}
-		memcpy(txattr_addr, inline_addr, inline_size);
-		f2fs_put_page(page, 1);
+		err = read_inline_xattr(inode, ipage, txattr_addr);
+		if (err)
+			goto fail;
 	}
 
 	/* read from xattr node block */


