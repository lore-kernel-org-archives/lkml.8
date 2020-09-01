Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA59CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AA221655
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978441;
	bh=sDJbBtyuXPf8AdJ2TLEs7TvBFyJ4HZya4/KdpqfIghc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bAzv57CnYI8vCNqcFJM4Wev0+NrXXwQsL98gXWL82A3z9nQx/O94CfuOexrWFxMpt
	 38h0qr2NGEB9HFdITnHyq79PwSLMyXAkN1nnx7quD9IDQ46inp77Aub8rimtikvIf0
	 ypxciPyS9VL6r25TXkFgQHMitLfW8z3Ya2CN7p5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgIAQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbgIAP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:14 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F05A82078B;
        Tue,  1 Sep 2020 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974094;
        bh=sDJbBtyuXPf8AdJ2TLEs7TvBFyJ4HZya4/KdpqfIghc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAHrqrmSB4+wTOyV0CJPyMHjbIK7a2KePXXbjKYHvv5XgBqg//ACEhBjJ0ylaK0Ec
         EeG4O3t/mJEqHW08oNKRn144pLZz9feRDorO86UEs6QnJLpiKzgmRuHvVeBjFlXpS2
         hmvYeTll0PNzb0AVA0nqTfLeMEpOWb5YTF9WeGzQ=
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
Subject: [PATCH 07/11] spi: qcom-qspi: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:09 +0200
Message-Id: <20200901152713.18629-7-krzk@kernel.org>
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
 drivers/spi/spi-qcom-qspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8857a97f40a..f83755e292bb 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -495,9 +495,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 
 	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
 	if (IS_ERR(ctrl->icc_path_cpu_to_qspi)) {
-		ret = PTR_ERR(ctrl->icc_path_cpu_to_qspi);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get cpu path: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
+				    "Failed to get cpu path\n");
 		goto exit_probe_master_put;
 	}
 	/* Set BW vote for register access */
-- 
2.17.1

