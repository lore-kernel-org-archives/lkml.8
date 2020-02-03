Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60392C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE6020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wzkVCfKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBCKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:10:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727674AbgBCKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:09:53 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0139vM0F024591;
        Mon, 3 Feb 2020 11:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=opqGRUisAUeNTFQFarkeIQS2xwkVHOyUZ4dQfSDAHe0=;
 b=wzkVCfKQgstkYyZWedkGMuhFtDHfXlchmK2VomNhoUMd8QdTo2oL3EgpuN/UnPmVByBJ
 nePsgLC02Gk5mQgVk9k6fvpESVBk1Z5vKN7rz0AIdMtNgndTIAvJ4yZHK2qBKCP3QbC9
 FWmk2OTan5xzUKtSPpR3iqVvbUzS4D2GFkuIJE9exMhyzEpH+1BdkWeZCrfStbLueX9r
 4Z1edlhgoel11mPrHyQnrBZdxknQ63/RDi7pmZvndZTvDc+asF94BPJtNRUhfJY+s1f5
 I+p6O89fGadmuC4QACtZJhnxaX/yKzL6yzj268uWxLjDrjrwa4uhcaLCdCh46H7ccfj7 Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw13ngdpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 11:09:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B203F10002A;
        Mon,  3 Feb 2020 11:09:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A599B2BE22E;
        Mon,  3 Feb 2020 11:09:04 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 11:09:04
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC:     Etienne Carriere <etienne.carriere@st.com>
Subject: [PATCH 6/6] ASoC: stm32: i2s: improve error management on probe deferral
Date:   Mon, 3 Feb 2020 11:08:14 +0100
Message-ID: <20200203100814.22944-7-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203100814.22944-1-olivier.moysan@st.com>
References: <20200203100814.22944-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_02:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not print an error trace when deferring probe for I2S driver.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index cdcc00d9a67e..2478405727c3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -831,25 +831,33 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	/* Get clocks */
 	i2s->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(i2s->pclk)) {
-		dev_err(&pdev->dev, "Could not get pclk\n");
+		if (PTR_ERR(i2s->pclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get pclk: %ld\n",
+				PTR_ERR(i2s->pclk));
 		return PTR_ERR(i2s->pclk);
 	}
 
 	i2s->i2sclk = devm_clk_get(&pdev->dev, "i2sclk");
 	if (IS_ERR(i2s->i2sclk)) {
-		dev_err(&pdev->dev, "Could not get i2sclk\n");
+		if (PTR_ERR(i2s->i2sclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get i2sclk: %ld\n",
+				PTR_ERR(i2s->i2sclk));
 		return PTR_ERR(i2s->i2sclk);
 	}
 
 	i2s->x8kclk = devm_clk_get(&pdev->dev, "x8k");
 	if (IS_ERR(i2s->x8kclk)) {
-		dev_err(&pdev->dev, "missing x8k parent clock\n");
+		if (PTR_ERR(i2s->x8kclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get x8k parent clock: %ld\n",
+				PTR_ERR(i2s->x8kclk));
 		return PTR_ERR(i2s->x8kclk);
 	}
 
 	i2s->x11kclk = devm_clk_get(&pdev->dev, "x11k");
 	if (IS_ERR(i2s->x11kclk)) {
-		dev_err(&pdev->dev, "missing x11k parent clock\n");
+		if (PTR_ERR(i2s->x11kclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get x11k parent clock: %ld\n",
+				PTR_ERR(i2s->x11kclk));
 		return PTR_ERR(i2s->x11kclk);
 	}
 
@@ -907,7 +915,9 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
 						i2s->base, i2s->regmap_conf);
 	if (IS_ERR(i2s->regmap)) {
-		dev_err(&pdev->dev, "regmap init failed\n");
+		if (PTR_ERR(i2s->regmap) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Regmap init error %ld\n",
+				PTR_ERR(i2s->regmap));
 		return PTR_ERR(i2s->regmap);
 	}
 
@@ -918,8 +928,11 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 					      &stm32_i2s_pcm_config, 0);
-	if (ret)
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
 		return ret;
+	}
 
 	/* Set SPI/I2S in i2s mode */
 	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
-- 
2.17.1

