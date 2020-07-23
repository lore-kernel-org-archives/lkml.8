Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F75C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01EC22B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDTwceFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgGWP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgGWP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C67C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so5596463wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=En0lr/VzzngR9tqy61OUwfv+moVc2X+fqbca8TirrBs=;
        b=uDTwceFA/YfSlC8QJVeph0MsWi0DHBL/sbf7V/39SHHTc/gStaxqdrJ5n/A7s1ziyM
         cyyoLAn0NUpbr+kYIMpbZlNjW3QHpt7qhJvVJ7QjZYskmA4kQ1C5IZ6lwWByvZFPdJyV
         Ji53b9Vx8tAZd5lwhBOvFSYBxwie/0eyvGndFZbM1nlBLyEko/ZKmqyz1dSyJ0RsoR+e
         ie9lNZaJ6WBDfPEufJy1veUPU16uBsYZGYUyfObxJ4yV7BMgV7rI+qG1qGfMp+p7A4DX
         53fba/2T6oJvTr3yhFVYtxCyMSvDtfgeHeey58s0UyEsZAdJbbJULf12Ha1iASuad4LI
         dGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=En0lr/VzzngR9tqy61OUwfv+moVc2X+fqbca8TirrBs=;
        b=HcuZkOVPK4jXXuzcRYYALUaXtQoceXHmI+uN+fP5EuHvhrmbIfkA/ZqT90pvpE8i0U
         gP5xtrpTWuhLP012rMHRxgvQ/DbfkI2G66hRKVzpRhDOpOjF/J3AztTvxCQJKdvwmqwf
         YyVjsiMeVmFOrPQVKjNqF72wdUU8bPTc335HL3DFWvp2NWBKgNflblmEl7T228HtyQmI
         dvG5yq6ZHuqNp+dgGHGlBQH+ll+E84u0WU8es67knyLyt2VOTis4KwkTUI4Ug26spl4R
         du3K/hLL+telnD/WV7FEO1njpcv2cYhzAsJ6zOh7QHwjHxOm7Poclwg3Czfu6CbNl7Ry
         Wivg==
X-Gm-Message-State: AOAM530e9UFaA2na5RDoEdGEpJj49tS7k2rIsRRJBNp5FPnJ7DmrbAJq
        gX/lf35zVbKz2JPRtihWczVJPS+1dnYTrw==
X-Google-Smtp-Source: ABdhPJwTRGfZ8U+deS6ZrOxBzPf1Fn1qo3sqRKR5jqUOY5YYKwNMlEGxOh9OAkyy/Dr1EI+Lu0qDMA==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr3643377wrn.145.1595518035339;
        Thu, 23 Jul 2020 08:27:15 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>,
        =?UTF-8?q?=E5=91=A8=E6=AD=A3?= <sernia.zhou@foxmail.com>,
        =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF?= <aric.pzqi@ingenic.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 16/16] clocksource/drivers/ingenic: Add support for the Ingenic X1000 OST.
Date:   Thu, 23 Jul 2020 17:26:36 +0200
Message-Id: <20200723152639.639771-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
OST, it no longer belongs to TCU. This driver will register both a
clocksource and a sched_clock to the system.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200722171804.97559-3-zhouyanjie@wanyeetech.com
---
 drivers/clocksource/Kconfig          |  12 +-
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/ingenic-sysost.c | 539 +++++++++++++++++++++++++++
 3 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clocksource/ingenic-sysost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9936d1534998..2ed8b4361d95 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -697,8 +697,18 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config INGENIC_SYSOST
+	bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select MFD_SYSCON
+	select TIMER_OF
+	select IRQ_DOMAIN
+	help
+	  Support for the SYSOST of the Ingenic X Series SoCs.
+
 config INGENIC_OST
-	bool "Clocksource for Ingenic OS Timer"
+	bool "Clocksource using the OST in Ingenic JZ SoCs"
 	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
 	select MFD_SYSCON
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index bdda1a2e4097..3994e221e262 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
+obj-$(CONFIG_INGENIC_SYSOST)	+= ingenic-sysost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingenic-sysost.c
new file mode 100644
index 000000000000..e77d58449005
--- /dev/null
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic XBurst SoCs SYSOST clocks driver
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/clock/ingenic,sysost.h>
+
+/* OST register offsets */
+#define OST_REG_OSTCCR			0x00
+#define OST_REG_OSTCR			0x08
+#define OST_REG_OSTFR			0x0c
+#define OST_REG_OSTMR			0x10
+#define OST_REG_OST1DFR			0x14
+#define OST_REG_OST1CNT			0x18
+#define OST_REG_OST2CNTL		0x20
+#define OST_REG_OSTCNT2HBUF		0x24
+#define OST_REG_OSTESR			0x34
+#define OST_REG_OSTECR			0x38
+
+/* bits within the OSTCCR register */
+#define OSTCCR_PRESCALE1_MASK	0x3
+#define OSTCCR_PRESCALE2_MASK	0xc
+#define OSTCCR_PRESCALE1_LSB	0
+#define OSTCCR_PRESCALE2_LSB	2
+
+/* bits within the OSTCR register */
+#define OSTCR_OST1CLR			BIT(0)
+#define OSTCR_OST2CLR			BIT(1)
+
+/* bits within the OSTFR register */
+#define OSTFR_FFLAG				BIT(0)
+
+/* bits within the OSTMR register */
+#define OSTMR_FMASK				BIT(0)
+
+/* bits within the OSTESR register */
+#define OSTESR_OST1ENS			BIT(0)
+#define OSTESR_OST2ENS			BIT(1)
+
+/* bits within the OSTECR register */
+#define OSTECR_OST1ENC			BIT(0)
+#define OSTECR_OST2ENC			BIT(1)
+
+struct ingenic_soc_info {
+	unsigned int num_channels;
+};
+
+struct ingenic_ost_clk_info {
+	struct clk_init_data init_data;
+	u8 ostccr_reg;
+};
+
+struct ingenic_ost_clk {
+	struct clk_hw hw;
+	unsigned int idx;
+	struct ingenic_ost *ost;
+	const struct ingenic_ost_clk_info *info;
+};
+
+struct ingenic_ost {
+	void __iomem *base;
+	const struct ingenic_soc_info *soc_info;
+	struct clk *clk, *percpu_timer_clk, *global_timer_clk;
+	struct clock_event_device cevt;
+	struct clocksource cs;
+	char name[20];
+
+	struct clk_hw_onecell_data *clocks;
+};
+
+static struct ingenic_ost *ingenic_ost;
+
+static inline struct ingenic_ost_clk *to_ost_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct ingenic_ost_clk, hw);
+}
+
+static unsigned long ingenic_ost_percpu_timer_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	unsigned int prescale;
+
+	prescale = readl(ost_clk->ost->base + info->ostccr_reg);
+
+	prescale = (prescale & OSTCCR_PRESCALE1_MASK) >> OSTCCR_PRESCALE1_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static unsigned long ingenic_ost_global_timer_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	unsigned int prescale;
+
+	prescale = readl(ost_clk->ost->base + info->ostccr_reg);
+
+	prescale = (prescale & OSTCCR_PRESCALE2_MASK) >> OSTCCR_PRESCALE2_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static u8 ingenic_ost_get_prescale(unsigned long rate, unsigned long req_rate)
+{
+	u8 prescale;
+
+	for (prescale = 0; prescale < 2; prescale++)
+		if ((rate >> (prescale * 2)) <= req_rate)
+			return prescale;
+
+	return 2; /* /16 divider */
+}
+
+static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long *parent_rate)
+{
+	unsigned long rate = *parent_rate;
+	u8 prescale;
+
+	if (req_rate > rate)
+		return rate;
+
+	prescale = ingenic_ost_get_prescale(rate, req_rate);
+
+	return rate >> (prescale * 2);
+}
+
+static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	u8 prescale = ingenic_ost_get_prescale(parent_rate, req_rate);
+	int val;
+
+	val = readl(ost_clk->ost->base + info->ostccr_reg);
+	val = (val & ~OSTCCR_PRESCALE1_MASK) | (prescale << OSTCCR_PRESCALE1_LSB);
+	writel(val, ost_clk->ost->base + info->ostccr_reg);
+
+	return 0;
+}
+
+static int ingenic_ost_global_timer_set_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	u8 prescale = ingenic_ost_get_prescale(parent_rate, req_rate);
+	int val;
+
+	val = readl(ost_clk->ost->base + info->ostccr_reg);
+	val = (val & ~OSTCCR_PRESCALE2_MASK) | (prescale << OSTCCR_PRESCALE2_LSB);
+	writel(val, ost_clk->ost->base + info->ostccr_reg);
+
+	return 0;
+}
+
+static const struct clk_ops ingenic_ost_percpu_timer_ops = {
+	.recalc_rate	= ingenic_ost_percpu_timer_recalc_rate,
+	.round_rate		= ingenic_ost_round_rate,
+	.set_rate		= ingenic_ost_percpu_timer_set_rate,
+};
+
+static const struct clk_ops ingenic_ost_global_timer_ops = {
+	.recalc_rate	= ingenic_ost_global_timer_recalc_rate,
+	.round_rate		= ingenic_ost_round_rate,
+	.set_rate		= ingenic_ost_global_timer_set_rate,
+};
+
+static const char * const ingenic_ost_clk_parents[] = { "ext" };
+
+static const struct ingenic_ost_clk_info ingenic_ost_clk_info[] = {
+	[OST_CLK_PERCPU_TIMER] = {
+		.init_data = {
+			.name = "percpu timer",
+			.parent_names = ingenic_ost_clk_parents,
+			.num_parents = ARRAY_SIZE(ingenic_ost_clk_parents),
+			.ops = &ingenic_ost_percpu_timer_ops,
+			.flags = CLK_SET_RATE_UNGATE,
+		},
+		.ostccr_reg = OST_REG_OSTCCR,
+	},
+
+	[OST_CLK_GLOBAL_TIMER] = {
+		.init_data = {
+			.name = "global timer",
+			.parent_names = ingenic_ost_clk_parents,
+			.num_parents = ARRAY_SIZE(ingenic_ost_clk_parents),
+			.ops = &ingenic_ost_global_timer_ops,
+			.flags = CLK_SET_RATE_UNGATE,
+		},
+		.ostccr_reg = OST_REG_OSTCCR,
+	},
+};
+
+static u64 notrace ingenic_ost_global_timer_read_cntl(void)
+{
+	struct ingenic_ost *ost = ingenic_ost;
+	unsigned int count;
+
+	count = readl(ost->base + OST_REG_OST2CNTL);
+
+	return count;
+}
+
+static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
+{
+	return ingenic_ost_global_timer_read_cntl();
+}
+
+static inline struct ingenic_ost *to_ingenic_ost(struct clock_event_device *evt)
+{
+	return container_of(evt, struct ingenic_ost, cevt);
+}
+
+static int ingenic_ost_cevt_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
+
+	return 0;
+}
+
+static int ingenic_ost_cevt_set_next(unsigned long next,
+				     struct clock_event_device *evt)
+{
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel((u32)~OSTFR_FFLAG, ost->base + OST_REG_OSTFR);
+	writel(next, ost->base + OST_REG_OST1DFR);
+	writel(OSTCR_OST1CLR, ost->base + OST_REG_OSTCR);
+	writel(OSTESR_OST1ENS, ost->base + OST_REG_OSTESR);
+	writel((u32)~OSTMR_FMASK, ost->base + OST_REG_OSTMR);
+
+	return 0;
+}
+
+static irqreturn_t ingenic_ost_cevt_cb(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ingenic_ost_register_clock(struct ingenic_ost *ost,
+			unsigned int idx, const struct ingenic_ost_clk_info *info,
+			struct clk_hw_onecell_data *clocks)
+{
+	struct ingenic_ost_clk *ost_clk;
+	int val, err;
+
+	ost_clk = kzalloc(sizeof(*ost_clk), GFP_KERNEL);
+	if (!ost_clk)
+		return -ENOMEM;
+
+	ost_clk->hw.init = &info->init_data;
+	ost_clk->idx = idx;
+	ost_clk->info = info;
+	ost_clk->ost = ost;
+
+	/* Reset clock divider */
+	val = readl(ost->base + info->ostccr_reg);
+	val &= ~(OSTCCR_PRESCALE1_MASK | OSTCCR_PRESCALE2_MASK);
+	writel(val, ost->base + info->ostccr_reg);
+
+	err = clk_hw_register(NULL, &ost_clk->hw);
+	if (err) {
+		kfree(ost_clk);
+		return err;
+	}
+
+	clocks->hws[idx] = &ost_clk->hw;
+
+	return 0;
+}
+
+static struct clk * __init ingenic_ost_get_clock(struct device_node *np, int id)
+{
+	struct of_phandle_args args;
+
+	args.np = np;
+	args.args_count = 1;
+	args.args[0] = id;
+
+	return of_clk_get_from_provider(&args);
+}
+
+static int __init ingenic_ost_percpu_timer_init(struct device_node *np,
+					 struct ingenic_ost *ost)
+{
+	unsigned int timer_virq, channel = OST_CLK_PERCPU_TIMER;
+	unsigned long rate;
+	int err;
+
+	ost->percpu_timer_clk = ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->percpu_timer_clk))
+		return PTR_ERR(ost->percpu_timer_clk);
+
+	err = clk_prepare_enable(ost->percpu_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate = clk_get_rate(ost->percpu_timer_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	timer_virq = of_irq_get(np, 0);
+	if (!timer_virq) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	snprintf(ost->name, sizeof(ost->name), "OST percpu timer");
+
+	err = request_irq(timer_virq, ingenic_ost_cevt_cb, IRQF_TIMER,
+			  ost->name, &ost->cevt);
+	if (err)
+		goto err_irq_dispose_mapping;
+
+	ost->cevt.cpumask = cpumask_of(smp_processor_id());
+	ost->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	ost->cevt.name = ost->name;
+	ost->cevt.rating = 400;
+	ost->cevt.set_state_shutdown = ingenic_ost_cevt_set_state_shutdown;
+	ost->cevt.set_next_event = ingenic_ost_cevt_set_next;
+
+	clockevents_config_and_register(&ost->cevt, rate, 4, 0xffffffff);
+
+	return 0;
+
+err_irq_dispose_mapping:
+	irq_dispose_mapping(timer_virq);
+err_clk_disable:
+	clk_disable_unprepare(ost->percpu_timer_clk);
+err_clk_put:
+	clk_put(ost->percpu_timer_clk);
+	return err;
+}
+
+static int __init ingenic_ost_global_timer_init(struct device_node *np,
+					       struct ingenic_ost *ost)
+{
+	unsigned int channel = OST_CLK_GLOBAL_TIMER;
+	struct clocksource *cs = &ost->cs;
+	unsigned long rate;
+	int err;
+
+	ost->global_timer_clk = ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->global_timer_clk))
+		return PTR_ERR(ost->global_timer_clk);
+
+	err = clk_prepare_enable(ost->global_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate = clk_get_rate(ost->global_timer_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* Clear counter CNT registers */
+	writel(OSTCR_OST2CLR, ost->base + OST_REG_OSTCR);
+
+	/* Enable OST channel */
+	writel(OSTESR_OST2ENS, ost->base + OST_REG_OSTESR);
+
+	cs->name = "ingenic-ost";
+	cs->rating = 400;
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask = CLOCKSOURCE_MASK(32);
+	cs->read = ingenic_ost_clocksource_read;
+
+	err = clocksource_register_hz(cs, rate);
+	if (err)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(ost->global_timer_clk);
+err_clk_put:
+	clk_put(ost->global_timer_clk);
+	return err;
+}
+
+static const struct ingenic_soc_info x1000_soc_info = {
+	.num_channels = 2,
+};
+
+static const struct of_device_id __maybe_unused ingenic_ost_of_match[] __initconst = {
+	{ .compatible = "ingenic,x1000-ost", .data = &x1000_soc_info, },
+	{ /* sentinel */ }
+};
+
+static int __init ingenic_ost_probe(struct device_node *np)
+{
+	const struct of_device_id *id = of_match_node(ingenic_ost_of_match, np);
+	struct ingenic_ost *ost;
+	unsigned int i;
+	int ret;
+
+	ost = kzalloc(sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ost->base = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(ost->base)) {
+		pr_err("%s: Failed to map OST registers\n", __func__);
+		ret = PTR_ERR(ost->base);
+		goto err_free_ost;
+	}
+
+	ost->clk = of_clk_get_by_name(np, "ost");
+	if (IS_ERR(ost->clk)) {
+		ret = PTR_ERR(ost->clk);
+		pr_crit("%s: Cannot get OST clock\n", __func__);
+		goto err_free_ost;
+	}
+
+	ret = clk_prepare_enable(ost->clk);
+	if (ret) {
+		pr_crit("%s: Unable to enable OST clock\n", __func__);
+		goto err_put_clk;
+	}
+
+	ost->soc_info = id->data;
+
+	ost->clocks = kzalloc(struct_size(ost->clocks, hws, ost->soc_info->num_channels),
+			      GFP_KERNEL);
+	if (!ost->clocks) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
+	ost->clocks->num = ost->soc_info->num_channels;
+
+	for (i = 0; i < ost->clocks->num; i++) {
+		ret = ingenic_ost_register_clock(ost, i, &ingenic_ost_clk_info[i], ost->clocks);
+		if (ret) {
+			pr_crit("%s: Cannot register clock %d\n", __func__, i);
+			goto err_unregister_ost_clocks;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ost->clocks);
+	if (ret) {
+		pr_crit("%s: Cannot add OF clock provider\n", __func__);
+		goto err_unregister_ost_clocks;
+	}
+
+	ingenic_ost = ost;
+
+	return 0;
+
+err_unregister_ost_clocks:
+	for (i = 0; i < ost->clocks->num; i++)
+		if (ost->clocks->hws[i])
+			clk_hw_unregister(ost->clocks->hws[i]);
+	kfree(ost->clocks);
+err_clk_disable:
+	clk_disable_unprepare(ost->clk);
+err_put_clk:
+	clk_put(ost->clk);
+err_free_ost:
+	kfree(ost);
+	return ret;
+}
+
+static int __init ingenic_ost_init(struct device_node *np)
+{
+	struct ingenic_ost *ost;
+	unsigned long rate;
+	int ret;
+
+	ret = ingenic_ost_probe(np);
+	if (ret) {
+		pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__, ret);
+		return ret;
+	}
+
+	of_node_clear_flag(np, OF_POPULATED);
+
+	ost = ingenic_ost;
+	if (IS_ERR(ost))
+		return PTR_ERR(ost);
+
+	ret = ingenic_ost_global_timer_init(np, ost);
+	if (ret) {
+		pr_crit("%s: Unable to init global timer: %x\n", __func__, ret);
+		goto err_free_ingenic_ost;
+	}
+
+	ret = ingenic_ost_percpu_timer_init(np, ost);
+	if (ret)
+		goto err_ost_global_timer_cleanup;
+
+	/* Register the sched_clock at the end as there's no way to undo it */
+	rate = clk_get_rate(ost->global_timer_clk);
+	sched_clock_register(ingenic_ost_global_timer_read_cntl, 32, rate);
+
+	return 0;
+
+err_ost_global_timer_cleanup:
+	clocksource_unregister(&ost->cs);
+	clk_disable_unprepare(ost->global_timer_clk);
+	clk_put(ost->global_timer_clk);
+err_free_ingenic_ost:
+	kfree(ost);
+	return ret;
+}
+
+TIMER_OF_DECLARE(x1000_ost,  "ingenic,x1000-ost",  ingenic_ost_init);
-- 
2.25.1

