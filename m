Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB2C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC3C24658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgBQPMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:12:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgBQPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:12:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3i3x-0007ek-6K; Mon, 17 Feb 2020 16:11:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD3021C2084;
        Mon, 17 Feb 2020 16:11:56 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:11:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Add common vdso clock mode storage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124403.028046322@linutronix.de>
References: <20200207124403.028046322@linutronix.de>
MIME-Version: 1.0
Message-ID: <158195231666.13786.8394117502019581056.tip-bot2@tip-bot2>
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

Commit-ID:     5d51bee725cc1497352d6b0b604e42a90c680540
Gitweb:        https://git.kernel.org/tip/5d51bee725cc1497352d6b0b604e42a90c680540
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:38:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 14:40:23 +01:00

clocksource: Add common vdso clock mode storage

All architectures which use the generic VDSO code have their own storage
for the VDSO clock mode. That's pointless and just requires duplicate code.

Provide generic storage for it. The new Kconfig symbol is intermediate and
will be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124403.028046322@linutronix.de

---
 include/linux/clocksource.h | 12 +++++++++++-
 kernel/time/clocksource.c   |  9 +++++++++
 kernel/time/vsyscall.c      | 10 ++++++++--
 lib/vdso/Kconfig            |  3 +++
 lib/vdso/gettimeofday.c     | 13 +++++++++++--
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 2c4574b..6d5ed1b 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -23,10 +23,19 @@
 struct clocksource;
 struct module;
 
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
+#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
+    defined(CONFIG_GENERIC_VDSO_CLOCK_MODE)
 #include <asm/clocksource.h>
 #endif
 
+enum vdso_clock_mode {
+	VDSO_CLOCKMODE_NONE,
+#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+	VDSO_ARCH_CLOCKMODES,
+#endif
+	VDSO_CLOCKMODE_MAX,
+};
+
 /**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
@@ -97,6 +106,7 @@ struct clocksource {
 	const char		*name;
 	struct list_head	list;
 	int			rating;
+	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
 
 	int			(*enable)(struct clocksource *cs);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 428beb6..7cb09c4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -928,6 +928,15 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 
 	clocksource_arch_init(cs);
 
+#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+	if (cs->vdso_clock_mode < 0 ||
+	    cs->vdso_clock_mode >= VDSO_CLOCKMODE_MAX) {
+		pr_warn("clocksource %s registered with invalid VDSO mode %d. Disabling VDSO support.\n",
+			cs->name, cs->vdso_clock_mode);
+		cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
+	}
+#endif
+
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9577c89..f9a5178 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -71,13 +71,19 @@ void update_vsyscall(struct timekeeper *tk)
 {
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
 	struct vdso_timestamp *vdso_ts;
+	s32 clock_mode;
 	u64 nsec;
 
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
-	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
-	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
+#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+	clock_mode = tk->tkr_mono.clock->vdso_clock_mode;
+#else
+	clock_mode = __arch_get_clock_mode(tk);
+#endif
+	vdata[CS_HRES_COARSE].clock_mode	= clock_mode;
+	vdata[CS_RAW].clock_mode		= clock_mode;
 
 	/* CLOCK_REALTIME also required for time() */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac2..d9f43c8 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,7 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_CLOCK_MODE
+	bool
+
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 5804e4e..3f2d8b8 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/hrtimer_defs.h>
+#include <linux/clocksource.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -64,10 +65,14 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 
 	do {
 		seq = vdso_read_begin(vd);
+		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
+		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+			return -1;
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (unlikely((s64)cycles < 0))
+		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
+		    unlikely((s64)cycles < 0))
 			return -1;
 
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
@@ -132,10 +137,14 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		}
 		smp_rmb();
 
+		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
+		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
+			return -1;
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
-		if (unlikely((s64)cycles < 0))
+		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
+		    unlikely((s64)cycles < 0))
 			return -1;
 
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
