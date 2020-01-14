Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB9C2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgANND1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:03:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgANNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLqB-0004qK-Hl; Tue, 14 Jan 2020 14:02:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 858EB1C0858;
        Tue, 14 Jan 2020 14:02:23 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:23 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Remove checks on return value for 32 bit vDSO
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-6-vincenzo.frascino@arm.com>
References: <20190830135902.20861-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157900694338.396.7563018599066002360.tip-bot2@tip-bot2>
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

Commit-ID:     a279235ddbe975670afe2267162028ec0a312293
Gitweb:        https://git.kernel.org/tip/a279235ddbe975670afe2267162028ec0a312293
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:58:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:45 +01:00

lib/vdso: Remove checks on return value for 32 bit vDSO

Since all the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks it is not required
anymore to check the return value of __cvdso_clock_get*time32_common()
before updating the old_timespec fields.

Remove the related checks from the generic vdso library.

References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20190830135902.20861-6-vincenzo.frascino@arm.com


---
 lib/vdso/gettimeofday.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index cd3aacf..b676a98 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -129,10 +129,10 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
 
-	if (likely(!ret)) {
-		res->tv_sec = ts.tv_sec;
-		res->tv_nsec = ts.tv_nsec;
-	}
+	/* For ret == 0 */
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
 	return ret;
 }
 #endif /* BUILD_VDSO32 */
@@ -240,7 +240,7 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
 
-	if (likely(!ret && res)) {
+	if (likely(res)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
