Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCD220774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503466AbgDNSM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:12:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47030 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503521AbgDNSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:12:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6E7F92A1BE3
Received: by jupiter.universe (Postfix, from userid 1000)
        id 22FA14800F7; Tue, 14 Apr 2020 20:11:56 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] ASoC: sgtl5000: Fix VAG power-on handling
Date:   Tue, 14 Apr 2020 20:11:40 +0200
Message-Id: <20200414181140.145825-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned slightly out of patch context in the code, there
is no reset routine for the chip. On boards where the chip is
supplied by a fixed regulator, it might not even be resetted
during (e.g. watchdog) reboot and can be in any state.

If the device is probed with VAG enabled, the driver's probe
routine will generate a loud pop sound when ANA_POWER is
being programmed. Avoid this by properly disabling just the
VAG bit and waiting the required power down time.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
2.25.1

