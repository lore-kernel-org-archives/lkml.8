Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2371EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E701220897
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824959;
	bh=SzXkSbZLavbpySA8SPOGSVH6HZgXsI0Fz963gWwXshQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NDp93WGVRtf4i/9NNFPAd3Jez2TnZ9UW0pcy/+Vuah+yCaztu0aX/rt1B6/O1aZq
	 Be6EJlSWxDVfonO9V+BvaWeNwRPqknQ8pYtSEGUtpVDXymixNWhhVEFj0qqgjcrTMN
	 7lbPUykI23y3zlEZQUKwKF9m2RwxNIJ7BihNGx50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgERSCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732537AbgERSCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:02:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4318B21582;
        Mon, 18 May 2020 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824951;
        bh=SzXkSbZLavbpySA8SPOGSVH6HZgXsI0Fz963gWwXshQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBljnOdtdmZJKm1Eq9ZcTvA+LKYVT8Cb+/PZVjWMy9M9XfVUUMpzkUqg+yaQTbj/U
         5o5iYdcAA2dioY/gotZYAXF1NRWiE3OS1gQCtkk13xKie9TPMh/V5YNLXv7/DHUXaX
         UF9V9Ro7bgZl1tv8FnnsVGKjAFamZaVh1OKKN/Fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 068/194] io_uring: check non-sync defer_list carefully
Date:   Mon, 18 May 2020 19:35:58 +0200
Message-Id: <20200518173537.403295842@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 4ee3631451c9a62e6b6bc7ee51fb9a5b34e33509 ]

io_req_defer() do double-checked locking. Use proper helpers for that,
i.e. list_empty_careful().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 01f71b9efb88f..832e042531bc4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4258,7 +4258,7 @@ static int io_req_defer(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	int ret;
 
 	/* Still need defer if there is pending req in defer list. */
-	if (!req_need_defer(req) && list_empty(&ctx->defer_list))
+	if (!req_need_defer(req) && list_empty_careful(&ctx->defer_list))
 		return 0;
 
 	if (!req->io && io_alloc_async_ctx(req))
-- 
2.20.1



