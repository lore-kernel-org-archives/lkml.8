Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD35C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9869C21D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIJDZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:25:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbgIJDXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 943FD830F0FA573D0EEC;
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
Subject: [PATCH 2/6] clocksource: sp804: remove unused sp804_timer_disable() and timer-sp804.h
Date:   Thu, 10 Sep 2020 11:14:15 +0800
Message-ID: <20200910031419.2790-3-thunder.leizhen@huawei.com>
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

Since commit 7484c727b636 ("ARM: realview: delete the RealView board
files") and commit 16956fed35fe ("ARM: versatile: switch to DT only
booting and remove legacy code"), there's no one to use the functions
defined or declared in include/clocksource/timer-sp804.h. Delete it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c |  7 -------
 include/clocksource/timer-sp804.h | 29 -----------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index bec2d372e0df..97b41a493253 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -18,8 +18,6 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <clocksource/timer-sp804.h>
-
 #include "timer-sp.h"
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -67,11 +65,6 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-void __init sp804_timer_disable(void __iomem *base)
-{
-	writel(0, base + TIMER_CTRL);
-}
-
 int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
deleted file mode 100644
index a5b41f31a1c2..000000000000
--- a/include/clocksource/timer-sp804.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLKSOURCE_TIMER_SP804_H
-#define __CLKSOURCE_TIMER_SP804_H
-
-struct clk;
-
-int __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					     const char *, struct clk *, int);
-int __sp804_clockevents_init(void __iomem *, unsigned int,
-			     struct clk *, const char *);
-void sp804_timer_disable(void __iomem *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
-#endif
-- 
2.26.0.106.g9fadedd


