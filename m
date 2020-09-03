Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3FC2D0A8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA572071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z299lBM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgICUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgICUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB8C061246;
        Thu,  3 Sep 2020 13:30:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so4138945wmm.2;
        Thu, 03 Sep 2020 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGc0yXuTiDFTGIiyB8RKG2RROl6pKeDEVLqeD/qlySQ=;
        b=Z299lBM+zeS6T63IlyOyPftevP++hmKvFRve7cd4JLiV0g+AYfED1OpJPoqyClpKLQ
         U4Cof/TLllguqcQpEBBuN6xdrbHUMJfRX5bVgum+js04Lk9ImuC12dH6jB8dWDn51kQ9
         pMApAk3W8s+0AByLZH9G+/sNsUIgWp/aMqi+WwnmNN0c5NYb0FfPWqQ5tmh8tqbICh+4
         qc6zFWPKemXHt5jCTYvkFOaFXVf5vs7GnI4hVF5Wj+UM+EfxqqgpSMtyiaT+EPgTrl3F
         8tuR95Hr4GboBN39VxpdIDhNwRrFXju/NDQ2HEAKgOUNeeVu4G1kgms0U1qKOjy32U7C
         c0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGc0yXuTiDFTGIiyB8RKG2RROl6pKeDEVLqeD/qlySQ=;
        b=nM/STBoKMTMVQQ2lPW65mrLZriBL1iKEnFFEqJe4ts5tcxrTKwykkaJKOdkHXYZGA0
         yiEWydbTP68sxd/YyDNWFhLEx+AFKmL7VL2oRC+F6cb3qZhBazrWFVX+v2HnJsC7vtUc
         t/2W6i9wr5MHP0+hS4Cp3+9fYVuIOXcHuSXP6NNQ1+2ZMPbkrDJK4FafWbqqMwi88eXK
         excvRcLSOZnaGxW7T1Zedyd7W6UYMD4oVHe5/Eye3eaOBruxnPvpMVA5HxEpjvYWNaWT
         jj/vETVHFTY/DHnO5Tb2kuOjoc9da2nl/otKWNW+5scPAMLxVdBsx2hYZE9cugoUVZGv
         mwmA==
X-Gm-Message-State: AOAM531+PA74L+YStCQoyAnJQoBNuIr+K+KBPBfkBC/E8q79MLkHgduI
        Cr4fIQs/cgXeB7bQID5tNjA=
X-Google-Smtp-Source: ABdhPJxQ7DZ6I7oOzap9bBKEMFXCm/suuPFfs+wc6lgap5FkPRR1GPgiwQFHEnBKqx2fZHFh/ybsYw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr4186180wme.8.1599165047136;
        Thu, 03 Sep 2020 13:30:47 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:46 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 03/20] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Thu,  3 Sep 2020 22:30:17 +0200
Message-Id: <20200903203034.1057334-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
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
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index acf24f512f2c..1b4482b0f4af 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -478,6 +478,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		return -EINVAL;
 	}
 
+	if (i2s->slot_width)
+		lrck_period = i2s->slot_width;
+
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
-- 
2.25.1

