Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F693C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5CE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0wn9pKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGWP1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgGWP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BDC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so4775306wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlvfNv3OhFVKUHdj8fPbw1vSekwLhG5U4hNz16AUgW0=;
        b=B0wn9pKtTdHu/xIF9ux/yklQ7cOpZj664VR7/vwM3Dky6BurAe6AKkJvH4RNQGSFpy
         HHEm/c/+cO2Ebn5OjhrdCjuZd6qnxF6lAoPus0LZBur2caILq5jGL9e3+T4+O9ElD7qL
         ncgAcI34fqVSnT2p6mVoZpFXR9hb9M4PpCYywBrdNJcA/0vVh0/q8jsNGE2ympls+0Ag
         CHs5Mlpdq3I8rdZLMv//0gz4B0KwP5/Hc0QR3VkDGyTruZXoPgXMIHW2puFPyzOHjwQU
         MJo5nF2xJQYJQnVhGsuqrzXliN20OP5Ad2wy1fhktIQ/EECiLxwCfeTvXZeg7vRh2zug
         K45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlvfNv3OhFVKUHdj8fPbw1vSekwLhG5U4hNz16AUgW0=;
        b=GoTxaFjfDdAHNOJEpuO9z0tDQT+6kdRbzdDSUywoDPmpdlaPL8DhZWzD8dswS+tM43
         0b3/TCskeZpcPvK7B0LcGcl/Z8EQ3UJDaORbbl07Srd10okrdttVEnanFcg4mRn3Ba2f
         mvcKxkEA/nbBAfLElM0ssf0VS4zQOjcBlOZ/9AJ1v5i/awAC04udmwuqQkDS6cYO06kp
         d57+ukkaAA4IOII4x6SSLH4FQXv55If6alVAmhXDXOPJLs9WOGXlJH0HMmXB8dvdbr93
         fCc76yYa2xwrsprnmChJ0AfxBwBR1DH9pq6GPm30g8KlHY0SjA+fbMPBb2v5a/2BPYSl
         pbbA==
X-Gm-Message-State: AOAM532sFNAN30gOOrRR/DyTopK+sYIDsdC3zSE/YJXF2JyagoKtP//Y
        K/8a7PX5VY6XpJnsynXF9nhKxg==
X-Google-Smtp-Source: ABdhPJxUROi8u/12EtUFc+5x0dsZxztYmokFxgt1AMiCnSoFdlI0rZhkSirEGrQz+6lqFhWdtyz5Vg==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr4678360wma.102.1595518027163;
        Thu, 23 Jul 2020 08:27:07 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 11/16] clocksource/drivers/imx: Add support for i.MX TPM driver with ARM64
Date:   Thu, 23 Jul 2020 17:26:31 +0200
Message-Id: <20200723152639.639771-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Allows building and compile-testing the i.MX TPM driver for ARM64.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1594178168-13007-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 91418381fcd4..9936d1534998 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -616,8 +616,9 @@ config CLKSRC_IMX_GPT
 
 config CLKSRC_IMX_TPM
 	bool "Clocksource using i.MX TPM" if COMPILE_TEST
-	depends on ARM && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.
-- 
2.25.1

