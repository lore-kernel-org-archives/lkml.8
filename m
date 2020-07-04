Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A32C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFD720890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7tjbM6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGDLjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGDLjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F317C08C5DE;
        Sat,  4 Jul 2020 04:39:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so13170749wrp.2;
        Sat, 04 Jul 2020 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07SzXUrNmaVEvqxJMeRoC1vO5sKNg5xLvcI7+EHrur4=;
        b=t7tjbM6q9DA++HkhhFBRV8bwWXc9Quuf0NpyLkimpVbL8K1VkNjwHTB4ASyTkmIefz
         9J1/NgNi6e1OXX1N2tccVS0Y0fFOpw6FctZvl3ZBzeHj7btm+R+QQp8To+hOuG581hb/
         j4VCBPQXgfAdWmlHJQeAY+dDCbochhyNvFb65r1smYn2PCrfiD3c8TGZtl3ikxTRPKas
         gTBJs9fOJ3EtLq0VZ2YIB/pQM7k8vGx/c+O/zMe28I+K+sOv8loaxpfp/yJ4klayWvY7
         0czoDeOJ4BR/tJs245n15+W5YOXD5+tfMnBYJKIe5iCeewm0b2SvBuYX4TQWgETIdxQP
         F94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07SzXUrNmaVEvqxJMeRoC1vO5sKNg5xLvcI7+EHrur4=;
        b=H7CCzUjiTkrBrbU5LJTV3cfOQu2SUKbfEmDtLyrkQvj8U9v7lsBJMAUdqy6Oi3DD6k
         LtTeISeAF4HmdvacNr/wqfJFrCl3iaPAc3Dlk4Q/YzSBZjy+VhpOz8IwounIwgDj4ly7
         5o8FZx6q8kmXyF08VR0g3yoJrRC+zOzzsAi4a95FJwo2UBDhf9KUYUQLcRbwdYOMU8z8
         4YGRL4zdpb5jjfV1de66Az4Ha97cqPcramF1zXGytMqljFGjRLmgBoaBvUuLYkBEY12Z
         vkrkIqldk6cBJg4hinv/WFGYiwiJ8or1gERVcSuc+3LjUw2orDCYsL48SXq9BnLbXnA4
         KL1w==
X-Gm-Message-State: AOAM5329a5OXfAmIfRMC1mqE9NPBIrx2OPTKOTyZVG5zvzLwPCl5IKF9
        nPFQFXRGRhEtcRJlIusDixo=
X-Google-Smtp-Source: ABdhPJzj9TjACX1ft7d4WQSD/0GePrc3Tb20hkx7aYSB5nl+CZoGE/JCwfOoqbVepk1s9FU63LnGug==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr38829811wrs.270.1593862752902;
        Sat, 04 Jul 2020 04:39:12 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 06/16] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Sat,  4 Jul 2020 13:38:52 +0200
Message-Id: <20200704113902.336911-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
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
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index bc7f9343bc7a..d7484c7e8fa2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1120,7 +1120,10 @@ static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
 static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
-- 
2.25.1

