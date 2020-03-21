Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B702C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAD720781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCUOep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:34:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38700 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgCUOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBn-00046s-9c; Sat, 21 Mar 2020 15:33:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D0E6E1C22BC;
        Sat, 21 Mar 2020 15:33:26 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:26 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm64: vdso32: Code clean up
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317122220.30393-19-vincenzo.frascino@arm.com>
References: <20200317122220.30393-19-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480120655.28353.3034580466720093310.tip-bot2@tip-bot2>
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

Commit-ID:     94d0f5be885ce1e6ca2886af1543165c16745d13
Gitweb:        https://git.kernel.org/tip/94d0f5be885ce1e6ca2886af1543165c16745d13
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:43 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:24:00 +01:00

arm64: vdso32: Code clean up

The compat vdso library had some checks that are not anymore relevant.

Remove the unused code from the compat vDSO library.

Note: This patch is preparatory for a future one that will introduce
asm/vdso/processor.h on arm64.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/lkml/20200317122220.30393-19-vincenzo.frascino@arm.com
Link: https://lkml.kernel.org/r/20200320145351.32292-19-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  8 --------
 arch/arm64/kernel/vdso32/vgettimeofday.c          | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 81b0c39..401df2b 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -76,10 +76,6 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_compat_clock_getres_time64;
 
-	/* The checks below are required for ABI consistency with arm */
-	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
-		return -EINVAL;
-
 	asm volatile(
 	"       swi #0\n"
 	: "=r" (ret)
@@ -97,10 +93,6 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_compat_clock_getres;
 
-	/* The checks below are required for ABI consistency with arm */
-	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
-		return -EINVAL;
-
 	asm volatile(
 	"       swi #0\n"
 	: "=r" (ret)
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index 54fc1c2..ddbad47 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -11,20 +11,12 @@
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
 int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_gettime(clock, ts);
 }
 
@@ -37,10 +29,6 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)res >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
