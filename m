Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A223EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FFB222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CGm10tVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgBNNOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:14:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54340 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:14:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so9898690wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i72FvbEWLa3zDSTR6a7Xw5ZV70drp4oYObx4m5ZAKZw=;
        b=CGm10tVlypJ+HwiqhcWlQuWRUF0hlJcMq8xVEJ/eDxvmAEJlr2zYS4wpbPjcqL+U93
         IhxLuUYVG+v8BsfHZZcmwHPgSKW3F1HmDtVGCG+xnCaht38WxONG0t4dR9tdd7byyR17
         idJtcPQU6ggpfUipTMm8XhXRfGt63U7vymlcpzZ+mWw1XOmcUqqCj3QjmUjeFxoMCa9p
         vFo3+ZbDa/KqK5nsz2gi6H171NGwxr6GSIBNX3lJUicDseGgghPJUkbtw0b/4wl7WvYp
         +LpnDDehRSkXeApfKWk6+WBIxPM8oXcB1uc0NJqotUalwHIaV7UDpcf+UJ3rL6IIFuDO
         i5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i72FvbEWLa3zDSTR6a7Xw5ZV70drp4oYObx4m5ZAKZw=;
        b=ZjlRXOyxfgzUcEOyvjbDGgo/R72jI0DV0QXUtqtarxp6ZarFqS9IjVsnlb2r38wSPb
         pXjfdEJoq9BUXEgQl06Nlz+O2aEWUSHNmDJNBOYHHK2XtJewkFwDa2EGsIf6Q9aYZMOb
         gnCUhLYcMlG2WbrpVe5FS3zL/vz/thu/U3soJM4tFhmRpNareM5SwmZV9ChZfBX3MqFb
         LzcJ/QSNt18/2fXyj7KesSKFlTyd37GI5gkoTaki8QGrxDK6iQUM0bqh5jPALPotnTVu
         PD+XYrdsON0dnY+AhofCLNnlEPvvJiGO8UHr5NEyhI42+YPNF5zLSqdFMcHqcMUNarcI
         Fevw==
X-Gm-Message-State: APjAAAWz5sbti+WunRwKJqJ9FxqgvCvFzp+TX5ZI7898sqy9eB3P4rMF
        6xkHvWK+wmW0uAJWxiJ8nsPMfA==
X-Google-Smtp-Source: APXvYqzUVheOHVBk+bnulr6p/1Aot7pY9Y1/9GteYZ9lCoDqBaU0C2n0XPV3QxsnBugGDKHbDB89JA==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4621941wmi.58.1581686040170;
        Fri, 14 Feb 2020 05:14:00 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 5/5] ASoC: meson: codec-glue: fix pcm format cast warning
Date:   Fri, 14 Feb 2020 14:13:50 +0100
Message-Id: <20200214131350.337968-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214131350.337968-1-jbrunet@baylibre.com>
References: <20200214131350.337968-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the cast of snd_pcm_format_t and fix the sparse warning:
restricted snd_pcm_format_t degrades to integer

Fixes: 9c29fd9bdf92 ("ASoC: meson: g12a: extract codec-to-codec utils")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/meson-codec-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
index 97bbc967e176..524a33472337 100644
--- a/sound/soc/meson/meson-codec-glue.c
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -74,7 +74,7 @@ int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
 	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
 	data->params.rate_min = params_rate(params);
 	data->params.rate_max = params_rate(params);
-	data->params.formats = 1 << params_format(params);
+	data->params.formats = 1ULL << (__force int) params_format(params);
 	data->params.channels_min = params_channels(params);
 	data->params.channels_max = params_channels(params);
 	data->params.sig_bits = dai->driver->playback.sig_bits;
-- 
2.24.1

