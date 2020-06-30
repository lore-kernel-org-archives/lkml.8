Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1042C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB533206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGpitUnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgF3JQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbgF3JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:16:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E58C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:16:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j12so9149929pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rd5iEUzyhkHEGXF29pak/hhB1EC5ycMxxyjQQksAAqY=;
        b=TGpitUnXwHKi/7l9y2kirXGLuOu95q2WsJQIWx2gn6HmUOzZRHlv/rlVSHSscwZ8kO
         AWvctomRCfaXqs2PK7ouUWeHgZg28RgwQSbDk3UoZKVdLm1cSAxnWuNvj0FeTwoFOl2D
         kHAgkHFtTyvVaIkNA3gVCvEE0SQWezS2ndkoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rd5iEUzyhkHEGXF29pak/hhB1EC5ycMxxyjQQksAAqY=;
        b=jVEH6ow4xxq+iWizITmV4PVcyBiyh7i0tbkX4nKXs9eofG0tkQpFxqWrZ/0axYEeYK
         rtXvGPaiA1MuBrmyp1XbZq+w+Ydor1085zVL9FnVeQQAK0dXQSSbu9WeYzfpnNzC/5UI
         UoDvmEupHuJIN4cQpo5K8AjNsyGVWoEeuwtbRiGhFU3/V+YrwvdiXnIOzsR8m4i2vwWh
         tmTfHAeXMY3qQ4Mf/haJhdaSkKhxTaRUbo/eZUNpE2+TDvAED881VOIX+KMaKLvEKYy7
         hQU0UOyVLMGYcukz+x0TPze9ftSA1JLYvMwZbQNLsCFUSExrxTmTk+R1tdGmvqlFHbWz
         3LWw==
X-Gm-Message-State: AOAM531t7VKUzYwZRwFbVzeIFPpOYnKYe9RycC/V66D88Ceck2dpFqzC
        sdLIDGt3YeT9BkvAI8HldOgnCU4LJXWxEQ==
X-Google-Smtp-Source: ABdhPJzB0kxAs3Rg/ffbxdy/cFXz9S5fvLhyfDQ8RVSkxRv0SuSfKCfoSQnEObJ51pxzQORK5k+Sjg==
X-Received: by 2002:a63:5863:: with SMTP id i35mr11672772pgm.390.1593508583749;
        Tue, 30 Jun 2020 02:16:23 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id q13sm2142575pfk.8.2020.06.30.02.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 02:16:22 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: rockchip: add format and rate constraints on rk3399
Date:   Tue, 30 Jun 2020 17:16:15 +0800
Message-Id: <20200630091615.4020059-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S8 and S24 formats does not work on this machine driver so force to use
S16_LE instead.

In addition, add constraint to limit the max value of rate because the
rate higher than 96000(172000, 192000) is not stable either.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index f45e5aaa4b302..9539b0d024fed 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -219,19 +219,32 @@ static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int rockchip_sound_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	return snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+			8000, 96000);
+}
+
 static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
+	.startup = rockchip_sound_startup,
 	.hw_params = rockchip_sound_max98357a_hw_params,
 };
 
 static const struct snd_soc_ops rockchip_sound_rt5514_ops = {
+	.startup = rockchip_sound_startup,
 	.hw_params = rockchip_sound_rt5514_hw_params,
 };
 
 static const struct snd_soc_ops rockchip_sound_da7219_ops = {
+	.startup = rockchip_sound_startup,
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
 static const struct snd_soc_ops rockchip_sound_dmic_ops = {
+	.startup = rockchip_sound_startup,
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
 
-- 
2.27.0.212.ge8ba1cc988-goog

