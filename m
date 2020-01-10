Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181612077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgAJPm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:42:59 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:42:58 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mgebs-1jJTt90naW-00h55e; Fri, 10 Jan 2020 16:42:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 3/3] y2038: hide timeval/timespec/itimerval/itimerspec types
Date:   Fri, 10 Jan 2020 16:42:32 +0100
Message-Id: <20200110154232.4104492-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200110154232.4104492-1-arnd@arndb.de>
References: <20200110154232.4104492-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WPEkrl/rLXk5wiQOlO54RwlcVS+s99NxMLu3KiL/xHh/Q8xzHdF
 vV4Su45Jt4OySWJpOdnN+TpFkQtdRIOZtyRe4BMlaP2D9Gi2lHEoSoplRIRBfmi6wx5byLU
 PLcecWFEvjT8ygPs0GagjLiywAS2DjmCr07XMUOtFr7gyVsavk2s7M2ewkPLvc8tMLCFcLj
 A7PiEFCF7GLmm6J2dGnFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHwVseXxjkw=:NHOqWfOqZ+bBetDJTrOjyE
 3iyLNHHuUJW5gifyc1bwdd+TfvtfVV52UN73H/9dsRCbr0JH8iNN+pJTpW7GIFnFEPXpH1p4J
 DXpDvdJONdnYLdNa3Yc2xDDWVM2UPUNenZaPtyOgG/CeVoUGwGyNOaz8FdL91Onbp1Olt5ky/
 REJRdpkHUYVZ9EjCBd64cFZfyCn5ZTvqIkBND22XPFsQZpnY/xX6PuU8M2nw2B2ruMutcTAN0
 VY79uLxOj3Dzf/EoDsAhHGCTpmJMC24SAYWFOx+thUt3fOn1dwnqlQZSNAgWsXk79V8Oz7n6T
 DdQsTHoMONd2hBYPLzyHcVnQNcG7qno6icHRqZ2zJu3q0avb0XeYKg6tLFbGIGVx8d18lF2MA
 dXPoaNO/+6FqJ/GPYuGEFzkmD+8HyE7cL+1Za9cWPLKUNq19a1PH7mpfC8jQbRHxHfFQ3DsDf
 p1FPXeE7tQf+N4DSj+LzkuDNyOqakIT1407zMzAwTCszl8k7Qt8juLndanHuTRNkk6S8rBi1S
 dUeC1EaSOasBEKfLXi0R6RS50AFmbpnbNCGKNHHFT9r2Ni84Jy8JocPtfhYEN9txs/1G5HbxI
 /d6DsKCDrQxUjLenIy0BZvPIWIYCzW1AP4pUsVxJ3VHURvX9NBvqNuLfcf0x1ziDp3tIhrdyF
 Skh6CIF8H9g6Sg/0mYnRzYFWstlfgTGs6jYYpLgC1cbVvzMtgvZSQPiDXtQiPbYNweV1503oK
 YYZPhoNTe5IzpIrU972k45THOZDOI/ibBD1aW4JtjjCWIS4MyxvHPw7PRczZu4eyhnkBE7euJ
 vSTaHrCHKc/hX59CZxYy0qhfJj5HWhZA1uE7S+iJ21U6G6EYFXya9ONOV/7kAHHaskN52iE08
 eKaSIhmFmxnJ4XvSaKGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-kernel users remaining, but there may still
be users that include linux/time.h instead of sys/time.h
from user space, so leave the types available to user space
while hiding them from kernel space.

Only the __kernel_old_* versions of these types remain now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/posix_types.h |  2 ++
 include/uapi/linux/time.h              | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index 2f9c80595ba7..b5f7594eee7a 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -87,7 +87,9 @@ typedef struct {
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
 typedef __kernel_long_t	__kernel_old_time_t;
+#ifndef __KERNEL__
 typedef __kernel_long_t	__kernel_time_t;
+#endif
 typedef long long __kernel_time64_t;
 typedef __kernel_long_t	__kernel_clock_t;
 typedef int		__kernel_timer_t;
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index a655aa28dc6e..4f4b6e48e01c 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/time_types.h>
 
+#ifndef __KERNEL__
 #ifndef _STRUCT_TIMESPEC
 #define _STRUCT_TIMESPEC
 struct timespec {
@@ -18,6 +19,17 @@ struct timeval {
 	__kernel_suseconds_t	tv_usec;	/* microseconds */
 };
 
+struct itimerspec {
+	struct timespec it_interval;/* timer period */
+	struct timespec it_value;	/* timer expiration */
+};
+
+struct itimerval {
+	struct timeval it_interval;/* timer interval */
+	struct timeval it_value;	/* current value */
+};
+#endif
+
 struct timezone {
 	int	tz_minuteswest;	/* minutes west of Greenwich */
 	int	tz_dsttime;	/* type of dst correction */
@@ -31,16 +43,6 @@ struct timezone {
 #define	ITIMER_VIRTUAL		1
 #define	ITIMER_PROF		2
 
-struct itimerspec {
-	struct timespec it_interval;	/* timer period */
-	struct timespec it_value;	/* timer expiration */
-};
-
-struct itimerval {
-	struct timeval it_interval;	/* timer interval */
-	struct timeval it_value;	/* current value */
-};
-
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.20.0

