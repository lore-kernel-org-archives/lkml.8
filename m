Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED54C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524162071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpQEHJ2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgAXP6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:58:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42113 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgAXP6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:58:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so2254873oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPUbG3hCFOeAz+2tCYBbaM8hPXs0XfYtKSvTc52tAwI=;
        b=JpQEHJ2Rcu3UyhumgEo2C76O1gAHMmICbO2XqI7Cx98M0sv72GM6EfAYOsMAghsqQe
         JhMIElcRwrzaB1PpFbvbZE6ZPXLJlxYob3nq/iQTVmdVW9VWBTmfDnTtLYgBvXZrYFBW
         +PwQ5MwpbCW6+5LcAeBGsvRQiBrVRwreDkJQbpHKrM2qiaH7OMfO16arMTqYmNuxKMik
         fK63KEzewuCjpm1mdX2UgaUF8lzZnLb2oOisZUeJ1UUJTWUZSFe2d+4ejC2PkgJ0IUn8
         saG8B3Lu3rsM2mERpGk+B+s8M6aUbZwxBHmmASQwgJ5RdytOrVrPukKjrggp4ZPZEHM2
         kBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPUbG3hCFOeAz+2tCYBbaM8hPXs0XfYtKSvTc52tAwI=;
        b=aTu2qTN+C9fVgXbSsM4qvOhHNyYJMxDdanJGsCvNQPhNs7g0HCk7IJO1M2PFIBHL93
         AtvEHYMvccDpNFgzYl08xhTnrms83KeKcSZtrVc9aLMQG+alOLFVOkvxQvAE7puxXgJ1
         FKZilPHzvMdAR+kNZRAaFfgVdM1gcOl4TIDqMpA4G3dOp4WlRz22MIwlGtNhNrUizaYL
         TeHkv9Ph9GkbjDCW9mqnnF5n4T0VdqTBCyGPzEAH1Ps7wq7ShkpQjtREv5M864i/Viyc
         giHU4xnCNcm7URXD3S53TCJ0vTzJVwmF5zN43Lt2VKk3URG1u7lvE5yjbs2XXOVvMS/D
         Un0g==
X-Gm-Message-State: APjAAAXpSaeLGseczWXX0PfO7rmt9Y55BBz/1sWMr7YSPEO8cR+qZOFC
        0DUhdlu/4radnODtmB+SZRE=
X-Google-Smtp-Source: APXvYqxmvd6MtkEknI+El5yUIiHfg27D/3uWaC3fx0XSnCQ5yTtInRzhZgJc540e0oIK+rptku90Pw==
X-Received: by 2002:a05:6808:a9c:: with SMTP id q28mr2455682oij.176.1579881491127;
        Fri, 24 Jan 2020 07:58:11 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h9sm1820292oie.53.2020.01.24.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 07:58:09 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: rt1015: Remove unnecessary const
Date:   Fri, 24 Jan 2020 08:57:50 -0700
Message-Id: <20200124155750.33753-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../sound/soc/codecs/rt1015.c:392:14: warning: duplicate 'const'
declaration specifier [-Wduplicate-decl-specifier]
static const SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
             ^
../include/sound/soc.h:355:2: note: expanded from macro
'SOC_ENUM_SINGLE_DECL'
        SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)
        ^
../include/sound/soc.h:352:2: note: expanded from macro
'SOC_ENUM_DOUBLE_DECL'
        const struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
        ^
1 warning generated.

Remove the const after static to fix it.

Fixes: df31007400c3 ("ASoC: rt1015: add rt1015 amplifier driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/845
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/rt1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 4a9c5b54008f..6d490e2dbc25 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -389,7 +389,7 @@ static const char * const rt1015_boost_mode[] = {
 	"Bypass", "Adaptive", "Fixed Adaptive"
 };
 
-static const SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
+static SOC_ENUM_SINGLE_DECL(rt1015_boost_mode_enum, 0, 0,
 	rt1015_boost_mode);
 
 static int rt1015_boost_mode_get(struct snd_kcontrol *kcontrol,
-- 
2.25.0

