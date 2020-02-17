Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60CBC34027
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB021D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBQTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:18:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgBQTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:18:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3luq-0006Cq-PD; Mon, 17 Feb 2020 20:18:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E5911C20B9;
        Mon, 17 Feb 2020 20:18:48 +0100 (CET)
Date:   Mon, 17 Feb 2020 19:18:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124403.656097274@linutronix.de>
References: <20200207124403.656097274@linutronix.de>
MIME-Version: 1.0
Message-ID: <158196712814.13786.6959049621142795361.tip-bot2@tip-bot2>
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

Commit-ID:     2d6b01bd88ccabba06d342ef80eaab6b39d12497
Gitweb:        https://git.kernel.org/tip/2d6b01bd88ccabba06d342ef80eaab6b39d12497
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:39:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 20:12:17 +01:00

lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes

Move the time namespace indicator clock mode to the other ones for
consistency sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124403.656097274@linutronix.de



---
 include/linux/clocksource.h |  3 +++
 include/vdso/datapage.h     |  2 --
 kernel/time/namespace.c     |  7 ++++---
 lib/vdso/gettimeofday.c     | 18 ++++++++++--------
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7fefe0b..02e3282 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -34,6 +34,9 @@ enum vdso_clock_mode {
 	VDSO_ARCH_CLOCKMODES,
 #endif
 	VDSO_CLOCKMODE_MAX,
+
+	/* Indicator for time namespace VDSO */
+	VDSO_CLOCKMODE_TIMENS = INT_MAX
 };
 
 /**
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index c5f347c..30c4cb0 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,8 +21,6 @@
 #define CS_RAW		1
 #define CS_BASES	(CS_RAW + 1)
 
-#define VCLOCK_TIMENS	UINT_MAX
-
 /**
  * struct vdso_timestamp - basetime per clock_id
  * @sec:	seconds
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 1285850..e6ba064 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -8,6 +8,7 @@
 #include <linux/user_namespace.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
+#include <linux/clocksource.h>
 #include <linux/seq_file.h>
 #include <linux/proc_ns.h>
 #include <linux/export.h>
@@ -172,8 +173,8 @@ static struct timens_offset offset_from_ts(struct timespec64 off)
  * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_data->clock_mode set to VCLOCK_TIMENS which enforces
- * the time namespace handling path.
+ * Timens page has vdso_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
+ * enforces the time namespace handling path.
  */
 static void timens_setup_vdso_data(struct vdso_data *vdata,
 				   struct time_namespace *ns)
@@ -183,7 +184,7 @@ static void timens_setup_vdso_data(struct vdso_data *vdata,
 	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
 
 	vdata->seq			= 1;
-	vdata->clock_mode		= VCLOCK_TIMENS;
+	vdata->clock_mode		= VDSO_CLOCKMODE_TIMENS;
 	offset[CLOCK_MONOTONIC]		= monotonic;
 	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
 	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 00f8d1f..a76ac8d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -116,10 +116,10 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VCLOCK_TIMENS. Time namespace
+		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
 		 * enabled tasks have a special VVAR page installed which
 		 * has vd->seq set to 1 and vd->clock_mode set to
-		 * VCLOCK_TIMENS. For non time namespace affected tasks
+		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
 		 * this does not affect performance because if vd->seq is
 		 * odd, i.e. a concurrent update is in progress the extra
 		 * check for vd->clock_mode is just a few extra
@@ -128,7 +128,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		 */
 		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode == VCLOCK_TIMENS)
+			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 				return do_hres_timens(vd, clk, ts);
 			cpu_relax();
 		}
@@ -200,12 +200,12 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VCLOCK_TIMENS. See comment in
+		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
 		 * do_hres().
 		 */
 		while ((seq = READ_ONCE(vd->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode == VCLOCK_TIMENS)
+			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 				return do_coarse_timens(vd, clk, ts);
 			cpu_relax();
 		}
@@ -292,7 +292,7 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
-		    vd->clock_mode == VCLOCK_TIMENS)
+		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 			vd = __arch_get_timens_vdso_data();
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
@@ -308,7 +308,8 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time
 	const struct vdso_data *vd = __arch_get_vdso_data();
 	__kernel_old_time_t t;
 
-	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+	if (IS_ENABLED(CONFIG_TIME_NS) &&
+	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_timens_vdso_data();
 
 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
@@ -332,7 +333,8 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
-	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+	if (IS_ENABLED(CONFIG_TIME_NS) &&
+	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_timens_vdso_data();
 
 	/*
