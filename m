Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2984120733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338622;
	bh=T7Jlt3dNLd93gjQSIyq8D/dlHKKX/+NIVSauKQY4LqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTk5VuAyJVjct5fZjMagnjSdZY3u8yAuRfzUJWUKdsTy4phohvBY7WArMX07SKAon
	 7/SkwszsvPwbP+SJ8bMvuj5ke7rkKUxpX2Jn6yk/wRmtAAI+wLRWK18LZ3DqajbXkj
	 memYfBHTw20+vCS7wVPvbWXpGCKBmz4+tzZdnm24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgBJMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbgBJMkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:05 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF9A20842;
        Mon, 10 Feb 2020 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338404;
        bh=T7Jlt3dNLd93gjQSIyq8D/dlHKKX/+NIVSauKQY4LqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTPa/rgtAaVaonnnUdsIAH6efrY9o7UOx6OgT7uxSFgb5HbwKibzxJvDvx/EW5FM6
         jTs/oZgMR2ruWcZ9r9Y1BXCnaMGoa84hLSK+oNonSigEPBZoewP9Y+sJ1yQ61FeFvO
         qujTn0LUmo2nQZHxexioCjehi8NIIqY6C+SpwpuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 106/367] mmc: sdhci-of-at91: fix memleak on clk_get failure
Date:   Mon, 10 Feb 2020 04:30:19 -0800
Message-Id: <20200210122434.180284190@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit a04184ce777b46e92c2b3c93c6dcb2754cb005e1 ]

sdhci_alloc_host() does its work not using managed infrastructure, so
needs explicit free on error path. Add it where needed.

Cc: <stable@vger.kernel.org>
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-at91.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 5959e394b416f..99d82c1874d62 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -335,19 +335,22 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
 	if (IS_ERR(priv->mainck)) {
 		dev_err(&pdev->dev, "failed to get baseclk\n");
-		return PTR_ERR(priv->mainck);
+		ret = PTR_ERR(priv->mainck);
+		goto sdhci_pltfm_free;
 	}
 
 	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
 	if (IS_ERR(priv->hclock)) {
 		dev_err(&pdev->dev, "failed to get hclock\n");
-		return PTR_ERR(priv->hclock);
+		ret = PTR_ERR(priv->hclock);
+		goto sdhci_pltfm_free;
 	}
 
 	priv->gck = devm_clk_get(&pdev->dev, "multclk");
 	if (IS_ERR(priv->gck)) {
 		dev_err(&pdev->dev, "failed to get multclk\n");
-		return PTR_ERR(priv->gck);
+		ret = PTR_ERR(priv->gck);
+		goto sdhci_pltfm_free;
 	}
 
 	ret = sdhci_at91_set_clks_presets(&pdev->dev);
-- 
2.20.1



