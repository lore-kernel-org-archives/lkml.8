Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71043C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F44214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051325;
	bh=7TCSdWKuzTv+3biIWXj1nC1I9NWCKG66xkzKdYXC158=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpWc7urz9xiU6W7TScqSMwfLHNlBuNdKn4yTlbiuYq2iElkukDvOH/z7ysE48tE4C
	 5cfeul93DdvEViZ7yPhTr32GE9iQekK5uDRfg6pkZqaQPw1T138AcJqodk33BQ8Uj0
	 1QlxjratXOc9xzcjTdUfCDrDyGRuiuHXoCEPfGXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442529AbgDPPfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898137AbgDPNkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5851020732;
        Thu, 16 Apr 2020 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044434;
        bh=7TCSdWKuzTv+3biIWXj1nC1I9NWCKG66xkzKdYXC158=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUkXeRLCEvr5b/rIeP4aqcFMV3TGdW68dkaPblQ+J/Ut17aVUo2lrRbQOHfJcd54y
         XnStYaUhJUwAkfD9bZBre40IISFCdss11PxB2bC0nOW/erjzg2qNVyEUNiLruPNdi5
         MjQA5mlZvT8ImRNxhEnE2XODE2rBm60OBrRKj9G0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.5 217/257] NFS: Fix use-after-free issues in nfs_pageio_add_request()
Date:   Thu, 16 Apr 2020 15:24:28 +0200
Message-Id: <20200416131353.126075880@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit dc9dc2febb17f72e9878eb540ad3996f7984239a upstream.

We need to ensure that we create the mirror requests before calling
nfs_pageio_add_request_mirror() on the request we are adding.
Otherwise, we can end up with a use-after-free if the call to
nfs_pageio_add_request_mirror() triggers I/O.

Fixes: c917cfaf9bbe ("NFS: Fix up NFS I/O subrequest creation")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1177,38 +1177,38 @@ int nfs_pageio_add_request(struct nfs_pa
 	if (desc->pg_error < 0)
 		goto out_failed;
 
-	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
-		if (midx) {
-			nfs_page_group_lock(req);
-
-			/* find the last request */
-			for (lastreq = req->wb_head;
-			     lastreq->wb_this_page != req->wb_head;
-			     lastreq = lastreq->wb_this_page)
-				;
-
-			dupreq = nfs_create_subreq(req, lastreq,
-					pgbase, offset, bytes);
-
-			nfs_page_group_unlock(req);
-			if (IS_ERR(dupreq)) {
-				desc->pg_error = PTR_ERR(dupreq);
-				goto out_failed;
-			}
-		} else
-			dupreq = req;
+	/* Create the mirror instances first, and fire them off */
+	for (midx = 1; midx < desc->pg_mirror_count; midx++) {
+		nfs_page_group_lock(req);
+
+		/* find the last request */
+		for (lastreq = req->wb_head;
+		     lastreq->wb_this_page != req->wb_head;
+		     lastreq = lastreq->wb_this_page)
+			;
+
+		dupreq = nfs_create_subreq(req, lastreq,
+				pgbase, offset, bytes);
+
+		nfs_page_group_unlock(req);
+		if (IS_ERR(dupreq)) {
+			desc->pg_error = PTR_ERR(dupreq);
+			goto out_failed;
+		}
 
-		if (nfs_pgio_has_mirroring(desc))
-			desc->pg_mirror_idx = midx;
+		desc->pg_mirror_idx = midx;
 		if (!nfs_pageio_add_request_mirror(desc, dupreq))
 			goto out_cleanup_subreq;
 	}
 
+	desc->pg_mirror_idx = 0;
+	if (!nfs_pageio_add_request_mirror(desc, req))
+		goto out_failed;
+
 	return 1;
 
 out_cleanup_subreq:
-	if (req != dupreq)
-		nfs_pageio_cleanup_request(desc, dupreq);
+	nfs_pageio_cleanup_request(desc, dupreq);
 out_failed:
 	nfs_pageio_error_cleanup(desc);
 	return 0;


