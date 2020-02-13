Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C8C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E9420675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608553;
	bh=dBjMwYiib9tdGRpo7RTRVgn9LZnKD9lqcHjCVdNjL9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SD0q9/38K/sYfGBWOBr16NzpBhUYlPgKa57tNv6ZNer+nRctaPWQmQaVvAR3PzcZx
	 WCE01V4T89DF1RHYxCQ0bQH6l4sYQfAYYu44U22Cn+6E018+IIibos3aWm3eeUzZie
	 XRXqIqiyt9ZsakBoCXpaOWZohkQsH6Kf7TZjyt5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgBMPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgBMP2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:12 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA1A222C2;
        Thu, 13 Feb 2020 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607691;
        bh=dBjMwYiib9tdGRpo7RTRVgn9LZnKD9lqcHjCVdNjL9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnADpDzebvLstqUVpNEa+gryVahNDh+C1GNkOH7LRST70CiSHSLMRKviUIU4l+2o8
         dET5gXRBVDUE/zkdL3/536+OXAvTY2KHJuMlh4cdlpLyuGjMMbdLTvFkB2Jo1eJ/VE
         JxYi811IorB7QS8wB3CXh+4YP21oav9uQy8JWeDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.5 030/120] NFS/pnfs: Fix pnfs_generic_prepare_to_resend_writes()
Date:   Thu, 13 Feb 2020 07:20:26 -0800
Message-Id: <20200213151912.218866135@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 221203ce6406273cf00e5c6397257d986c003ee6 upstream.

Instead of making assumptions about the commit verifier contents, change
the commit code to ensure we always check that the verifier was set
by the XDR code.

Fixes: f54bcf2ecee9 ("pnfs: Prepare for flexfiles by pulling out common code")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c   |    4 ++--
 fs/nfs/nfs3xdr.c  |    5 ++++-
 fs/nfs/nfs4xdr.c  |    5 ++++-
 fs/nfs/pnfs_nfs.c |    7 +++----
 fs/nfs/write.c    |    4 +++-
 5 files changed, 16 insertions(+), 9 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -245,10 +245,10 @@ static int nfs_direct_cmp_commit_data_ve
 					 data->ds_commit_index);
 
 	/* verifier not set so always fail */
-	if (verfp->committed < 0)
+	if (verfp->committed < 0 || data->res.verf->committed <= NFS_UNSTABLE)
 		return 1;
 
-	return nfs_direct_cmp_verf(verfp, &data->verf);
+	return nfs_direct_cmp_verf(verfp, data->res.verf);
 }
 
 /**
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2334,6 +2334,7 @@ static int nfs3_xdr_dec_commit3res(struc
 				   void *data)
 {
 	struct nfs_commitres *result = data;
+	struct nfs_writeverf *verf = result->verf;
 	enum nfs_stat status;
 	int error;
 
@@ -2346,7 +2347,9 @@ static int nfs3_xdr_dec_commit3res(struc
 	result->op_status = status;
 	if (status != NFS3_OK)
 		goto out_status;
-	error = decode_writeverf3(xdr, &result->verf->verifier);
+	error = decode_writeverf3(xdr, &verf->verifier);
+	if (!error)
+		verf->committed = NFS_FILE_SYNC;
 out:
 	return error;
 out_status:
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4313,11 +4313,14 @@ static int decode_write_verifier(struct
 
 static int decode_commit(struct xdr_stream *xdr, struct nfs_commitres *res)
 {
+	struct nfs_writeverf *verf = res->verf;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_COMMIT);
 	if (!status)
-		status = decode_write_verifier(xdr, &res->verf->verifier);
+		status = decode_write_verifier(xdr, &verf->verifier);
+	if (!status)
+		verf->committed = NFS_FILE_SYNC;
 	return status;
 }
 
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -31,12 +31,11 @@ EXPORT_SYMBOL_GPL(pnfs_generic_rw_releas
 /* Fake up some data that will cause nfs_commit_release to retry the writes. */
 void pnfs_generic_prepare_to_resend_writes(struct nfs_commit_data *data)
 {
-	struct nfs_page *first = nfs_list_entry(data->pages.next);
+	struct nfs_writeverf *verf = data->res.verf;
 
 	data->task.tk_status = 0;
-	memcpy(&data->verf.verifier, &first->wb_verf,
-	       sizeof(data->verf.verifier));
-	data->verf.verifier.data[0]++; /* ensure verifier mismatch */
+	memset(&verf->verifier, 0, sizeof(verf->verifier));
+	verf->committed = NFS_UNSTABLE;
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_prepare_to_resend_writes);
 
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1837,6 +1837,7 @@ static void nfs_commit_done(struct rpc_t
 
 static void nfs_commit_release_pages(struct nfs_commit_data *data)
 {
+	const struct nfs_writeverf *verf = data->res.verf;
 	struct nfs_page	*req;
 	int status = data->task.tk_status;
 	struct nfs_commit_info cinfo;
@@ -1864,7 +1865,8 @@ static void nfs_commit_release_pages(str
 
 		/* Okay, COMMIT succeeded, apparently. Check the verifier
 		 * returned by the server against all stored verfs. */
-		if (!nfs_write_verifier_cmp(&req->wb_verf, &data->verf.verifier)) {
+		if (verf->committed > NFS_UNSTABLE &&
+		    !nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier)) {
 			/* We have a match */
 			if (req->wb_page)
 				nfs_inode_remove_request(req);


