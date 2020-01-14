Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485A42467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgANNDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:03:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43281 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgANNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLqB-0004qi-Il; Tue, 14 Jan 2020 14:02:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0505D1C085A;
        Tue, 14 Jan 2020 14:02:24 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:23 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Build 32 bit specific functions in the
 right context
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190830135902.20861-3-vincenzo.frascino@arm.com>
References: <20190830135902.20861-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157900694383.396.6172623174438789034.tip-bot2@tip-bot2>
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

Commit-ID:     bf279849ad59538a1518c667c0795ec1fe9dbd66
Gitweb:        https://git.kernel.org/tip/bf279849ad59538a1518c667c0795ec1fe9dbd66
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 30 Aug 2019 14:58:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:44 +01:00

lib/vdso: Build 32 bit specific functions in the right context

clock_gettime32 and clock_getres_time32 should be compiled only with a
32 bit vdso library.

Exclude these symbols when BUILD_VDSO32 is not defined.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20190830135902.20861-3-vincenzo.frascino@arm.com


---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 42bd8ab..8e77071 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -117,6 +117,7 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -139,6 +140,7 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	}
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
@@ -231,6 +233,7 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -253,4 +256,5 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	}
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 #endif /* VDSO_HAS_CLOCK_GETRES */
