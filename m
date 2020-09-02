Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26CBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992522083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075496;
	bh=SQl/6OS4NtkfhoHM6x57EjikQWPjJp6R4j4puLXRYOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W3KH2raBagS6xoPP3avAR+8ME4Var+4ywbrIwegIlHn7wRI/AnpTiP/NFlDQYrk85
	 9ZgS295UeLndjK4LJsaapZ3hjwv9wiZJ9RCKWzTaatIJgSfniip1KgebmXrnk/xCmF
	 eyfbEbeDpo0ucaX6hIBM1gLdXN3Y5v5lUwOz69hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIBTiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgIBTiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:38:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4B720C56;
        Wed,  2 Sep 2020 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075488;
        bh=SQl/6OS4NtkfhoHM6x57EjikQWPjJp6R4j4puLXRYOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnPu8F1exJo+uPphLfUjycPSojRrb5lbYJCxy0OkbDJoBIbtJlppeGGRantb0xIHK
         wZTnr9qAwMjHtzjSypym5MrBxUODR9ojVsLzCCi9AExiyKzJmWJ+LpoGJ9xmkVXtgX
         ZyNbL60PgIqbyR0miZYsDgn1IJnK+/B8f+ssAeeE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 07/11] mmc: sdhci-of-arasan: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 21:36:54 +0200
Message-Id: <20200902193658.20539-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f186fbd016b1..3aea46db2ea7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1543,10 +1543,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		of_node_put(node);
 
 		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
-			ret = PTR_ERR(sdhci_arasan->soc_ctl_base);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get syscon: %d\n",
-					ret);
+			ret = dev_err_probe(&pdev->dev,
+					    PTR_ERR(sdhci_arasan->soc_ctl_base),
+					    "Can't get syscon\n");
 			goto err_pltfm_free;
 		}
 	}
-- 
2.17.1

