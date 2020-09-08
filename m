Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE6C2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861672087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585375;
	bh=jgGMZKTpMuWZUCumUs3Zf/xRhs6V9jg+7yCewR8BJWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EeOaphqCQH8hmts9FRD/G4kZ3nOpy93sdJhWuJXN8hmhOJ5CkER9YwZCbLiw27isc
	 jpAXqNt6VW0SjbVSz2HQQUPxKhNuXgm4K+SgpTHotXpsZTWs4m6DmPT3P4swv+krXZ
	 yZ+ND59sjzaGNCnZmKjk98lfAMqMstwdkRto/PFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgIHRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbgIHQSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C3324812;
        Tue,  8 Sep 2020 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579811;
        bh=jgGMZKTpMuWZUCumUs3Zf/xRhs6V9jg+7yCewR8BJWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYXXnGkebeNEbZdwkZKHd8lFpf9xZ2xZmAoL8ePnpqUNfYRczD8jJNk/QsuN5XOLO
         Exbu9CI5eQOJE+6l7nmggr0JWzycnZJGkfDF6WmIz45I4x76pS9+QiHjC8GBzU5MVk
         yG2OA4XzpNeSkJhaTAkAvEW7BzmsjxtaSfy+HvfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Pu <houpu@bytedance.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/129] nbd: restore default timeout when setting it to zero
Date:   Tue,  8 Sep 2020 17:24:15 +0200
Message-Id: <20200908152230.410276465@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Pu <houpu@bytedance.com>

[ Upstream commit acb19e17c5134dd78668c429ecba5b481f038e6a ]

If we configured io timeout of nbd0 to 100s. Later after we
finished using it, we configured nbd0 again and set the io
timeout to 0. We expect it would timeout after 30 seconds
and keep retry. But in fact we could not change the timeout
when we set it to 0. the timeout is still the original 100s.

So change the timeout to default 30s when we set it to zero.
It also behaves same as commit 2da22da57348 ("nbd: fix zero
cmd timeout handling v2").

It becomes more important if we were reconfigure a nbd device
and the io timeout it set to zero. Because it could take 30s
to detect the new socket and thus io could be completed more
quickly compared to 100s.

Signed-off-by: Hou Pu <houpu@bytedance.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7b61d53ba050e..7c577cabb9c3b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1349,6 +1349,8 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 	nbd->tag_set.timeout = timeout * HZ;
 	if (timeout)
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+	else
+		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
 }
 
 /* Must be called with config_lock held */
-- 
2.25.1



