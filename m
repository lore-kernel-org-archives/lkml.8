Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF320715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824589;
	bh=Ravtxt/8JFd5uOHHBu5b9u7OtEtK3wSnXvPfha5Ixis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h3VYh36K4gT2xWaEFt2h8A9/vNtbRpbBSCqtiw/D9WwdsHFmp0h080Eg/AQkydrj0
	 6abS3NOBG2XxHneRlAV9iMNgdoSEz4zDNAFqYYm6rRo7erccgNS+XB7fJyFdCeyMWe
	 pcst2j2dQ9M9A8gSuYP0Yh9wdRYL1/lXQHpROH/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgERR42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731624AbgERR4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D88B120674;
        Mon, 18 May 2020 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824582;
        bh=Ravtxt/8JFd5uOHHBu5b9u7OtEtK3wSnXvPfha5Ixis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtBYY0mCyTsrZFYjcG0MSGkaRNy0X1dZbiFI/ROruk6US/ynmWnbWdQBBz3TOSc9D
         dnNMdnYr33id/rcvTyudDAYW/b/2YDtHjqjvven4fpBIaoTwfgcttc9BzJykpOW9iy
         DbIbvJERSIT2QqHxNnGM80xlAC3/sokPwhR7l2TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/147] mmc: core: Check request type before completing the request
Date:   Mon, 18 May 2020 19:36:31 +0200
Message-Id: <20200518173522.498574957@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

[ Upstream commit e6bfb1bf00852b55f4c771f47ae67004c04d3c87 ]

In the request completion path with CQE, request type is being checked
after the request is getting completed. This is resulting in returning
the wrong request type and leading to the IO hang issue.

ASYNC request type is getting returned for DCMD type requests.
Because of this mismatch, mq->cqe_busy flag is never getting cleared
and the driver is not invoking blk_mq_hw_run_queue. So requests are not
getting dispatched to the LLD from the block layer.

All these eventually leading to IO hang issues.
So, get the request type before completing the request.

Cc: <stable@vger.kernel.org>
Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1588775643-18037-2-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 95b41c0891d02..9d01b5dca5198 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1417,6 +1417,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct request_queue *q = req->q;
 	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	unsigned long flags;
 	bool put_card;
 	int err;
@@ -1446,7 +1447,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
-- 
2.20.1



