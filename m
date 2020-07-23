Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0875C433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8920709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLYnd4JC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPJjUiXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGWTKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:10:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:42 -0400
Date:   Thu, 23 Jul 2020 19:09:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTgNlyUTfo/nbjkbD9gHSp3PIhgnpUG5A8VgfBwPZWg=;
        b=pLYnd4JCrGlU0vgV7UVj+56lPgOe70o2Qchc4SnTTqS0v+9YFkwmmg9ZOm5/LQVDZh9jsf
        Yy48Q361oz30V8qrI6KQ/ukK30acW58ZaMGTBA+YJ9nf5AuEPdvxnJW3aY8RQbCeMovPqE
        lqLIk6gwcPJl3U30o085ow6Pry3C8Qg0HBJNmkQpGBzuOtRmQC0K2vk3ns8FaIPa3qHwLb
        /Oq4LqnCG+S41W1vJ5w5OVvSO0wX114SIb7yaqTROVeWB6ylcze2xtlNm10bYdTA/dGUQ+
        04ZCFvVJOvXoWKvi3eJnUXfhK9bvYVW9edU0yd2FvXnk48DqtUqUnaMBRVYDiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTgNlyUTfo/nbjkbD9gHSp3PIhgnpUG5A8VgfBwPZWg=;
        b=zPJjUiXPTBFQfnZzip8JptB7/k1k1k6kiHtwwLkW5Ar+OyNDknIbZcvrZf7ivz3dILlPnB
        PyPZwH0Ox57nTwDw==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Add support for the
 Ingenic X1000 OST.
Cc:     sernia.zhou@foxmail.com, aric.pzqi@ingenic.com,
        zhouyanjie@wanyeetech.com, Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722171804.97559-3-zhouyanjie@wanyeetech.com>
References: <20200722171804.97559-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <159553137700.4006.8463650588532881488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5ecafc120bbea614c9d29d0ee2cbb77bbb786059
Gitweb:        https://git.kernel.org/tip/5ecafc120bbea614c9d29d0ee2cbb77bbb7=
86059
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Thu, 23 Jul 2020 01:18:04 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:58:09 +02:00

clocksource/drivers/ingenic: Add support for the Ingenic X1000 OST.

X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
OST, it no longer belongs to TCU. This driver will register both a
clocksource and a sched_clock to the system.

Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingenic=
.com>
Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingenic.c=
om>
Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200722171804.97559-3-zhouyanjie@wanyeetech.=
com
---
 drivers/clocksource/Kconfig          |  12 +-
 drivers/clocksource/Makefile         |   1 +-
 drivers/clocksource/ingenic-sysost.c | 539 ++++++++++++++++++++++++++-
 3 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clocksource/ingenic-sysost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9936d15..2ed8b43 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -697,8 +697,18 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
=20
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
index bdda1a2..3994e22 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+=3D h8300_tpu.o
 obj-$(CONFIG_INGENIC_OST)		+=3D ingenic-ost.o
+obj-$(CONFIG_INGENIC_SYSOST)	+=3D ingenic-sysost.o
 obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
new file mode 100644
index 0000000..e77d584
--- /dev/null
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic XBurst SoCs SYSOST clocks driver
+ * Copyright (c) 2020 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@=
wanyeetech.com>
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
+	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
+	unsigned int prescale;
+
+	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
+
+	prescale =3D (prescale & OSTCCR_PRESCALE1_MASK) >> OSTCCR_PRESCALE1_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static unsigned long ingenic_ost_global_timer_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
+	unsigned int prescale;
+
+	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
+
+	prescale =3D (prescale & OSTCCR_PRESCALE2_MASK) >> OSTCCR_PRESCALE2_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static u8 ingenic_ost_get_prescale(unsigned long rate, unsigned long req_rat=
e)
+{
+	u8 prescale;
+
+	for (prescale =3D 0; prescale < 2; prescale++)
+		if ((rate >> (prescale * 2)) <=3D req_rate)
+			return prescale;
+
+	return 2; /* /16 divider */
+}
+
+static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long *parent_rate)
+{
+	unsigned long rate =3D *parent_rate;
+	u8 prescale;
+
+	if (req_rate > rate)
+		return rate;
+
+	prescale =3D ingenic_ost_get_prescale(rate, req_rate);
+
+	return rate >> (prescale * 2);
+}
+
+static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw, unsigned lon=
g req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
+	u8 prescale =3D ingenic_ost_get_prescale(parent_rate, req_rate);
+	int val;
+
+	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
+	val =3D (val & ~OSTCCR_PRESCALE1_MASK) | (prescale << OSTCCR_PRESCALE1_LSB);
+	writel(val, ost_clk->ost->base + info->ostccr_reg);
+
+	return 0;
+}
+
+static int ingenic_ost_global_timer_set_rate(struct clk_hw *hw, unsigned lon=
g req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk =3D to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info =3D ost_clk->info;
+	u8 prescale =3D ingenic_ost_get_prescale(parent_rate, req_rate);
+	int val;
+
+	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
+	val =3D (val & ~OSTCCR_PRESCALE2_MASK) | (prescale << OSTCCR_PRESCALE2_LSB);
+	writel(val, ost_clk->ost->base + info->ostccr_reg);
+
+	return 0;
+}
+
+static const struct clk_ops ingenic_ost_percpu_timer_ops =3D {
+	.recalc_rate	=3D ingenic_ost_percpu_timer_recalc_rate,
+	.round_rate		=3D ingenic_ost_round_rate,
+	.set_rate		=3D ingenic_ost_percpu_timer_set_rate,
+};
+
+static const struct clk_ops ingenic_ost_global_timer_ops =3D {
+	.recalc_rate	=3D ingenic_ost_global_timer_recalc_rate,
+	.round_rate		=3D ingenic_ost_round_rate,
+	.set_rate		=3D ingenic_ost_global_timer_set_rate,
+};
+
+static const char * const ingenic_ost_clk_parents[] =3D { "ext" };
+
+static const struct ingenic_ost_clk_info ingenic_ost_clk_info[] =3D {
+	[OST_CLK_PERCPU_TIMER] =3D {
+		.init_data =3D {
+			.name =3D "percpu timer",
+			.parent_names =3D ingenic_ost_clk_parents,
+			.num_parents =3D ARRAY_SIZE(ingenic_ost_clk_parents),
+			.ops =3D &ingenic_ost_percpu_timer_ops,
+			.flags =3D CLK_SET_RATE_UNGATE,
+		},
+		.ostccr_reg =3D OST_REG_OSTCCR,
+	},
+
+	[OST_CLK_GLOBAL_TIMER] =3D {
+		.init_data =3D {
+			.name =3D "global timer",
+			.parent_names =3D ingenic_ost_clk_parents,
+			.num_parents =3D ARRAY_SIZE(ingenic_ost_clk_parents),
+			.ops =3D &ingenic_ost_global_timer_ops,
+			.flags =3D CLK_SET_RATE_UNGATE,
+		},
+		.ostccr_reg =3D OST_REG_OSTCCR,
+	},
+};
+
+static u64 notrace ingenic_ost_global_timer_read_cntl(void)
+{
+	struct ingenic_ost *ost =3D ingenic_ost;
+	unsigned int count;
+
+	count =3D readl(ost->base + OST_REG_OST2CNTL);
+
+	return count;
+}
+
+static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
+{
+	return ingenic_ost_global_timer_read_cntl();
+}
+
+static inline struct ingenic_ost *to_ingenic_ost(struct clock_event_device *=
evt)
+{
+	return container_of(evt, struct ingenic_ost, cevt);
+}
+
+static int ingenic_ost_cevt_set_state_shutdown(struct clock_event_device *ev=
t)
+{
+	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
+
+	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
+
+	return 0;
+}
+
+static int ingenic_ost_cevt_set_next(unsigned long next,
+				     struct clock_event_device *evt)
+{
+	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
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
+	struct clock_event_device *evt =3D dev_id;
+	struct ingenic_ost *ost =3D to_ingenic_ost(evt);
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
+	ost_clk =3D kzalloc(sizeof(*ost_clk), GFP_KERNEL);
+	if (!ost_clk)
+		return -ENOMEM;
+
+	ost_clk->hw.init =3D &info->init_data;
+	ost_clk->idx =3D idx;
+	ost_clk->info =3D info;
+	ost_clk->ost =3D ost;
+
+	/* Reset clock divider */
+	val =3D readl(ost->base + info->ostccr_reg);
+	val &=3D ~(OSTCCR_PRESCALE1_MASK | OSTCCR_PRESCALE2_MASK);
+	writel(val, ost->base + info->ostccr_reg);
+
+	err =3D clk_hw_register(NULL, &ost_clk->hw);
+	if (err) {
+		kfree(ost_clk);
+		return err;
+	}
+
+	clocks->hws[idx] =3D &ost_clk->hw;
+
+	return 0;
+}
+
+static struct clk * __init ingenic_ost_get_clock(struct device_node *np, int=
 id)
+{
+	struct of_phandle_args args;
+
+	args.np =3D np;
+	args.args_count =3D 1;
+	args.args[0] =3D id;
+
+	return of_clk_get_from_provider(&args);
+}
+
+static int __init ingenic_ost_percpu_timer_init(struct device_node *np,
+					 struct ingenic_ost *ost)
+{
+	unsigned int timer_virq, channel =3D OST_CLK_PERCPU_TIMER;
+	unsigned long rate;
+	int err;
+
+	ost->percpu_timer_clk =3D ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->percpu_timer_clk))
+		return PTR_ERR(ost->percpu_timer_clk);
+
+	err =3D clk_prepare_enable(ost->percpu_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate =3D clk_get_rate(ost->percpu_timer_clk);
+	if (!rate) {
+		err =3D -EINVAL;
+		goto err_clk_disable;
+	}
+
+	timer_virq =3D of_irq_get(np, 0);
+	if (!timer_virq) {
+		err =3D -EINVAL;
+		goto err_clk_disable;
+	}
+
+	snprintf(ost->name, sizeof(ost->name), "OST percpu timer");
+
+	err =3D request_irq(timer_virq, ingenic_ost_cevt_cb, IRQF_TIMER,
+			  ost->name, &ost->cevt);
+	if (err)
+		goto err_irq_dispose_mapping;
+
+	ost->cevt.cpumask =3D cpumask_of(smp_processor_id());
+	ost->cevt.features =3D CLOCK_EVT_FEAT_ONESHOT;
+	ost->cevt.name =3D ost->name;
+	ost->cevt.rating =3D 400;
+	ost->cevt.set_state_shutdown =3D ingenic_ost_cevt_set_state_shutdown;
+	ost->cevt.set_next_event =3D ingenic_ost_cevt_set_next;
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
+	unsigned int channel =3D OST_CLK_GLOBAL_TIMER;
+	struct clocksource *cs =3D &ost->cs;
+	unsigned long rate;
+	int err;
+
+	ost->global_timer_clk =3D ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->global_timer_clk))
+		return PTR_ERR(ost->global_timer_clk);
+
+	err =3D clk_prepare_enable(ost->global_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate =3D clk_get_rate(ost->global_timer_clk);
+	if (!rate) {
+		err =3D -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* Clear counter CNT registers */
+	writel(OSTCR_OST2CLR, ost->base + OST_REG_OSTCR);
+
+	/* Enable OST channel */
+	writel(OSTESR_OST2ENS, ost->base + OST_REG_OSTESR);
+
+	cs->name =3D "ingenic-ost";
+	cs->rating =3D 400;
+	cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask =3D CLOCKSOURCE_MASK(32);
+	cs->read =3D ingenic_ost_clocksource_read;
+
+	err =3D clocksource_register_hz(cs, rate);
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
+static const struct ingenic_soc_info x1000_soc_info =3D {
+	.num_channels =3D 2,
+};
+
+static const struct of_device_id __maybe_unused ingenic_ost_of_match[] __ini=
tconst =3D {
+	{ .compatible =3D "ingenic,x1000-ost", .data =3D &x1000_soc_info, },
+	{ /* sentinel */ }
+};
+
+static int __init ingenic_ost_probe(struct device_node *np)
+{
+	const struct of_device_id *id =3D of_match_node(ingenic_ost_of_match, np);
+	struct ingenic_ost *ost;
+	unsigned int i;
+	int ret;
+
+	ost =3D kzalloc(sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ost->base =3D of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(ost->base)) {
+		pr_err("%s: Failed to map OST registers\n", __func__);
+		ret =3D PTR_ERR(ost->base);
+		goto err_free_ost;
+	}
+
+	ost->clk =3D of_clk_get_by_name(np, "ost");
+	if (IS_ERR(ost->clk)) {
+		ret =3D PTR_ERR(ost->clk);
+		pr_crit("%s: Cannot get OST clock\n", __func__);
+		goto err_free_ost;
+	}
+
+	ret =3D clk_prepare_enable(ost->clk);
+	if (ret) {
+		pr_crit("%s: Unable to enable OST clock\n", __func__);
+		goto err_put_clk;
+	}
+
+	ost->soc_info =3D id->data;
+
+	ost->clocks =3D kzalloc(struct_size(ost->clocks, hws, ost->soc_info->num_ch=
annels),
+			      GFP_KERNEL);
+	if (!ost->clocks) {
+		ret =3D -ENOMEM;
+		goto err_clk_disable;
+	}
+
+	ost->clocks->num =3D ost->soc_info->num_channels;
+
+	for (i =3D 0; i < ost->clocks->num; i++) {
+		ret =3D ingenic_ost_register_clock(ost, i, &ingenic_ost_clk_info[i], ost->=
clocks);
+		if (ret) {
+			pr_crit("%s: Cannot register clock %d\n", __func__, i);
+			goto err_unregister_ost_clocks;
+		}
+	}
+
+	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ost->clocks);
+	if (ret) {
+		pr_crit("%s: Cannot add OF clock provider\n", __func__);
+		goto err_unregister_ost_clocks;
+	}
+
+	ingenic_ost =3D ost;
+
+	return 0;
+
+err_unregister_ost_clocks:
+	for (i =3D 0; i < ost->clocks->num; i++)
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
+	ret =3D ingenic_ost_probe(np);
+	if (ret) {
+		pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__, ret);
+		return ret;
+	}
+
+	of_node_clear_flag(np, OF_POPULATED);
+
+	ost =3D ingenic_ost;
+	if (IS_ERR(ost))
+		return PTR_ERR(ost);
+
+	ret =3D ingenic_ost_global_timer_init(np, ost);
+	if (ret) {
+		pr_crit("%s: Unable to init global timer: %x\n", __func__, ret);
+		goto err_free_ingenic_ost;
+	}
+
+	ret =3D ingenic_ost_percpu_timer_init(np, ost);
+	if (ret)
+		goto err_ost_global_timer_cleanup;
+
+	/* Register the sched_clock at the end as there's no way to undo it */
+	rate =3D clk_get_rate(ost->global_timer_clk);
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
