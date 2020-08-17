Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA27C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EE420578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689460;
	bh=bG8t/xepkdf4mxiEc3Yj/rM9RKATeDbJ8MdTAc8pIqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBN32MWtobwRGxKMg4uQJWdzeDMEkWgo/9b/tSFa9dI8+McqALffmuxbApgU+TFSu
	 fEwJPqhSntF0p0+/OLgsigx4CUdpFcRWJFX3LOTG0Kf+fv52eF+5+IopqP0EgP+HIs
	 UXIgXJnU2dSiwA3nZeS8Mbw8rNKfbYlC7tpJ8sm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgHQShj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbgHQP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27920206FA;
        Mon, 17 Aug 2020 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679940;
        bh=bG8t/xepkdf4mxiEc3Yj/rM9RKATeDbJ8MdTAc8pIqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=af/XlmM/TAUvgHJLkHlp1FowPdXDp+9D+NGgKiy94JAUBEDhecy4icxyOwHhsKAhN
         ORWMEOX1iIOFD6k6I/VC5xJzBHIShY7+MwmuV9oQxhLwwlEVa9Ncp/xoRfSbJHGnwm
         K/629xnoCuN5gTUIOgSt6k+rSicfI1c+6v5AbMNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef <josef.grieb@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 356/393] io_uring: use TWA_SIGNAL for task_work uncondtionally
Date:   Mon, 17 Aug 2020 17:16:46 +0200
Message-Id: <20200817143836.867157350@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit 0ba9c9edcd152158a0e321a4c13ac1dfc571ff3d upstream.

An earlier commit:

b7db41c9e03b ("io_uring: fix regression with always ignoring signals in io_cqring_wait()")

ensured that we didn't get stuck waiting for eventfd reads when it's
registered with the io_uring ring for event notification, but we still
have cases where the task can be waiting on other events in the kernel and
need a bigger nudge to make forward progress. Or the task could be in the
kernel and running, but on its way to blocking.

This means that TWA_RESUME cannot reliably be used to ensure we make
progress. Use TWA_SIGNAL unconditionally.

Cc: stable@vger.kernel.org # v5.7+
Reported-by: Josef <josef.grieb@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4161,22 +4161,22 @@ static int io_req_task_work_add(struct i
 {
 	struct task_struct *tsk = req->task;
 	struct io_ring_ctx *ctx = req->ctx;
-	int ret, notify = TWA_RESUME;
+	int ret, notify;
 
 	/*
-	 * SQPOLL kernel thread doesn't need notification, just a wakeup.
-	 * If we're not using an eventfd, then TWA_RESUME is always fine,
-	 * as we won't have dependencies between request completions for
-	 * other kernel wait conditions.
+	 * SQPOLL kernel thread doesn't need notification, just a wakeup. For
+	 * all other cases, use TWA_SIGNAL unconditionally to ensure we're
+	 * processing task_work. There's no reliable way to tell if TWA_RESUME
+	 * will do the job.
 	 */
-	if (ctx->flags & IORING_SETUP_SQPOLL)
-		notify = 0;
-	else if (ctx->cq_ev_fd)
+	notify = 0;
+	if (!(ctx->flags & IORING_SETUP_SQPOLL))
 		notify = TWA_SIGNAL;
 
 	ret = task_work_add(tsk, cb, notify);
 	if (!ret)
 		wake_up_process(tsk);
+
 	return ret;
 }
 


