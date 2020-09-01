Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E002C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F342067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978653;
	bh=jo5js8lscFdRLSI/iL/0MdnOq2JeNN+Y1xQFxh7q//s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UY0S2zEL1hZh7oBMhpUtCQSxy3vaSRxMsU8o0C7jXavkuR+LWvujlL6H5DH6rFQ53
	 syLx/eWM5lJBJWfEwQlrD7mchJoSn1eRHTu2W6G29z1MXDV+VFM2ED9w0HRPGJgGxW
	 Lw53AC+ZQdccJuzRbTAPaAZcc+O4vgS4slmwbEbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIAQoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgIAP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5A9207D3;
        Tue,  1 Sep 2020 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974062;
        bh=jo5js8lscFdRLSI/iL/0MdnOq2JeNN+Y1xQFxh7q//s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7ARaH/6gOwD0Qobni24k3l1FK1h9lohBOSSiMWp1zDmY29GS2uEBiXYEB8w/mMRy
         dWIESHQOUL9Sm/eKOoGkTa5jVu/U50ba2pw7lGsX32GR0ma0KXpP+2Yj3eJwSGKyCl
         2Gir9We9wSMfaBjfLz7kXjkoSL+SRHr5UgQe8JiY=
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 03/11] spi: atmel: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:05 +0200
Message-Id: <20200901152713.18629-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901152713.18629-1-krzk@kernel.org>
References: <20200901152713.18629-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-atmel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2cfe6253a784..7c68d5cdbdc6 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -513,9 +513,8 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 
 	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
-		err = PTR_ERR(master->dma_tx);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "No TX DMA channel, DMA is disabled\n");
+		err = dev_err_probe(dev, PTR_ERR(master->dma_tx),
+				    "No TX DMA channel, DMA is disabled\n");
 		goto error_clear;
 	}
 
-- 
2.17.1

