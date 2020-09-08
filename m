Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00352080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589602;
	bh=LuqAQTUqtL6HFzAzTGMqWk172HN34Be2mNrwsMi8xN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tm0C7zhi6Zdgdi2kMhdPssCm3JRRgyiVy36cTlDzEAn0G6iwgKk2lnmgWqLy93hfA
	 YeszW2G6xPbFPzfTofs1sGSEWwfeW+i9vhUHO8Ty24ze8mV710z9yzYr4vDBhAYpGN
	 FKFUuXGeHlA7N3T7BvMg22Dlg48jGxkuW5vs9Emg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgIHS0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbgIHQKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:10:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689E124807;
        Tue,  8 Sep 2020 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579801;
        bh=LuqAQTUqtL6HFzAzTGMqWk172HN34Be2mNrwsMi8xN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPt9hvXEUnR6jGKLceVAc7nZFc0r6nlLde3I1U16K+qnZirl0w+NcAOOoIpaITUWY
         TgNJrD2oBPzT5+nBGCKXXEQSESpLCefNVqmSqQH5sZJlY9T6Bqkk1AyNVdLEgl1Xf1
         /p7GaV9HCadl/lAT0/wk6Nw9L7URi9mRs2zCeVWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 039/129] dmaengine: pl330: Fix burst length if burst size is smaller than bus width
Date:   Tue,  8 Sep 2020 17:24:40 +0200
Message-Id: <20200908152231.630693284@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 0661cef675d37e2c4b66a996389ebeae8568e49e ]

Move the burst len fixup after setting the generic value for it. This
finally enables the fixup introduced by commit 137bd11090d8 ("dmaengine:
pl330: Align DMA memcpy operations to MFIFO width"), which otherwise was
overwritten by the generic value.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 137bd11090d8 ("dmaengine: pl330: Align DMA memcpy operations to MFIFO width")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20200825064617.16193-1-m.szyprowski@samsung.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6cce9ef61b294..cd81d10974a29 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2788,6 +2788,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while (burst != (1 << desc->rqcfg.brst_size))
 		desc->rqcfg.brst_size++;
 
+	desc->rqcfg.brst_len = get_burst_len(desc, len);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
 	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
@@ -2795,7 +2796,6 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	if (desc->rqcfg.brst_size * 8 < pl330->pcfg.data_bus_width)
 		desc->rqcfg.brst_len = 1;
 
-	desc->rqcfg.brst_len = get_burst_len(desc, len);
 	desc->bytes_requested = len;
 
 	desc->txd.flags = flags;
-- 
2.25.1



