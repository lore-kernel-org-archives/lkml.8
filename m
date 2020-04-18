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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6116CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7CB21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbAoSbAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDROjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgDROjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BDBC061A0F;
        Sat, 18 Apr 2020 07:39:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so5159863wrw.7;
        Sat, 18 Apr 2020 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nS1Dh0dVCLU/Z6QcUpBzyWAuOru5+9aARHs3DkttnVE=;
        b=MbAoSbAc3D2+nJFIYEQeQQ/dHol3lD3ZutnkM2xwFwzOJdrCCCkOEVVcrcRQ62eV4g
         4mjR5SK5RiTtI+vgC8VsFBlN1uCx9tcGSTfJBpDFEwsNGpwCv8XxQLPHy5rX3pNcgXN8
         /H2nvjvJ7mQPsaRM/fi64I5nwdOKmQWqDDVP3L139dvKTbRby3Zz/s9icjPUnKDQdRLz
         5F0gIPt7vg86Vvcf6VhT9IwBi6un67axwSATzhZ5QtyicCU+yU9SLZgjNDyPUoYrwqY0
         FhB+3EleruV/2WjbvlpwwJBrPEdCmFQS2DEcQ4uVkLMe35d9SVZk+EZE1CHkdX68P+eP
         AHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nS1Dh0dVCLU/Z6QcUpBzyWAuOru5+9aARHs3DkttnVE=;
        b=b4bm+nRDB7QQFSWbo1SwredvTvlgdu+RTiXqygDrQlmyww9qSYZmqX2hqxjuHjvAIe
         JwUnu39i/8W+z4zjhpeqxVoVLxj/PsXeO8nCbMUeJtrn2Z7dCfopi6iiv4sbT5ZNrT12
         EPSjPUDDr3tNExnezWqp8rIFHZKGr8obCTO3Z3NVWYB86U/SLMrFQyyZFW6Jyu5U+mZP
         BJw6OL9digmQ0i0Z19K8ulDAlngPQOK/meYdJ+Y2RUa7Af+CXpOMzYwVC8MJ4Alz6jbW
         HufU/MdnKhvdzR26dQgn00C2+YzSORTbOtWoJkGiDdxdUMIsRh8SXseUBR4SjlV9NumZ
         TbQA==
X-Gm-Message-State: AGi0PuZE6PIrVcfGVKXcq7k1eEkO3jr/gFQYcaoOfDs3CjKtsy6dHoPl
        Lsc7XDfaNVIP9Igwmi4WKUc=
X-Google-Smtp-Source: APiQypKmRFkljkLfEDZwaNdb9gqp2zspKzPItWN+bdHyeoJEPtnPaZGdrFscUEGHdJTSLu1NGSDfQA==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr9205532wrq.368.1587220771345;
        Sat, 18 Apr 2020 07:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:30 -0700 (PDT)
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
Subject: [PATCH 4/7] ASoC: sun4i-i2s: Set sign extend sample
Date:   Sat, 18 Apr 2020 16:39:20 +0200
Message-Id: <20200418143923.19608-5-peron.clem@gmail.com>
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

On the newer SoCs such as the H3 and A64 this is set by default
to transfer a 0 after each sample in each slot. However the A10
and A20 SoCs that this driver was developed on had a default
setting where it padded the audio gain with zeros.

This isn't a problem whilst we have only support for 16bit audio
but with larger sample resolution rates in the pipeline then SEXT
bits should be cleared so that they also pad at the LSB. Without
this the audio gets distorted.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a23c9f2a3f8c..e5f00be8cdcf 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -663,6 +663,12 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
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
 
@@ -765,6 +771,11 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
 			   val);
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN8I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN8I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
@@ -867,6 +878,11 @@ static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
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

