Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6006F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691678;
	bh=Pp+vN7qB4/2ERCceyOTqwYXEP0XhOyD+YA3d2GFVuFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LL7CnzQ3w+1iju0ITQxASaMOwBRWpi/JTmyWR8AH0aOCJyMN4yithq15RRvih5Y1/
	 rO0ht+0fxQ4OAoD7kSCAfg2bUPqD6QhLYat3Uth8+ANn8wPNV/zdjKkQFUjx2pkd5+
	 NRYOkeProFgGiLCbW7ohmTPsJFPH8xVPDeyE5oJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbgHQTOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbgHQPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677CA23105;
        Mon, 17 Aug 2020 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678809;
        bh=Pp+vN7qB4/2ERCceyOTqwYXEP0XhOyD+YA3d2GFVuFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJRlFvRWep+x8nsvpeCdxnN7gpfOTZSGYk9uUsfn2qdieIG+DpWtQVnqeAgxiECtt
         JXLKAtxKp7p/yrZqJWAWD3hxrydrYqS6ek+6PEZNFCyshbMgNmuqWtKR2CGb0Ewyk3
         B/N4PcHr5z56FTl3yRMBL5u5bK3hLuPr7vk+gzOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 462/464] io_uring: add missing REQ_F_COMP_LOCKED for nested requests
Date:   Mon, 17 Aug 2020 17:16:55 +0200
Message-Id: <20200817143855.909267241@linuxfoundation.org>
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

commit 9b7adba9eaec28e0e4343c96d0dbeb9578802f5f upstream.

When we traverse into failing links or timeouts, we need to ensure we
propagate the REQ_F_COMP_LOCKED flag to ensure that we correctly signal
to the completion side that we already hold the completion lock.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/io_uring.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1549,12 +1549,9 @@ static void io_req_link_next(struct io_k
 /*
  * Called if REQ_F_LINK_HEAD is set, and we fail the head request
  */
-static void io_fail_links(struct io_kiocb *req)
+static void __io_fail_links(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	while (!list_empty(&req->link_list)) {
 		struct io_kiocb *link = list_first_entry(&req->link_list,
@@ -1568,13 +1565,29 @@ static void io_fail_links(struct io_kioc
 			io_link_cancel_timeout(link);
 		} else {
 			io_cqring_fill_event(link, -ECANCELED);
+			link->flags |= REQ_F_COMP_LOCKED;
 			__io_double_put_req(link);
 		}
 		req->flags &= ~REQ_F_LINK_TIMEOUT;
 	}
 
 	io_commit_cqring(ctx);
-	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+}
+
+static void io_fail_links(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	if (!(req->flags & REQ_F_COMP_LOCKED)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ctx->completion_lock, flags);
+		__io_fail_links(req);
+		spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	} else {
+		__io_fail_links(req);
+	}
+
 	io_cqring_ev_posted(ctx);
 }
 
@@ -4767,6 +4780,7 @@ static int io_timeout_cancel(struct io_r
 		return -EALREADY;
 
 	req_set_fail_links(req);
+	req->flags |= REQ_F_COMP_LOCKED;
 	io_cqring_fill_event(req, -ECANCELED);
 	io_put_req(req);
 	return 0;


