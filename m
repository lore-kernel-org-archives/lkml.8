Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC0C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07484214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgBQPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:12:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgBQPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:12:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3i3t-0007bl-PQ; Mon, 17 Feb 2020 16:11:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6A11D1C1A54;
        Mon, 17 Feb 2020 16:11:53 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:11:53 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Allow fixed clock mode
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207124403.748756829@linutronix.de>
References: <20200207124403.748756829@linutronix.de>
MIME-Version: 1.0
Message-ID: <158195231319.13786.8013282336314595679.tip-bot2@tip-bot2>
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

Commit-ID:     997cf1781d0a694952048de2705f755d2c8c1bcd
Gitweb:        https://git.kernel.org/tip/997cf1781d0a694952048de2705f755d2c8c1bcd
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Fri, 07 Feb 2020 13:39:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 14:40:28 +01:00

lib/vdso: Allow fixed clock mode

Some architectures have a fixed clocksource which is known at compile time
and cannot be replaced or disabled at runtime, e.g. timebase on
PowerPC. For such cases the clock mode check in the VDSO code is pointless.

Move the check for a VDSO capable clocksource into an inline function and
allow architectures to redefine it via a macro.

[ tglx: Removed the #ifdef mess ]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/20200207124403.748756829@linutronix.de


---
 lib/vdso/gettimeofday.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a76ac8d..8eb6d1e 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -46,6 +46,13 @@ static inline bool __arch_vdso_hres_capable(void)
 }
 #endif
 
+#ifndef vdso_clocksource_ok
+static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+{
+	return vd->clock_mode != VDSO_CLOCKMODE_NONE;
+}
+#endif
+
 #ifdef CONFIG_TIME_NS
 static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 			  struct __kernel_timespec *ts)
@@ -66,7 +73,7 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 	do {
 		seq = vdso_read_begin(vd);
 
-		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
+		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
@@ -134,7 +141,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		}
 		smp_rmb();
 
-		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
+		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
