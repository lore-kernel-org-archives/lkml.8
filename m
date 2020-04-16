Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D632076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047179;
	bh=c/+ghOKLZbmpam34in/vAlc768DdP6257rzcST0JZms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HPkQKA75j9jCWO+i7tTMAdr9AzquFt8/8GXJbQx49Xk92Pkfqhys737fufXAoXsJ5
	 iOxuRIQZ1mVOPqDtf4yDlqaoXlLbdji+YQa4f/ca0WvLVZKLYBZxsY75738dQ8ncDT
	 zN8Hz/PDOZimb0P8rMUCkEPfdncXrbu4wofRB4Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410083AbgDPO0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409362AbgDPN6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717B3217D8;
        Thu, 16 Apr 2020 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045512;
        bh=c/+ghOKLZbmpam34in/vAlc768DdP6257rzcST0JZms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHigHWSjTzZQHph3NT0fvrNpXikN2N0RbgSLoqm+3nei/DANi+I649yrTD1GBShwE
         uJ8yXShxS79diSHyJSrlEsYYCQlLEKxQmEq9ovIexu6thIsgmKY3ZhyrkjfOIS4RC8
         zofJB7vZEVpZpCV25unOT20btg4giy24EGfSifKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.6 165/254] io_uring: honor original task RLIMIT_FSIZE
Date:   Thu, 16 Apr 2020 15:24:14 +0200
Message-Id: <20200416131347.163857313@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit 4ed734b0d0913e566a9d871e15d24eb240f269f7 upstream.

With the previous fixes for number of files open checking, I added some
debug code to see if we had other spots where we're checking rlimit()
against the async io-wq workers. The only one I found was file size
checking, which we should also honor.

During write and fallocate prep, store the max file size and override
that for the current ask if we're in io-wq worker context.

Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/io_uring.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -565,6 +565,7 @@ struct io_kiocb {
 	struct list_head	link_list;
 	unsigned int		flags;
 	refcount_t		refs;
+	unsigned long		fsize;
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -2294,6 +2295,8 @@ static int io_write_prep(struct io_kiocb
 	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 
+	req->fsize = rlimit(RLIMIT_FSIZE);
+
 	/* either don't need iovec imported or already have it */
 	if (!req->io || req->flags & REQ_F_NEED_CLEANUP)
 		return 0;
@@ -2366,10 +2369,17 @@ static int io_write(struct io_kiocb *req
 		}
 		kiocb->ki_flags |= IOCB_WRITE;
 
+		if (!force_nonblock)
+			current->signal->rlim[RLIMIT_FSIZE].rlim_cur = req->fsize;
+
 		if (req->file->f_op->write_iter)
 			ret2 = call_write_iter(req->file, kiocb, &iter);
 		else
 			ret2 = loop_rw_iter(WRITE, req->file, kiocb, &iter);
+
+		if (!force_nonblock)
+			current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+
 		/*
 		 * Raw bdev writes will -EOPNOTSUPP for IOCB_NOWAIT. Just
 		 * retry them without IOCB_NOWAIT.
@@ -2512,8 +2522,10 @@ static void io_fallocate_finish(struct i
 	if (io_req_cancelled(req))
 		return;
 
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = req->fsize;
 	ret = vfs_fallocate(req->file, req->sync.mode, req->sync.off,
 				req->sync.len);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
@@ -2531,6 +2543,7 @@ static int io_fallocate_prep(struct io_k
 	req->sync.off = READ_ONCE(sqe->off);
 	req->sync.len = READ_ONCE(sqe->addr);
 	req->sync.mode = READ_ONCE(sqe->len);
+	req->fsize = rlimit(RLIMIT_FSIZE);
 	return 0;
 }
 


