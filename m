Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4456C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C5D2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255900;
	bh=bQT96VQvGrM0SnF9nv2ZHHxC/VoVHwjpVFK5h8byZS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0RPFKGn3SghX257GqSbPpNr3JvtbHP/BSraHxc1bPKI8SS7fay1EweGKLFgft9H5V
	 QHnBfMahLuEFgqgt6HqkbgoQINwkNhv7IXM118L8gDHKjxlBDyXKQQHl+LAW3WFaw4
	 IeBA12ZB38MJuLu8l20heWeWBvtcbnONDwcPbzDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgD3NvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgD3NvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCB820870;
        Thu, 30 Apr 2020 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254672;
        bh=bQT96VQvGrM0SnF9nv2ZHHxC/VoVHwjpVFK5h8byZS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRtC68YEUPX8t0bcOeTzeaPjyZIjgk65aRNginuH0JQ3enG50hlkw+vLqdDVTt3EV
         X6Ja2AfVRPsP6nUTECuwO6aTGDf7KT8L7uPeLCKuB1/XblomicfomCIMRGhJV9ypuB
         UzQXVEGB2/YmY5lFvqlRbcmwfpBSTqZ+odAgrB8g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Fabio Estevam <festivem@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 24/79] ASoC: sgtl5000: Fix VAG power-on handling
Date:   Thu, 30 Apr 2020 09:49:48 -0400
Message-Id: <20200430135043.19851-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit aa7812737f2877e192d57626cbe8825cc7cf6de9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 34 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sgtl5000.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d5130193b4a2f..e8a8bf7b4ffed 100644
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
index a4bf4bca95bf7..56ec5863f2507 100644
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

