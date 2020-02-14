Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCA62187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696375;
	bh=g0H+3ovq4kYtjGmq5NPbNijrKDqg75LfmPzzqNKWwBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNwfDQjVPpbOyva94g1N1bRaksMdQo/UFsNAm4uafT0DKx8+rymqxgooTPFHWNQO0
	 hA/FymTlTM7G3S+umvNyzvikiN/EupbWkJCNb8rNHlRx+l2yypkIMAe7pgoJn/wxxJ
	 mSQ5eCRZI55qksS7syYCEVNrAvwIG6lBQC0eYvjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgBNQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390190AbgBNQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CAC2187F;
        Fri, 14 Feb 2020 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696332;
        bh=g0H+3ovq4kYtjGmq5NPbNijrKDqg75LfmPzzqNKWwBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGO6MJiatgMRGHHIVEV5JWItFTWHf2hTMILTXJa5aBBYNaCmgmF/Sgzvq+1AuiP8i
         F8UTmd1aRYzRWmne24zmy1nA5hBw3OYHUehS3/ysY1CoQBxpmmrwlo7vs2ehIsU8+W
         ZADrdvyqtcVclkxDdDv6HuhGDLSH9b7Q2QNcNKKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 170/459] dmaengine: axi-dmac: add a check for devm_regmap_init_mmio
Date:   Fri, 14 Feb 2020 10:57:00 -0500
Message-Id: <20200214160149.11681-170-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit a5b982af953bcc838cd198b0434834cc1dff14ec ]

The driver misses checking the result of devm_regmap_init_mmio().
Add a check to fix it.

Fixes: fc15be39a827 ("dmaengine: axi-dmac: add regmap support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20191209085711.16001-1-hslester96@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dma-axi-dmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index a0ee404b736ed..f1d149e328395 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -830,6 +830,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
 	struct resource *res;
+	struct regmap *regmap;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -921,10 +922,17 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmac);
 
-	devm_regmap_init_mmio(&pdev->dev, dmac->base, &axi_dmac_regmap_config);
+	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
+		 &axi_dmac_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_free_irq;
+	}
 
 	return 0;
 
+err_free_irq:
+	free_irq(dmac->irq, dmac);
 err_unregister_of:
 	of_dma_controller_free(pdev->dev.of_node);
 err_unregister_device:
-- 
2.20.1

