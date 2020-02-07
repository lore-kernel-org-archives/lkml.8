Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ACDC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3921927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBGN0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgBGN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:04 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03dl-0003ox-9Y; Fri, 07 Feb 2020 14:25:49 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2ACE4105CFF;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.656097274@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:39:01 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: [patch V2 14/17] lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes
References: <20200207123847.339896630@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move the time namespace indicator clock mode to the other ones for
consistency sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/clocksource.h |    3 +++
 include/vdso/datapage.h     |    2 --
 kernel/time/namespace.c     |    7 ++++---
 lib/vdso/gettimeofday.c     |   18 ++++++++++--------
 4 files changed, 17 insertions(+), 13 deletions(-)

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
@@ -172,8 +173,8 @@ static struct timens_offset offset_from_
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
@@ -183,7 +184,7 @@ static void timens_setup_vdso_data(struc
 	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
 
 	vdata->seq			= 1;
-	vdata->clock_mode		= VCLOCK_TIMENS;
+	vdata->clock_mode		= VDSO_CLOCKMODE_TIMENS;
 	offset[CLOCK_MONOTONIC]		= monotonic;
 	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
 	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -116,10 +116,10 @@ static __always_inline int do_hres(const
 
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
@@ -128,7 +128,7 @@ static __always_inline int do_hres(const
 		 */
 		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode == VCLOCK_TIMENS)
+			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 				return do_hres_timens(vd, clk, ts);
 			cpu_relax();
 		}
@@ -200,12 +200,12 @@ static __always_inline int do_coarse(con
 
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
@@ -292,7 +292,7 @@ static __maybe_unused int
 
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
-		    vd->clock_mode == VCLOCK_TIMENS)
+		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 			vd = __arch_get_timens_vdso_data();
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
@@ -308,7 +308,8 @@ static __maybe_unused __kernel_old_time_
 	const struct vdso_data *vd = __arch_get_vdso_data();
 	__kernel_old_time_t t;
 
-	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+	if (IS_ENABLED(CONFIG_TIME_NS) &&
+	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_timens_vdso_data();
 
 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
@@ -332,7 +333,8 @@ int __cvdso_clock_getres_common(clockid_
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
-	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+	if (IS_ENABLED(CONFIG_TIME_NS) &&
+	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_timens_vdso_data();
 
 	/*

