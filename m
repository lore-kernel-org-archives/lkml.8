Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8370C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526A246A1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgANNCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43169 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgANNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpx-0004j0-Pw; Tue, 14 Jan 2020 14:02:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1925B1C07F3;
        Tue, 14 Jan 2020 14:02:19 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:18 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-clocks: Wire up clock_gettime() with timens offsets
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-12-dima@arista.com>
References: <20191112012724.250792-12-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693888.396.15066865383207889988.tip-bot2@tip-bot2>
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

Commit-ID:     5a590f35add93c2bdf3ed83eee73111021679562
Gitweb:        https://git.kernel.org/tip/5a590f35add93c2bdf3ed83eee73111021679562
Author:        Andrei Vagin <avagin@openvz.org>
AuthorDate:    Tue, 12 Nov 2019 01:27:00 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:52 +01:00

posix-clocks: Wire up clock_gettime() with timens offsets

Adjust monotonic and boottime clocks with per-timens offsets.  As the
result a process inside time namespace will see timers and clocks corrected
to offsets that were set when the namespace was created

Note that applications usually go through vDSO to get time, which is not
yet adjusted. Further changes will complete time namespace virtualisation
with vDSO support.

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-12-dima@arista.com


---
 kernel/time/alarmtimer.c   |  9 ++++++++-
 kernel/time/posix-stubs.c  |  3 +++
 kernel/time/posix-timers.c |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4d8c905..9a8e81b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
@@ -886,6 +887,12 @@ static struct platform_driver alarmtimer_driver = {
 	}
 };
 
+static void get_boottime_timespec(struct timespec64 *tp)
+{
+	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
+}
+
 /**
  * alarmtimer_init - Initialize alarm timer code
  *
@@ -906,7 +913,7 @@ static int __init alarmtimer_init(void)
 	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
-	alarm_bases[ALARM_BOOTTIME].get_timespec = ktime_get_boottime_ts64;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 20c65a7..bcbaa20 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,9 +78,11 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fe1de4f..d26b915 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -195,6 +196,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -209,6 +211,7 @@ static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -223,6 +226,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -235,6 +239,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
