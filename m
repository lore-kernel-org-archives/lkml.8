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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD3C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBAA21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8cF3XH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgDRWon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411BAC061A0C;
        Sat, 18 Apr 2020 15:44:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so7407958wrs.6;
        Sat, 18 Apr 2020 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=c8cF3XH6qZJcJPkN9nADZfE8ZdxqJJNLek9MBPzd976KNgLjfAOvhXssjXgfR0qUXZ
         z5SbODX1HI8kSbTahGSNYROR6DUal2jkuISdlMolZvPcEr70LFjcykcK1MP0UOcKBhIU
         Ff5QtHea/ZcWq77sRWFG1qP7w6fn1pfjPGu5tFfutPE2Hj96sJkLdvi4XAKDYYyMKNqx
         R00g3cSrpQeA/7DOSY1CCSiEIqPbTrTVBzDoq3hp++7L21hPafhxjXx5u7ZowEpl0AKz
         t2dofmvt7RGD5O8ClZ3VCGllQKrDMZ7oHQNsKAdP0RKpixpqN3OalmxOd//da9ZJC8dw
         C0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=Nppv0I2w6G0BF97L//1icXp38FyQd8VhI/EtAsC77m3C9Jf7Y4B3dspERDtW5AMkr6
         iqpkuRGXCBvX0K1ll4ZaAPQUvGx2RUCI9Za/oYOBe35wl8J6AIbdM7FTjhAlbJz5/ZG6
         AVReIF7x+IFFe2aKgCn2Rytl3SVzS+hhd6mqQotHK1CBFO6NIaP5/iB+CbEQoz9UvM8J
         VKtcroXrpd+l66Ww6O3cbgpV6WdI/cKFDs6gZuce457hd5eOBvpriB+rOosJ+0tG8I2/
         vox0z7G7iVYOOBBTsRTL8hwjFVxnH6855amaJia2+P3xe4prj03FY/eE3wsGeYEaAM5N
         1Aiw==
X-Gm-Message-State: AGi0PubheRUnA9Iybmid8g02xWZZjTaJO0Krma33kW253ZVvHSw4xeOK
        8dnbgJK3AKJ7xOnHqCVO/oM=
X-Google-Smtp-Source: APiQypLzc6502sCH/dr5KEi1k3BQRUxUNmwEVNQJvwCGsDJys1dWkVAT0BXLftMcmhDCZMKxtYFX6Q==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr10337697wrv.87.1587249879909;
        Sat, 18 Apr 2020 15:44:39 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:39 -0700 (PDT)
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
Subject: [PATCH v2 1/7] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Sun, 19 Apr 2020 00:44:29 +0200
Message-Id: <20200418224435.23672-2-peron.clem@gmail.com>
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

