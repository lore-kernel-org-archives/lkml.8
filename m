Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E4BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C052083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XaVnRFyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgG2PpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgG2PpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7CFC0619D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so3449477wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odKL8nfgi2JfYFNsaHMY4SKWdmff32MEW/xIQyAYpOU=;
        b=XaVnRFyyLv/CDI3rNrvt+N1NR94GoD23fiy/1/aev0VHbn3oeX9+0gLViXcHzcPViC
         mwlIFOWJmaj7nZtyvHYwX0VYgYAWhYlilB06hqnszYmsJEMA/ptUEBCYejYVctWNmLvG
         DaXtxBbRu5szTpoi/tqJKw0GDefnpfkG2ef3NB7uRsoJKp358/WBuGwCaFgmhWSEt1Xb
         TdyN1A3/uSX2bqsM9cPHzZ0isZY56UvuXLD7Dfz5VjSyrzzma3a0D2RYNurND6ap+y6s
         vdzrI/4KXtoIAm5gIupf2DJq9ssRajx8xEWOiGD5gNisR6FFXhdyhHxyuvBdWbPxj3Rl
         LPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odKL8nfgi2JfYFNsaHMY4SKWdmff32MEW/xIQyAYpOU=;
        b=cMH96YgPuG8t252ryKIaO/yyg2mZHroUoV6Jk8/Fbbjz8CBEFCFOQctWdbiABswuzR
         /iktOC9gKbZ+wASYdCHb6e6hz/XTqRPYXuGMJVbBCt6Zx4/FYkN12+ZXMK3RnHztgXF+
         XA0TDnbFOuH1tjag4NOYW62USb/b7fbVf4WITqaWnn/e54HN5+msUqrtlGW81d4Yb53G
         7pvbIlWd81sD+U6ofr4sw2I9gDKoydQ0OuKktnVO5p6DKjvt1t403+7rZiISLoXN+E0I
         N1Ox2AyS02TPIjOjpnnD5Kvn6Sn+1eNrX/ntzgz8/2zjJszUWEStfNC3k5mLmQmF/MQY
         QLtw==
X-Gm-Message-State: AOAM532yV7si/Clz1UT5NF9Fh+gdvaJ0BlOyZvhfyBcL3logHRLP+FX5
        hrucZNydMAU55RPWYs5HfM5VpA==
X-Google-Smtp-Source: ABdhPJwJufUM+fr/ccstncgAq56W2HRh9FWgpXsZ5IRILScKbhvt1s8lTYaYBt7VHezKJF6mEIM+8w==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr8667635wmc.167.1596037515187;
        Wed, 29 Jul 2020 08:45:15 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm5950967wrm.74.2020.07.29.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:45:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/4] ASoC: meson: axg-tdmin: fix g12a skew
Date:   Wed, 29 Jul 2020 17:44:54 +0200
Message-Id: <20200729154456.1983396-3-jbrunet@baylibre.com>
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

After carefully checking the result provided by the TDMIN on the g12a and
sm1 SoC families, the TDMIN skew offset appears to be 3 instead of 2 on the
axg.

Fixes: f01bc67f58fd ("ASoC: meson: axg-tdm-formatter: rework quirks settings")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmin.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index 973d4c02ef8d..3d002b4eb939 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -233,10 +233,26 @@ static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
 	},
 };
 
+static const struct axg_tdm_formatter_driver g12a_tdmin_drv = {
+	.component_drv	= &axg_tdmin_component_drv,
+	.regmap_cfg	= &axg_tdmin_regmap_cfg,
+	.ops		= &axg_tdmin_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk	= false,
+		.skew_offset	= 3,
+	},
+};
+
 static const struct of_device_id axg_tdmin_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmin",
 		.data = &axg_tdmin_drv,
+	}, {
+		.compatible = "amlogic,g12a-tdmin",
+		.data = &g12a_tdmin_drv,
+	}, {
+		.compatible = "amlogic,sm1-tdmin",
+		.data = &g12a_tdmin_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmin_of_match);
-- 
2.25.4

