Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105C8C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD8520716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682844;
	bh=II2jU+hdZxVqYC9gS6Z+ZKE+DZDH2JmlXDJESTVV82k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QoZ/NIbjfXWoLMZ/G0NTyf35QbzQDqvEVmDMyyki4r9h1G5zIdiYIBi5uaHoHCRTS
	 Y+LfrxLG7vXG5FOHwLHL7tDmgYS2WkBn0XBiqKKug+skz7xH74F9Kh6rb6ibI3+nSz
	 AuWF5eAVkoVpdy49M8NtKyGpuf2UBuD9u83RXfC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgHQQrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbgHQQBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:01:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1227920748;
        Mon, 17 Aug 2020 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680061;
        bh=II2jU+hdZxVqYC9gS6Z+ZKE+DZDH2JmlXDJESTVV82k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5S+ZIR9bAq9h8t+Zf51Cw2J8eZXv9nQ1T+DuF2uw3C2e6lQyjyAIxAKVTtIb4tuM
         np9CuqzRRV4GqGXzZ0DDKcQSImMgk6B3OYblB15AEuR7JPEw5n4/kFpmE3uzYTbd0P
         LfpXQFn2li6RJ9uC+cfZTIT05W9W7Nqehmyjz8JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/270] iocost: Fix check condition of iocg abs_vdebt
Date:   Mon, 17 Aug 2020 17:13:59 +0200
Message-Id: <20200817143757.701645077@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit d9012a59db54442d5b2fcfdfcded35cf566397d3 ]

We shouldn't skip iocg when its abs_vdebt is not zero.

Fixes: 0b80f9866e6b ("iocost: protect iocg->abs_vdebt with iocg->waitq.lock")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4d2bda812d9b4..dcc6685d5becc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1377,7 +1377,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg_is_idle(iocg))
 			continue;
 
-- 
2.25.1



