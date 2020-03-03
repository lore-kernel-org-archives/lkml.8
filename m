Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C441C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999720CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257662;
	bh=wW3mnCktbCYmM3gZdL9hrOX6Kz4wm/IgY/aenYoR6z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoWBcoP8MN0xC1kUx11hzjXiehdtP97XA3LtD19BUnHIc0s3edbgvXmPqbFVEvTRE
	 1tLq5+1owDFef+Q9ZQapR/WlVuN5vu76l5kmtlRia5OflNBcWiIgzxYZ0xKaoPO1sD
	 op9WS7P5U3/qoTp2ENJwQVN4CrM5HmVpLcRwPFGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgCCRrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbgCCRrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:47:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32CD20CC7;
        Tue,  3 Mar 2020 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257659;
        bh=wW3mnCktbCYmM3gZdL9hrOX6Kz4wm/IgY/aenYoR6z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5M8iExaBgHYAqvgfCsTyVW+6dbWDcq5AUSa5w4n0oLLiq4Sk/H40tq01FjRVu2H0
         MhKXraxYNt+3NT0a1v1zA6hCW/lyHEH8ow/853s5JKy/gRB4sENzs4wca+4oarolf/
         Ucm21g52r8+yYILO4aqDsq5z2R5XgRfT2sU1crZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 037/176] NFSv4: Fix races between open and dentry revalidation
Date:   Tue,  3 Mar 2020 18:41:41 +0100
Message-Id: <20200303174308.801200679@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit cf5b4059ba7197d6cef9c0e024979d178ed8c8ec ]

We want to make sure that we revalidate the dentry if and only if
we've done an OPEN by filename.
In order to avoid races with remote changes to the directory on the
server, we want to save the verifier before calling OPEN. The exception
is if the server returned a delegation with our OPEN, as we then
know that the filename can't have changed on the server.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@gmail.com>
Tested-by: Benjamin Coddington <bcodding@gmail.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4file.c |  1 -
 fs/nfs/nfs4proc.c | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 620de905cba97..3f892035c1413 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -86,7 +86,6 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (inode != d_inode(dentry))
 		goto out_drop;
 
-	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 	nfs_file_set_open_context(filp, ctx);
 	nfs_fscache_open_file(inode, filp);
 	err = 0;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6ddb4f517d373..13c2de527718a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2962,10 +2962,13 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	struct dentry *dentry;
 	struct nfs4_state *state;
 	fmode_t acc_mode = _nfs4_ctx_to_accessmode(ctx);
+	struct inode *dir = d_inode(opendata->dir);
+	unsigned long dir_verifier;
 	unsigned int seq;
 	int ret;
 
 	seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
+	dir_verifier = nfs_save_change_attribute(dir);
 
 	ret = _nfs4_proc_open(opendata, ctx);
 	if (ret != 0)
@@ -2993,8 +2996,19 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 			dput(ctx->dentry);
 			ctx->dentry = dentry = alias;
 		}
-		nfs_set_verifier(dentry,
-				nfs_save_change_attribute(d_inode(opendata->dir)));
+	}
+
+	switch(opendata->o_arg.claim) {
+	default:
+		break;
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
+	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
+		if (!opendata->rpc_done)
+			break;
+		if (opendata->o_res.delegation_type != 0)
+			dir_verifier = nfs_save_change_attribute(dir);
+		nfs_set_verifier(dentry, dir_verifier);
 	}
 
 	/* Parse layoutget results before we check for access */
-- 
2.20.1



