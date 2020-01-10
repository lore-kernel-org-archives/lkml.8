Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF670C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0B220721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgAJPnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:43:01 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgAJPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:43:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McXs5-1jOAit0D5Z-00cyU7; Fri, 10 Jan 2020 16:42:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 2/3] y2038: remove unused time32 interfaces
Date:   Fri, 10 Jan 2020 16:42:31 +0100
Message-Id: <20200110154232.4104492-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200110154232.4104492-1-arnd@arndb.de>
References: <20200110154232.4104492-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pAjGFh8trdx2wDTRKVgWxSPYzOFCYwZttTYRX4Hgtd+fzQRC1xt
 lxzUrtWZKGRORQGonNhkjMmNGPvVua6dJeboqMPYWMwg4yDuWkYdkMfuQ0d+/buFIn/3CZZ
 g7n4wvyIRFCK9zTSC+npEgbX75ZbatdK4WeDR0WBB6WKbr8GNY8GTbE2NRiLeEpQOqOvfXx
 nGoo61mHknPVr+2RbwnWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8GY17PLMCJU=:liJw+LxS9jPI7Ts80YQ4I6
 7TEkenz/vQFh3+jevY/1bPZgMeBJ+3gLqx2zwkS6A5R/xKzBNukwaYYLvkcvHpOtFIx6jEiaO
 gToAR+dL041FctxaTiDMFy5B3i2nMGvSuQPiZ3FIFfXAZ7bLB4mKmRMO5hSfOb2KKYlNcVtY7
 r20cQs7+7KQPIRNJnu00gNRvA0wPg6YePbGJD87aCd2DsvLM+e824lUZiSuaUFr01yOJiV3yj
 PxLzQzPs+hA8rX4g0KxAjpzCWge//BR/4DqkLS2zBCq1Ry4l5DmtQGkc9+T40rZhJCPf56iSD
 GgZrYCjYg20U4kTV8UzLGbl70uOe7RyO1tOySu9pC/5Qu3S5AwXsEQUDpjZQMJqjpZJrNNXcu
 tLub+Pp6XD183HnbX371G3nvu0mwtwJvboAV6GCc1A90s5xUXkWl8HiBSP+Tn8wEoMOOtHJsG
 76EFbNnva5/u5E7cMNGiCODYW/MODO3iNUimIv2p1PEttGvryYviMK/wMLOFw8OuCpaE4AQ5s
 iIFvwuFhA3pgMUv4R4Tr3wIG2/J5lIpBeS+8pf+P0BZqeGWDNtcon6unXGCAKagDLYhc2Se0y
 t/FlD35SHiezJDP51f76eUmKi9zSKxz8FEwRU7OekYTtD/ie9ZMol6cUZI4n6rP6W2ajLRg60
 NXZL57VxWFcqkNgM0CliX4QmfczuSqNUU0kxb6jnuBGHmD/Z2qmXzQHbp13VytJrZn6OjTUPI
 VHQ+hpXQvRN9zt8M5EII0OTuTzf8xiirBC8AmWOQxBzrc1neLzXDXGXFn8MBA6fzU+60vEPLt
 PluI/YEgZz2IZRMbf72zAL5lPxMi1KK5wG3ixW5yBLbXu0Z3efneeLP33rm/w5riBouEI4fPj
 s1n3d68BBEHl9dn5VtDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users remain, so kill these off before we grow new ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h        |  29 -------
 include/linux/time32.h        | 154 +---------------------------------
 include/linux/timekeeping32.h |  32 -------
 include/linux/types.h         |   5 --
 kernel/compat.c               |  64 --------------
 kernel/time/time.c            |  43 ----------
 6 files changed, 1 insertion(+), 326 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 11083d84eb23..df2475be134a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -248,15 +248,6 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
-/*
- * These functions operate on 32- or 64-bit specs depending on
- * COMPAT_USE_64BIT_TIME, hence the void user pointer arguments.
- */
-extern int compat_get_timespec(struct timespec *, const void __user *);
-extern int compat_put_timespec(const struct timespec *, void __user *);
-extern int compat_get_timeval(struct timeval *, const void __user *);
-extern int compat_put_timeval(const struct timeval *, void __user *);
-
 struct compat_iovec {
 	compat_uptr_t	iov_base;
 	compat_size_t	iov_len;
@@ -416,26 +407,6 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to, const kernel_siginf
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
-static inline int old_timeval32_compare(struct old_timeval32 *lhs,
-					struct old_timeval32 *rhs)
-{
-	if (lhs->tv_sec < rhs->tv_sec)
-		return -1;
-	if (lhs->tv_sec > rhs->tv_sec)
-		return 1;
-	return lhs->tv_usec - rhs->tv_usec;
-}
-
-static inline int old_timespec32_compare(struct old_timespec32 *lhs,
-					struct old_timespec32 *rhs)
-{
-	if (lhs->tv_sec < rhs->tv_sec)
-		return -1;
-	if (lhs->tv_sec > rhs->tv_sec)
-		return 1;
-	return lhs->tv_nsec - rhs->tv_nsec;
-}
-
 extern int get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat);
 
 /*
diff --git a/include/linux/time32.h b/include/linux/time32.h
index cad4c3186002..cf9320cd2d0b 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -12,8 +12,6 @@
 #include <linux/time64.h>
 #include <linux/timex.h>
 
-#define TIME_T_MAX	(__kernel_old_time_t)((1UL << ((sizeof(__kernel_old_time_t) << 3) - 1)) - 1)
-
 typedef s32		old_time32_t;
 
 struct old_timespec32 {
@@ -73,162 +71,12 @@ struct __kernel_timex;
 int get_old_timex32(struct __kernel_timex *, const struct old_timex32 __user *);
 int put_old_timex32(struct old_timex32 __user *, const struct __kernel_timex *);
 
-#if __BITS_PER_LONG == 64
-
-/* timespec64 is defined as timespec here */
-static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
-{
-	return *(const struct timespec *)&ts64;
-}
-
-static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
-{
-	return *(const struct timespec64 *)&ts;
-}
-
-#else
-static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
-{
-	struct timespec ret;
-
-	ret.tv_sec = (time_t)ts64.tv_sec;
-	ret.tv_nsec = ts64.tv_nsec;
-	return ret;
-}
-
-static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
-{
-	struct timespec64 ret;
-
-	ret.tv_sec = ts.tv_sec;
-	ret.tv_nsec = ts.tv_nsec;
-	return ret;
-}
-#endif
-
-static inline int timespec_equal(const struct timespec *a,
-				 const struct timespec *b)
-{
-	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
-}
-
-/*
- * lhs < rhs:  return <0
- * lhs == rhs: return 0
- * lhs > rhs:  return >0
- */
-static inline int timespec_compare(const struct timespec *lhs, const struct timespec *rhs)
-{
-	if (lhs->tv_sec < rhs->tv_sec)
-		return -1;
-	if (lhs->tv_sec > rhs->tv_sec)
-		return 1;
-	return lhs->tv_nsec - rhs->tv_nsec;
-}
-
-/*
- * Returns true if the timespec is norm, false if denorm:
- */
-static inline bool timespec_valid(const struct timespec *ts)
-{
-	/* Dates before 1970 are bogus */
-	if (ts->tv_sec < 0)
-		return false;
-	/* Can't have more nanoseconds then a second */
-	if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)
-		return false;
-	return true;
-}
-
-/**
- * timespec_to_ns - Convert timespec to nanoseconds
- * @ts:		pointer to the timespec variable to be converted
- *
- * Returns the scalar nanosecond representation of the timespec
- * parameter.
- */
-static inline s64 timespec_to_ns(const struct timespec *ts)
-{
-	return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
-}
-
 /**
- * ns_to_timespec - Convert nanoseconds to timespec
- * @nsec:	the nanoseconds value to be converted
- *
- * Returns the timespec representation of the nsec parameter.
- */
-extern struct timespec ns_to_timespec(const s64 nsec);
-
-/**
- * timespec_add_ns - Adds nanoseconds to a timespec
- * @a:		pointer to timespec to be incremented
- * @ns:		unsigned nanoseconds value to be added
- *
- * This must always be inlined because its used from the x86-64 vdso,
- * which cannot call other kernel functions.
- */
-static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
-{
-	a->tv_sec += __iter_div_u64_rem(a->tv_nsec + ns, NSEC_PER_SEC, &ns);
-	a->tv_nsec = ns;
-}
-
-static inline unsigned long mktime(const unsigned int year,
-			const unsigned int mon, const unsigned int day,
-			const unsigned int hour, const unsigned int min,
-			const unsigned int sec)
-{
-	return mktime64(year, mon, day, hour, min, sec);
-}
-
-static inline bool timeval_valid(const struct timeval *tv)
-{
-	/* Dates before 1970 are bogus */
-	if (tv->tv_sec < 0)
-		return false;
-
-	/* Can't have more microseconds then a second */
-	if (tv->tv_usec < 0 || tv->tv_usec >= USEC_PER_SEC)
-		return false;
-
-	return true;
-}
-
-/**
- * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
- *
- * Returns the scalar nanosecond representation of the timeval
- * parameter.
- */
-static inline s64 timeval_to_ns(const struct timeval *tv)
-{
-	return ((s64) tv->tv_sec * NSEC_PER_SEC) +
-		tv->tv_usec * NSEC_PER_USEC;
-}
-
-/**
- * ns_to_timeval - Convert nanoseconds to timeval
+ * ns_to_kernel_old_timeval - Convert nanoseconds to timeval
  * @nsec:	the nanoseconds value to be converted
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct timeval ns_to_timeval(const s64 nsec);
 extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
 
-/*
- * Old names for the 32-bit time_t interfaces, these will be removed
- * when everything uses the new names.
- */
-#define compat_time_t		old_time32_t
-#define compat_timeval		old_timeval32
-#define compat_timespec		old_timespec32
-#define compat_itimerspec	old_itimerspec32
-#define ns_to_compat_timeval	ns_to_old_timeval32
-#define get_compat_itimerspec64	get_old_itimerspec32
-#define put_compat_itimerspec64	put_old_itimerspec32
-#define compat_get_timespec64	get_old_timespec32
-#define compat_put_timespec64	put_old_timespec32
-
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index cc59cc9e0e84..266017fc9ee9 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -11,36 +11,4 @@ static inline unsigned long get_seconds(void)
 	return ktime_get_real_seconds();
 }
 
-static inline void getnstimeofday(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ktime_get_real_ts64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
-static inline void ktime_get_ts(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ktime_get_ts64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
-static inline void getrawmonotonic(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ktime_get_raw_ts64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
-static inline void getboottime(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	getboottime64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
 #endif
diff --git a/include/linux/types.h b/include/linux/types.h
index eb870ad42919..d3021c879179 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -65,11 +65,6 @@ typedef __kernel_ssize_t	ssize_t;
 typedef __kernel_ptrdiff_t	ptrdiff_t;
 #endif
 
-#ifndef _TIME_T
-#define _TIME_T
-typedef __kernel_old_time_t	time_t;
-#endif
-
 #ifndef _CLOCK_T
 #define _CLOCK_T
 typedef __kernel_clock_t	clock_t;
diff --git a/kernel/compat.c b/kernel/compat.c
index 95005f849c68..843dd17e6078 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -26,70 +26,6 @@
 
 #include <linux/uaccess.h>
 
-static int __compat_get_timeval(struct timeval *tv, const struct old_timeval32 __user *ctv)
-{
-	return (!access_ok(ctv, sizeof(*ctv)) ||
-			__get_user(tv->tv_sec, &ctv->tv_sec) ||
-			__get_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
-}
-
-static int __compat_put_timeval(const struct timeval *tv, struct old_timeval32 __user *ctv)
-{
-	return (!access_ok(ctv, sizeof(*ctv)) ||
-			__put_user(tv->tv_sec, &ctv->tv_sec) ||
-			__put_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
-}
-
-static int __compat_get_timespec(struct timespec *ts, const struct old_timespec32 __user *cts)
-{
-	return (!access_ok(cts, sizeof(*cts)) ||
-			__get_user(ts->tv_sec, &cts->tv_sec) ||
-			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
-}
-
-static int __compat_put_timespec(const struct timespec *ts, struct old_timespec32 __user *cts)
-{
-	return (!access_ok(cts, sizeof(*cts)) ||
-			__put_user(ts->tv_sec, &cts->tv_sec) ||
-			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
-}
-
-int compat_get_timeval(struct timeval *tv, const void __user *utv)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_from_user(tv, utv, sizeof(*tv)) ? -EFAULT : 0;
-	else
-		return __compat_get_timeval(tv, utv);
-}
-EXPORT_SYMBOL_GPL(compat_get_timeval);
-
-int compat_put_timeval(const struct timeval *tv, void __user *utv)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_to_user(utv, tv, sizeof(*tv)) ? -EFAULT : 0;
-	else
-		return __compat_put_timeval(tv, utv);
-}
-EXPORT_SYMBOL_GPL(compat_put_timeval);
-
-int compat_get_timespec(struct timespec *ts, const void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_get_timespec(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_get_timespec);
-
-int compat_put_timespec(const struct timespec *ts, void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_put_timespec(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_put_timespec);
-
 #ifdef __ARCH_WANT_SYS_SIGPROCMASK
 
 /*
diff --git a/kernel/time/time.c b/kernel/time/time.c
index cdd7386115ff..3985b2b32d08 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -449,49 +449,6 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-/**
- * ns_to_timespec - Convert nanoseconds to timespec
- * @nsec:       the nanoseconds value to be converted
- *
- * Returns the timespec representation of the nsec parameter.
- */
-struct timespec ns_to_timespec(const s64 nsec)
-{
-	struct timespec ts;
-	s32 rem;
-
-	if (!nsec)
-		return (struct timespec) {0, 0};
-
-	ts.tv_sec = div_s64_rem(nsec, NSEC_PER_SEC, &rem);
-	if (unlikely(rem < 0)) {
-		ts.tv_sec--;
-		rem += NSEC_PER_SEC;
-	}
-	ts.tv_nsec = rem;
-
-	return ts;
-}
-EXPORT_SYMBOL(ns_to_timespec);
-
-/**
- * ns_to_timeval - Convert nanoseconds to timeval
- * @nsec:       the nanoseconds value to be converted
- *
- * Returns the timeval representation of the nsec parameter.
- */
-struct timeval ns_to_timeval(const s64 nsec)
-{
-	struct timespec ts = ns_to_timespec(nsec);
-	struct timeval tv;
-
-	tv.tv_sec = ts.tv_sec;
-	tv.tv_usec = (suseconds_t) ts.tv_nsec / 1000;
-
-	return tv;
-}
-EXPORT_SYMBOL(ns_to_timeval);
-
 struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
 {
 	struct timespec64 ts = ns_to_timespec64(nsec);
-- 
2.20.0

