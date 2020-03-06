Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A88222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCFM5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:57:04 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35914 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCFM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:57:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3D8F48030786;
        Fri,  6 Mar 2020 12:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i17JiqHGbEZr; Fri,  6 Mar 2020 15:57:00 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] clocksource: mips-gic-timer: Set limitations on clocksource/sched-clocks usage
Date:   Fri, 6 Mar 2020 15:56:04 +0300
In-Reply-To: <20200306125605.8143-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306125605.8143-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306125701.3D8F48030786@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Currently neither clocksource nor scheduler clock kernel framework
support the clocks with variable frequency. Needless to say how many
problems may cause the sudden base clocks frequency change. In a
simplest case the system time will either slow down or speed up.
Since on CM2.5 and earlier MIPS GIC timer is synchronously clocked
with CPU we must set some limitations on using it for these frameworks
if CPU frequency may change. First of all it's not safe to have the
MIPS GIC used for scheduler timings. So we shouldn't proceed with
the clocks registration in the sched-subsystem. Secondly we must
significantly decrease the MIPS GIC clocksource rating. This will let
the system to use it only as a last resort.

Note CM3.x-based systems may also experience the problems with MIPS GIC
if they the CPU-frequency change activated for the whole CPU cluster
instead of using the individual CPC core clocks divider.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/clocksource/mips-gic-timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 8239ff99cfe4..5eb241b8b28d 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -185,7 +185,10 @@ static int __init __gic_clocksource_init(void)
 	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
 
 	/* Calculate a somewhat reasonable rating value. */
-	gic_clocksource.rating = 200 + gic_frequency / 10000000;
+	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ))
+		gic_clocksource.rating = 200 + gic_frequency / 10000000;
+	else
+		gic_clocksource.rating = 99;
 
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
@@ -239,9 +242,11 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	/* And finally start the counter */
 	clear_gic_config(GIC_CONFIG_COUNTSTOP);
 
-	sched_clock_register(mips_cm_is64 ?
-			     gic_read_count_64 : gic_read_count_2x32,
-			     64, gic_frequency);
+	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+		sched_clock_register(mips_cm_is64 ?
+				     gic_read_count_64 : gic_read_count_2x32,
+				     64, gic_frequency);
+	}
 
 	return 0;
 }
-- 
2.25.1

