Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58978C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1840F21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIJDZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:25:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729741AbgIJDX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8618C8DEF45982C07999;
        Thu, 10 Sep 2020 11:22:59 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 11:22:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH 4/6] clocksource: sp804: support non-standard register offset
Date:   Thu, 10 Sep 2020 11:14:17 +0800
Message-ID: <20200910031419.2790-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200910031419.2790-1-thunder.leizhen@huawei.com>
References: <20200910031419.2790-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Currently, we get a timer register address by: add the constant register
offset to the timer base address. e.g. "base + TIMER_CTRL". It can not be
dynamically adjusted at run time.

So create a new structure "sp804_timer" to record the original registers
offset, and create a new structure "sp804_clkevt" to record the
calculated registers address. So the "base + TIMER_CTRL" is changed to
"clkevt->ctrl", this will faster than "base + timer->ctrl".

For example:
	struct sp804_timer arm_sp804_timer = {
		.ctrl	= TIMER_CTRL,
	};

	struct sp804_clkevt clkevt;

	clkevt.ctrl = base + arm_sp804_timer.ctrl;

-	writel(0, base + TIMER_CTRL);
+	writel(0, clkevt.ctrl);

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp.h    |  26 +++++++
 drivers/clocksource/timer-sp804.c | 108 +++++++++++++++++++++++-------
 2 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index b2037eb94a41..1ab75cbed0e0 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -10,6 +10,7 @@
  *
  * Every SP804 contains two identical timers.
  */
+#define NR_TIMERS	2
 #define TIMER_1_BASE	0x00
 #define TIMER_2_BASE	0x20
 
@@ -29,3 +30,28 @@
 #define TIMER_RIS	0x10			/*  CVR ro */
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
+
+struct sp804_timer {
+	int load;
+	int value;
+	int ctrl;
+	int intclr;
+	int ris;
+	int mis;
+	int bgload;
+	int timer_base[NR_TIMERS];
+	int width;
+};
+
+struct sp804_clkevt {
+	void __iomem *base;
+	void __iomem *load;
+	void __iomem *value;
+	void __iomem *ctrl;
+	void __iomem *intclr;
+	void __iomem *ris;
+	void __iomem *mis;
+	void __iomem *bgload;
+	unsigned long reload;
+	int width;
+};
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e0c3779621eb..68440e139dfd 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,17 @@
 
 #include "timer-sp.h"
 
+struct sp804_timer __initdata arm_sp804_timer = {
+	.load		= TIMER_LOAD,
+	.value		= TIMER_VALUE,
+	.ctrl		= TIMER_CTRL,
+	.intclr		= TIMER_INTCLR,
+	.timer_base	= {TIMER_1_BASE, TIMER_2_BASE},
+	.width		= 32,
+};
+
+static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
+
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
@@ -58,11 +69,26 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	return rate;
 }
 
-static void __iomem *sched_clock_base;
+static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		if (sp804_clkevt[i].base == base)
+			return &sp804_clkevt[i];
+	}
+
+	/* It's impossible to reach here */
+	WARN_ON(1);
+
+	return NULL;
+}
+
+static struct sp804_clkevt *sched_clkevt;
 
 static u64 notrace sp804_read(void)
 {
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+	return ~readl_relaxed(sched_clkevt->value);
 }
 
 int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
@@ -71,22 +97,25 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						  int use_sched_clock)
 {
 	long rate;
+	struct sp804_clkevt *clkevt;
 
 	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-	writel(0, base + TIMER_CTRL);
-	writel(0xffffffff, base + TIMER_LOAD);
-	writel(0xffffffff, base + TIMER_VALUE);
+	clkevt = sp804_clkevt_get(base);
+
+	writel(0, clkevt->ctrl);
+	writel(0xffffffff, clkevt->load);
+	writel(0xffffffff, clkevt->value);
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		base + TIMER_CTRL);
+		clkevt->ctrl);
 
-	clocksource_mmio_init(base + TIMER_VALUE, name,
+	clocksource_mmio_init(clkevt->value, name,
 		rate, 200, 32, clocksource_mmio_readl_down);
 
 	if (use_sched_clock) {
-		sched_clock_base = base;
+		sched_clkevt = clkevt;
 		sched_clock_register(sp804_read, 32, rate);
 	}
 
@@ -94,8 +123,7 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 }
 
 
-static void __iomem *clkevt_base;
-static unsigned long clkevt_reload;
+static struct sp804_clkevt *common_clkevt;
 
 /*
  * IRQ handler for the timer
@@ -105,7 +133,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
+	writel(1, common_clkevt->intclr);
 
 	evt->event_handler(evt);
 
@@ -114,7 +142,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
 static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	writel(0, clkevt_base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
@@ -129,8 +157,8 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
 	timer_shutdown(evt);
-	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(common_clkevt->reload, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 	return 0;
 }
 
@@ -140,8 +168,8 @@ static int sp804_set_next_event(unsigned long next,
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
 
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(next, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 
 	return 0;
 }
@@ -168,13 +196,13 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	if (rate < 0)
 		return -EINVAL;
 
-	clkevt_base = base;
-	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
+	common_clkevt = sp804_clkevt_get(base);
+	common_clkevt->reload = DIV_ROUND_CLOSEST(rate, HZ);
 	evt->name = name;
 	evt->irq = irq;
 	evt->cpumask = cpu_possible_mask;
 
-	writel(0, base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
@@ -184,7 +212,26 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	return 0;
 }
 
-static int __init sp804_of_init(struct device_node *np)
+static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		void __iomem *timer_base;
+		struct sp804_clkevt *clkevt;
+
+		timer_base = base + timer->timer_base[i];
+		clkevt = &sp804_clkevt[i];
+		clkevt->base	= timer_base;
+		clkevt->load	= timer_base + timer->load;
+		clkevt->value	= timer_base + timer->value;
+		clkevt->ctrl	= timer_base + timer->ctrl;
+		clkevt->intclr	= timer_base + timer->intclr;
+		clkevt->width	= timer->width;
+	}
+}
+
+static int __init sp804_of_init(struct device_node *np, struct sp804_timer *timer)
 {
 	static bool initialized = false;
 	void __iomem *base;
@@ -199,12 +246,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
-	timer1_base = base;
-	timer2_base = base + TIMER_2_BASE;
+	timer1_base = base + timer->timer_base[0];
+	timer2_base = base + timer->timer_base[1];
 
 	/* Ensure timers are disabled */
-	writel(0, timer1_base + TIMER_CTRL);
-	writel(0, timer2_base + TIMER_CTRL);
+	writel(0, timer1_base + timer->ctrl);
+	writel(0, timer2_base + timer->ctrl);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -230,6 +277,8 @@ static int __init sp804_of_init(struct device_node *np)
 	if (irq <= 0)
 		goto err;
 
+	sp804_clkevt_init(timer, base);
+
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
@@ -259,7 +308,12 @@ static int __init sp804_of_init(struct device_node *np)
 	iounmap(base);
 	return ret;
 }
-TIMER_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
+
+static int __init arm_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &arm_sp804_timer);
+}
+TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
 static int __init integrator_cp_of_init(struct device_node *np)
 {
@@ -282,11 +336,13 @@ static int __init integrator_cp_of_init(struct device_node *np)
 	}
 
 	/* Ensure timer is disabled */
-	writel(0, base + TIMER_CTRL);
+	writel(0, base + arm_sp804_timer.ctrl);
 
 	if (init_count == 2 || !of_device_is_available(np))
 		goto err;
 
+	sp804_clkevt_init(&arm_sp804_timer, base);
+
 	if (!init_count) {
 		ret = sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
 		if (ret)
-- 
2.26.0.106.g9fadedd


