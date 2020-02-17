Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E681C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1DE215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgBQPMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:12:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgBQPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:11:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3i3t-0007bg-9Y; Mon, 17 Feb 2020 16:11:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EBCB31C2084;
        Mon, 17 Feb 2020 16:11:52 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:11:52 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Allow architectures to override the ns
 shift operation
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cb3d449de856982ed060a71e6ace8eeca4654e685=2E15803?=
 =?utf-8?q?99657=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
References: =?utf-8?q?=3Cb3d449de856982ed060a71e6ace8eeca4654e685=2E158039?=
 =?utf-8?q?9657=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <158195231271.13786.11903618348396315008.tip-bot2@tip-bot2>
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

Commit-ID:     d34b9b611b4c23816dde3c8bde531d7e8a5c27f5
Gitweb:        https://git.kernel.org/tip/d34b9b611b4c23816dde3c8bde531d7e8a5c27f5
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Fri, 07 Feb 2020 13:39:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 14:40:28 +01:00

lib/vdso: Allow architectures to override the ns shift operation

On powerpc/32, GCC (8.1) generates pretty bad code for the ns >>= vd->shift
operation taking into account that the shift is always <= 32 and the upper
part of the result is likely to be zero. GCC makes reversed assumptions
considering the shift to be likely >= 32 and the upper part to be like not
zero.

unsigned long long shift(unsigned long long x, unsigned char s)
{
	return x >> s;
}

results in:

00000018 <shift>:
  18:	35 25 ff e0 	addic.  r9,r5,-32
  1c:	41 80 00 10 	blt     2c <shift+0x14>
  20:	7c 64 4c 30 	srw     r4,r3,r9
  24:	38 60 00 00 	li      r3,0
  28:	4e 80 00 20 	blr
  2c:	54 69 08 3c 	rlwinm  r9,r3,1,0,30
  30:	21 45 00 1f 	subfic  r10,r5,31
  34:	7c 84 2c 30 	srw     r4,r4,r5
  38:	7d 29 50 30 	slw     r9,r9,r10
  3c:	7c 63 2c 30 	srw     r3,r3,r5
  40:	7d 24 23 78 	or      r4,r9,r4
  44:	4e 80 00 20 	blr

Even when forcing the shift to be smaller than 32 with an &= 31, it still
considers the shift as likely >= 32.

Move the default shift implementation into an inline which can be redefined
in architecture code via a macro.

[ tglx: Made the shift argument u32 and removed the __arch prefix ]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/b3d449de856982ed060a71e6ace8eeca4654e685.1580399657.git.christophe.leroy@c-s.fr
Link: https://lkml.kernel.org/r/20200207124403.857649978@linutronix.de


---
 lib/vdso/gettimeofday.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 8eb6d1e..b95aef9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -39,6 +39,13 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
+#ifndef vdso_shift_ns
+static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
+{
+	return ns >> shift;
+}
+#endif
+
 #ifndef __arch_vdso_hres_capable
 static inline bool __arch_vdso_hres_capable(void)
 {
@@ -80,7 +87,7 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns >>= vd->shift;
+		ns = vdso_shift_ns(ns, vd->shift);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
@@ -148,7 +155,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns >>= vd->shift;
+		ns = vdso_shift_ns(ns, vd->shift);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
