Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E8FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCBC20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978593;
	bh=o8qlZ2EryFTu3cjlwAR8kRQlz7lJkpkfP6U3eaeoReE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0ruC0UHKpG2jkV33yTGIdcn9yEqKjEKRNCuMvPpgXoMTFkYsYCWG2lkmpeulrSHh
	 +WzPTMUHVgnrEisjAm/l54WOHk72dKiJ15oQVkO/6iSsaaQZkDsK0B6u4mAtFjHTls
	 jUNSZZnWyc3Wf3eK0/RRmHzwxZVwcaZOKdmhOJos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgIAQnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbgIAP1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:50 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CC82078B;
        Tue,  1 Sep 2020 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974069;
        bh=o8qlZ2EryFTu3cjlwAR8kRQlz7lJkpkfP6U3eaeoReE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnBeGSSXnEMQ4CLcP1ia4NPBE1xz6UJfBgv5qLJlLwDIXOlWFOMKFvKfOYau0Wrp5
         t+qX6bomEziRTl4D9pW4LjSoJtxAWrDw/V2kooxiPBLWtDGz3XwxN970p60F1uiDgH
         YVip6d1dTCUU1c4xzjgbWDLgdUfBeinrVW2AUDGs=
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
Subject: [PATCH 04/11] spi: bcm2835: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:06 +0200
Message-Id: <20200901152713.18629-4-krzk@kernel.org>
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
 drivers/spi/spi-bcm2835.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c45d76c848c8..5519f1eda238 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1319,11 +1319,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
-		err = PTR_ERR(bs->clk);
-		if (err == -EPROBE_DEFER)
-			dev_dbg(&pdev->dev, "could not get clk: %d\n", err);
-		else
-			dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
+				    "could not get clk\n");
 		goto out_controller_put;
 	}
 
-- 
2.17.1

