Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41936C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC04207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgETIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:35:22 -0400
Received: from v6.sk ([167.172.42.174]:60110 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETIfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:35:22 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 4F4C661300;
        Wed, 20 May 2020 08:35:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ASoC: mmp-sspa: Fix the error handling in probe()
Date:   Wed, 20 May 2020 10:35:16 +0200
Message-Id: <20200520083516.2120802-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail after pm_runtime_enable(), we fail to undo it. Same with
clk_prepare_enable(). Let's order them after all things that can fail.

Fixes: 7d98cc648253 ("ASoC: mmp-sspa: Add support for the runtime power management")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sound/soc/pxa/mmp-sspa.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 60bf6fe05315..77a6d2998570 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -467,6 +467,7 @@ static const struct snd_soc_component_driver mmp_sspa_component = {
 static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 {
 	struct sspa_priv *sspa;
+	int ret;
 
 	sspa = devm_kzalloc(&pdev->dev,
 				sizeof(struct sspa_priv), GFP_KERNEL);
@@ -518,8 +519,6 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 			return PTR_ERR(sspa->sysclk);
 		}
 	}
-	pm_runtime_enable(&pdev->dev);
-	clk_prepare_enable(sspa->audio_clk);
 	platform_set_drvdata(pdev, sspa);
 
 	sspa->playback_dma_data.maxburst = 4;
@@ -529,16 +528,21 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 	sspa->playback_dma_data.addr = 0x80 + SSPA_D;
 
 	if (pdev->dev.of_node) {
-		int ret;
-
 		ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 						      &mmp_pcm_config, 0);
 		if (ret)
 			return ret;
 	}
 
-	return devm_snd_soc_register_component(&pdev->dev, &mmp_sspa_component,
-					       &mmp_sspa_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &mmp_sspa_component,
+					      &mmp_sspa_dai, 1);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+	clk_prepare_enable(sspa->audio_clk);
+
+	return 0;
 }
 
 static int asoc_mmp_sspa_remove(struct platform_device *pdev)
-- 
2.26.2

