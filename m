Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A91AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F482065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682606;
	bh=vlHt9tpYNwGZ4ENADltlfg5pqYoTKoHP+nArZuNnC+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXPXYycvF2jcpNNuDOCHcWGkORvvLlBfm9fWQq7d1v+0r2flcjTWlvs7iGe48tyzO
	 lLVJNp0FN4iuct52zOuX6uLjVrlAV9HHOF0Eccx2Wipo2Jv5BCj+RM+94IAmNzvuDe
	 Z02fKHzzphBOC8ShwaBFMeJ9jd1eKphLt8WiCRJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgHQQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730947AbgHQP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9D020760;
        Mon, 17 Aug 2020 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679946;
        bh=vlHt9tpYNwGZ4ENADltlfg5pqYoTKoHP+nArZuNnC+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzykGUOWeHSV1PLbIubAOsdgGCBP37t/jB5YnpRp9FNmq2qfqgon8q0zwEdDLHT6D
         6fHuGookVnDu4L29GaOPyzdYOj7J1ooA/K0u4cAJs8LzIJxUhTfqYflPxNX8yFVhlj
         KNLrJWkS27EQoTs9pVGgVM8W9oG7JcEe5CrkDNWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.7 358/393] NFS: Dont move layouts to plh_return_segs list while in use
Date:   Mon, 17 Aug 2020 17:16:48 +0200
Message-Id: <20200817143836.966676005@linuxfoundation.org>
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

commit ff041727e9e029845857cac41aae118ead5e261b upstream.

If the layout segment is still in use for a read or a write, we should
not move it to the layout plh_return_segs list. If we do, we can end
up returning the layout while I/O is still in progress.

Fixes: e0b7d420f72a ("pNFS: Don't discard layout segments that are marked for return")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2392,16 +2392,6 @@ out_forget:
 	return ERR_PTR(-EAGAIN);
 }
 
-static int
-mark_lseg_invalid_or_return(struct pnfs_layout_segment *lseg,
-		struct list_head *tmp_list)
-{
-	if (!mark_lseg_invalid(lseg, tmp_list))
-		return 0;
-	pnfs_cache_lseg_for_layoutreturn(lseg->pls_layout, lseg);
-	return 1;
-}
-
 /**
  * pnfs_mark_matching_lsegs_return - Free or return matching layout segments
  * @lo: pointer to layout header
@@ -2438,7 +2428,7 @@ pnfs_mark_matching_lsegs_return(struct p
 				lseg, lseg->pls_range.iomode,
 				lseg->pls_range.offset,
 				lseg->pls_range.length);
-			if (mark_lseg_invalid_or_return(lseg, tmp_list))
+			if (mark_lseg_invalid(lseg, tmp_list))
 				continue;
 			remaining++;
 			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);


