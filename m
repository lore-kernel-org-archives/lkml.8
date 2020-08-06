Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307D323119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEI+zt9g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gb01PpxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgHFRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:12:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgHFRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:06 -0400
Date:   Thu, 06 Aug 2020 17:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd5AfIYXFdlRNvNYPKomq5pISASI7cUerV9XrD7j7bA=;
        b=gEI+zt9go5T3ru+v5NAAIyzbtcyGRLeS2LsFXngbDvuIJ2CE7MyZcOWBfBzxgKzDPNmClv
        eCTIhRidCMtP2FEYxKJUaz0tbxLsmf4hV0X83zcOPwjrciWBbMUsyshVO3n76/jHN9kPJn
        7P7rb9OF1lbdMX6wfeR3/44gS8XY0S/6wCogYSW4pqHDdLBMmfwhEtgksfsSlzVGqlUdDO
        gkEluGJNKaTztCI6UflVdI42f38pwDDA+R1vVASx2LJgmCn7ZAcR8rI/9lj35/zVoXtD8/
        iVsKxrWl8EhJihJEGisiQjSgLi/m6tIn1OQFW9gFJnprv6E1VpxSx237szrSLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd5AfIYXFdlRNvNYPKomq5pISASI7cUerV9XrD7j7bA=;
        b=Gb01PpxBYOdqzJHFtA46wdH9W58WwOjMmkf+zzIw91P2WkpwQjqksdVjbHv+9vsfMWfCSC
        H8WquW6F1HvmIqCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso/treewide: Add vdso_data pointer argument to
 __arch_get_hw_counter()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <draft-87wo2ekuzn.fsf@nanos.tec.linutronix.de>
References: <draft-87wo2ekuzn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159673380184.3192.11397705484145709278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4c5a116ada953b86125ab7c70a57c57463a55a55
Gitweb:        https://git.kernel.org/tip/4c5a116ada953b86125ab7c70a57c57463a55a55
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Aug 2020 22:37:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 Aug 2020 10:57:30 +02:00

vdso/treewide: Add vdso_data pointer argument to __arch_get_hw_counter()

MIPS already uses and S390 will need the vdso data pointer in
__arch_get_hw_counter().

This works nicely as long as the architecture does not support time
namespaces in the VDSO. With time namespaces enabled the regular
accessor to the vdso data pointer __arch_get_vdso_data() will return the
namespace specific VDSO data page for tasks which are part of a
non-root time namespace. This would cause the architectures which need
the vdso data pointer in __arch_get_hw_counter() to access the wrong
vdso data page.

Add a vdso_data pointer argument to __arch_get_hw_counter() and hand it in
from the call sites in the core code. For architectures which do not need
the data pointer in their counter accessor function the compiler will just
optimize it out.

Fix up all existing architecture implementations and make MIPS utilize the
pointer instead of invoking the accessor function.

No functional change and no change in the resulting object code (except
MIPS).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/draft-87wo2ekuzn.fsf@nanos.tec.linutronix.de
---
 arch/arm/include/asm/vdso/gettimeofday.h          | 3 ++-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 3 ++-
 arch/arm64/include/asm/vdso/gettimeofday.h        | 3 ++-
 arch/mips/include/asm/vdso/gettimeofday.h         | 5 +++--
 arch/riscv/include/asm/vdso/gettimeofday.h        | 3 ++-
 arch/x86/include/asm/vdso/gettimeofday.h          | 3 ++-
 lib/vdso/gettimeofday.c                           | 4 ++--
 7 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 1b207cf..2134cbd 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -113,7 +113,8 @@ static inline bool arm_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable arm_vdso_hres_capable
 
-static __always_inline u64 __arch_get_hw_counter(int clock_mode)
+static __always_inline u64 __arch_get_hw_counter(int clock_mode,
+						 const struct vdso_data *vd)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
 	u64 cycle_now;
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 75cbae6..7508b0a 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -103,7 +103,8 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	u64 res;
 
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 9c29ad3..631ab12 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -64,7 +64,8 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	u64 res;
 
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index c63ddca..2203e2d 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -167,7 +167,8 @@ static __always_inline u64 read_gic_count(const struct vdso_data *data)
 
 #endif
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 #ifdef CONFIG_CSRC_R4K
 	if (clock_mode == VDSO_CLOCKMODE_R4K)
@@ -175,7 +176,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 #endif
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 	if (clock_mode == VDSO_CLOCKMODE_GIC)
-		return read_gic_count(get_vdso_data());
+		return read_gic_count(vd);
 #endif
 	/*
 	 * Core checks mode already. So this raced against a concurrent
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index 3099362..f839f16 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -60,7 +60,8 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	/*
 	 * The purpose of csr_read(CSR_TIME) is to trap the system into
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index fb81fea..df01d73 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -241,7 +241,8 @@ static u64 vread_hvclock(void)
 }
 #endif
 
-static inline u64 __arch_get_hw_counter(s32 clock_mode)
+static inline u64 __arch_get_hw_counter(s32 clock_mode,
+					const struct vdso_data *vd)
 {
 	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
 		return (u64)rdtsc_ordered();
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index bcc9a98..2919f16 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -68,7 +68,7 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
-		cycles = __arch_get_hw_counter(vd->clock_mode);
+		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
 		ns = vdso_ts->nsec;
@@ -138,7 +138,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
-		cycles = __arch_get_hw_counter(vd->clock_mode);
+		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
 		ns = vdso_ts->nsec;
