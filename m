Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D27C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1AF2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070185;
	bh=phdX10EbQs8XHpNHIWm7HtuHu+ZagE7py/+TI7E//N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=WYAi1XQFf8+0QeWHQQLhy0tnI2Ht/FF2hYMkJsEF0aPZwk+8TCe3uqLg7d8n1WI47
	 PNAnwsSTqK2ZZxXoTfJC/hIpzyhyZJ3qSJqsAYIeqNSRa2WQ3ETYFBBw5wbQuychJO
	 fbF126Uswfleav+50U1rbdotn1RzweiJqww74j0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgCXRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:24 -0400
Received: from foss.arm.com ([217.140.110.172]:38500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbgCXRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B19B1FB;
        Tue, 24 Mar 2020 10:16:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1B53F71F;
        Tue, 24 Mar 2020 10:16:21 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:16:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Subject: Applied "ASoC: jz4740-i2s: Add support for the JZ4760" to the asoc tree
In-Reply-To:  <20200306222931.39664-5-paul@crapouillou.net>
Message-Id:  <applied-20200306222931.39664-5-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740-i2s: Add support for the JZ4760

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

From bde8ca7c87d4388e24195f6c84cd9ac775344d2b Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 6 Mar 2020 23:29:30 +0100
Subject: [PATCH] ASoC: jz4740-i2s: Add support for the JZ4760

The change of offset for the {rx,tx}_threshold fields in the conf
register predates the JZ4780, and was first introduced in the JZ4760.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20200306222931.39664-5-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 3f9b2e1b4747..253f8d8ba273 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -49,12 +49,8 @@
 
 #define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
 #define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
-#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
-#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
-#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_MASK \
-			(0xf << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET)
-#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_MASK \
-			(0x1f <<  JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET)
+#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
+#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
 
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
@@ -90,6 +86,7 @@
 
 enum jz47xx_i2s_version {
 	JZ_I2S_JZ4740,
+	JZ_I2S_JZ4760,
 	JZ_I2S_JZ4780,
 };
 
@@ -403,9 +400,9 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
-		conf = (7 << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
+	if (i2s->soc_info->version >= JZ_I2S_JZ4760) {
+		conf = (7 << JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
+			(8 << JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
 			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
 			JZ_AIC_CONF_I2S |
 			JZ_AIC_CONF_INTERNAL_CODEC;
@@ -467,6 +464,11 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.dai = &jz4740_i2s_dai,
 };
 
+static const struct i2s_soc_info jz4760_i2s_soc_info = {
+	.version = JZ_I2S_JZ4760,
+	.dai = &jz4740_i2s_dai,
+};
+
 static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.remove = jz4740_i2s_dai_remove,
@@ -499,6 +501,7 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
+	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
 	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
 	{ /* sentinel */ }
 };
-- 
2.20.1

