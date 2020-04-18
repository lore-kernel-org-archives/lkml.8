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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E3C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82FB21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFNSOPep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDROjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDROjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57FC061A10;
        Sat, 18 Apr 2020 07:39:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k11so6372476wrp.5;
        Sat, 18 Apr 2020 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=VFNSOPepRO8LhHnCsEQL9MS6dTL5kqLw8PsSoFR/IqpGp4vIfHp7KkZ1uMf4VH1+L+
         q4tVepabnjhTmwyy8YKwI+NH5WJ/fSdupt4yspBkUczo1nVyHM0KyeJILornWmV/r08Q
         ku6GjZ1rIZCZIv2j045VNzd4Yj4Ly9xUvNQNB1c+vowUVT85JsQkv6dII88jTS5Dt0ob
         4e6q88RkoiFpChLzn47Q53BS7ycM235VpgDCcDwyk28GCfraICXPGXiATmwNV8AjQA/a
         ajuI93Rr95PSIWe0pCDg/R45RTTkAeDFhbtezQGd8Yyeve4x9pGR8BagKsRYB7j/APch
         Exbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=J5gqxdg4ieeO/CNkDpWJZZx2LuuYW3A2qhHxBjZ9xYjaxOZ6kyNitDDSO9HW3uHnIC
         0pI2xQoG2M5d7qRgprl8fzu6zx8oDlAye8DNSHc4/DI9HXTsm431WLE7DiT7lfHlGwF/
         tFoPWOo4vP8PQ9uvtSeNm8kHdyF4ZHTPrjC7h7MQv00pcmvJOHtlbFTYftYmbXwF3Wjc
         6tWzJR+5BtxLShYD+9qB45m19pWILLtJ0QTRSUN2ftySVRNBxDEbH/zSKEUn+OlNJeS1
         hn+6n3phsx2bMVHfHG55I/LRO4NywQAbJKTI/LPT1GD5hxL37KznQztWvD+CmhN4R4D5
         si/w==
X-Gm-Message-State: AGi0PubXc4MR60Ep5ZxzMdf468wmElRGyJfKuYKln/PUjcXrnP8wN+e1
        mvsNnEm/KPfGcfWnY9UGSDM=
X-Google-Smtp-Source: APiQypJuUCkFiPwqfns+vAkEj6LuyE3CN+CHAPCJKI9sRF2HzFfQQW4yZlrPaWVbC5uK0hNjDwIsnA==
X-Received: by 2002:a5d:500b:: with SMTP id e11mr9191160wrt.272.1587220768520;
        Sat, 18 Apr 2020 07:39:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:27 -0700 (PDT)
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
Subject: [PATCH 1/7] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Sat, 18 Apr 2020 16:39:17 +0200
Message-Id: <20200418143923.19608-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418143923.19608-1-peron.clem@gmail.com>
References: <20200418143923.19608-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Some codecs such as i2s based HDMI audio and the Pine64 DAC require
a different amount of bit clocks per frame than what is calculated
by the sample width. Use the values obtained by the tdm slot bindings
to adjust the LRCLK width accordingly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a..4198a5410bf9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -455,6 +455,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		return -EINVAL;
 	}
 
+	if (i2s->slot_width)
+		lrck_period = i2s->slot_width;
+
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
-- 
2.20.1

