Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1C6206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594818095;
	bh=SZ93HvN5hT6+SbAbEMCbWN+cCEkXYiCiaxjJCORj4vA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uDSSjvXjpmaaMV99aZmSoo712IgBgjR+yn1kjUMlREaQGYM6pj0qoh/6XKWkbwhE+
	 xzhmLlWaw9BVL1qmKJ7NNB8yffhvG1rKTSRQI2SSChn/+9z/ITngBnixKJHnH7h6W6
	 0XO4Jon+gjCZTE5uXlf4Sc/Dq14whJhUfpR6WwgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgGONBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGONBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:01:33 -0400
Received: from localhost.localdomain (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A59220657;
        Wed, 15 Jul 2020 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594818092;
        bh=SZ93HvN5hT6+SbAbEMCbWN+cCEkXYiCiaxjJCORj4vA=;
        h=From:To:Cc:Subject:Date:From;
        b=mFkrVXx991rb6Q2Vgw0Woxo9kEiRRm1FatgxdV6hQS+atmhVJff5VMbjD85Wuve8/
         BEx8NtB50ySWa5YVzAd/brMyKLe1yDOiSMYIb8zBp2ReOMvxZMlMKqHnvXxYfnzprH
         l4jZo7RviEbInXImJgWynSLywuBbXe7ZLaS+ZK94=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: remove always true comparisons
Date:   Wed, 15 Jul 2020 18:31:22 +0530
Message-Id: <20200715130122.39873-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdmac->event_id0 is of type unsigned int and hence can never be less
than zero. Driver compares this at couple of places with greater than or
equal to zero, these are always true so should be dropped

drivers/dma/imx-sdma.c:1336:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
drivers/dma/imx-sdma.c:1637:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b8cfc9d5f1a2..4f8d8f5e1132 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1333,8 +1333,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0 >= 0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
+	sdma_event_disable(sdmac, sdmac->event_id0);
 	if (sdmac->event_id1)
 		sdma_event_disable(sdmac, sdmac->event_id1);
 
@@ -1634,11 +1633,9 @@ static int sdma_config(struct dma_chan *chan,
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0 >= 0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
-			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
-	}
+	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		return -EINVAL;
+	sdma_event_enable(sdmac, sdmac->event_id0);
 
 	if (sdmac->event_id1) {
 		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
-- 
2.26.2

