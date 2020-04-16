Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAFC217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045385;
	bh=KtggvIYcmYpaeupy2pxpogJA2WSu2oQ8qYpjo3uH7w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5+7gl216Jmq5lDDM+pR1ZfLUsnqu/d27UmaC/rX2abDsbEzCIILmpLcZmif9pcY9
	 nmx/Lcz/U0TLGVXQqpKty6geljBuuWOIZmnFAtMePRXO9dBjeDyw5ETPyevppMQjjM
	 SU2YGas+ZF/xP8vIgNjcBtzdL5HeqHIgQiAxp1xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409197AbgDPN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897741AbgDPNio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEFD221F7;
        Thu, 16 Apr 2020 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044323;
        bh=KtggvIYcmYpaeupy2pxpogJA2WSu2oQ8qYpjo3uH7w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMrJtuZJWnE8gpidA8IrPMLLEW9hp8S8dKguI1gw8XGEEiGjFDfhE1MVQz2kVIx6S
         WhEJ3CkVrjZnLeUujrlqyQmZTiD4FhiTbRqmiuhmHglxD4pRaGBm4SpsQ1ESo66T+3
         7Odxx4w9jkb7NpBn0Ei//dr4XqgZo14NFKoKDbco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.5 172/257] io_uring: honor original task RLIMIT_FSIZE
Date:   Thu, 16 Apr 2020 15:23:43 +0200
Message-Id: <20200416131347.893221294@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
 fs/io_uring.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -432,6 +432,7 @@ struct io_kiocb {
 #define REQ_F_INFLIGHT		16384	/* on inflight list */
 #define REQ_F_COMP_LOCKED	32768	/* completion under lock */
 #define REQ_F_HARDLINK		65536	/* doesn't sever on completion < 0 */
+	unsigned long		fsize;
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -1899,6 +1900,8 @@ static int io_write_prep(struct io_kiocb
 	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
 		return -EBADF;
 
+	req->fsize = rlimit(RLIMIT_FSIZE);
+
 	if (!req->io)
 		return 0;
 
@@ -1970,10 +1973,17 @@ static int io_write(struct io_kiocb *req
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


