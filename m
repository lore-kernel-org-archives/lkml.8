Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF10C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902C121D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbgAPVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53523 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbgAPVbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjD-0001Vs-So; Thu, 16 Jan 2020 22:31:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6999D1C198A;
        Thu, 16 Jan 2020 22:30:59 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:30:59 -0000
From:   "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyper-v: Untangle stimers and
 timesync from clocksources
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109160650.16150-2-parri.andrea@gmail.com>
References: <20200109160650.16150-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Message-ID: <157921025923.396.10137663019407257740.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0af3e137c144377fbaf5025ba784ff5ba7ad40c9
Gitweb:        https://git.kernel.org/tip/0af3e137c144377fbaf5025ba784ff5ba7ad40c9
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Thu, 09 Jan 2020 17:06:49 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:09:02 +01:00

clocksource/drivers/hyper-v: Untangle stimers and timesync from clocksources

hyperv_timer.c exports hyperv_cs, which is used by stimers and the
timesync mechanism.  However, the clocksource dependency is not
needed: these mechanisms only depend on the partition reference
counter (which can be read via a MSR or via the TSC Reference Page).

Introduce the (function) pointer hv_read_reference_counter, as an
embodiment of the partition reference counter read, and export it
in place of the hyperv_cs pointer.  The latter can be removed.

This should clarify that there's no relationship between Hyper-V
stimers & timesync and the Linux clocksource abstractions.  No
functional or semantic change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200109160650.16150-2-parri.andrea@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 36 ++++++++++++++++++-----------
 drivers/hv/hv_util.c               |  8 +++---
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 12d75b5..42748ad 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -66,7 +66,7 @@ static int hv_ce_set_next_event(unsigned long delta,
 {
 	u64 current_tick;
 
-	current_tick = hyperv_cs->read(NULL);
+	current_tick = hv_read_reference_counter();
 	current_tick += delta;
 	hv_init_timer(0, current_tick);
 	return 0;
@@ -304,8 +304,8 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
  */
 
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
+u64 (*hv_read_reference_counter)(void);
+EXPORT_SYMBOL_GPL(hv_read_reference_counter);
 
 static union {
 	struct ms_hyperv_tsc_page page;
@@ -318,7 +318,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
+static u64 notrace read_hv_clock_tsc(void)
 {
 	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
@@ -328,9 +328,14 @@ static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
+{
+	return read_hv_clock_tsc();
+}
+
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_tsc() - hv_sched_clock_offset;
 }
 
 static void suspend_hv_clock_tsc(struct clocksource *arg)
@@ -359,14 +364,14 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
-	.read	= read_hv_clock_tsc,
+	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
 };
 
-static u64 notrace read_hv_clock_msr(struct clocksource *arg)
+static u64 notrace read_hv_clock_msr(void)
 {
 	u64 current_tick;
 	/*
@@ -378,15 +383,20 @@ static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
+{
+	return read_hv_clock_msr();
+}
+
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_msr() - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
 	.rating	= 400,
-	.read	= read_hv_clock_msr,
+	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -399,7 +409,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	hyperv_cs = &hyperv_cs_tsc;
+	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
@@ -417,7 +427,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
@@ -439,10 +449,10 @@ void __init hv_init_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
 		return;
 
-	hyperv_cs = &hyperv_cs_msr;
+	hv_read_reference_counter = read_hv_clock_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd84..296f909 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -211,7 +211,7 @@ static struct timespec64 hv_get_adj_host_time(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host_ts.lock, flags);
-	reftime = hyperv_cs->read(hyperv_cs);
+	reftime = hv_read_reference_counter();
 	newtime = host_ts.host_time + (reftime - host_ts.ref_time);
 	ts = ns_to_timespec64((newtime - WLTIMEDELTA) * 100);
 	spin_unlock_irqrestore(&host_ts.lock, flags);
@@ -250,7 +250,7 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
 	 */
 	spin_lock_irqsave(&host_ts.lock, flags);
 
-	cur_reftime = hyperv_cs->read(hyperv_cs);
+	cur_reftime = hv_read_reference_counter();
 	host_ts.host_time = hosttime;
 	host_ts.ref_time = cur_reftime;
 
@@ -315,7 +315,7 @@ static void timesync_onchannelcallback(void *context)
 					sizeof(struct vmbuspipe_hdr) +
 					sizeof(struct icmsg_hdr)];
 				adj_guesttime(timedatap->parenttime,
-					      hyperv_cs->read(hyperv_cs),
+					      hv_read_reference_counter(),
 					      timedatap->flags);
 			}
 		}
@@ -524,7 +524,7 @@ static struct ptp_clock *hv_ptp_clock;
 static int hv_timesync_init(struct hv_util_service *srv)
 {
 	/* TimeSync requires Hyper-V clocksource. */
-	if (!hyperv_cs)
+	if (!hv_read_reference_counter)
 		return -ENODEV;
 
 	spin_lock_init(&host_ts.lock);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 553e539..34eef08 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -30,7 +30,7 @@ extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
 #ifdef CONFIG_HYPERV_TIMER
-extern struct clocksource *hyperv_cs;
+extern u64 (*hv_read_reference_counter)(void);
 extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
