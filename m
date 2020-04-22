Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28963C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E742073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552333;
	bh=YXatwA0IzgcsJ9gEYbMuYDXR5EsegBs5QetUF828Olk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ct59x2iTa7CYDubztOv025aIne7a1QzF3T7bcazNza7NV1Nr5Y0fOoz5xao4F1tYb
	 +1MZ2RQV7TYkGKvKKNuepZGrEU4SPXrO49eyTElroqsAXYv6pTtGf24c8aDX0wnMVW
	 0Dyz0HCkTpxtdrgP48GgXg707KR+QJu0R4oXIVWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbgDVKpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbgDVKSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B282D2076B;
        Wed, 22 Apr 2020 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550680;
        bh=YXatwA0IzgcsJ9gEYbMuYDXR5EsegBs5QetUF828Olk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzrtfaLsliK47K3DPyA0gXiqdgJa2AOOL9dfBnJ841rMNs+dq20fgoH3EJyXTOwGV
         prxtcoqHAmWtCO0zTZzxMRd6QvPskzIva+27I1iPQDJxW6Z7MQD9B6KRSHB+86vtqn
         cmoFh89t7m0ILFfAE5UwFtydL4NxIbXEgT/+XU88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/118] NFS: alloc_nfs_open_context() must use the file cred when available
Date:   Wed, 22 Apr 2020 11:56:51 +0200
Message-Id: <20200422095040.243072668@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
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
index 2a03bfeec10a4..3802c88e83720 100644
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



