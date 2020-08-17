Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF537C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968682067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684040;
	bh=sMSJ1v+AsU2GCfmY+AV8iZ7kghNonY2Bav41QQVLTrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sE2HoELDiwj/7anIFce9k2T+pu/0F3A3g7MAk/n+OmYRLjD4cMxRSYu4u1k0gM1vk
	 LXawkoyp5LCz4PVcztI6MhuWo9sRMYeuIM1v4Qni1zF24QSqT8YOCAzKzj4mP4201b
	 Gb2O/w+2OphsLHyU73ytKPys7GaObso3P7GpJSyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbgHQRHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbgHQQJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:09:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E3822CBB;
        Mon, 17 Aug 2020 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680565;
        bh=sMSJ1v+AsU2GCfmY+AV8iZ7kghNonY2Bav41QQVLTrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LY9opn0VQEnCw1zUSU8JFqfHI4dOHA5mRI8ZYXjHc/aCbGYYqhUHrjQZhD+dHolKn
         BrTxuvnFQZ/UBrZUo5OuUV9npICiORMvWGsQrCEhwIbAJu0uyIJlRhSSURd+2Lc+Pa
         FZ8T5DZk+bFmcuHZk7lzRk/aU/GJAtooVKv3Ad6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.4 238/270] NFS: Dont move layouts to plh_return_segs list while in use
Date:   Mon, 17 Aug 2020 17:17:19 +0200
Message-Id: <20200817143807.649098096@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
@@ -2362,16 +2362,6 @@ out_forget:
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
@@ -2408,7 +2398,7 @@ pnfs_mark_matching_lsegs_return(struct p
 				lseg, lseg->pls_range.iomode,
 				lseg->pls_range.offset,
 				lseg->pls_range.length);
-			if (mark_lseg_invalid_or_return(lseg, tmp_list))
+			if (mark_lseg_invalid(lseg, tmp_list))
 				continue;
 			remaining++;
 			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);


