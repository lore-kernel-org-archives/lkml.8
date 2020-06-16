Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2322C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9762071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323938;
	bh=3oWwutp/+uahJDtgiqiuL+cN+x0gcWJYmPHEXiNUFu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSWNDFpy+uToLtgAngPlQPvK4UwI5HWWMo375BcSDTbx4nQHXykvfF9U036f7ZipV
	 c8zGqX7hGN1fksdYxQCiShtMjKUvcUmsbFqrFIChNzYnWByIge/igNk8Kad+v8UvEj
	 riHeSb3cYgWdFxbGTTAQB19QDFHvqb9GZFk2SlX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgFPQMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731883AbgFPPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547092151B;
        Tue, 16 Jun 2020 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322238;
        bh=3oWwutp/+uahJDtgiqiuL+cN+x0gcWJYmPHEXiNUFu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wtty6JQAOB8DoyL/En+hapHbETtg7v2XN6SBQIkrDuNBzNdgjtAXaLcxp8Hiky13o
         ypHxj0BdGwxHF1nttpRqnygOaz62U9OoURlo4r49jGCPadIjAJ8RcTI/TPpLr6jANi
         SGrrmVoKoaZWudslN+aawp20LndmJKfWnJxh+o48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 053/163] io_uring: fix flush req->refs underflow
Date:   Tue, 16 Jun 2020 17:33:47 +0200
Message-Id: <20200616153109.386860739@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

commit 4518a3cc273cf82efdd36522fb1f13baad173c70 upstream.

In io_uring_cancel_files(), after refcount_sub_and_test() leaves 0
req->refs, it calls io_put_req(), which would also put a ref. Call
io_free_req() instead.

Cc: stable@vger.kernel.org
Fixes: 2ca10259b418 ("io_uring: prune request from overflow list on flush")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7390,7 +7390,7 @@ static void io_uring_cancel_files(struct
 			 * all we had, then we're done with this request.
 			 */
 			if (refcount_sub_and_test(2, &cancel_req->refs)) {
-				io_put_req(cancel_req);
+				io_free_req(cancel_req);
 				finish_wait(&ctx->inflight_wait, &wait);
 				continue;
 			}


