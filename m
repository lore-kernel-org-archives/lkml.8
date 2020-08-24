Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C06C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1685B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598257938;
	bh=2FKLRsp/q4hCpwXTaY8+6NDt7k4ARIDqnPQJhxEo6BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JyFa8/xkr9jUI2erpxHlasjs7IsH5eeoticAeNSSkwQifJXcRvj0bBHrNebYbRzT7
	 2vDM5xEYda8WH//5q9cJ7P2PBGt3Q4lFkOIc4/9vS/jwX0PhHLT0T22rbVocL+Ht/D
	 +2V/cSgCWTwAD/IuUJybyv0xoPcql61lL7Z+ssTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHXIcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgHXIcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:32:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F592074D;
        Mon, 24 Aug 2020 08:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257928;
        bh=2FKLRsp/q4hCpwXTaY8+6NDt7k4ARIDqnPQJhxEo6BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1T7CkykaxA0ieOGgtps0HycJ9sVwcKeUAh1hc/q/RPG5jHTgrkyEnaSImBkjKwxJ
         y/5WLOi7ENqGLqt5vxigla+7hnCiqTEoXPEix2PMRzl1f1o6uEx3dOof2N33h+I/IG
         jySxa8IId3oLNijzxcxhsZq2KylHK7+oHP72zO9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 012/148] io_uring: find and cancel head link async work on files exit
Date:   Mon, 24 Aug 2020 10:28:30 +0200
Message-Id: <20200824082414.547922920@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit b711d4eaf0c408a811311ee3e94d6e9e5a230a9a upstream.

Commit f254ac04c874 ("io_uring: enable lookup of links holding inflight files")
only handled 2 out of the three head link cases we have, we also need to
lookup and cancel work that is blocked in io-wq if that work has a link
that's holding a reference to the files structure.

Put the "cancel head links that hold this request pending" logic into
io_attempt_cancel(), which will to through the motions of finding and
canceling head links that hold the current inflight files stable request
pending.

Cc: stable@vger.kernel.org
Reported-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7609,6 +7609,33 @@ static bool io_timeout_remove_link(struc
 	return found;
 }
 
+static bool io_cancel_link_cb(struct io_wq_work *work, void *data)
+{
+	return io_match_link(container_of(work, struct io_kiocb, work), data);
+}
+
+static void io_attempt_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req)
+{
+	enum io_wq_cancel cret;
+
+	/* cancel this particular work, if it's running */
+	cret = io_wq_cancel_work(ctx->io_wq, &req->work);
+	if (cret != IO_WQ_CANCEL_NOTFOUND)
+		return;
+
+	/* find links that hold this pending, cancel those */
+	cret = io_wq_cancel_cb(ctx->io_wq, io_cancel_link_cb, req, true);
+	if (cret != IO_WQ_CANCEL_NOTFOUND)
+		return;
+
+	/* if we have a poll link holding this pending, cancel that */
+	if (io_poll_remove_link(ctx, req))
+		return;
+
+	/* final option, timeout link is holding this req pending */
+	io_timeout_remove_link(ctx, req);
+}
+
 static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 				  struct files_struct *files)
 {
@@ -7665,10 +7692,8 @@ static void io_uring_cancel_files(struct
 				continue;
 			}
 		} else {
-			io_wq_cancel_work(ctx->io_wq, &cancel_req->work);
-			/* could be a link, check and remove if it is */
-			if (!io_poll_remove_link(ctx, cancel_req))
-				io_timeout_remove_link(ctx, cancel_req);
+			/* cancel this request, or head link requests */
+			io_attempt_cancel(ctx, cancel_req);
 			io_put_req(cancel_req);
 		}
 


