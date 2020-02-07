Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE036C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1021927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBGN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBGN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:05 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03di-0003sN-VC; Fri, 07 Feb 2020 14:25:47 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 357C7105D02;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.965789141@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:39:04 +0100
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
Subject: [patch V2 17/17] lib/vdso: Allow architectures to provide the vdso data pointer
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

On powerpc, __arch_get_vdso_data() clobbers the link register, requiring
the caller to save it.

As the parent function already has to set a stack frame and saves the link
register before calling the C vdso function, retrieving the vdso data
pointer there is less overhead.

Split out the functional code from the __cvdso.*() interfaces into new
static functions which can either be called from the existing interfaces
with the vdso data pointer supplied via __arch_get_vdso_data() or directly
from ASM code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/abf97996602ef07223fec30c005df78e5ed41b2e.1580399657.git.christophe.leroy@c-s.fr

---
 lib/vdso/gettimeofday.c |   72 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 16 deletions(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -233,9 +233,9 @@ static __always_inline int do_coarse(con
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
+__cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
+			     struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
 
 	/* Check for negative values or invalid clocks */
@@ -260,23 +260,31 @@ static __maybe_unused int
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+__cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
+			   struct __kernel_timespec *ts)
 {
-	int ret = __cvdso_clock_gettime_common(clock, ts);
+	int ret = __cvdso_clock_gettime_common(vd, clock, ts);
 
 	if (unlikely(ret))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }
 
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime_data(__arch_get_vdso_data(), clock, ts);
+}
+
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+__cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
+			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_gettime_common(clock, &ts);
+	ret = __cvdso_clock_gettime_common(vd, clock, &ts);
 
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
@@ -287,12 +295,18 @@ static __maybe_unused int
 
 	return ret;
 }
+
+static __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_gettime32_data(__arch_get_vdso_data(), clock, res);
+}
 #endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
-__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+__cvdso_gettimeofday_data(const struct vdso_data *vd,
+			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
@@ -316,10 +330,16 @@ static __maybe_unused int
 	return 0;
 }
 
+static __maybe_unused int
+__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday_data(__arch_get_vdso_data(), tv, tz);
+}
+
 #ifdef VDSO_HAS_TIME
-static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
+static __maybe_unused __kernel_old_time_t
+__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	__kernel_old_time_t t;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
@@ -333,13 +353,18 @@ static __maybe_unused __kernel_old_time_
 
 	return t;
 }
+
+static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
+{
+	return __cvdso_time_data(__arch_get_vdso_data(), time);
+}
 #endif /* VDSO_HAS_TIME */
 
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
+int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
+				struct __kernel_timespec *res)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
 	u64 ns;
 
@@ -378,23 +403,31 @@ int __cvdso_clock_getres_common(clockid_
 }
 
 static __maybe_unused
-int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
+			      struct __kernel_timespec *res)
 {
-	int ret = __cvdso_clock_getres_common(clock, res);
+	int ret = __cvdso_clock_getres_common(vd, clock, res);
 
 	if (unlikely(ret))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
 
+static __maybe_unused
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres_data(__arch_get_vdso_data(), clock, res);
+}
+
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+__cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
+				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_getres_common(clock, &ts);
+	ret = __cvdso_clock_getres_common(vd, clock, &ts);
 
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
@@ -405,5 +438,12 @@ static __maybe_unused int
 	}
 	return ret;
 }
+
+static __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32_data(__arch_get_vdso_data(),
+						clock, res);
+}
 #endif /* BUILD_VDSO32 */
 #endif /* VDSO_HAS_CLOCK_GETRES */

