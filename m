Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8842063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgF2Soi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:44:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34260 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgF2SoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B9ADB1A10E4;
        Mon, 29 Jun 2020 08:54:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F80E1A01C6;
        Mon, 29 Jun 2020 08:54:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 179B8402F7;
        Mon, 29 Jun 2020 14:54:09 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Refine regcache usage with pm runtime
Date:   Mon, 29 Jun 2020 14:42:33 +0800
Message-Id: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is dedicated power domain bound with device, after probing
the power will be disabled, then registers are not accessible in
fsl_sai_dai_probe(), so regcache only need to be enabled in end of
probe() and regcache_mark_dirty should be moved to pm runtime resume
callback function.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9d436b0c5718..a22562f2df47 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1016,6 +1016,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sai);
 
 	pm_runtime_enable(&pdev->dev);
+	regcache_cache_only(sai->regmap, true);
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
 			&fsl_sai_dai, 1);
@@ -1107,7 +1108,6 @@ static int fsl_sai_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(sai->bus_clk);
 
 	regcache_cache_only(sai->regmap, true);
-	regcache_mark_dirty(sai->regmap);
 
 	return 0;
 }
@@ -1137,6 +1137,7 @@ static int fsl_sai_runtime_resume(struct device *dev)
 	}
 
 	regcache_cache_only(sai->regmap, false);
+	regcache_mark_dirty(sai->regmap);
 	regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), FSL_SAI_CSR_SR);
 	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), FSL_SAI_CSR_SR);
 	usleep_range(1000, 2000);
-- 
2.21.0

