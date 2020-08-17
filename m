Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28596C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F71204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690710;
	bh=/NfL1I0lyz/OTieWorhDGicPfBDzwIhgoHhl5yOB0lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6LTcUapXqFnmtQodYo1BX/Y77hdT5CvKnEOGFTQqExqO0FFXww7vnpgrAscJMSWw
	 zXh5juRJ6d0GISftPSCeDOliLpSJWFfwG3afkfyLoa63iinQmZYOgzMzNuNu94gDDC
	 ZfUf72wHcTCugpZGhT1h6WiBYNHdxO8hLCejWLks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403993AbgHQS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbgHQPuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:50:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1E422B40;
        Mon, 17 Aug 2020 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679395;
        bh=/NfL1I0lyz/OTieWorhDGicPfBDzwIhgoHhl5yOB0lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbbZgFTJa0OiG22t+Ro7+Y/ey+nHqR5H9PLoYhvSEwl+gVz9mQju7frojdA+7Rw8E
         R4GoPSPHAJ6Zaz/aX150CINWT4FCjWpBc3BjbNzMUhIf5DKOJlA3cd1P+nfZZD+uV9
         ZdKRouHMCc3theS4rAx5vlW+jIQM1rGVZkLcWOfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 197/393] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
Date:   Mon, 17 Aug 2020 17:14:07 +0200
Message-Id: <20200817143829.176118153@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit c99e1d0c91ac8d7db3062ea1af315f21295701d7 ]

These functions do not check the return value of devm_clk_register():
  - sdhci_arasan_register_sdcardclk()
  - sdhci_arasan_register_sampleclk()

Therefore, add the missed checks to fix them.

Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200608162226.3259186-1-hslester96@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d4905c106c060..28091d3f704b7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1020,6 +1020,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
 	clk_data->sdcardclk_hw.init = &sdcardclk_init;
 	clk_data->sdcardclk =
 		devm_clk_register(dev, &clk_data->sdcardclk_hw);
+	if (IS_ERR(clk_data->sdcardclk))
+		return PTR_ERR(clk_data->sdcardclk);
 	clk_data->sdcardclk_hw.init = NULL;
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
@@ -1072,6 +1074,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
 	clk_data->sampleclk_hw.init = &sampleclk_init;
 	clk_data->sampleclk =
 		devm_clk_register(dev, &clk_data->sampleclk_hw);
+	if (IS_ERR(clk_data->sampleclk))
+		return PTR_ERR(clk_data->sampleclk);
 	clk_data->sampleclk_hw.init = NULL;
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get,
-- 
2.25.1



