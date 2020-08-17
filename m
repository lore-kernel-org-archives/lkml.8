Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13206C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E667B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685864;
	bh=ztlG9QaknFyTfYzdpNT3wqiqJdOID9j2ksEW3cd4nbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rR608K37ya4DbmWG0nsmqTFxwHNfNjwJEPyEhi6rljV8pshVGF2cyO0osr0JtDklJ
	 vBZZlf6yVtOtYsNTRH9MN6imWCy+o7gz7orr2h1HFn/mMOHVupCMH2tphIcGGHWhWo
	 luezFeedgUbOsKbGDAXa5FqoB/NsT6DBrO+sysR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgHQRhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbgHQQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:17:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605DE20772;
        Mon, 17 Aug 2020 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681040;
        bh=ztlG9QaknFyTfYzdpNT3wqiqJdOID9j2ksEW3cd4nbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fp5QezfThy0E+8gwAk5BnNBMZo8+c8cgZKv7z5hlzsrMLoVMBrNReMa5qNMSe3yzn
         mBeqo4Qzk//OCahLdGSzhQfSlanAYkGak8kw1iJUpPI3DeORP3ZFfwqq4pzg57PtNC
         ekuqoafvU6NMK3dXe/nf0J4aGTyTvlMFwb+ckPyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 157/168] NFS: Dont return layout segments that are in use
Date:   Mon, 17 Aug 2020 17:18:08 +0200
Message-Id: <20200817143741.510921746@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
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
@@ -1181,31 +1181,27 @@ out:
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


