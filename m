Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDFBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC66D22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916057;
	bh=cCUOGE8MGkysAC94vp/q2pSVU3xfxlp5tQo6NvQEVZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tZMiKXFdbeOPwzGVFLeJALU4oLIeJmiJSCGq/e3MRaS5mYW8NexiL6RF77THO80i0
	 clMwjtMoPZ+Xbz5ODCYzXHA4lJXt9FFxyi4LbwKCQ9aIgb90GsHOuult4rTum1uBZm
	 t9cnxIHyYMMqhOYlITR8AJ0H9ueXpbJO8ZTMREek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHTJeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgHTJbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6854122B4B;
        Thu, 20 Aug 2020 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915894;
        bh=cCUOGE8MGkysAC94vp/q2pSVU3xfxlp5tQo6NvQEVZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwX/cb+SdmekRmfw8X5tcjVPYn7xQPjwP927EZ47svfMY/YUYGkmCyp1lLbWdUsdq
         QOLm7WhkswVdeEca/Yz4i9OEQGC+fTA3O6X2qcXUonzfmoTu6S+6QBNTdSY9SR9ptT
         oaLFh7zXyeT/gcpxS/BAW7hvpfPfZBx9dc17APDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 173/232] nfs: ensure correct writeback errors are returned on close()
Date:   Thu, 20 Aug 2020 11:20:24 +0200
Message-Id: <20200820091621.199408680@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 67dd23f9e6fbaf163431912ef5599c5e0693476c ]

nfs_wb_all() calls filemap_write_and_wait(), which uses
filemap_check_errors() to determine the error to return.
filemap_check_errors() only looks at the mapping->flags and will
therefore only return either -ENOSPC or -EIO.  To ensure that the
correct error is returned on close(), nfs{,4}_file_flush() should call
filemap_check_wb_err() which looks at the errseq value in
mapping->wb_err without consuming it.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with
generic one")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/file.c     | 5 ++++-
 fs/nfs/nfs4file.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f96367a2463e3..d72496efa17b0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -140,6 +140,7 @@ static int
 nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
+	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -148,7 +149,9 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	since = filemap_sample_wb_err(file->f_mapping);
+	nfs_wb_all(inode);
+	return filemap_check_wb_err(file->f_mapping, since);
 }
 
 ssize_t
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd35..a339707654673 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -110,6 +110,7 @@ static int
 nfs4_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
+	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -125,7 +126,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 		return filemap_fdatawrite(file->f_mapping);
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	since = filemap_sample_wb_err(file->f_mapping);
+	nfs_wb_all(inode);
+	return filemap_check_wb_err(file->f_mapping, since);
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.25.1



