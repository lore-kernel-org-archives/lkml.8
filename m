Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD020726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwoqRQQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBGTjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:39:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727031AbgBGTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581104387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Kop8A2EloQTwM9Kw3Boak4V4+YcgdPRM/QwHvEJTtvA=;
        b=cwoqRQQKUqCindQ8WVobbq8y2umDlwe8+zJN4oGxPeA+mRB90eZkDPqYkjEBglRHOR6b73
        T2+0J40496ILeXsPts+tieyACNN74Ym41aygkNn/TR4IjJ32Qw64t5iaaPkjZTA49DhuyY
        MbCTxWka21aP+UMwbDgx/1+hwMgtmZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-BkhSdnzhN06xu9hPY53NKw-1; Fri, 07 Feb 2020 14:39:43 -0500
X-MC-Unique: BkhSdnzhN06xu9hPY53NKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70A86DB22;
        Fri,  7 Feb 2020 19:39:42 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3FB47FB60;
        Fri,  7 Feb 2020 19:39:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>, pbunyan@redhat.com,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH v2] tick: Make tick_periodic() check for missing ticks
Date:   Fri,  7 Feb 2020 14:39:29 -0500
Message-Id: <20200207193929.27308-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 kernel/time/tick-common.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

 v2: Avoid direct u64 division and better ns-ktime conversion.

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7e5d3524e924..55dbbe0f5573 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -84,12 +85,41 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu == cpu) {
+		/*
+		 * Use running_clock() as reference to check for missing ticks.
+		 */
+		static ktime_t last_update;
+		ktime_t now;
+		int ticks = 1;
+
+		now = ns_to_ktime(running_clock());
 		write_seqlock(&jiffies_lock);
 
-		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		if (last_update) {
+			u64 delta = ktime_sub(now, last_update);
 
-		do_timer(1);
+			/*
+			 * Compute missed ticks
+			 *
+			 * There is likely a persistent delta between
+			 * last_update and tick_next_period. So they are
+			 * updated separately.
+			 */
+			if (delta >= 2 * tick_period) {
+				s64 period = ktime_to_ns(tick_period);
+
+				ticks = ktime_divns(delta, period);
+			}
+			last_update = ktime_add(last_update,
+						ticks * tick_period);
+		} else {
+			last_update = now;
+		}
+
+		/* Keep track of the next tick event */
+		tick_next_period = ktime_add(tick_next_period,
+					     ticks * tick_period);
+		do_timer(ticks);
 		write_sequnlock(&jiffies_lock);
 		update_wall_time();
 	}
-- 
2.18.1

