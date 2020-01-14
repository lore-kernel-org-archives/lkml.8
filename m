Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC5124673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgANTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:49:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgANTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBW-0005aF-UR; Tue, 14 Jan 2020 20:49:07 +0100
Message-Id: <20200114185947.500141436@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [patch 09/15] clocksource: Add common vdso clock mode storage
References: <20200114185237.273005683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures which use the generic VDSO code have their own storage
for the VDSO clock mode. That's pointless and just requires duplicate code.

Provide generic storage for it. The new Kconfig symbol is intermediate and
will be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/clocksource.h |   12 +++++++++++-
 kernel/time/clocksource.c   |    9 +++++++++
 kernel/time/vsyscall.c      |    7 +++++++
 lib/vdso/Kconfig            |    3 +++
 lib/vdso/gettimeofday.c     |   13 +++++++++++--
 5 files changed, 41 insertions(+), 3 deletions(-)

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
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -921,6 +921,15 @@ int __clocksource_register_scale(struct
 
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
 
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -72,12 +72,19 @@ void update_vsyscall(struct timekeeper *
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec;
+	s32 mode;
 
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
+#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
+	mode = tk->tkr_mono.clock->vdso_clock_mode;
+	vdata[CS_HRES_COARSE].clock_mode	= mode;
+	vdata[CS_RAW].clock_mode		= mode;
+#else
 	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
 	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
+#endif
 
 	/* CLOCK_REALTIME also required for time() */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,7 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_CLOCK_MODE
+	bool
+
 endif
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/hrtimer_defs.h>
+#include <linux/clocksource.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -64,10 +65,14 @@ static int do_hres_timens(const struct v
 
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
@@ -132,10 +137,14 @@ static __always_inline int do_hres(const
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

