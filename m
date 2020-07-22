Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1636C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD34C20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="gnuS6aH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgGVMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgGVMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:09:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49EC0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 05:09:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so1666474wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqHxcywQyVz1wfQvBGx3vpEtZ8YqD1CPktgmCd8zLdc=;
        b=gnuS6aH1Z4+o6kdQgqoa7jvwbtLsfXA0ZmIQoHVWFjcQCBaB72XsvvMy+iiGTDr7FR
         eZWTN6R+9wO8Vzt+lAXECEneA6FaZoBbjMb+5XruTj2zqJ+vUxX8E9A2KBdlDFpriudM
         TV2OnwnG+XnlNHojz2MN6h49JUtWDs714yEYfBccT9OpZ/3Q0CGegDDWUcdvukrF+rWt
         9wCHhPBFCCoNzk4u/31jInctoCb5e7vlmaTrSE4XxKeP8+CvMSFcnof+BUGFfZkvjOdZ
         NGAVlCBCxc14B1kpyLLfdsOIds3mFz2Y4oXpIrpx93QZmrxvI+p4kKnM8diRhr1QXqce
         p0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqHxcywQyVz1wfQvBGx3vpEtZ8YqD1CPktgmCd8zLdc=;
        b=gqMAoTukT1z5ggtTXhVgttBytep8H1h1ebpfQJUiDz06YzAEx17v3ryT0rza29gDgS
         X8AvzuBpe3h4EGiG1Cpho85t9yV8nWFNwqPr7N8kCP7U+ryuLiQxI9JrJcpf/sXq/8hF
         OUYdH2Rtyezi7dpkjBGZai3lluAauXS3izOXG3YrjYPPHWSUuuHxjs1a8TZSQOunFHPg
         gRF0CSvCHCxheYL8nS2UpbG3Op1gpZDqQ1IfUJg9TnFxd7l2j8sYmK8iW9S0q6zwSLpq
         CsbZ8r2Rzjy649rGhkx7/YiGTL2YlI7IoKFa8uozHWKwJGtfBtLziRXVFR1dGaxJatnf
         ykcg==
X-Gm-Message-State: AOAM532WM/gxmS3wjZszkmfXcZKNm2dwMBpWEIJjdlMCbOqulRy+IzTA
        UrtHqQsYtlxRUhfLtsq5ZGv/aA==
X-Google-Smtp-Source: ABdhPJyEIrrWfWDnGxTltj2DTpGuaDacNmpFZhftR7gDW78DkgWP3WGw2p75qhnhfmYpYtGiWYlZvg==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr29109610wrm.327.1595419751422;
        Wed, 22 Jul 2020 05:09:11 -0700 (PDT)
Received: from localhost.localdomain (172.red-80-27-177.dynamicip.rima-tde.net. [80.27.177.172])
        by smtp.gmail.com with ESMTPSA id o7sm28003296wrv.50.2020.07.22.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:09:09 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH] gpio: omap: improve coding style for pin config flags
Date:   Wed, 22 Jul 2020 14:07:56 +0200
Message-Id: <20200722120755.230741-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the handling of pin config flags from if/else to switch
statement to make the code more readable and cleaner.

Suggested-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/gpio/gpio-omap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e0eada82178c..7fbe0c9e1fc1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -899,13 +899,18 @@ static int omap_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	u32 debounce;
 	int ret = -ENOTSUPP;
 
-	if ((pinconf_to_config_param(config) == PIN_CONFIG_BIAS_DISABLE) ||
-	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_UP) ||
-	    (pinconf_to_config_param(config) == PIN_CONFIG_BIAS_PULL_DOWN)) {
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
 		ret = gpiochip_generic_config(chip, offset, config);
-	} else if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
 		debounce = pinconf_to_config_argument(config);
 		ret = omap_gpio_debounce(chip, offset, debounce);
+		break;
+	default:
+		break;
 	}
 
 	return ret;
-- 
2.25.1

