Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE9BC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3596321D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgIJDYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:24:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728405AbgIJDYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:24:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97D294C2AC19CB38FE89;
        Thu, 10 Sep 2020 11:22:59 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 11:22:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH 3/6] clocksource: sp804: prepare for support non-standard register offset
Date:   Thu, 10 Sep 2020 11:14:16 +0800
Message-ID: <20200910031419.2790-4-thunder.leizhen@huawei.com>
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

Do a bit of cleaning, to make the next patch looks more clear. The
details are as follows:
1. Remove a mismatched comment. It just temporarily disable a timer,
   and the timer will be set to periodic mode later.
2. Add two local variables: timer1_base and timer2_base in
   sp804_of_init(), To avoid repeatedly calculate the base address of
   timer2, and make it easier to recognize timer1.
3. Delete the leading "__" of __sp804_clocksource_and_sched_clock_init()
   and __sp804_clockevents_init().

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 97b41a493253..e0c3779621eb 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -65,10 +65,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     struct clk *clk,
-						     int use_sched_clock)
+int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						  const char *name,
+						  struct clk *clk,
+						  int use_sched_clock)
 {
 	long rate;
 
@@ -76,7 +76,6 @@ int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
 
-	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
 	writel(0xffffffff, base + TIMER_LOAD);
 	writel(0xffffffff, base + TIMER_VALUE);
@@ -159,7 +158,8 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
@@ -188,6 +188,8 @@ static int __init sp804_of_init(struct device_node *np)
 {
 	static bool initialized = false;
 	void __iomem *base;
+	void __iomem *timer1_base;
+	void __iomem *timer2_base;
 	int irq, ret = -EINVAL;
 	u32 irq_num = 0;
 	struct clk *clk1, *clk2;
@@ -197,9 +199,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
+	timer1_base = base;
+	timer2_base = base + TIMER_2_BASE;
+
 	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+	writel(0, timer1_base + TIMER_CTRL);
+	writel(0, timer2_base + TIMER_CTRL);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -228,21 +233,22 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(timer2_base, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+		ret = sp804_clocksource_and_sched_clock_init(timer1_base,
+							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = __sp804_clockevents_init(base, irq, clk1 , name);
+		ret = sp804_clockevents_init(timer1_base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret =__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							      name, clk2, 1);
+		ret = sp804_clocksource_and_sched_clock_init(timer2_base,
+							     name, clk2, 1);
 		if (ret)
 			goto err;
 	}
@@ -282,7 +288,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		goto err;
 
 	if (!init_count) {
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+		ret = sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
 		if (ret)
 			goto err;
 	} else {
@@ -290,7 +296,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		if (irq <= 0)
 			goto err;
 
-		ret = __sp804_clockevents_init(base, irq, clk, name);
+		ret = sp804_clockevents_init(base, irq, clk, name);
 		if (ret)
 			goto err;
 	}
-- 
2.26.0.106.g9fadedd


