Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9542C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEED2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIJDZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:25:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729296AbgIJDXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82174D9B1BCA02E82597;
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
Subject: [PATCH 5/6] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Thu, 10 Sep 2020 11:14:18 +0800
Message-ID: <20200910031419.2790-6-thunder.leizhen@huawei.com>
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

Use compatible = "hisi,sp804" mark as Hisilicon sp804 timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp.h    | 12 ++++++++++++
 drivers/clocksource/timer-sp804.c | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 1ab75cbed0e0..6ca8d82e8544 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -31,6 +31,18 @@
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
 
+
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+
+
 struct sp804_timer {
 	int load;
 	int value;
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 68440e139dfd..736b0476629f 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -29,6 +29,15 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.value		= HISI_TIMER_VALUE,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -315,6 +324,12 @@ static int __init arm_sp804_of_init(struct device_node *np)
 }
 TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisi,sp804", hisi_sp804_of_init);
+
 static int __init integrator_cp_of_init(struct device_node *np)
 {
 	static int init_count = 0;
-- 
2.26.0.106.g9fadedd


