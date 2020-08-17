Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CA72083B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691046;
	bh=j1ZFhY5yPwchj58hGcRxDu3F9DG3gz9cojapMFGgyV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=16NNOSu2AQkFCEQNm8QU2R9VrAqCApSfWDhNY+FOyibsS8J/NFdUH+EEcJxQf2oz/
	 X2qTQEV6NnB0nM5pgCvtJNnJD/Yw82DT5R96CU8RD+gK5bafnjPYql/e+nCbI5H05/
	 LY28mvgUIliiWz6MYsD3CF5Ems6T0yP/1nGoKBfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391959AbgHQTED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbgHQPqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:46:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0EA2065D;
        Mon, 17 Aug 2020 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679172;
        bh=j1ZFhY5yPwchj58hGcRxDu3F9DG3gz9cojapMFGgyV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJtR7KwuRwXiqd28Wja14/6YxCwaGRAhg6TU51dDgUW2q1xtqT5i6GAagKwJRzzHI
         YsZj7J3Mij+xm7CSIUvmM/0EbyaOAsBe3mj3nbblGuTxnRc2SBoTewyI/aRKK2yZvj
         kCTWIk+p6EChJeA8tNSZeEIxFaGIWlPBLsqDNCAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 119/393] io_uring: fix stalled deferred requests
Date:   Mon, 17 Aug 2020 17:12:49 +0200
Message-Id: <20200817143825.387573280@linuxfoundation.org>
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

[ Upstream commit dd9dfcdf5a603680458f5e7b0d2273c66e5417db ]

Always do io_commit_cqring() after completing a request, even if it was
accounted as overflowed on the CQ side. Failing to do that may lead to
not to pushing deferred requests when needed, and so stalling the whole
ring.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c212af69c15b4..06a093da872f8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7581,6 +7581,7 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 			}
 			WRITE_ONCE(ctx->rings->cq_overflow,
 				atomic_inc_return(&ctx->cached_cq_overflow));
+			io_commit_cqring(ctx);
 			spin_unlock_irq(&ctx->completion_lock);
 
 			/*
-- 
2.25.1



