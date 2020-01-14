Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DEFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44AF2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgANNDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:03:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43278 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgANNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLqC-0004rS-57; Tue, 14 Jan 2020 14:02:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4105D1C085B;
        Tue, 14 Jan 2020 14:02:24 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: vdso: Set BUILD_VDSO32 and provide 32bit fallbacks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
References: <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <157900694409.396.3651284834298683513.tip-bot2@tip-bot2>
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

Commit-ID:     715f23b6104aa297feea20d4f200ca81941e23de
Gitweb:        https://git.kernel.org/tip/715f23b6104aa297feea20d4f200ca81941e23de
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 14 Jan 2020 09:41:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:43 +01:00

ARM: vdso: Set BUILD_VDSO32 and provide 32bit fallbacks

Setting BUILD_VDSO32 is required to expose the legacy 32bit interfaces in
the generic VDSO code which are going to be hidden behind an #ifdef
BUILD_VDSO32.

The 32bit fallbacks are necessary to remove the existing
VDSO_HAS_32BIT_FALLBACK hackery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/87tv4zq9dc.fsf@nanos.tec.linutronix.de
---
 arch/arm/include/asm/vdso/gettimeofday.h | 36 +++++++++++++++++++++++-
 arch/arm/vdso/Makefile                   |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 0ad2429..fe6e1f6 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -52,6 +52,24 @@ static __always_inline long clock_gettime_fallback(
 	return ret;
 }
 
+static __always_inline long clock_gettime32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline int clock_getres_fallback(
 					clockid_t _clkid,
 					struct __kernel_timespec *_ts)
@@ -70,6 +88,24 @@ static __always_inline int clock_getres_fallback(
 	return ret;
 }
 
+static __always_inline int clock_getres32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline u64 __arch_get_hw_counter(int clock_mode)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 0fda344..1babb39 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -14,7 +14,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
-ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
 
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
