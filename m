Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BCC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D7820715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBGN0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgBGNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:25:56 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03df-0003o5-1M; Fri, 07 Feb 2020 14:25:43 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 281AA105CFE;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.563379423@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:39:00 +0100
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
Subject: [patch V2 13/17] lib/vdso: Avoid highres update if clocksource is not VDSO capable
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

From: Thomas Gleixner <tglx@linutronix.de>

If the current clocksource is not VDSO capable there is no point in
updating the high resolution parts of the VDSO data.

Replace the architecture specific check with a check for a VDSO capable
clocksource and skip the update if there is none.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h |    7 -------
 include/asm-generic/vdso/vsyscall.h  |    7 -------
 kernel/time/vsyscall.c               |    6 +++---
 3 files changed, 3 insertions(+), 17 deletions(-)

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

