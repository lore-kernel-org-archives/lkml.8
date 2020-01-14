Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CC4C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CB24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgANTtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:49:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgANTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:13 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBb-0005bG-Fw; Tue, 14 Jan 2020 20:49:11 +0100
Message-Id: <20200114185947.996078385@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:51 +0100
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
Subject: [patch 14/15] lib/vdso: Avoid highres update if clocksource is not VDSO capable
References: <20200114185237.273005683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the current clocksource is not VDSO capable there is no point in
updating the high resolution parts of the VDSO data.

Replace the architecture specific check with a check for a VDSO capable
clocksource and skip the update if there is none.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h |    7 -------
 include/asm-generic/vdso/vsyscall.h  |    7 -------
 kernel/time/vsyscall.c               |   14 +++++++-------
 3 files changed, 7 insertions(+), 21 deletions(-)

--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -22,13 +22,6 @@ struct vdso_data *__arm_get_k_vdso_data(
 #define __arch_get_k_vdso_data __arm_get_k_vdso_data
 
 static __always_inline
-bool __arm_update_vdso_data(void)
-{
-	return cntvct_ok;
-}
-#define __arch_update_vdso_data __arm_update_vdso_data
-
-static __always_inline
 void __arm_sync_vdso_data(struct vdso_data *vdata)
 {
 	flush_dcache_page(virt_to_page(vdata));
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -11,13 +11,6 @@ static __always_inline struct vdso_data
 }
 #endif /* __arch_get_k_vdso_data */
 
-#ifndef __arch_update_vdso_data
-static __always_inline bool __arch_update_vdso_data(void)
-{
-	return true;
-}
-#endif /* __arch_update_vdso_data */
-
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
 						   struct timekeeper *tk)
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -71,15 +71,15 @@ void update_vsyscall(struct timekeeper *
 {
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
 	struct vdso_timestamp *vdso_ts;
+	s32 clock_mode;
 	u64 nsec;
-	s32 mode;
 
 	/* copy vsyscall data */
 	vdso_write_begin(vdata);
 
-	mode = tk->tkr_mono.clock->vdso_clock_mode;
-	vdata[CS_HRES_COARSE].clock_mode	= mode;
-	vdata[CS_RAW].clock_mode		= mode;
+	clock_mode = tk->tkr_mono.clock->vdso_clock_mode;
+	vdata[CS_HRES_COARSE].clock_mode	= clock_mode;
+	vdata[CS_RAW].clock_mode		= clock_mode;
 
 	/* CLOCK_REALTIME also required for time() */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
@@ -105,10 +105,10 @@ void update_vsyscall(struct timekeeper *
 	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
 
 	/*
-	 * Architectures can opt out of updating the high resolution part
-	 * of the VDSO.
+	 * If the current clocksource is not VDSO capable, then spare the
+	 * update of the high reolution parts.
 	 */
-	if (__arch_update_vdso_data())
+	if (clock_mode != VDSO_CLOCKMODE_NONE)
 		update_vdso_data(vdata, tk);
 
 	__arch_update_vsyscall(vdata, tk);

