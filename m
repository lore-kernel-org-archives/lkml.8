Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAF4207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFCSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:53:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E209C08C5C0;
        Wed,  3 Jun 2020 11:53:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgYWI-0006iC-4o; Wed, 03 Jun 2020 20:53:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B3FA1C0081;
        Wed,  3 Jun 2020 20:53:45 +0200 (CEST)
Date:   Wed, 03 Jun 2020 18:53:45 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] lib/vdso: Force inlining of
 __cvdso_clock_gettime_common()
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C1ab6a62c356c3bec35d1623563ef9c636205bcda=2E15880?=
 =?utf-8?q?79622=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
References: =?utf-8?q?=3C1ab6a62c356c3bec35d1623563ef9c636205bcda=2E158807?=
 =?utf-8?q?9622=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <159121042519.17951.1602387180058090601.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b91c8c42ffdd5c983923edb38b3c3e112bfe6263
Gitweb:        https://git.kernel.org/tip/b91c8c42ffdd5c983923edb38b3c3e112bfe6263
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Tue, 28 Apr 2020 13:16:53 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 20:50:57 +02:00

lib/vdso: Force inlining of __cvdso_clock_gettime_common()

When adding gettime64() to a 32 bit architecture (namely powerpc/32)
it has been noticed that GCC doesn't inline anymore
__cvdso_clock_gettime_common() because it is called twice
(Once by __cvdso_clock_gettime() and once by
__cvdso_clock_gettime32).

This has the effect of seriously degrading the performance:

Before the implementation of gettime64(), gettime() runs in:

  clock-gettime-monotonic-raw:	    vdso: 1003 nsec/call
  clock-gettime-monotonic-coarse:   vdso:  592 nsec/call
  clock-gettime-monotonic:          vdso:  942 nsec/call

When adding a gettime64() entry point, the standard gettime()
performance is degraded by 30% to 50%:

  clock-gettime-monotonic-raw:      vdso: 1300 nsec/call
  clock-gettime-monotonic-coarse:   vdso:  900 nsec/call
  clock-gettime-monotonic:          vdso: 1232 nsec/call

Adding __always_inline() to __cvdso_clock_gettime_common() regains the
original performance.

In terms of code size, the inlining increases the code size by only 176
bytes. This is in the noise for a kernel image.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1ab6a62c356c3bec35d1623563ef9c636205bcda.1588079622.git.christophe.leroy@c-s.fr

---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af..7938d3c 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -210,7 +210,7 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static __maybe_unused int
+static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
