Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5708EC5519A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365ED2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxOaNN/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgDZKl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgDZKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8547C061A0C;
        Sun, 26 Apr 2020 03:41:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so16963470wmh.0;
        Sun, 26 Apr 2020 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAlZaoiz7z+tk4BIsyEyQrq2oirv6iyn95ommhRUilY=;
        b=XxOaNN/oo6lGOklyj3NhlxlRBrpy6ioLx03ck5H7GDVdAatidgptZbQhVYKoFQUDi3
         FCUzUHP79DXtjqILxaIJW+6CJCmkVduNIuax/2ZpwbQUuCmcw+p5icAV0ZGwUO6V/T4O
         +x73v9seqJyyynz+dOZay78b9PduueemgmNl02zL101gmzIbNvb/aSrXrEPa0japWipe
         RRGcK2ho9iZUXeFMfjE9h1IR7E755by6WlnJbgQBuYgLD3UOgGI77PLGD790nG3Iy71n
         mNtp8zfsula8jRMmEdavc4P4/FXRwcrrDDpgsxD+pDzNNHwN3NVacC+d9dn9ieH0Deub
         7cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAlZaoiz7z+tk4BIsyEyQrq2oirv6iyn95ommhRUilY=;
        b=a2EZFLpFY2ft7hMR1cO15ULCZUvSucxLQX88DUGP2rq9oBQzD2ibPDEbVp2ELIjZyf
         F/XzXE1QAE9sNBv7qJltqs8Un/sQYiRtCYYrfZZo+ZSqdD/YeZhO567N/JTgKQH/KOF2
         l5+3FCpCUvdzfOxrN3b7D8FKKa6kJVhC09W+i4VzCEmDV6dfmwTV/AHK33NSwjMVSLuh
         x7bRiLsXuDU2w5cm5jQFOLoP3cXv25EVmyI/3gUPpLksKKeD3IBoKNdgl6GfZFEI41u+
         KI6N4ci1TbLKd6EbQTuEEsvnqftE1w3mhMT752eSYbcWiNQN8pcagFfpgBJpdwwDtgjg
         QrzA==
X-Gm-Message-State: AGi0Puaz4VJBHhjBQ6fZccmID/d3efkPwfl7Ba7GAVeqcs5Bu0YEmhKW
        s6EtA9hLttLk5KZVOSNmXwhodVQWP5w=
X-Google-Smtp-Source: APiQypJR0tbWFtI/ZGUUxkQxM0jdyUfgqcf8Wm4A/N0MbV5/pxHiPiYcFnu42+NFJFOkHcIIx5G7kw==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr20798240wmf.16.1587897683345;
        Sun, 26 Apr 2020 03:41:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:22 -0700 (PDT)
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
Subject: [PATCH v3 4/7] ASoC: sun4i-i2s: Set sign extend sample
Date:   Sun, 26 Apr 2020 12:41:12 +0200
Message-Id: <20200426104115.22630-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

On the newer SoCs such as the H3 and A64 this is set by default
to transfer a 0 after each sample in each slot. However the A10
and A20 SoCs that this driver was developed on had a default
setting where it padded the audio gain with zeros.

This isn't a problem while we have only support for 16bit audio
but with larger sample resolution rates in the pipeline then SEXT
bits should be cleared so that they also pad at the LSB. Without
this the audio gets distorted.

Set sign extend sample for all the sunxi generations even if they
are not affected. This will keep coherency and avoid relying on
default.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a23c9f2a3f8c..8ea08b49e7fe 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -48,6 +48,9 @@
 #define SUN4I_I2S_FMT0_FMT_I2S				(0 << 0)
 
 #define SUN4I_I2S_FMT1_REG		0x08
+#define SUN4I_I2S_FMT1_REG_SEXT_MASK		BIT(8)
+#define SUN4I_I2S_FMT1_REG_SEXT(sext)			((sext) << 8)
+
 #define SUN4I_I2S_FIFO_TX_REG		0x0c
 #define SUN4I_I2S_FIFO_RX_REG		0x10
 
@@ -105,6 +108,9 @@
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED		(1 << 7)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL		(0 << 7)
 
+#define SUN8I_I2S_FMT1_REG_SEXT_MASK		GENMASK(5, 4)
+#define SUN8I_I2S_FMT1_REG_SEXT(sext)			((sext) << 4)
+
 #define SUN8I_I2S_INT_STA_REG		0x0c
 #define SUN8I_I2S_FIFO_TX_REG		0x20
 
@@ -663,6 +669,12 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	}
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 			   SUN4I_I2S_CTRL_MODE_MASK, val);
+
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN4I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN4I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
@@ -765,6 +777,11 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
 			   val);
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN8I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN8I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
@@ -867,6 +884,11 @@ static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
 			   val);
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN8I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN8I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
-- 
2.20.1

