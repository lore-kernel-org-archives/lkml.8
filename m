Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C92AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3D0206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgCXRpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:45:05 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43022 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgCXRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:45:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 188D78030790;
        Tue, 24 Mar 2020 17:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z9-RRAwksDAn; Tue, 24 Mar 2020 20:45:01 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] clocksource: mips-gic-timer: Register as sched_clock
Date:   Tue, 24 Mar 2020 20:43:24 +0300
Message-ID: <20200324174325.14213-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200324174325.14213-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306125622.839ED80307C4@mail.baikalelectronics.ru>
 <20200324174325.14213-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

The MIPS GIC timer is well suited for use as sched_clock, so register it
as such.

Whilst the existing gic_read_count() function matches the prototype
needed by sched_clock_register() already, we split it into 2 functions
in order to remove the need to evaluate the mips_cm_is64 condition
within each call since sched_clock should be as fast as possible.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
---
 drivers/clocksource/mips-gic-timer.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 37671a5d4ed9..8239ff99cfe4 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 #include <linux/time.h>
 #include <asm/mips-cps.h>
@@ -24,13 +25,10 @@ static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
 
-static u64 notrace gic_read_count(void)
+static u64 notrace gic_read_count_2x32(void)
 {
 	unsigned int hi, hi2, lo;
 
-	if (mips_cm_is64)
-		return read_gic_counter();
-
 	do {
 		hi = read_gic_counter_32h();
 		lo = read_gic_counter_32l();
@@ -40,6 +38,19 @@ static u64 notrace gic_read_count(void)
 	return (((u64) hi) << 32) + lo;
 }
 
+static u64 notrace gic_read_count_64(void)
+{
+	return read_gic_counter();
+}
+
+static u64 notrace gic_read_count(void)
+{
+	if (mips_cm_is64)
+		return gic_read_count_64();
+
+	return gic_read_count_2x32();
+}
+
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 {
 	int cpu = cpumask_first(evt->cpumask);
@@ -228,6 +239,10 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	/* And finally start the counter */
 	clear_gic_config(GIC_CONFIG_COUNTSTOP);
 
+	sched_clock_register(mips_cm_is64 ?
+			     gic_read_count_64 : gic_read_count_2x32,
+			     64, gic_frequency);
+
 	return 0;
 }
 TIMER_OF_DECLARE(mips_gic_timer, "mti,gic-timer",
-- 
2.25.1

