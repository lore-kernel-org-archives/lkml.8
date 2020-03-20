Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC110C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9773A20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p19SPgPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCTNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCTNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id l20so6352026wmi.3;
        Fri, 20 Mar 2020 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5cvJnNy7rAzr+MR1scINKdcIp3JWPdrNsZ6zcMIVv4=;
        b=p19SPgPejGnTVvwBAFp6mGqj9G09TyJAC5X2QImlRQopPKDsfqINnD4PyGN0oHvzoP
         Sb6W07fXufM161Sk9P6T5suaFfwY5h0Yth+apytQanDyhuGom6wf5bMK1Ukb5sMi6Mhs
         1IONjXqOQzoahXd4kV94p0tlfW+x2ewnVEFGUWF+WAmxifl7EfnCWU6Pq9HmYKhVe6Z4
         uB7STSa4MY8c5quhpV+hAZ7agaJlmGOHLz72FzC+f4i4pn5nIbX4CYHPODZ1/fsDiB97
         LlY0FFtM5toQVc2/iKt+QcjSLff7bUixJ1KenSwx4VHu+QnEmtFgVqI8kFlJkvmdjKh0
         brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5cvJnNy7rAzr+MR1scINKdcIp3JWPdrNsZ6zcMIVv4=;
        b=a5e97drkhjxzTRz3AqdiNns2ke9OT57tDdHbhH8NEZJENFD4/67i3J1KYxMA5k7T2k
         WNrqbADNrE25yOFfdnIRAxIhfK9afrGZ39keBvMYW397okW9NGaSzjbMvFV+uRx1O4rd
         lYI0Ov2/eQde4heyVkbJ2Aj4R6L94kQLVWC5DPDyjDujQIk9nNCzS53KR4iFA2BXvzc9
         2c6S36iuDy1JvE2iAdTQXyUwpvG6t6QjgRp09JWcsmDE5yQJlHx+YAXHwaE7eko5MD7z
         C5FC1fU5/DeApTQG5N/RlZSBS/qBs0YZrbtjqOQHuTd6tXZMPYyt7TG+eDckSHNA0SKy
         s1lg==
X-Gm-Message-State: ANhLgQ27EcxbbNQT/ToI5/PqchRpuTOLK4kkMYT3yZlQS5AgOvLmmiO1
        Y0QYYLQWopRUblwBrPErNhQ=
X-Google-Smtp-Source: ADFU+vtf+LzzSJ8so+tDHns/2cSauccKBJ/XdHAkB3Gr0pIdrtAlho2CPDyKdeFvEYM04ty9UQBu3A==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr10223733wmi.136.1584711306228;
        Fri, 20 Mar 2020 06:35:06 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id f15sm8409248wru.83.2020.03.20.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clocksource: Add Tegra186 timers support
Date:   Fri, 20 Mar 2020 14:34:47 +0100
Message-Id: <20200320133452.3705040-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320133452.3705040-1-thierry.reding@gmail.com>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Currently this only supports a single watchdog, which uses a timer in
the background for countdown. Eventually the timers could be used for
various time-keeping tasks, but by default the architected timer will
already provide that functionality.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clocksource/Kconfig          |   8 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-tegra186.c | 377 +++++++++++++++++++++++++++
 3 files changed, 386 insertions(+)
 create mode 100644 drivers/clocksource/timer-tegra186.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6bbea3..54d1b27d1f8b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -149,6 +149,14 @@ config TEGRA_TIMER
 	help
 	  Enables support for the Tegra driver.
 
+config TEGRA186_TIMER
+	bool "NVIDIA Tegra186 timer driver"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	select TIMER_OF
+	help
+	  Enables support for the timers and watchdogs found on NVIDIA
+	  Tegra186 and later SoCs.
+
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 641ba5383ab5..ffa7950f4b7c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra.o
+obj-$(CONFIG_TEGRA186_TIMER)	+= timer-tegra186.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
new file mode 100644
index 000000000000..f8bdda041e3a
--- /dev/null
+++ b/drivers/clocksource/timer-tegra186.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
+
+/* shared registers */
+#define TKEIE(x) (0x100 + ((x) * 4))
+#define  TKEIE_WDT_MASK(x, y) ((y) << (16 + 4 * (x)))
+
+/* timer registers */
+#define TMRCR 0x000
+#define  TMRCR_ENABLE BIT(31)
+#define  TMRCR_PERIODIC BIT(30)
+#define  TMRCR_PTV(x) ((x) & 0x0fffffff)
+
+#define TMRSR 0x004
+#define  TMRSR_INTR_CLR BIT(30)
+
+#define TMRCSSR 0x008
+#define  TMRCSSR_SRC_USEC (0 << 0)
+
+/* watchdog registers */
+#define WDTCR 0x000
+#define  WDTCR_SYSTEM_POR_RESET_ENABLE BIT(16)
+#define  WDTCR_SYSTEM_DEBUG_RESET_ENABLE BIT(15)
+#define  WDTCR_REMOTE_INT_ENABLE BIT(14)
+#define  WDTCR_LOCAL_FIQ_ENABLE BIT(13)
+#define  WDTCR_LOCAL_INT_ENABLE BIT(12)
+#define  WDTCR_PERIOD_MASK (0xff << 4)
+#define  WDTCR_PERIOD(x) (((x) & 0xff) << 4)
+#define  WDTCR_TIMER_SOURCE_MASK 0xf
+#define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
+
+#define WDTCMDR 0x008
+#define  WDTCMDR_DISABLE_COUNTER BIT(1)
+#define  WDTCMDR_START_COUNTER BIT(0)
+
+#define WDTUR 0x00c
+#define  WDTUR_UNLOCK_PATTERN 0x0000c45a
+
+struct tegra186_timer_soc {
+	unsigned int num_timers;
+	unsigned int num_wdts;
+};
+
+struct tegra186_tmr {
+	struct tegra186_timer *parent;
+	void __iomem *regs;
+	unsigned int index;
+	unsigned int hwirq;
+};
+
+struct tegra186_wdt {
+	struct watchdog_device base;
+
+	void __iomem *regs;
+	unsigned int index;
+	bool locked;
+
+	struct tegra186_tmr *tmr;
+};
+
+static inline struct tegra186_wdt *to_tegra186_wdt(struct watchdog_device *wdd)
+{
+	return container_of(wdd, struct tegra186_wdt, base);
+}
+
+struct tegra186_timer {
+	const struct tegra186_timer_soc *soc;
+	struct device *dev;
+	void __iomem *regs;
+	unsigned int irq;
+
+	struct tegra186_wdt *wdt;
+};
+
+static void tmr_writel(struct tegra186_tmr *tmr, u32 value, unsigned int offset)
+{
+	writel(value, tmr->regs + offset);
+}
+
+static void wdt_writel(struct tegra186_wdt *wdt, u32 value, unsigned int offset)
+{
+	writel(value, wdt->regs + offset);
+}
+
+static u32 wdt_readl(struct tegra186_wdt *wdt, unsigned int offset)
+{
+	return readl(wdt->regs + offset);
+}
+
+static struct tegra186_tmr *tegra186_tmr_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset = 0x10000 + index * 0x10000;
+	struct tegra186_tmr *tmr;
+
+	tmr = devm_kzalloc(tegra->dev, sizeof(*tmr), GFP_KERNEL);
+	if (!tmr)
+		return ERR_PTR(-ENOMEM);
+
+	tmr->parent = tegra;
+	tmr->regs = tegra->regs + offset;
+	tmr->index = index;
+	tmr->hwirq = 0;
+
+	return tmr;
+}
+
+static const struct watchdog_info tegra186_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "NVIDIA Tegra186 WDT",
+};
+
+static void tegra186_wdt_disable(struct tegra186_wdt *wdt)
+{
+	/* unlock and disable the watchdog */
+	wdt_writel(wdt, WDTUR_UNLOCK_PATTERN, WDTUR);
+	wdt_writel(wdt, WDTCMDR_DISABLE_COUNTER, WDTCMDR);
+
+	/* disable timer */
+	tmr_writel(wdt->tmr, 0, TMRCR);
+}
+
+static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
+{
+	struct tegra186_timer *tegra = wdt->tmr->parent;
+	u32 value;
+
+	/* unmask hardware IRQ, this may have been lost across powergate */
+	value = TKEIE_WDT_MASK(wdt->index, 1);
+	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
+
+	/* clear interrupt */
+	tmr_writel(wdt->tmr, TMRSR_INTR_CLR, TMRSR);
+
+	/* select microsecond source */
+	tmr_writel(wdt->tmr, TMRCSSR_SRC_USEC, TMRCSSR);
+
+	/* configure timer (system reset happens on the fifth expiration) */
+	value = TMRCR_PTV(wdt->base.timeout * USEC_PER_SEC / 5) |
+		TMRCR_PERIODIC | TMRCR_ENABLE;
+	tmr_writel(wdt->tmr, value, TMRCR);
+
+	if (!wdt->locked) {
+		value = wdt_readl(wdt, WDTCR);
+
+		/* select the proper timer source */
+		value &= ~WDTCR_TIMER_SOURCE_MASK;
+		value |= WDTCR_TIMER_SOURCE(wdt->tmr->index);
+
+		/* single timer period since that's already configured */
+		value &= ~WDTCR_PERIOD_MASK;
+		value |= WDTCR_PERIOD(1);
+
+		/* enable local interrupt for WDT petting */
+		value |= WDTCR_LOCAL_INT_ENABLE;
+
+		/* enable local FIQ and remote interrupt for debug dump */
+		if (0)
+			value |= WDTCR_REMOTE_INT_ENABLE |
+				 WDTCR_LOCAL_FIQ_ENABLE;
+
+		/* enable system debug reset (doesn't properly reboot) */
+		if (0)
+			value |= WDTCR_SYSTEM_DEBUG_RESET_ENABLE;
+
+		/* enable system POR reset */
+		value |= WDTCR_SYSTEM_POR_RESET_ENABLE;
+
+		wdt_writel(wdt, value, WDTCR);
+	}
+
+	wdt_writel(wdt, WDTCMDR_START_COUNTER, WDTCMDR);
+}
+
+static int tegra186_wdt_start(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_stop(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_ping(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+	wdt->base.timeout = timeout;
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static const struct watchdog_ops tegra186_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = tegra186_wdt_start,
+	.stop = tegra186_wdt_stop,
+	.ping = tegra186_wdt_ping,
+	.set_timeout = tegra186_wdt_set_timeout,
+};
+
+static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset = 0x10000, source;
+	struct tegra186_wdt *wdt;
+	u32 value;
+	int err;
+
+	offset += tegra->soc->num_timers * 0x10000 + index * 0x10000;
+
+	wdt = devm_kzalloc(tegra->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return ERR_PTR(-ENOMEM);
+
+	wdt->regs = tegra->regs + offset;
+	wdt->index = index;
+
+	/* read the watchdog configuration since it might be locked down */
+	value = wdt_readl(wdt, WDTCR);
+
+	if (value & WDTCR_LOCAL_INT_ENABLE)
+		wdt->locked = true;
+
+	source = value & WDTCR_TIMER_SOURCE_MASK;
+
+	wdt->tmr = tegra186_tmr_create(tegra, source);
+	if (IS_ERR(wdt->tmr))
+		return ERR_CAST(wdt->tmr);
+
+	wdt->base.info = &tegra186_wdt_info;
+	wdt->base.ops = &tegra186_wdt_ops;
+	wdt->base.min_timeout = 1;
+	wdt->base.max_timeout = 255;
+	wdt->base.parent = tegra->dev;
+
+	err = watchdog_init_timeout(&wdt->base, 5, tegra->dev);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	return wdt;
+}
+
+static irqreturn_t tegra186_timer_irq(int irq, void *data)
+{
+	struct tegra186_timer *tegra = data;
+
+	if (tegra->wdt) {
+		tegra186_wdt_disable(tegra->wdt);
+		tegra186_wdt_enable(tegra->wdt);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int tegra186_timer_probe(struct platform_device *pdev)
+{
+	struct tegra186_timer *tegra;
+	int err;
+
+	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	tegra->soc = of_device_get_match_data(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, tegra);
+	tegra->dev = &pdev->dev;
+
+	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tegra->regs))
+		return PTR_ERR(tegra->regs);
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to get interrupt #0: %d\n", err);
+		return err;
+	}
+
+	tegra->irq = err;
+
+	err = devm_request_irq(tegra->dev, tegra->irq, tegra186_timer_irq,
+			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			       "tegra186-timer", tegra);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to request IRQ#%u: %d\n",
+			tegra->irq, err);
+		return err;
+	}
+
+	/* create a watchdog using a preconfigured timer */
+	tegra->wdt = tegra186_wdt_create(tegra, 0);
+	if (IS_ERR(tegra->wdt)) {
+		err = PTR_ERR(tegra->wdt);
+		dev_err(&pdev->dev, "failed to create WDT: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
+			 tegra186_timer_resume);
+
+static const struct tegra186_timer_soc tegra186_timer = {
+	.num_timers = 10,
+	.num_wdts = 3,
+};
+
+static const struct of_device_id tegra186_timer_of_match[] = {
+	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
+	{ }
+};
+
+static struct platform_driver tegra186_wdt_driver = {
+	.driver = {
+		.name = "tegra186-timer",
+		.pm = &tegra186_timer_pm_ops,
+		.of_match_table = tegra186_timer_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra186_timer_probe,
+};
+module_platform_driver(tegra186_wdt_driver);
+
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra186 timers driver");
+MODULE_LICENSE("GPL v2");
-- 
2.24.1

