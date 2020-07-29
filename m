Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9599C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7C92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R6e6hElL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgG2PpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgG2PpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q76so2230116wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWqyEKTC/HJjMKifmyPTB4RZCmPL+DNrii7Si5MfMvM=;
        b=R6e6hElLlc+cKRmwfD9negfPjHCnH1BoA3KEGyKUVu+4cXtnt3BZD57hM2PlEEHmI/
         sqd2gXZg6qgdERDcATkW1xvA2BW9ApWfymSmV2YB6nEbHiIMBJJDmrsI+BaHWWeG/Us5
         U5Sm96lEvo7l/QRv4D6UEIgelIEez1Ks7QNRWZ1C/D8Cu5whCC7FoPyMb2z3BhRG2qgy
         FnBLSmNJOF1c50vViNF9o6VQ7a4k8Cx1fyQCIiNcYpM1c9YgLxXz7T+LYBgIxVV/A6Rw
         KkgIGG2I94TbAxr15mGQj9KGOCXZ8j9Xy0OLXIE2Z7A/ceEyEaCYB0q9i2y1J9ZGF17h
         1iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWqyEKTC/HJjMKifmyPTB4RZCmPL+DNrii7Si5MfMvM=;
        b=RcfenMIAl/GysT7m/VpoE9DowZwTck/DkvG7f7qwFouGwfEwWxmyp72tGvGCMmzvvR
         zAaLAqH1pHjkb6kqOM2MV3bTB6TiCC6JHOFBdG0S/JINW9a8YBa8+oEcsxJxMf1byUtf
         bhjSQep+0UufMgXHT7L5yf2HebV5yNiWTOGSek3KDn1qfZFLV7OoMWIx9LXxYEd49ZMs
         E1Inwq3Ronju+M1aRe0RtL9cZpXlVoYMsYkNeF4Y9kHPo4ZXckL1DuN7KtT/EBX7i+3h
         6JGK2fyqPKM2HmIMD9/DKaRBQhRyDFJ0QIANl5dVR5Q8USELUvgEIlbyZf4og85FmldE
         VWFQ==
X-Gm-Message-State: AOAM532nL0Wr4QJ34+CcWJvfflXSzVsQOWPwdgE6CLIN0ECRYJEUbbMD
        ew82A9ZZPFzUi9ebMaBMG7V81/SLHp/bUA==
X-Google-Smtp-Source: ABdhPJxgGC9nboToZyRcUcXbiOSxER7K3hBnDiXzlzkgzlpkoRrJEvHRzVMhiuKp6ZHByGydbFxnFg==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr9082184wmh.174.1596037517108;
        Wed, 29 Jul 2020 08:45:17 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm5950967wrm.74.2020.07.29.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:45:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4/4] ASoC: meson: cards: remove DT_PREFIX for standard daifmt properties
Date:   Wed, 29 Jul 2020 17:44:56 +0200
Message-Id: <20200729154456.1983396-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729154456.1983396-1-jbrunet@baylibre.com>
References: <20200729154456.1983396-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard dai format property don't need the "amlogic," prefix.
There nothing amlogic specific about them. Just remove it.

Fixes: 435857e015dc ("ASoC: meson: align axg card driver with DT bindings documentation")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/meson-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 29b601a0e274..f9ce03f3921f 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -119,7 +119,7 @@ unsigned int meson_card_parse_daifmt(struct device_node *node,
 	struct device_node *framemaster = NULL;
 	unsigned int daifmt;
 
-	daifmt = snd_soc_of_parse_daifmt(node, DT_PREFIX,
+	daifmt = snd_soc_of_parse_daifmt(node, "",
 					 &bitclkmaster, &framemaster);
 	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
 
-- 
2.25.4

