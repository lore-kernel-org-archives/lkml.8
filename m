Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE6C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF4922522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBGN0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:26:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBGN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:26:06 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j03dg-0003pj-VJ; Fri, 07 Feb 2020 14:25:45 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2D8F3105D00;
        Fri,  7 Feb 2020 13:25:38 +0000 (GMT)
Message-Id: <20200207124403.748756829@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Feb 2020 13:39:02 +0100
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
Subject: [patch V2 15/17] lib/vdso: Allow fixed clock mode
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

Some architectures have a fixed clocksource which is known at compile time
and cannot be replaced or disabled at runtime, e.g. timebase on
PowerPC. For such cases the clock mode check in the VDSO code is pointless.

Move the check for a VDSO capable clocksource into an inline function and
allow architectures to redefine it via a macro.

[ tglx: Removed the #ifdef mess ]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 lib/vdso/gettimeofday.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -46,6 +46,13 @@ static inline bool __arch_vdso_hres_capa
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
@@ -66,7 +73,7 @@ static int do_hres_timens(const struct v
 	do {
 		seq = vdso_read_begin(vd);
 
-		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
+		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
@@ -134,7 +141,7 @@ static __always_inline int do_hres(const
 		}
 		smp_rmb();
 
-		if (unlikely(vd->clock_mode == VDSO_CLOCKMODE_NONE))
+		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);

