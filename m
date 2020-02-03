Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E4C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60BF20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ShA0NrRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBCKKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:10:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16710 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727672AbgBCKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:09:52 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013A7o72019717;
        Mon, 3 Feb 2020 11:09:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RBofiPp4R9DTfyooLMsUguafFOqr7As70nNTDt8X928=;
 b=ShA0NrRqqtRfTilhlu0v+aukPkeGjS3YyKLE5L8y7KB3dQyCga0T1GXRF/UaEwEjw0L1
 bDQc9ScM7GRWHEvlDcmpCBffUT3kfDJXhhKCwFgSSrTSyn1Ysx2YgqOIe+oEVKAthcxN
 8XO5jDfb65l4YSgDEKQ5mo9ifMnZJWhMZPWAtwnhMwE/4pVYTZwJ/8zaifSJ7O09XCZh
 g1IR8rLNBBCpPPP9sBF0qcCg+TXOEdKzQBAAJgBbH12FNmfeoeBclfukodHA/B+o0HCl
 vddRti/pmFDo3I9eafpUnuIH10BbUFVrxMsF55RdqHzwsMjGsABNBKXjhAQm0K2sd5e7 PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybdrs7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 11:09:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 965E210003A;
        Mon,  3 Feb 2020 11:09:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A0412BE22D;
        Mon,  3 Feb 2020 11:09:01 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 11:09:01
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC:     Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH 4/6] ASoC: stm32: sai: improve error management on probe deferral
Date:   Mon, 3 Feb 2020 11:08:12 +0100
Message-ID: <20200203100814.22944-5-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203100814.22944-1-olivier.moysan@st.com>
References: <20200203100814.22944-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_02:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not print an error trace when deferring probe for SAI driver.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 12 +++++++++---
 sound/soc/stm/stm32_sai_sub.c | 11 ++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index b824ba6cb028..058757c721f0 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -174,20 +174,26 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	if (!STM_SAI_IS_F4(sai)) {
 		sai->pclk = devm_clk_get(&pdev->dev, "pclk");
 		if (IS_ERR(sai->pclk)) {
-			dev_err(&pdev->dev, "missing bus clock pclk\n");
+			if (PTR_ERR(sai->pclk) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "missing bus clock pclk: %ld\n",
+					PTR_ERR(sai->pclk));
 			return PTR_ERR(sai->pclk);
 		}
 	}
 
 	sai->clk_x8k = devm_clk_get(&pdev->dev, "x8k");
 	if (IS_ERR(sai->clk_x8k)) {
-		dev_err(&pdev->dev, "missing x8k parent clock\n");
+		if (PTR_ERR(sai->clk_x8k) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "missing x8k parent clock: %ld\n",
+				PTR_ERR(sai->clk_x8k));
 		return PTR_ERR(sai->clk_x8k);
 	}
 
 	sai->clk_x11k = devm_clk_get(&pdev->dev, "x11k");
 	if (IS_ERR(sai->clk_x11k)) {
-		dev_err(&pdev->dev, "missing x11k parent clock\n");
+		if (PTR_ERR(sai->clk_x11k) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "missing x11k parent clock: %ld\n",
+				PTR_ERR(sai->clk_x11k));
 		return PTR_ERR(sai->clk_x11k);
 	}
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 30bcd5d3a32a..0bbf9ed5e48b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1380,7 +1380,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    sai->regmap_config);
 	if (IS_ERR(sai->regmap)) {
-		dev_err(&pdev->dev, "Failed to initialize MMIO\n");
+		if (PTR_ERR(sai->regmap) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Regmap init error %ld\n",
+				PTR_ERR(sai->regmap));
 		return PTR_ERR(sai->regmap);
 	}
 
@@ -1471,7 +1473,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	of_node_put(args.np);
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
 	if (IS_ERR(sai->sai_ck)) {
-		dev_err(&pdev->dev, "Missing kernel clock sai_ck\n");
+		if (PTR_ERR(sai->sai_ck) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Missing kernel clock sai_ck: %ld\n",
+				PTR_ERR(sai->sai_ck));
 		return PTR_ERR(sai->sai_ck);
 	}
 
@@ -1553,7 +1557,8 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not register pcm dma\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

