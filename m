Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C95C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E115D2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551144;
	bh=FtXTfofnjxnh+C0trmA6BpW36cW+yD3+qYSHdl9Ug4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQysMnPL4Ljy/8WeTfkZiNig8e7TYKHAgTlQ/q5Mzp9XO5rXTp/5gf0l2iiN/yRb+
	 XEX+ngXBPX1kmYrBZ5kyMKLlCUoMhoo52D596m/6Mv7DgulpB4yagW71HMd9ZTuU+4
	 NBIKPX5fEMI2g/EKjgV2CjA6KrluroNCJ75S+E14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgDVKZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbgDVKZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:25:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DD32071E;
        Wed, 22 Apr 2020 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551133;
        bh=FtXTfofnjxnh+C0trmA6BpW36cW+yD3+qYSHdl9Ug4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixCcJE/7r7EpnszEtK+L1H2QUQrBWFifeltDNeeeEMukXmUWi4QwT0cCQVQ/+i7co
         FfBQIPH6hBnBY9pLZMdE7W2WmUJBvEWUVyyVqx1S+1Zhu+fpJHKKS9MEDmHYRwEwAE
         H3mGuSX5rSqZ2aDDkUujBpWT5mUMhmuJR/2Rrbgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 071/166] NFS: alloc_nfs_open_context() must use the file cred when available
Date:   Wed, 22 Apr 2020 11:56:38 +0200
Message-Id: <20200422095056.505011559@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 1d179d6bd67369a52edea8562154b31ee20be1cc ]

If we're creating a nfs_open_context() for a specific file pointer,
we must use the cred assigned to that file.

Fixes: a52458b48af1 ("NFS/NFSD/SUNRPC: replace generic creds with 'struct cred'.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 11bf15800ac99..a10fb87c6ac33 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -959,16 +959,16 @@ struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
 						struct file *filp)
 {
 	struct nfs_open_context *ctx;
-	const struct cred *cred = get_current_cred();
 
 	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx) {
-		put_cred(cred);
+	if (!ctx)
 		return ERR_PTR(-ENOMEM);
-	}
 	nfs_sb_active(dentry->d_sb);
 	ctx->dentry = dget(dentry);
-	ctx->cred = cred;
+	if (filp)
+		ctx->cred = get_cred(filp->f_cred);
+	else
+		ctx->cred = get_current_cred();
 	ctx->ll_cred = NULL;
 	ctx->state = NULL;
 	ctx->mode = f_mode;
-- 
2.20.1



