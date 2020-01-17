Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6762B222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAQPID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:08:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56524 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAQPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:08:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isTE7-0002ef-Hg; Fri, 17 Jan 2020 16:07:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 25DB31C19E5;
        Fri, 17 Jan 2020 16:07:59 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:07:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] lib/vdso: Update coarse timekeeper unconditionally
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114185946.765577901@linutronix.de>
References: <20200114185946.765577901@linutronix.de>
MIME-Version: 1.0
Message-ID: <157927367892.396.644956436024849151.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9f24c540f7f8eb3a981528da9a9a636a5bdf5987
Gitweb:        https://git.kernel.org/tip/9f24c540f7f8eb3a981528da9a9a636a5bdf5987
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 14 Jan 2020 19:52:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jan 2020 15:53:50 +01:00

lib/vdso: Update coarse timekeeper unconditionally

The low resolution parts of the VDSO, i.e.:

  clock_gettime(CLOCK_*_COARSE), clock_getres(), time()

can be used even if there is no VDSO capable clocksource.

But if an architecture opts out of the VDSO data update then this
information becomes stale. This affects ARM when there is no architected
timer available. The lack of update causes userspace to use stale data
forever.

Make the update of the low resolution parts unconditional and only skip
the update of the high resolution parts if the architecture requests it.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200114185946.765577901@linutronix.de

---
 kernel/time/vsyscall.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index f0aab61..9577c89 100644
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
 
-	if (!__arch_update_vdso_data()) {
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
 
