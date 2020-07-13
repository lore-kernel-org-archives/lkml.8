Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEF5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AFC20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY+eI2Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgGMOt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgGMOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65184C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so16866254wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XFfrtDb0YISFxdApa9cgcznz1fKsVfnxLcnox2gJ38=;
        b=bY+eI2Sa1VcgBw/m+GSPdg+IKtmwOksNpPhNngNhJ4tpus+dIQgVEyXQmm5h/Mo+8d
         CFGMao+VaidBm/qr7yKY8/suL3RWH+306Rfniq0CT6jdAnE7udAzLAZ38vDwZTSgwCxP
         9Zfvo7Amfu/J/ldW9uMo1y69ApSm1SwamkBSUJZYzG+E0lsy1bD/tTOlXKuPBU95ZPwZ
         5NNTSXixUFUk4gTpO9djXoEEhSurqXpdLHwBPR04hIDB8s8nXY4sx0MYqnLsre6mwD/M
         tVq7d9wH1fGqnHlxr+56BcsdYIdOJk6QJB/JnCveFhAqYodfYN9gC3Sf0THlqUv0vJFp
         w0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XFfrtDb0YISFxdApa9cgcznz1fKsVfnxLcnox2gJ38=;
        b=fMiutFGM8QL4IWhum0ClaK88rlN8FQjNT6ssuiXuQHsEousImTq4XdwDhuhPoae/Oa
         /8vepCNCCfJNRWcIMk2gTXXQOWCKV/Digjs2phVVhMVTrs7w6BXwJ/v3/zZyc/FxCrwY
         8AwXyi37f+8yN1dEh84ODAg3OuX949sz38JdODXtdW9oPMpWerb5QdtGLRaFs4R/A0yc
         rXXPS1gU075HpYTMf1s5124wdaGVt2JfFqbKl6u68/Jrx0FPkuVuihyX3Dp5y2bXSLcX
         TnOkGaujEdUDSgz23dh5bbgnV8NgKuS3qdxpyJ5nPQYLLqSDbuVgB9S6nhwJh8LVFBP5
         VW4g==
X-Gm-Message-State: AOAM530QOff7cTA9VgpRkkVYefRv+rki2WD/G7ZrseAW7NrUG57hd5BW
        qhfFpHnBds19FYefoTJ5q5Qw9g==
X-Google-Smtp-Source: ABdhPJwmbiZnb+8yCbeRKEkrxSMvb3wxXhG75vw/5/nsc4kMk/NuIYjdgJ42nxTh62tfqm0segUiEg==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr79197339wrr.42.1594651790130;
        Mon, 13 Jul 2020 07:49:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 16/25] arch: arm: mach-at91: pm: Move prototypes to mutually included header
Date:   Mon, 13 Jul 2020 15:49:21 +0100
Message-Id: <20200713144930.1034632-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the caller and the supplier's source file should have access to
the include file containing the prototypes.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototype for ‘at91_pinctrl_gpio_suspend’ [-Wmissing-prototypes]
 1637 | void at91_pinctrl_gpio_suspend(void)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototype for ‘at91_pinctrl_gpio_resume’ [-Wmissing-prototypes]
 1661 | void at91_pinctrl_gpio_resume(void)
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-at91/pm.c             | 17 ++++++-----------
 drivers/pinctrl/pinctrl-at91.c      |  1 +
 include/linux/platform_data/atmel.h |  5 +++++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 074bde64064e4..59f2a2d6fbbb8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -25,17 +25,6 @@
 #include "generic.h"
 #include "pm.h"
 
-/*
- * FIXME: this is needed to communicate between the pinctrl driver and
- * the PM implementation in the machine. Possibly part of the PM
- * implementation should be moved down into the pinctrl driver and get
- * called as part of the generic suspend/resume path.
- */
-#ifdef CONFIG_PINCTRL_AT91
-extern void at91_pinctrl_gpio_suspend(void);
-extern void at91_pinctrl_gpio_resume(void);
-#endif
-
 struct at91_soc_pm {
 	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
 	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
@@ -325,6 +314,12 @@ static void at91_pm_suspend(suspend_state_t state)
 static int at91_pm_enter(suspend_state_t state)
 {
 #ifdef CONFIG_PINCTRL_AT91
+	/*
+	 * FIXME: this is needed to communicate between the pinctrl driver and
+	 * the PM implementation in the machine. Possibly part of the PM
+	 * implementation should be moved down into the pinctrl driver and get
+	 * called as part of the generic suspend/resume path.
+	 */
 	at91_pinctrl_gpio_suspend();
 #endif
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 9c52130876597..37997e5ab0538 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -22,6 +22,7 @@
 #include <linux/pinctrl/pinmux.h>
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/atmel.h>
 
 #include "pinctrl-at91.h"
 #include "core.h"
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 99e6069c5fd89..666ef482ea8c0 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -28,4 +28,9 @@ static inline int at91_suspend_entering_slow_clock(void)
 }
 #endif
 
+#ifdef CONFIG_PINCTRL_AT91
+void at91_pinctrl_gpio_suspend(void);
+void at91_pinctrl_gpio_resume(void);
+#endif
+
 #endif /* __ATMEL_H__ */
-- 
2.25.1

