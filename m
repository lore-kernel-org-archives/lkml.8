Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C54DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA2624963
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942340;
	bh=hdhau5x237LBx7BVJYuRDozB3xA1U7LTwu5kqngl8TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2o9Y7U/QoWItJDq1nwdcnBF7hwFac383K/OdhHmKTporrDgUFNgnvrKyhBwgqyGXV
	 n541PrzewgzSJ5XdXKzckmHoyBJ9rERCCxd+ZP6BzPNWBcIuCtQ/ZGS3Zgu9voVxXz
	 Xzss+Y5aeYDUk/x3/5wkIUnVqDdltwYouDHZCBvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgEHMwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbgEHMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3939A218AC;
        Fri,  8 May 2020 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942312;
        bh=hdhau5x237LBx7BVJYuRDozB3xA1U7LTwu5kqngl8TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d37ZXudMAtG7cbwrQji6niJhmVDV2GxDpUalgpVjNdNbRzk2k7pD0qeqD3BS/4ZZL
         1fYBc/wjiHdQgXwWRStzyQ4gAi5B5z0pJyRhzZv0OyyB9B5LU8YbwY1DZufJQU70V8
         bVCGbyZ2wHTMQBOVQnSPfFqWOKeWJquGBcl96edc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Fabio Estevam <festivem@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/32] ASoC: sgtl5000: Fix VAG power-on handling
Date:   Fri,  8 May 2020 14:35:18 +0200
Message-Id: <20200508123035.505300470@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 896412d11a31c..7c0a06b487f74 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1633,6 +1633,40 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
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
index 18cae08bbd3a6..066517e352a70 100644
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



