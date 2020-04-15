Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04DC38A2D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9709C206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952464;
	bh=T8pZkTaDHImqwJ86Evn/kitbk35NPo627KNyM6vX0gI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jgTExSOJZ9KN4W70fk2uKE3JXLsfiNADwYMLns47xMVtGO2evU9L9nfe+FKAvRdcj
	 Ob8p4UQGe+pAhDCwrfbPnlVX8s4RTINMsypiW+V2ZUOnwQAFAdv+O1JaEc5B/RmCS9
	 U5iJyhCQXBeYbe6/9XRKuf9GC8ugU/xtvXyCUt9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441232AbgDOMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368114AbgDOMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:00:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8186120737;
        Wed, 15 Apr 2020 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586952049;
        bh=T8pZkTaDHImqwJ86Evn/kitbk35NPo627KNyM6vX0gI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mptKzifq+PHSnyWRuMEP8eVpvVICk394IDrONGAn8Ee8ZDXY7EYoee35akOJnVBIe
         L0tfKKifvRBouewAIAOEkSQZ9pcAr0SiptUCu8LW5oWckKpL9TEDX7HPANyuJXCDhk
         SpJjyRX0HwmT3r2q3L6liRw0TooblHJcDvjPqmDw=
Date:   Wed, 15 Apr 2020 13:00:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Fix VAG power-on handling" to the asoc tree
In-Reply-To:  <20200414181140.145825-1-sebastian.reichel@collabora.com>
Message-Id:  <applied-20200414181140.145825-1-sebastian.reichel@collabora.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sgtl5000: Fix VAG power-on handling

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

From aa7812737f2877e192d57626cbe8825cc7cf6de9 Mon Sep 17 00:00:00 2001
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 14 Apr 2020 20:11:40 +0200
Subject: [PATCH] ASoC: sgtl5000: Fix VAG power-on handling

As mentioned slightly out of patch context in the code, there
is no reset routine for the chip. On boards where the chip is
supplied by a fixed regulator, it might not even be resetted
during (e.g. watchdog) reboot and can be in any state.

If the device is probed with VAG enabled, the driver's probe
routine will generate a loud pop sound when ANA_POWER is
being programmed. Avoid this by properly disabling just the
VAG bit and waiting the required power down time.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Fabio Estevam <festivem@gmail.com>
Link: https://lore.kernel.org/r/20200414181140.145825-1-sebastian.reichel@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 34 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sgtl5000.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d5130193b4a2..e8a8bf7b4ffe 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1653,6 +1653,40 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev,
 			"Error %d initializing CHIP_CLK_CTRL\n", ret);
 
+	/* Mute everything to avoid pop from the following power-up */
+	ret = regmap_write(sgtl5000->regmap, SGTL5000_CHIP_ANA_CTRL,
+			   SGTL5000_CHIP_ANA_CTRL_DEFAULT);
+	if (ret) {
+		dev_err(&client->dev,
+			"Error %d muting outputs via CHIP_ANA_CTRL\n", ret);
+		goto disable_clk;
+	}
+
+	/*
+	 * If VAG is powered-on (e.g. from previous boot), it would be disabled
+	 * by the write to ANA_POWER in later steps of the probe code. This
+	 * may create a loud pop even with all outputs muted. The proper way
+	 * to circumvent this is disabling the bit first and waiting the proper
+	 * cool-down time.
+	 */
+	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ANA_POWER, &value);
+	if (ret) {
+		dev_err(&client->dev, "Failed to read ANA_POWER: %d\n", ret);
+		goto disable_clk;
+	}
+	if (value & SGTL5000_VAG_POWERUP) {
+		ret = regmap_update_bits(sgtl5000->regmap,
+					 SGTL5000_CHIP_ANA_POWER,
+					 SGTL5000_VAG_POWERUP,
+					 0);
+		if (ret) {
+			dev_err(&client->dev, "Error %d disabling VAG\n", ret);
+			goto disable_clk;
+		}
+
+		msleep(SGTL5000_VAG_POWERDOWN_DELAY);
+	}
+
 	/* Follow section 2.2.1.1 of AN3663 */
 	ana_pwr = SGTL5000_ANA_POWER_DEFAULT;
 	if (sgtl5000->num_supplies <= VDDD) {
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index a4bf4bca95bf..56ec5863f250 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -233,6 +233,7 @@
 /*
  * SGTL5000_CHIP_ANA_CTRL
  */
+#define SGTL5000_CHIP_ANA_CTRL_DEFAULT		0x0133
 #define SGTL5000_LINE_OUT_MUTE			0x0100
 #define SGTL5000_HP_SEL_MASK			0x0040
 #define SGTL5000_HP_SEL_SHIFT			6
-- 
2.20.1

