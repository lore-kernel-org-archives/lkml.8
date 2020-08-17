Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99437C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDA320657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682598;
	bh=VxGE96xVX8mqRT56wQqLgk6r5LrYyc4XB8oho4I7MnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEGvuGyWZx7OO3cCuTMfGfLGtRdvAqLJK94zv41l41lIKOjAakvkzZ/DezkI1WVmL
	 awoXh4XwPI2/B3f0SYAsxNk6x2Cq1TFSf3lQoVAMgc4T3pImage5GzjlkmPR9BcrbM
	 CpX8w3Qda5Me66GM8kJRWSGSRA/3iXmy1zrysj6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbgHQQnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730950AbgHQP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B57D206FA;
        Mon, 17 Aug 2020 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679949;
        bh=VxGE96xVX8mqRT56wQqLgk6r5LrYyc4XB8oho4I7MnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfP0FwTD0yGxVyDnAPqGRkNwObxSesZlCsAlPMzdraqFzUYvI4HEB2MgKxmDFDJtS
         EUSwMKDszRUm74RZTkHGigy1r8jh4R9DRFJkhULvS7YTUKzh2R6ysUtLVuUjOchLhl
         mbYWn57DFAD1jDYf48ObtUVmG7AcGL8IW5AM9+EY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.7 359/393] NFS: Dont return layout segments that are in use
Date:   Mon, 17 Aug 2020 17:16:49 +0200
Message-Id: <20200817143837.016330666@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit d474f96104bd4377573526ebae2ee212205a6839 upstream.

If the NFS_LAYOUT_RETURN_REQUESTED flag is set, we want to return the
layout as soon as possible, meaning that the affected layout segments
should be marked as invalid, and should no longer be in use for I/O.

Fixes: f0b429819b5f ("pNFS: Ignore non-recalled layouts in pnfs_layout_need_return()")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1226,31 +1226,27 @@ out:
 	return status;
 }
 
+static bool
+pnfs_layout_segments_returnable(struct pnfs_layout_hdr *lo,
+				enum pnfs_iomode iomode,
+				u32 seq)
+{
+	struct pnfs_layout_range recall_range = {
+		.length = NFS4_MAX_UINT64,
+		.iomode = iomode,
+	};
+	return pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+					       &recall_range, seq) != -EBUSY;
+}
+
 /* Return true if layoutreturn is needed */
 static bool
 pnfs_layout_need_return(struct pnfs_layout_hdr *lo)
 {
-	struct pnfs_layout_segment *s;
-	enum pnfs_iomode iomode;
-	u32 seq;
-
 	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 		return false;
-
-	seq = lo->plh_return_seq;
-	iomode = lo->plh_return_iomode;
-
-	/* Defer layoutreturn until all recalled lsegs are done */
-	list_for_each_entry(s, &lo->plh_segs, pls_list) {
-		if (seq && pnfs_seqid_is_newer(s->pls_seq, seq))
-			continue;
-		if (iomode != IOMODE_ANY && s->pls_range.iomode != iomode)
-			continue;
-		if (test_bit(NFS_LSEG_LAYOUTRETURN, &s->pls_flags))
-			return false;
-	}
-
-	return true;
+	return pnfs_layout_segments_returnable(lo, lo->plh_return_iomode,
+					       lo->plh_return_seq);
 }
 
 static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)


