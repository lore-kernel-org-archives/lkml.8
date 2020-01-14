Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059A4C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC9524685
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgANNCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgANNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLq3-0004n0-5k; Tue, 14 Jan 2020 14:02:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B691A1C0813;
        Tue, 14 Jan 2020 14:02:21 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:21 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Mark do_hres() and do_coarse() as
 __always_inline
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-3-dima@arista.com>
References: <20191112012724.250792-3-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900694149.396.8953565038340925743.tip-bot2@tip-bot2>
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

Commit-ID:     c966533f8c6c45f93c52599f8460e7695f0b7eaa
Gitweb:        https://git.kernel.org/tip/c966533f8c6c45f93c52599f8460e7695f0b7eaa
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:26:51 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:48 +01:00

lib/vdso: Mark do_hres() and do_coarse() as __always_inline

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):

clock            | before     | after      | diff
----------------------------------------------------------
monotonic        |  153222105 |  166775025 | 8.8%
monotonic-coarse |  671557054 |  691513017 | 3.0%
monotonic-raw    |  147116067 |  161057395 | 9.5%
boottime         |  153446224 |  166962668 | 9.1%

The improvement for arm64 for monotonic and boottime is around 3.5%.

clock            | before     | after      | diff
==================================================
monotonic          17326692     17951770     3.6%
monotonic-coarse   43624027     44215292     1.3%
monotonic-raw      17541809     17554932     0.1%
boottime           17334982     17954361     3.5%

[ tglx: Avoid the goto ]

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-3-dima@arista.com


---
 lib/vdso/gettimeofday.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index fac9e86..b453d24 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,7 +38,7 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
-static int do_hres(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -68,8 +68,8 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static int do_coarse(const struct vdso_data *vd, clockid_t clk,
-		      struct __kernel_timespec *ts)
+static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
+				     struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u32 seq;
@@ -99,13 +99,15 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VDSO_HRES))
-		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
+		vd = &vd[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
 		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
-		return do_hres(&vd[CS_RAW], clock, ts);
+		vd = &vd[CS_RAW];
+	else
+		return -1;
 
-	return -1;
+	return do_hres(vd, clock, ts);
 }
 
 static __maybe_unused int
