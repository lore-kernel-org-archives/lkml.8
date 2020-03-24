Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89951C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6081720719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKdoWh5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCXF7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:59:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45707 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCXF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:59:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so1978443pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NASMMfM1v2BouRLznFM4rDUFSaPPa3sTp6p/VmzLtkE=;
        b=eKdoWh5GvGQhmu8/Y8ftFUvGGuPKR+uYhe7mWNDAW5HOAb3Q2omC5+3UGUNx7+IxIP
         sOTYYUFTh9t08xr7rdDDmTdnYjfGZBKzIkagl4GV3Csvo+TeeH6D8caT3DFyVAh5F3w6
         vr/n/aHIzFkQQLOZH76aVEGpBP+y+DmKxEXOxN0QvM27M33xSzS5AOc6Pc0FHuqlrYLs
         kZWn+HSWCbzs+0BX8SF+jXQ53pcVuvF1MPO+YF+x/kYKVeF8f1C0WSGvORBIrCeafpJB
         RshVkIafuxL+viPdG2zZa82llXGaba3tDs982y7tAKhd2oFhY37DuCE8qi8wCoqv4caK
         5Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NASMMfM1v2BouRLznFM4rDUFSaPPa3sTp6p/VmzLtkE=;
        b=bUuGbu4Ngzq+ODvjNyov31D31h1OIwdQ7XNaOYLysFnLXqBeenNV0OhKSeT2civXSI
         AIPL2yWmLJU0FRwm/+CLZEVb6WI1oXvGrx9mhVHOCoFE8C89urMljMUpC5YpH8vmaz8H
         Nb7CQwguFVJ/i9anyd6dYdG+RM0sAZyNzByno1LfTve7LIHvW8/0aucigCDN4q5nxWAq
         +aa5cT9CVoO+nLQDNmy5HeqZVk/2sXij6Ol23SO5cXRuQU4Izh1xKjxqse5D8KZYH1Wj
         EmZYUG8wrI9sa8CshjdZ8WSW6+Z5f8oOW8h4T+E0q/S9zCIgYGf5FFojsiBZy07b8+Se
         GGpw==
X-Gm-Message-State: ANhLgQ3f/TVV4RCEBvsCXE8EWwlDdFovf8g6UteZB469IuaTAD55n+0p
        TanINSflMV9K7DdxRkJxSLI=
X-Google-Smtp-Source: ADFU+vs9k1fziiB+fM2v9aXFbhw7sfli+y+Z09y1iKRYJ2E+0PuBvEaXQetUXyOPbk386L6Drq/8hA==
X-Received: by 2002:a63:514f:: with SMTP id r15mr24814945pgl.432.1585029590697;
        Mon, 23 Mar 2020 22:59:50 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s12sm13921742pgi.38.2020.03.23.22.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Mar 2020 22:59:50 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     saravanak@google.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clocksource/drivers/sprd: Add module support to Spreadtrum timer
Date:   Tue, 24 Mar 2020 13:59:37 +0800
Message-Id: <182aae1ed5e5d2b124f1a32686e5566c9a27c980.1585021186.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
In-Reply-To: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timers still have devices created for them. So, when compiling a timer
driver as a module, implement it as a normal platform device driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/clocksource/Kconfig      |  2 +-
 drivers/clocksource/timer-sprd.c | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cc909e4..404f7dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -481,7 +481,7 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if EXPERT
+	tristate "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99..5461789 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -5,6 +5,8 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "timer-of.h"
 
@@ -141,7 +143,7 @@ static irqreturn_t sprd_timer_interrupt(int irq, void *dev_id)
 	},
 };
 
-static int __init sprd_timer_init(struct device_node *np)
+static int sprd_timer_init(struct device_node *np)
 {
 	int ret;
 
@@ -190,7 +192,7 @@ static void sprd_suspend_timer_disable(struct clocksource *cs)
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-static int __init sprd_suspend_timer_init(struct device_node *np)
+static int sprd_suspend_timer_init(struct device_node *np)
 {
 	int ret;
 
@@ -204,6 +206,37 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	return 0;
 }
 
+#ifdef MODULE
+static int sprd_timer_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (of_property_read_bool(np, "interrupts"))
+		return sprd_timer_init(np);
+
+	return sprd_suspend_timer_init(np);
+}
+
+static const struct of_device_id sprd_timer_match_table[] = {
+	{ .compatible = "sprd,sc9860-suspend-timer" },
+	{ .compatible = "sprd,sc9860-timer" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sprd_timer_match_table);
+
+static struct platform_driver sprd_timer_driver = {
+	.probe		= sprd_timer_probe,
+	.driver		= {
+		.name	= "sprd-timer",
+		.of_match_table = sprd_timer_match_table,
+	},
+};
+module_platform_driver(sprd_timer_driver);
+
+#else
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
 TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
 		 sprd_suspend_timer_init);
+#endif
+
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

