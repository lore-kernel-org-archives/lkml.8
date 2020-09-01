Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D21C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE8E20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978737;
	bh=c4WH/PmFagCnAWTlKVBg6RiP8BT5Mny0HhSQHue4V+4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jYuVHpO103e4bt/y3xYJY5a1VQGtwBZKY9UrO49RleRnLQS6MQCZ6sI76U2nf7Ab9
	 VFNamSw6MZQK6CUqAe+aj6r//bNyrgpfH5vlUfDpcefTKmq4i/5XY7oZ0QapBLNWHR
	 sUvUQuWgqpiCgnGuyqPQ5vN4uFTo9A8Yz4L4SYnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgIAQpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgIAP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68082078B;
        Tue,  1 Sep 2020 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974046;
        bh=c4WH/PmFagCnAWTlKVBg6RiP8BT5Mny0HhSQHue4V+4=;
        h=From:To:Cc:Subject:Date:From;
        b=dBf7pbKTxqSrRfmZPKIKVWm9Cz+lUwtaXkAMTDqXPBydndINMBfIDiJZ7C8ZULAZg
         nSHIr9NGcPio9oQG/8r2FzIWU6WMPm25e9fgO7vD6sOYRx8Kh0D522XY9dPLfXKPeu
         tIWTjHmR7GZfL6PmK36bMso5sJoq3DwbHWnAYCgQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 01/11] spi: sprd: Release DMA channel also on probe deferral
Date:   Tue,  1 Sep 2020 17:27:03 +0200
Message-Id: <20200901152713.18629-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dma_request_chan() for TX channel fails with EPROBE_DEFER, the RX
channel would not be released and on next re-probe it would be requested
second time.

Fixes: 386119bc7be9 ("spi: sprd: spi: sprd: Add DMA mode support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 6678f1cbc566..0443fec3a6ab 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -563,11 +563,11 @@ static int sprd_spi_dma_request(struct sprd_spi *ss)
 
 	ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
 	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
 		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
 			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 
 		dev_err(ss->dev, "request TX DMA channel failed!\n");
-		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
 		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 	}
 
-- 
2.17.1

