Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E1C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74947206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584018790;
	bh=O3u33Z/i2lGBhCK8D4N+BtJBwEIB9Ku0dgN8i6x/a8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Q8tFoXTca81xQCUlian0+ErE2vy2BtrorXEuvA7Fn0qbYHGHdUsxu48x5OKTjsY9f
	 RtNVAxkoweWCp4y4QKNSUKrkHg8kcKGP5R8EyQXVXdpACq8M187FMkGQu31Kk7He9L
	 2Kagv4R15mwW4X2pre9P9MvR8IdkwmFk8XdHVao8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCLNNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:13:09 -0400
Received: from foss.arm.com ([217.140.110.172]:34280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:13:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CABEAFEC;
        Thu, 12 Mar 2020 06:13:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FA9B3F534;
        Thu, 12 Mar 2020 06:13:07 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:13:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: only enable dais from device tree" to the asoc tree
In-Reply-To:  <20200311180422.28363-2-srinivas.kandagatla@linaro.org>
Message-Id:  <applied-20200311180422.28363-2-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm-dai: only enable dais from device tree

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 9b60441692d94effcd37a141035c6106a91ddf8c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 11 Mar 2020 18:04:21 +0000
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: only enable dais from device tree

Existing code enables all the playback and capture dais even
if there is no device tree entry. This can lead to
un-necessary dais in the system which will never be used.
So honour whats specfied in device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200311180422.28363-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c0d422d0ab94..8b48815ff918 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -69,6 +69,8 @@ struct q6asm_dai_rtd {
 };
 
 struct q6asm_dai_data {
+	struct snd_soc_dai_driver *dais;
+	int num_dais;
 	long long int sid;
 };
 
@@ -889,7 +891,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.compr_ops	= &q6asm_dai_compr_ops,
 };
 
-static struct snd_soc_dai_driver q6asm_fe_dais[] = {
+static struct snd_soc_dai_driver q6asm_fe_dais_template[] = {
 	Q6ASM_FEDAI_DRIVER(1),
 	Q6ASM_FEDAI_DRIVER(2),
 	Q6ASM_FEDAI_DRIVER(3),
@@ -903,10 +905,22 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 static int of_q6asm_parse_dai_data(struct device *dev,
 				    struct q6asm_dai_data *pdata)
 {
-	static struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_dai_driver *dai_drv;
 	struct snd_soc_pcm_stream empty_stream;
 	struct device_node *node;
-	int ret, id, dir;
+	int ret, id, dir, idx = 0;
+
+
+	pdata->num_dais = of_get_child_count(dev->of_node);
+	if (!pdata->num_dais) {
+		dev_err(dev, "No dais found in DT\n");
+		return -EINVAL;
+	}
+
+	pdata->dais = devm_kcalloc(dev, pdata->num_dais, sizeof(*dai_drv),
+				   GFP_KERNEL);
+	if (!pdata->dais)
+		return -ENOMEM;
 
 	memset(&empty_stream, 0, sizeof(empty_stream));
 
@@ -917,7 +931,8 @@ static int of_q6asm_parse_dai_data(struct device *dev,
 			continue;
 		}
 
-		dai_drv = &q6asm_fe_dais[id];
+		dai_drv = &pdata->dais[idx++];
+		*dai_drv = q6asm_fe_dais_template[id];
 
 		ret = of_property_read_u32(node, "direction", &dir);
 		if (ret)
@@ -955,11 +970,12 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, pdata);
 
-	of_q6asm_parse_dai_data(dev, pdata);
+	rc = of_q6asm_parse_dai_data(dev, pdata);
+	if (rc)
+		return rc;
 
 	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
-					q6asm_fe_dais,
-					ARRAY_SIZE(q6asm_fe_dais));
+					       pdata->dais, pdata->num_dais);
 }
 
 static const struct of_device_id q6asm_dai_device_id[] = {
-- 
2.20.1

