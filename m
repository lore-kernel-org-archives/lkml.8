Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63602C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242152098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593628;
	bh=8oOtyPkdf47pnN5G7/BrbY1fcYbqtcbHjJaAtLsYWFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zCZnfV3BIZBgQcdhfr6ON3w5/k6BSDkSlR7ApjpsftsUZxKZUj0woLWfzZqnI3Hgu
	 3/kLVi5CdrRQuo84jFDhnZvz0V1W+16gR4W/hI1T8e/L91xVwGn+e8s8IsuN+LyaPx
	 odtzTvwXmHNaMnBDFTTGlZu7Sh3zc2UyQdU65BYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgIHTdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784FA22574;
        Tue,  8 Sep 2020 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579425;
        bh=8oOtyPkdf47pnN5G7/BrbY1fcYbqtcbHjJaAtLsYWFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDiCfrPAIY2P8K5MmCe6iewLX79+L3PuXeCtC28XZWIfVSQx2gWgBs1zwVJvOHrT/
         SfXljKcjGOOHxWlw6j5borOxU/vKZkU25fENBqmIIfHWV9dcsCqA4m+I6oxjzHR9zc
         2BZisAz2/JTP8gzGx/50G/pwwiSN7m/L2JOMqzfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 045/186] dmaengine: at_hdmac: add missing kfree() call in at_dma_xlate()
Date:   Tue,  8 Sep 2020 17:23:07 +0200
Message-Id: <20200908152243.844522114@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e097eb7473d9e70da9e03276f61cd392ccb9d79f ]

If memory allocation for 'atslave' succeed, at_dma_xlate() doesn't have a
corresponding kfree() in exception handling. Thus add kfree() for this
function implementation.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20200817115728.1706719-4-yukuai3@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_hdmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index c91642b5f1037..626819b33a325 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1691,6 +1691,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
 	if (!chan) {
 		put_device(&dmac_pdev->dev);
+		kfree(atslave);
 		return NULL;
 	}
 
-- 
2.25.1



