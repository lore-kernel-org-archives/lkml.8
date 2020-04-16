Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA636C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982FC20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048211;
	bh=7TCSdWKuzTv+3biIWXj1nC1I9NWCKG66xkzKdYXC158=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhN6xfgCvMLaqInvBNq/bCmvi4uz80tM+EiGgS2/occetfes12s/NvC9to2WAobh+
	 KoqQWp5wA+/6Kn/cYfp+gpyBK/F9it+At8YIia50L5opRNj9mRi4vU+gHCI0QMnz21
	 e9w1zFz3kU6WGN4BfZJHHozJzEptuHXf+8drD1PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394529AbgDPOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392629AbgDPOAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E91520732;
        Thu, 16 Apr 2020 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045632;
        bh=7TCSdWKuzTv+3biIWXj1nC1I9NWCKG66xkzKdYXC158=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/yNgIiP9l4NWGnWbYG5CPZOJVrs9HRqM8A54iPB1xotp2qNot79y5Oz/LyK2NGx6
         gwbMuJNN+yEpoHpVbfk/+Pk3ERtzfbfFHwM9Mb2yRVpvZ1q3IKqXw/0gKobeDrClzj
         t72x6MtlmcOrYSJkeNzbfQhn+Cisf5frV2R9zpVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.6 213/254] NFS: Fix use-after-free issues in nfs_pageio_add_request()
Date:   Thu, 16 Apr 2020 15:25:02 +0200
Message-Id: <20200416131352.681418494@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
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


