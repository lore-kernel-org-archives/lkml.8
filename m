Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D35C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B1A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691053;
	bh=DXsh2KSh8admmfQ2XiOKL2C8v8roywEDD8/KUc90Ylc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rUOBBUwI9cuaw5ragQvtfF2Qj1q+XBpLP9e2uhyUXrW+xBcZqRXYfFXRgAVzxAbNJ
	 hiSwjBH+FLV46fGPMjoLNfFJquh/6Vj4wlyU3jEBbb3Kg/dpFFkFgNKeG4ErvrxIUn
	 4g6GfgutXZpPJBg973nvUU1zMlL5vNAkg60wjbJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391968AbgHQTEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730509AbgHQPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:46:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC05C2053B;
        Mon, 17 Aug 2020 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679169;
        bh=DXsh2KSh8admmfQ2XiOKL2C8v8roywEDD8/KUc90Ylc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BifGxyWr2N9Ga6Vpk52UqfDmRatdFm+ynr+aMnLPyXja78Wc3tYkwG2qE2HKUtoAR
         oo+Aw9y7jYqwFAuhxI/7n5LiR//jQhihf6HybH3ckP9QwlSXGyhoYTBDjD0eDGLjHt
         lmjZQQY3qwnRhIxXCz0eaTjWC9Z+zSqRfGhLW/tQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 118/393] io_uring: fix racy overflow count reporting
Date:   Mon, 17 Aug 2020 17:12:48 +0200
Message-Id: <20200817143825.340708318@linuxfoundation.org>
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

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit b2bd1cf99f3e7c8fbf12ea07af2c6998e1209e25 ]

All ->cq_overflow modifications should be under completion_lock,
otherwise it can report a wrong number to the userspace. Fix it in
io_uring_cancel_files().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 159338b5f8263..c212af69c15b4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7579,10 +7579,9 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 				clear_bit(0, &ctx->sq_check_overflow);
 				clear_bit(0, &ctx->cq_check_overflow);
 			}
-			spin_unlock_irq(&ctx->completion_lock);
-
 			WRITE_ONCE(ctx->rings->cq_overflow,
 				atomic_inc_return(&ctx->cached_cq_overflow));
+			spin_unlock_irq(&ctx->completion_lock);
 
 			/*
 			 * Put inflight ref and overflow ref. If that's
-- 
2.25.1



