Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3508C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C86621D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIJDYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:24:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727893AbgIJDYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:24:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 92071518D3DB16E300B0;
        Thu, 10 Sep 2020 11:23:04 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 11:22:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH 6/6] clocksource: sp804: enable Hisilicon sp804 timer 64bit mode
Date:   Thu, 10 Sep 2020 11:14:19 +0800
Message-ID: <20200910031419.2790-7-thunder.leizhen@huawei.com>
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

A 100MHZ 32-bit timer will be wrapped up less than 43s. Although the
kernel maintains a software high 32-bit count in the tick IRQ. But it's
not applicable to the user mode APPs.

Note: The kernel still uses the lower 32 bits of the timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp.h    | 9 +++++++++
 drivers/clocksource/timer-sp804.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 6ca8d82e8544..6c0a902926eb 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -35,22 +35,28 @@
 #define HISI_TIMER_1_BASE	0x00
 #define HISI_TIMER_2_BASE	0x40
 #define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_LOAD_H	0x04
 #define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_VALUE_H	0x0c
 #define HISI_TIMER_CTRL		0x10
 #define HISI_TIMER_INTCLR	0x14
 #define HISI_TIMER_RIS		0x18
 #define HISI_TIMER_MIS		0x1c
 #define HISI_TIMER_BGLOAD	0x20
+#define HISI_TIMER_BGLOAD_H	0x24
 
 
 struct sp804_timer {
 	int load;
+	int load_h;
 	int value;
+	int value_h;
 	int ctrl;
 	int intclr;
 	int ris;
 	int mis;
 	int bgload;
+	int bgload_h;
 	int timer_base[NR_TIMERS];
 	int width;
 };
@@ -58,12 +64,15 @@ struct sp804_timer {
 struct sp804_clkevt {
 	void __iomem *base;
 	void __iomem *load;
+	void __iomem *load_h;
 	void __iomem *value;
+	void __iomem *value_h;
 	void __iomem *ctrl;
 	void __iomem *intclr;
 	void __iomem *ris;
 	void __iomem *mis;
 	void __iomem *bgload;
+	void __iomem *bgload_h;
 	unsigned long reload;
 	int width;
 };
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 736b0476629f..53498cf63c3b 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -31,7 +31,9 @@ struct sp804_timer __initdata arm_sp804_timer = {
 
 struct sp804_timer __initdata hisi_sp804_timer = {
 	.load		= HISI_TIMER_LOAD,
+	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
+	.value_h	= HISI_TIMER_VALUE_H,
 	.ctrl		= HISI_TIMER_CTRL,
 	.intclr		= HISI_TIMER_INTCLR,
 	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
@@ -117,6 +119,10 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	writel(0, clkevt->ctrl);
 	writel(0xffffffff, clkevt->load);
 	writel(0xffffffff, clkevt->value);
+	if (clkevt->width == 64) {
+		writel(0xffffffff, clkevt->load_h);
+		writel(0xffffffff, clkevt->value_h);
+	}
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clkevt->ctrl);
 
@@ -233,7 +239,9 @@ static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *ba
 		clkevt = &sp804_clkevt[i];
 		clkevt->base	= timer_base;
 		clkevt->load	= timer_base + timer->load;
+		clkevt->load_h	= timer_base + timer->load_h;
 		clkevt->value	= timer_base + timer->value;
+		clkevt->value_h	= timer_base + timer->value_h;
 		clkevt->ctrl	= timer_base + timer->ctrl;
 		clkevt->intclr	= timer_base + timer->intclr;
 		clkevt->width	= timer->width;
-- 
2.26.0.106.g9fadedd


