Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714F2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608273;
	bh=2LOS4tbupeTSygClD40dSb6uvh6u9TGMj8TmfoR5iNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjjwQ/o2vHxgarNRoYB4gxrIVAIPxKP+i2ab/ryPVLcEvMGY57mxIxhH5xVVMzre9
	 rHOAybD5m+1wRkfYGSRVN8WbcfojR515ivW79WJA0/ChpzLc/t772Sv+uKk5eFjMxK
	 N1yr9dyLLjupvY0Eh9XCXdkXJ9eFJhLEgmukZqAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgBMPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbgBMP3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:21 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BC2218AC;
        Thu, 13 Feb 2020 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607760;
        bh=2LOS4tbupeTSygClD40dSb6uvh6u9TGMj8TmfoR5iNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxahJbJURHdE5Swf5Vp/X6iAAfau/ycqCV4TVY6GbUDvF0J/5lUiRzTJeCee+o9Iu
         Lrt6u7rbYONmP2Yp5TLDNKNN0BxhAbfKpE33L1VaszjHew3NX7Ky1ofG/cQUfKeT/v
         3WrSDv6OvEaqr6WdADMtABlfFQZriGEUMoOYyNjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.5 116/120] dmaengine: axi-dmac: add a check for devm_regmap_init_mmio
Date:   Thu, 13 Feb 2020 07:21:52 -0800
Message-Id: <20200213151939.111274282@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit a5b982af953bcc838cd198b0434834cc1dff14ec upstream.

The driver misses checking the result of devm_regmap_init_mmio().
Add a check to fix it.

Fixes: fc15be39a827 ("dmaengine: axi-dmac: add regmap support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20191209085711.16001-1-hslester96@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dma-axi-dmac.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -830,6 +830,7 @@ static int axi_dmac_probe(struct platfor
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
 	struct resource *res;
+	struct regmap *regmap;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -921,10 +922,17 @@ static int axi_dmac_probe(struct platfor
 
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


