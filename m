Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6259E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N422ErcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgBNNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:14:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47012 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgBNNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:13:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so10841531wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx2gKjAQJal87pQJbLzDoMa1/1VjjJ5Q248YqNAOaeA=;
        b=N422ErcPs9NI0qQ9oVh8hQQl5TMjeSe4c4P3iVWsbGe1Ufj2jDDOuRWEMhjjZ5QFpe
         AW8ZMdjeYX9cnNx+/7/qRXb5L45+g8ASci1nw7zmvrlk3df/JnQngoeanBhgKfDzlbdt
         JgdO9SIL0WD1fwHAZ1n5HSGa2Yj0h9ZHHRufJAYNcS9RdvaXcBfMaN7tt3VqKGaxIb22
         mVlPU0P6tatHNqV8k7eV4JGfwBXs+89328BCQ6tknbNxUDMu/+Erxbxp3y2A3HM7rFwo
         +Cc+jXo5o42RwZP4LJwOp1MTVua74Jb1c+KQwCJuTngywi6ZWtXTDP0MhI5wqnUHvAcZ
         mKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx2gKjAQJal87pQJbLzDoMa1/1VjjJ5Q248YqNAOaeA=;
        b=CE4usVA0y/dvmqQe1eBIv3yUYL/sO4zqHAzk1Lbwge148BI+tHxNeEb0Zq/Lwhq0/U
         5MKPU2OqJLNWtHmoLjrEQQIC4Ll+HrHif467nmBxQ7RecQzNCJFi6OFrdJy4Ksmyrq9o
         JB0KM20e6i6p/Vjiww8K2LneOEfOUeRiEd4yRoEzLETMFr31uoG9WA1E8ozmUPY0p702
         wBt3LNKJNXmm6dZN/6vjg/pwCL/cfI098KEwAMAUJKDlOxAwwdlpKBPH6j7QMf1B8fiQ
         qjmSZPAfbOK3mtILAyHuiHdLbi0jAbPdpqvgLDdUaV2Pqi4zOaknhm6pz+pai1EFKxbD
         Pbtw==
X-Gm-Message-State: APjAAAWCXSmvvgIekCaA1rXO3gbf6M7YtGgnAxxkT2vbIn+JoLTMXpgk
        PD+qu+fExoWd65nRw6lYpEwZOw==
X-Google-Smtp-Source: APXvYqwPovlBw5L+IhhgUPCRfLNltnNqjwAk6wy8BfWcbw70VU71jYxmICvuD2qHagjj9wv+rO5uBA==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr3718396wrx.285.1581686035381;
        Fri, 14 Feb 2020 05:13:55 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:54 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/5] ASoC: meson: aiu: remove unused encoder structure
Date:   Fri, 14 Feb 2020 14:13:46 +0100
Message-Id: <20200214131350.337968-2-jbrunet@baylibre.com>
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

Remove an unused structure definition which slipped through the initial
driver submission.

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu-encoder-i2s.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
index 13bf029086a9..4900e38e7e49 100644
--- a/sound/soc/meson/aiu-encoder-i2s.c
+++ b/sound/soc/meson/aiu-encoder-i2s.c
@@ -28,13 +28,6 @@
 #define AIU_CLK_CTRL_MORE_I2S_DIV	GENMASK(5, 0)
 #define AIU_CODEC_DAC_LRCLK_CTRL_DIV	GENMASK(11, 0)
 
-struct aiu_encoder_i2s {
-	struct clk *aoclk;
-	struct clk *mclk;
-	struct clk *mixer;
-	struct clk *pclk;
-};
-
 static void aiu_encoder_i2s_divider_enable(struct snd_soc_component *component,
 					   bool enable)
 {
-- 
2.24.1

