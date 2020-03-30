Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ECEC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB5320733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh689xve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgC3Ums (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:42:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37238 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3Ums (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:42:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id t11so2992436lfe.4;
        Mon, 30 Mar 2020 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UkrNjDcajPGTgBBKiQQcXEwPOc4ohLFowCr4Ks0haU=;
        b=oh689xveR36/57W4/RPGauOKst42L1S+MXOTtXleBkLzOiJ+NL6bEEF08gPLfBCf0w
         9Pjkq3FiUE6g4iYJ8R39BdR0UWMSKcTcSnno1jANPY0fk/zWl1BAJFlujrzpTgHKkSGV
         gObEjTicF1K/HwtUIdhfSUayjN79qoBwC316M9dZthNujLGmduxoHiokK5om+GbTi3AS
         L/Dxvq4qgEZhv5U/aZrx6fSyXGwCCMliWGEcViF4NUEropR1GG3/uqfvnR5+yzLKHgyT
         aXNT0WT7NKJmJsVH/dDsGFZR3FUZqlExP3CH+UOkUsLNUYXSPO1fGkEna1DVIH04DUpT
         cdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UkrNjDcajPGTgBBKiQQcXEwPOc4ohLFowCr4Ks0haU=;
        b=Ic/hZaz/uAexoa0HZLzld/MMF5y7Tw7yJmr4NZJ3uSxeJD5x6vRlQMOFhveLwI+WqZ
         s4vCPScwKsqSFNKxCFnxjFM8RQu0FRWTlOIq3ghgSzLOiu9wAiqyrv16GF2Fj3RW+I+3
         qizMyTZPeeaqQYFqVlLkw/3X4gL+BdmdKUWqY4925am/5yI1tIyTwqFsV33CI6skfF4D
         6lNG0w+n0F9yO+jn7Q0g14+5Q+l2g9AAZ/Ql0zjxWD+HsdhwJ25hkUKb4YUSY8YXQmYq
         QsomhrGP1XWqY/8rW4rmtRBAYHWvX22FfIaKMZanNS0EVglj1ETqTA98FvKpk5KldFWo
         b5XQ==
X-Gm-Message-State: AGi0PuYVWkFacdYk0Lflwlv2lu1ge1r6hbJc1aHFVjRumsdUjQexZUef
        XYTKbr9ml+KXkV8N87pMFjU=
X-Google-Smtp-Source: APiQypLLLnVzRTLcP4jabC1fU1WzfNOMcZ3hKwFpODI7tRHqByybGrOo5XBHUG6/XotAfAYXhdyTvQ==
X-Received: by 2002:ac2:4c88:: with SMTP id d8mr9381636lfl.100.1585600965414;
        Mon, 30 Mar 2020 13:42:45 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id v22sm7287988ljj.67.2020.03.30.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:42:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ASoC: tegra: tegra_wm8903: Support nvidia,headset property
Date:   Mon, 30 Mar 2020 23:40:11 +0300
Message-Id: <20200330204011.18465-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330204011.18465-1-digetx@gmail.com>
References: <20200330204011.18465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone-jack state needs to be masked in a case of a 4-pin jack
when microphone and ground pins are shorted. Presence of nvidia,headset
tells that WM8903 CODEC driver should mask microphone's status if short
circuit is detected, i.e headphones are inserted.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra_wm8903.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 071c7d2de77c..e756dc8eeca4 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -177,6 +177,7 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = codec_dai->component;
 	struct snd_soc_card *card = rtd->card;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
+	int shrt = 0;
 
 	if (gpio_is_valid(machine->gpio_hp_det)) {
 		tegra_wm8903_hp_jack_gpio.gpio = machine->gpio_hp_det;
@@ -189,12 +190,15 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 					&tegra_wm8903_hp_jack_gpio);
 	}
 
+	if (of_property_read_bool(card->dev->of_node, "nvidia,headset"))
+		shrt = SND_JACK_MICROPHONE;
+
 	snd_soc_card_jack_new(rtd->card, "Mic Jack", SND_JACK_MICROPHONE,
 			      &tegra_wm8903_mic_jack,
 			      tegra_wm8903_mic_jack_pins,
 			      ARRAY_SIZE(tegra_wm8903_mic_jack_pins));
 	wm8903_mic_detect(component, &tegra_wm8903_mic_jack, SND_JACK_MICROPHONE,
-				0);
+				shrt);
 
 	snd_soc_dapm_force_enable_pin(&card->dapm, "MICBIAS");
 
-- 
2.25.1

