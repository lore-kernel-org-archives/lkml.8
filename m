Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC8F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691741;
	bh=aUOs9LCM4c8OQ2S4wj4edcrtg3pphFJSpYWD2ii3lf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sC6SNgGaE0hY8bMAsck0/wGuEALpr7/PMd+3At+U/mgHS1XisE8MRIB/epOCg8e+k
	 DxZOAFBk3jdAHnd7lUPp35qYYvxnLwC3e1bmfektIN5wHfHk1LrjlB1y5p6pXlzCh5
	 WaHrg8o0swphfSD/9leGorvBJnKUyvH+fK2DIuxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbgHQTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbgHQPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:39:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A3E23105;
        Mon, 17 Aug 2020 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678789;
        bh=aUOs9LCM4c8OQ2S4wj4edcrtg3pphFJSpYWD2ii3lf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQFSvoQhZPgwHr906iCjixBCveRhoV2rwwpDfWgSfJ/3LoZYkLUFxkEHZgo6FJr90
         VWeC6ZpxEPdSq7EwO97rFu3r2QJ7DhEtbhU4PBqLTxMvLXnONBwn6yQ8ZjmVui+K9+
         dMGKwwnOwzDqzWo7cP2Nb2eSIT7eXMD9eMVWgyr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Tom=C3=A1=C5=A1=20Chaloupka?= <chalucha@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 424/464] io_uring: set ctx sq/cq entry count earlier
Date:   Mon, 17 Aug 2020 17:16:17 +0200
Message-Id: <20200817143854.084312729@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit bd74048108c179cea0ff52979506164c80f29da7 upstream.

If we hit an earlier error path in io_uring_create(), then we will have
accounted memory, but not set ctx->{sq,cq}_entries yet. Then when the
ring is torn down in error, we use those values to unaccount the memory.

Ensure we set the ctx entries before we're able to hit a potential error
path.

Cc: stable@vger.kernel.org
Reported-by: Tomáš Chaloupka <chalucha@gmail.com>
Tested-by: Tomáš Chaloupka <chalucha@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7834,6 +7834,10 @@ static int io_allocate_scq_urings(struct
 	struct io_rings *rings;
 	size_t size, sq_array_offset;
 
+	/* make sure these are sane, as we already accounted them */
+	ctx->sq_entries = p->sq_entries;
+	ctx->cq_entries = p->cq_entries;
+
 	size = rings_size(p->sq_entries, p->cq_entries, &sq_array_offset);
 	if (size == SIZE_MAX)
 		return -EOVERFLOW;
@@ -7850,8 +7854,6 @@ static int io_allocate_scq_urings(struct
 	rings->cq_ring_entries = p->cq_entries;
 	ctx->sq_mask = rings->sq_ring_mask;
 	ctx->cq_mask = rings->cq_ring_mask;
-	ctx->sq_entries = rings->sq_ring_entries;
-	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
 	if (size == SIZE_MAX) {


