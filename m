Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB6C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0585621D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIOfImqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgDRWow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgDRWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB2C061A0F;
        Sat, 18 Apr 2020 15:44:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so1986236wrt.1;
        Sat, 18 Apr 2020 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DdH07t1k9/y181hGinDV6UTR/Vqce1FXEwc4JDSNUgo=;
        b=NIOfImqp3qpMP3D9X6b+JfPw8bgsFJJLKGc6iM/svj0msjDwQB4NHHi3x6j4+/9LfH
         w1b1LK8t9l4uX6A46YGmQt9P7ru+6QI+xL5hGLIjDyhD96hkoA66gyw/Pv/5p18m5+Y4
         xRY0pBCRDt+5PJPsr7ebb/yiZLIhYulHfqXCtzMBkh3q/WYyNJa04dmF8j/pJW6NXyJN
         vevvk/QIj/SNZsEVXrY4FSFbnO9mofuC1CQR7oEzIEaF0jiBTZyZoTXhwAvlz3/ErcIh
         asUcS5rQUe+zij5OFyhR3VRoF3JCU71k/uGoT6ZnsFLFFlpK3aedMIrs0DB8za7JPK7y
         bQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdH07t1k9/y181hGinDV6UTR/Vqce1FXEwc4JDSNUgo=;
        b=WPDHdrZAzS6uIB7jMHpY5b2nWcaJfvPelnLHiVC2/lh5+TJsehJdh3mxLHrvj+g5iQ
         LOTnT8RZYpxrumZWmXHFhnHBCbIWDh2Wgdvsee8kAYCZity4w3P1YUa9hvUPw/dJeLPZ
         fkKc9pD3bfu5e6kNNojLw4gHqKUs6oPjdsVAlbIqFMq4FW5uEDDjK1Q5VTbgHPe5yQSt
         NPRJmpCVCLv1H3XxRKFzsCfMSPbDm8wZEuHmoCFfIERQKflSmtIEqRrubt1VZtC1l5/b
         YAKBBTXr1Zu23MDsSShk4QMtk/sF5gq6gu4mjpdBu/3TUcM8F84Q6zaoRbcDpQ/fjdaR
         +u5g==
X-Gm-Message-State: AGi0PuZzdu0lqMQ8hqzeWMHnomRvAgZKCDPqY285RsMUvJM7QPLT42FB
        Qy6JBSBYUhz7/T4meerMQc8=
X-Google-Smtp-Source: APiQypKLBSnMaQwSZzz/e93DLQSKm39F96CERmHmKiJfEdeWuhNhNE+Fk3LRWI+U1wVer5IdoPcLQg==
X-Received: by 2002:adf:f084:: with SMTP id n4mr11151919wro.252.1587249887329;
        Sat, 18 Apr 2020 15:44:47 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:46 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 6/7] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Sun, 19 Apr 2020 00:44:34 +0200
Message-Id: <20200418224435.23672-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418224435.23672-1-peron.clem@gmail.com>
References: <20200418224435.23672-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
to reflect this.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9778af37fbca..9053d290dd87 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -921,7 +921,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 {
 	/* Flush RX FIFO */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+	regmap_write_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
 
@@ -942,7 +942,7 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 {
 	/* Flush TX FIFO */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+	regmap_write_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
 
@@ -1096,13 +1096,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
 
 static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case SUN4I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
+	return true;
 }
 
 static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
@@ -1121,6 +1115,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
@@ -1131,23 +1127,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case SUN8I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
-}
-
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	if (reg == SUN8I_I2S_INT_STA_REG)
 		return true;
 	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
+		return true;
 
 	return sun4i_i2s_volatile_reg(dev, reg);
 }
@@ -1218,7 +1203,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
 	.reg_defaults	= sun8i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
@@ -1231,7 +1216,7 @@ static const struct regmap_config sun50i_i2s_regmap_config = {
 	.reg_defaults	= sun50i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun50i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
-- 
2.20.1

