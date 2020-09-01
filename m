Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6222F2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975665;
	bh=WAnsymW3dLKgxGcbm6M9vOZzwrD1DT97PuziyPkFERc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QpCoX1p24+n9xPoop85+g4aazE+sQFoIsCqjsjZuN8fSaexOd5uFIDfgf1PZVbHY4
	 YlzgXPWtEVXH8WiSLXYKC+zltvwGztLOkB3rpQUOOP8TAaYAFfL9vRTyXluqx1jfiy
	 ry+dZqpVlAB4OwXMyx8TcPp2KClIJWOj635j/KjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgIAPyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIAPqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:46:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCB9206EB;
        Tue,  1 Sep 2020 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975196;
        bh=WAnsymW3dLKgxGcbm6M9vOZzwrD1DT97PuziyPkFERc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqZtnYVKGGVb91sNv3Nd4rA7y8ZCa3fMgD1AHnqECz1vCud8rY6zuK+ZWebNSSzZX
         rq4egQ2GmLALrx9yN/cODRkcjJGKA4CBwggsaYpbcc22Zkk37FAAT575oe0hmlTuar
         Rxdwuo+xvdJp5oEllF+BAKSlPZPqXHVoTna52vcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benedikt Ames <wisp3rwind@posteo.eu>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 245/255] io_uring: make offset == -1 consistent with preadv2/pwritev2
Date:   Tue,  1 Sep 2020 17:11:41 +0200
Message-Id: <20200901151012.493684257@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 0fef948363f62494d779cf9dc3c0a86ea1e5f7cd ]

The man page for io_uring generally claims were consistent with what
preadv2 and pwritev2 accept, but turns out there's a slight discrepancy
in how offset == -1 is handled for pipes/streams. preadv doesn't allow
it, but preadv2 does. This currently causes io_uring to return -EINVAL
if that is attempted, but we should allow that as documented.

This change makes us consistent with preadv2/pwritev2 for just passing
in a NULL ppos for streams if the offset is -1.

Cc: stable@vger.kernel.org # v5.7+
Reported-by: Benedikt Ames <wisp3rwind@posteo.eu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2b7018456091c..4115bfedf15dc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2518,6 +2518,11 @@ static ssize_t io_import_iovec(int rw, struct io_kiocb *req,
 	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
 }
 
+static inline loff_t *io_kiocb_ppos(struct kiocb *kiocb)
+{
+	return kiocb->ki_filp->f_mode & FMODE_STREAM ? NULL : &kiocb->ki_pos;
+}
+
 /*
  * For files that don't have ->read_iter() and ->write_iter(), handle them
  * by looping over ->read() or ->write() manually.
@@ -2553,10 +2558,10 @@ static ssize_t loop_rw_iter(int rw, struct file *file, struct kiocb *kiocb,
 
 		if (rw == READ) {
 			nr = file->f_op->read(file, iovec.iov_base,
-					      iovec.iov_len, &kiocb->ki_pos);
+					      iovec.iov_len, io_kiocb_ppos(kiocb));
 		} else {
 			nr = file->f_op->write(file, iovec.iov_base,
-					       iovec.iov_len, &kiocb->ki_pos);
+					       iovec.iov_len, io_kiocb_ppos(kiocb));
 		}
 
 		if (iov_iter_is_bvec(iter))
@@ -2681,7 +2686,7 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 		goto copy_iov;
 
 	iov_count = iov_iter_count(&iter);
-	ret = rw_verify_area(READ, req->file, &kiocb->ki_pos, iov_count);
+	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
@@ -2780,7 +2785,7 @@ static int io_write(struct io_kiocb *req, bool force_nonblock)
 		goto copy_iov;
 
 	iov_count = iov_iter_count(&iter);
-	ret = rw_verify_area(WRITE, req->file, &kiocb->ki_pos, iov_count);
+	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
-- 
2.25.1



