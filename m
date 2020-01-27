Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E171C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1822467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgA1AG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:26 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOd-00033A-D1; Tue, 28 Jan 2020 01:06:23 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.6-rc1
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896587.31887.9884737771559149853.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-01-27

up to:  9f24c540f7f8: lib/vdso: Update coarse timekeeper unconditionally


Two fixes for the generic VDSO code which missed 5.5:

 - Make the update to the coarse timekeeper unconditional. This is required
   because the coarse timekeeper interfaces in the VDSO do not depend on a
   VDSO capable clocksource. If the system does not have a VDSO capable
   clocksource and the update is depending on the VDSO capable clocksource,
   the coarse VDSO interfaces would operate on stale data forever.

 - Invert the logic of __arch_update_vdso_data() to avoid further head
   scratching. Tripped over this several times while analyzing the update
   problem above.

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      lib/vdso: Make __arch_update_vdso_data() logic understandable
      lib/vdso: Update coarse timekeeper unconditionally


 arch/arm/include/asm/vdso/vsyscall.h |  4 ++--
 include/asm-generic/vdso/vsyscall.h  |  4 ++--
 kernel/time/vsyscall.c               | 37 +++++++++++++++++-------------------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index c4166f317071..cff87d8d30da 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -34,9 +34,9 @@ struct vdso_data *__arm_get_k_vdso_data(void)
 #define __arch_get_k_vdso_data __arm_get_k_vdso_data
 
 static __always_inline
-int __arm_update_vdso_data(void)
+bool __arm_update_vdso_data(void)
 {
-	return !cntvct_ok;
+	return cntvct_ok;
 }
 #define __arch_update_vdso_data __arm_update_vdso_data
 
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index ce4103208619..cec543d9e87b 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,9 +12,9 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 #endif /* __arch_get_k_vdso_data */
 
 #ifndef __arch_update_vdso_data
-static __always_inline int __arch_update_vdso_data(void)
+static __always_inline bool __arch_update_vdso_data(void)
 {
-	return 0;
+	return true;
 }
 #endif /* __arch_update_vdso_data */
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 5ee0f7709410..9577c89179cd 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -28,11 +28,6 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
 	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
 
-	/* CLOCK_REALTIME */
-	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
-	vdso_ts->sec	= tk->xtime_sec;
-	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
-
 	/* CLOCK_MONOTONIC */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
@@ -70,12 +65,6 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
 	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
 	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
-
-	/*
-	 * Read without the seqlock held by clock_getres().
-	 * Note: No need to have a second copy.
-	 */
-	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
 }
 
 void update_vsyscall(struct timekeeper *tk)
@@ -84,20 +73,17 @@ void update_vsyscall(struct timekeeper *tk)
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec;
 
-	if (__arch_update_vdso_data()) {
-		/*
-		 * Some architectures might want to skip the update of the
-		 * data page.
-		 */
-		return;
-	}
-
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
 	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
 	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
 
+	/* CLOCK_REALTIME also required for time() */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
+	vdso_ts->sec	= tk->xtime_sec;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
+
 	/* CLOCK_REALTIME_COARSE */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	= tk->xtime_sec;
@@ -110,7 +96,18 @@ void update_vsyscall(struct timekeeper *tk)
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
 	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
-	update_vdso_data(vdata, tk);
+	/*
+	 * Read without the seqlock held by clock_getres().
+	 * Note: No need to have a second copy.
+	 */
+	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+
+	/*
+	 * Architectures can opt out of updating the high resolution part
+	 * of the VDSO.
+	 */
+	if (__arch_update_vdso_data())
+		update_vdso_data(vdata, tk);
 
 	__arch_update_vsyscall(vdata, tk);
 

