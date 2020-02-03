Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D0920721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPdbVnlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBCRIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:08:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727708AbgBCRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580749680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/baBOLQ8a9BZmW0Wn8lk/36NXp7qMRmGfHfTBlL93OY=;
        b=QPdbVnlCM9wffQZopTjbaEh/wV9bvV7e1s4iV7WX9xqP54qUzWXrHE6z2nnUzSawltttY8
        h/42bOcyq9Uo7O8YSOrTTomih8yrzabmbhnOYZQIL/ZKxh4csthiyVfwoEJP/EUI1JXx+W
        18SIxCreHhbK1xpqOTTuetnFkg1O9ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-V_vKwLK2PWG0MrblZ27ZIg-1; Mon, 03 Feb 2020 12:07:56 -0500
X-MC-Unique: V_vKwLK2PWG0MrblZ27ZIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84B4A1800D41;
        Mon,  3 Feb 2020 17:07:55 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E6A819C7F;
        Mon,  3 Feb 2020 17:07:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>, pbunyan@redhat.com,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] tick: Make tick_periodic() check for missing ticks
Date:   Mon,  3 Feb 2020 12:07:39 -0500
Message-Id: <20200203170739.20736-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tick_periodic() function is used at the beginning part of the
bootup process for time keeping while the other clock sources are
being initialized.

The current code assumes that all the timer interrupts are handled in
a timely manner with no missing ticks. That is not actually true. Some
ticks are missed and there are some discrepancies between the tick time
(jiffies) and the timestamp reported in the kernel log.  Some systems,
however, are more prone to missing ticks than the others.  In the extreme
case, the discrepancy can actually cause a soft lockup message to be
printed by the watchdog kthread. For example, on a Cavium ThunderX2
Sabre arm64 system:

 [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!

On that system, the missing ticks are especially prevalent during the
smp_init() phase of the boot process. With an instrumented kernel,
it was found that it took about 24s as reported by the timestamp for
the tick to accumulate 4s of time.

Investigation and bisection done by others seemed to point to the
commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or
lack thereof") as the culprit. It could also be a firmware issue as
new firmware was promised that would fix the issue.

To properly address this problem, we cannot assume that there will
be no missing tick in tick_periodic(). This function is now modified
to follow the example of tick_do_update_jiffies64() by using another
reference clock to check for missing ticks. Since the watchdog timer
uses running_clock(), it is used here as the reference. With this patch
applied, the soft lockup problem in the arm64 system is gone and tick
time tracks much more closely to the timestamp time.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/tick-common.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7e5d3524e924..831e87ef134f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -84,12 +85,28 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu == cpu) {
+		/*
+		 * Use running_clock() as reference to check for missing ticks.
+		 */
+		static u64 last_update;
+		u64 now, delta;
+		int ticks = 1;
+
+		now = running_clock();
+		if (last_update) {
+			delta = ktime_sub(now, last_update);
+
+			/* Compute missed ticks */
+			ticks = max((int)(delta / ktime_to_ns(tick_period)), 1);
+		}
+		last_update = now;
+
 		write_seqlock(&jiffies_lock);
 
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
-
-		do_timer(1);
+		tick_next_period = ktime_add(tick_next_period,
+					     ticks * tick_period);
+		do_timer(ticks);
 		write_sequnlock(&jiffies_lock);
 		update_wall_time();
 	}
-- 
2.18.1

