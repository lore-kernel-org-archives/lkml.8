Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77280C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4AE20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cXqWOztT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAJRRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:17:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40058 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgAJRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:17:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2759866wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=cXqWOztTfUwDyWcSOmq5q8KkhLQbdC1xKjmCSstZ/Hn6Z+4u0++FOr7D5KQew6gdXv
         5s46S3ILloL2xrwfboySqYcQtXsVFP27YDhENrWgXVl3clNZMkLz021SGYO0l/cttBdZ
         3KAQOd0IP+mlfZC+Q/ysje6uZrAiDyromn4DR1MW/87HxHO3v9AkWSYYiTzHxNKi+9Uq
         ZIJkZNhsELC3vGl1MlXIL+HPo30okZ07MFpnMtTULx4E4egxelSAfUkJRslnFyPczYDA
         WEBICS4JV3NfsVj55Gn5xNG3n1jtJumfAxqO2R7HxQ5SjT0jl33Qw7qgrABFoyADjik+
         Sz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=MxCvCBm1VH10jNJrWE/+8lChgxUVW06goTNhWrWE//vzY3Bi2QV7/uqda2hHD6s/Bb
         TRG4iqJBKu50fmmW1N3dRunVraZnk6/Y5zHCitakBbttaUmhG1C3iSur4kMxR4n8ZI3S
         lF11aDBg2CQ02m6i37wJBUgnGZgxF8VyKHw2Ny0CvaFq4lfNFqSZ0Q+kL6xt/a+YOov1
         ARrnbd6tjqgrROHI6+1gZNO5coaLppRBBmKIvNblf1wuRfR+Xw+Yid1UBxuvVp5KJfDi
         KPkf0z8lxjAaBc/ebgtSF+Mq7JZ/qWgMtxlBUtNzYHtU4/h7m35ikMbaOqhcSDto6iK5
         nFAQ==
X-Gm-Message-State: APjAAAUnaARgwBk0SvmHFv9IzhccBE51j71z60IMqhiqha6rD0640Kxd
        TNdosn8PxAjfRTADTt3965/xxA==
X-Google-Smtp-Source: APXvYqxka4QzXLEAcNp6/SHuWVKMR5GdHU980ugJZUTkhmLyhAbEB0PPB0uoiBUnQlyurAJ7pE2V7A==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr5685494wme.125.1578676624588;
        Fri, 10 Jan 2020 09:17:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:b0ec:c83d:aa26:b93])
        by smtp.gmail.com with ESMTPSA id z123sm3072725wme.18.2020.01.10.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:17:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/3] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Fri, 10 Jan 2020 18:16:42 +0100
Message-Id: <20200110171643.18578-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110171643.18578-1-brgl@bgdev.pl>
References: <20200110171643.18578-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 9fc5c73cc0be..c1e0d46996e4 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -35,7 +35,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -660,10 +661,16 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+/*
+ * Bottom half of timer0 is used for clockevent, top half is used for
+ * clocksource.
+ */
+static const struct davinci_timer_cfg dm365_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_128),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -723,7 +730,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -771,6 +777,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -789,7 +796,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.23.0

