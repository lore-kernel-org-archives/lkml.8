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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568DF208B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtFrKdEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGDLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgGDLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67358C08C5DE;
        Sat,  4 Jul 2020 04:39:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so35434562wrw.5;
        Sat, 04 Jul 2020 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6srjU/ZvMImw58RSlWml1hSuOXhUjM1f+LvigtsjUM0=;
        b=XtFrKdEpb8bM+H8QddJjKQH5JC/VHoJSwNcO8OBf/L+QWdA26GqLvH11+AYVmuRzf7
         ROsysFD/uvNR1V9BVbVkxhgRR6fSKMl889u5A8Ah/9nseslR/JnSdVo6IHY+GgWas1PX
         RcRpZf2BY/wSGyagBdkI3/LAHRt0WY+NfYjLUxCWy+6lsxsGZqkWLq0jjwi6n6e6cpgu
         I6pTE1xqoHcSZ0z3W3fSd4Kv4DjvelmrAEcFKzBPofWi7cvp7RTPHUuRKrfil8RbMOR8
         SjIh2IG44xkvhbQ4EO6URcl+EysjVlf3KK95SjIXJJigqokxZdB+2d4CU4a4JMYtvoqa
         ZhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6srjU/ZvMImw58RSlWml1hSuOXhUjM1f+LvigtsjUM0=;
        b=cyE8/73WioUPuPbsSw/8vG5GYTbTbFbA7Z0aaSb8TKu5JxT2LDi3/8hxEpjVmYbOAC
         FkuulbH1TcTvCyDHfHtuhotdMU3dHjP1LCQo6s5mMf4ASpRn5FIpdnWwVpy0fM3DwWWN
         L8AYR8w3BWw62P718S1m3xM4/EDo92lnoFD6V91EeCwhVtVb93SF/1Mo7nlhJb+y3zJD
         izqnr9ox6ElpycOcuv2NdUnrOn24O/39gRKPbvn5ArhnCbKtsCG9/P8nC6ByD2slacFx
         g8XPkuOTlw/7UGyRhdd+rU638uDOYh/J+SJDAZGr+ypOXsxlTgFldY218rYwDgqaJP28
         ts+A==
X-Gm-Message-State: AOAM531XAL/XVhpkAkVoygUq2VEhrO/PxOCsON32tjfNPty+pTIX3kev
        RGPGPMrZAwWcGzlDe8Ei0a8=
X-Google-Smtp-Source: ABdhPJwK6E1iUiYqMoIAXl71mOL+4VQsJk1OxMZ+u6k8BriUd2J7xo3i7cKAuCBEKWDBXnm86Zm6gw==
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr39861926wrl.362.1593862754105;
        Sat, 04 Jul 2020 04:39:14 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:13 -0700 (PDT)
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
Subject: [PATCH 07/16] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Sat,  4 Jul 2020 13:38:53 +0200
Message-Id: <20200704113902.336911-8-peron.clem@gmail.com>
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

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d7484c7e8fa2..109c10296d83 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1147,12 +1147,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

