Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF85C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B71208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916094;
	bh=NnN6YacW0a2xO0gvCRIxh7ybG+jk2VHafX/DGDFWdoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLDZ9mMavX3JbD4m9qMMoqJeFBQ3ZRryE8gTFbUTxX8YwjII6DQyahSzc/IKM3ZI0
	 QuEtIcAaX5y/Ya8a8n7cJMw74QuHDWLZPvURMhNB9J9IblMqQtlB4Eo/bED39u6mBx
	 jr3Ls9tGg/0sG8JaXerY3fE9ThryFb4Me7PgxqP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgHTJew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgHTJcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:32:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C964922B3F;
        Thu, 20 Aug 2020 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915930;
        bh=NnN6YacW0a2xO0gvCRIxh7ybG+jk2VHafX/DGDFWdoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcdJzW9ebzxprXNRxrTtWOJ64BhD/hIsFM+hj0J9yY0SAHiZ9FNcaOch2sMuHCGQ+
         5BSmOqB4wnAn3pXVGXXjViGuxo68sIXCDM3vg7upX1EGPkQYbDDCTAYx0MKYEMaLnm
         9ehuKyVRlZqF6NoGwqI1WRVFmiap7xiX0MXARZ2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 184/232] nfs: nfs_file_write() should check for writeback errors
Date:   Thu, 20 Aug 2020 11:20:35 +0200
Message-Id: <20200820091621.714245075@linuxfoundation.org>
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

[ Upstream commit ce368536dd614452407dc31e2449eb84681a06af ]

The NFS_CONTEXT_ERROR_WRITE flag (as well as the check of said flag) was
removed by commit 6fbda89b257f.  The absence of an error check allows
writes to be continually queued up for a server that may no longer be
able to handle them.  Fix it by adding an error check using the generic
error reporting functions.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d72496efa17b0..63940a7a70be1 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -590,12 +590,14 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
 	.page_mkwrite = nfs_vm_page_mkwrite,
 };
 
-static int nfs_need_check_write(struct file *filp, struct inode *inode)
+static int nfs_need_check_write(struct file *filp, struct inode *inode,
+				int error)
 {
 	struct nfs_open_context *ctx;
 
 	ctx = nfs_file_open_context(filp);
-	if (nfs_ctx_key_to_expire(ctx, inode))
+	if (nfs_error_is_fatal_on_server(error) ||
+	    nfs_ctx_key_to_expire(ctx, inode))
 		return 1;
 	return 0;
 }
@@ -606,6 +608,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	unsigned long written = 0;
 	ssize_t result;
+	errseq_t since;
+	int error;
 
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
@@ -630,6 +634,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos > i_size_read(inode))
 		nfs_revalidate_mapping(inode, file->f_mapping);
 
+	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
@@ -648,7 +653,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	/* Return error values */
-	if (nfs_need_check_write(file, inode)) {
+	error = filemap_check_wb_err(file->f_mapping, since);
+	if (nfs_need_check_write(file, inode, error)) {
 		int err = nfs_wb_all(inode);
 		if (err < 0)
 			result = err;
-- 
2.25.1



