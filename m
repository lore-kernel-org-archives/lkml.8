Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC4C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AFF206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598257951;
	bh=aRx+YliMIlfhHADwgY6F1wy2b/b10bc5vVPUkcz9jwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piBi+acvi3sEVMIZXCPNh+2tz3kac1RCcf3hbaHuOLQE+me091aaijJBCBUFUfpsc
	 2GVVd7WL9C1hc7oP7tuT94LeOWNGU70dF3R6rGtdFw7IlLNJMzYYivw3R6TKmRStob
	 0ySJIr21tydX93YOmdJ+pNNKEQbRsEoi2aNji/vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHXIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgHXIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:32:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201A5207D3;
        Mon, 24 Aug 2020 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257943;
        bh=aRx+YliMIlfhHADwgY6F1wy2b/b10bc5vVPUkcz9jwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMjlXSHGOjMP5wDgzvM6nVWtFmBCznS2q2R7wV3nd8fPZNFhEaq/w+i1knW2cZQ4P
         hdvR/k35pL4FnMSIqljAL17nOS+XJOE7NduymfPQpU/n/hCbqWtqH3aM/BIlHSJnFQ
         ocVUagGwlpCdziVtBJj7gXsJKIBV31XLdqw9IVgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Prochazka <nicolas.prochazka@gmail.com>,
        Tomoatsu Shimada <shimada@walbrix.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Philippe Liard <pliard@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Adrien Schildknecht <adrien+dev@schischi.me>,
        Daniel Rosenberg <drosen@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.8 017/148] squashfs: avoid bio_alloc() failure with 1Mbyte blocks
Date:   Mon, 24 Aug 2020 10:28:35 +0200
Message-Id: <20200824082414.791473408@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Lougher <phillip@squashfs.org.uk>

commit f26044c83e6e473a61917f5db411d1417327d425 upstream.

This is a regression introduced by the patch "migrate from ll_rw_block
usage to BIO".

Bio_alloc() is limited to 256 pages (1 Mbyte).  This can cause a failure
when reading 1 Mbyte block filesystems.  The problem is a datablock can be
fully (or almost uncompressed), requiring 256 pages, but, because blocks
are not aligned to page boundaries, it may require 257 pages to read.

Bio_kmalloc() can handle 1024 pages, and so use this for the edge
condition.

Fixes: 93e72b3c612a ("squashfs: migrate from ll_rw_block usage to BIO")
Reported-by: Nicolas Prochazka <nicolas.prochazka@gmail.com>
Reported-by: Tomoatsu Shimada <shimada@walbrix.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: Philippe Liard <pliard@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: Daniel Rosenberg <drosen@google.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200815035637.15319-1-phillip@squashfs.org.uk
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/squashfs/block.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -87,7 +87,11 @@ static int squashfs_bio_read(struct supe
 	int error, i;
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_NOIO, page_count);
+	if (page_count <= BIO_MAX_PAGES)
+		bio = bio_alloc(GFP_NOIO, page_count);
+	else
+		bio = bio_kmalloc(GFP_NOIO, page_count);
+
 	if (!bio)
 		return -ENOMEM;
 


