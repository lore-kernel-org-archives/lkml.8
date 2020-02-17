Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153FC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF1208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgBQTSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:18:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgBQTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:18:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3lur-0006DH-6h; Mon, 17 Feb 2020 20:18:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D060F1C20B8;
        Mon, 17 Feb 2020 20:18:48 +0100 (CET)
Date:   Mon, 17 Feb 2020 19:18:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Avoid highres update if clocksource is
 not VDSO capable
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124403.563379423@linutronix.de>
References: <20200207124403.563379423@linutronix.de>
MIME-Version: 1.0
Message-ID: <158196712861.13786.9777024048543338540.tip-bot2@tip-bot2>
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

Commit-ID:     c7a18100bdffdff440c7291db6e80863fab0461e
Gitweb:        https://git.kernel.org/tip/c7a18100bdffdff440c7291db6e80863fab0461e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2020 13:39:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 20:12:17 +01:00

lib/vdso: Avoid highres update if clocksource is not VDSO capable

If the current clocksource is not VDSO capable there is no point in
updating the high resolution parts of the VDSO data.

Replace the architecture specific check with a check for a VDSO capable
clocksource and skip the update if there is none.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124403.563379423@linutronix.de


---
 arch/arm/include/asm/vdso/vsyscall.h | 7 -------
 include/asm-generic/vdso/vsyscall.h  | 7 -------
 kernel/time/vsyscall.c               | 6 +++---
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 002f9ed..47e41ae 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -22,13 +22,6 @@ struct vdso_data *__arm_get_k_vdso_data(void)
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
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 4a28797..c835607 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -11,13 +11,6 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
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
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index d31a5ef..54ce6eb 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -105,10 +105,10 @@ void update_vsyscall(struct timekeeper *tk)
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
