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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FCC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD082075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8SdxWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgDZKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbgDZKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177FCC061A0C;
        Sun, 26 Apr 2020 03:41:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v4so13599038wme.1;
        Sun, 26 Apr 2020 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FLLl3Lmv6P46g23QaNfgW2hXBgcdl0HHdXkGyMc3vQ=;
        b=YV8SdxWnCc7yDLnHkZGAeWRKIyr/QoRW4IOW0ERhXl1Sk67OS4PbfAGe5c44az0zzn
         gSLeDjP1mOWpE/nDCUFVkbINqiYRabevpwJKJk99nNPr6/mGS8wEg3bGOJJLwi/+sq9W
         68xapeEEDPYPqlcxP1MRaSx8KYKquHkJv9WIle6pxk2AH30Lpd4UJJmKexNSBeg+ydJh
         Xd+XKwa0wsB8XIBhc6ncR0XO9GVIEkr4WTJzhpUNdfPE1YfncqvCDedLTcQOZzXQBdZc
         Tp2rZp6tNz+zkvJHrzjn1PkvN0syPRtg2uM4X0+6/XYe4HlmSf5ECH69lBnY+yXiU/St
         ridg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FLLl3Lmv6P46g23QaNfgW2hXBgcdl0HHdXkGyMc3vQ=;
        b=sT5qrnUSW4/z2bsp9CLSvpkPLUdzOWy0yo4B42vZSgs2yf7rGGRXAOpLPGG9wi/dul
         gcUjIzb+D3aRCFpQoQT2j+SZrLme4Rd+hkgVthEjPA2SrMiMeKL0AnjJZZWr8RcUZSI6
         gCH8ijjM80YJ3bCPnuDkicBXcPjhbSbpeB9P5BfR/+D1PMgKSfRL0yjVjEmiHppQORPY
         q8QV4CrtI4HlQL8/9hn+p2o8Q9iW7wX0Ia5S8xvcZMhobB0lBpx8ZHbm/Kh2x81wSU2A
         MRXtbb5RZjF6ol1zpOCB7ZmXnm97aVyeICJQLvRMk0alU0ATz/xirN5HLyOQO+0p1TU3
         DgeQ==
X-Gm-Message-State: AGi0Puaw5kWV5/GnxpPQSJlJqD1R6kLTmHow4G+kSD6eJhZ/UyK0pg/j
        1NBL6HCtgXn1UnxDmi/Thm0=
X-Google-Smtp-Source: APiQypKv5SHULHMlQUX80eAs8h8KPRFAzZNFj61ehmLXvJWXiIe6MAQFvFVTO/AASlwcFJaq37x6pQ==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr20341161wmj.101.1587897685701;
        Sun, 26 Apr 2020 03:41:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:25 -0700 (PDT)
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
Subject: [PATCH v3 6/7] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Sun, 26 Apr 2020 12:41:14 +0200
Message-Id: <20200426104115.22630-7-peron.clem@gmail.com>
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

Bypass the regmap cache when flushing or reading the i2s FIFOs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 277bf566c154..b5ab25483a9b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1121,6 +1121,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
-- 
2.20.1

