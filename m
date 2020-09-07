Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCECC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D5421927
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496615;
	bh=b8RGyXcP6g9WqOwCH5gMQQmDdR7oyUfGaniALTLI0+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1dJT+QV4P9tBI9b8CtRxHMNLdY7BoWzx5fsMIXOvnZJkrb0G/7Q8Kep7NJzSkEXp
	 4boJkZOE+IhjL0QqZMNgv1CUUaCNaVY3OvHh32bUNj/BN43BGcjW1aqgvpJvpSanGm
	 +1fEZUsD1FXRBMoXxhPT+o2Ez2jsT4tDV/43+Z7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgIGQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbgIGQdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551BF21974;
        Mon,  7 Sep 2020 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496423;
        bh=b8RGyXcP6g9WqOwCH5gMQQmDdR7oyUfGaniALTLI0+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFVHHJRGHPbs94InQYz+yvj16Xih48GqhLRibkDFd4T1O2N/chDEwR426szcpbTZt
         hXFTtwwNJwW639qW1eC6/C3bfecRojKBHp/1grHbPHbM9TywLuEcPPCgh9pR3mcI7L
         rGV8TL1z5S/DOQnHuIYhZEtZExkqKdKf/YHMxG7I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/43] drivers/dma/dma-jz4780: Fix race condition between probe and irq handler
Date:   Mon,  7 Sep 2020 12:32:56 -0400
Message-Id: <20200907163329.1280888-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 6d6018fc30bee67290dbed2fa51123f7c6f3d691 ]

In probe, IRQ is requested before zchan->id is initialized which can be
read in the irq handler. Hence, shift request irq after other initializations
complete.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20200821034423.12713-1-madhuparnabhowmik10@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dma-jz4780.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index bf95f1d551c51..0ecb724b394f5 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -885,24 +885,11 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-
-	jzdma->irq = ret;
-
-	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
-			  jzdma);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
-		return ret;
-	}
-
 	jzdma->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(jzdma->clk)) {
 		dev_err(dev, "failed to get clock\n");
 		ret = PTR_ERR(jzdma->clk);
-		goto err_free_irq;
+		return ret;
 	}
 
 	clk_prepare_enable(jzdma->clk);
@@ -955,10 +942,23 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_disable_clk;
+
+	jzdma->irq = ret;
+
+	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0, dev_name(dev),
+			  jzdma);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
+		goto err_disable_clk;
+	}
+
 	ret = dmaenginem_async_device_register(dd);
 	if (ret) {
 		dev_err(dev, "failed to register device\n");
-		goto err_disable_clk;
+		goto err_free_irq;
 	}
 
 	/* Register with OF DMA helpers. */
@@ -966,17 +966,17 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 					 jzdma);
 	if (ret) {
 		dev_err(dev, "failed to register OF DMA controller\n");
-		goto err_disable_clk;
+		goto err_free_irq;
 	}
 
 	dev_info(dev, "JZ4780 DMA controller initialised\n");
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(jzdma->clk);
-
 err_free_irq:
 	free_irq(jzdma->irq, jzdma);
+
+err_disable_clk:
+	clk_disable_unprepare(jzdma->clk);
 	return ret;
 }
 
-- 
2.25.1

