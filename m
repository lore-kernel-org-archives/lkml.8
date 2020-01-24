Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17414C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2BE2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860148;
	bh=CkSWa3+tm2tcfSWRmOI5hOneByH/GcjVShb/+UDPSb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FnUrjd6DEhfLixmUKRQm0UxrVzeVpp3HgtyhfYRbfOUVWOi99YJ/YpLXdcAmRSOq9
	 gUehd4lZDCZlQqEUmDUbc1n0Bo2g5B2KEIwzhM6MbdCESLg7DxCanFq3YTG3YT3G9U
	 jW4LJ/vz4gkPUeEgby5ZAuWZxp/h/woHwsC3jPPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgAXKC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388899AbgAXKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:02:25 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28EA620709;
        Fri, 24 Jan 2020 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860144;
        bh=CkSWa3+tm2tcfSWRmOI5hOneByH/GcjVShb/+UDPSb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFtUya4DFp1NeCf3vV1Uqa5YyYXnGZ2KjXFn2PkTaOu9jAtWJlyjud5kXhQN9ki1P
         rm66IF/8uYphgXY6niwEDrEuq09zITY7fmbqLZJNWXd8lc1Rx4RwUYu5DYW+MOl5NO
         7kuHvTHYxDOi0/Q2cltXzkpavMnJ4I/PR2aE63Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 244/343] dmaengine: hsu: Revert "set HSU_CH_MTSR to memory width"
Date:   Fri, 24 Jan 2020 10:31:02 +0100
Message-Id: <20200124092952.202928949@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c24a5c735f87d0549060de31367c095e8810b895 ]

The commit

  080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")

has been mistakenly submitted. The further investigations show that
the original code does better job since the memory side transfer size
has never been configured by DMA users.

As per latest revision of documentation: "Channel minimum transfer size
(CHnMTSR)... For IOSF UART, maximum value that can be programmed is 64 and
minimum value that can be programmed is 1."

This reverts commit 080edf75d337d35faa6fc3df99342b10d2848d16.

Fixes: 080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/hsu/hsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 29d04ca71d52e..15525a2b8ebd7 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -64,10 +64,10 @@ static void hsu_dma_chan_start(struct hsu_dma_chan *hsuc)
 
 	if (hsuc->direction == DMA_MEM_TO_DEV) {
 		bsr = config->dst_maxburst;
-		mtsr = config->src_addr_width;
+		mtsr = config->dst_addr_width;
 	} else if (hsuc->direction == DMA_DEV_TO_MEM) {
 		bsr = config->src_maxburst;
-		mtsr = config->dst_addr_width;
+		mtsr = config->src_addr_width;
 	}
 
 	hsu_chan_disable(hsuc);
-- 
2.20.1



