Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D962C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B37A2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgAJSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:33:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:33:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipz5z-0002hp-NY; Fri, 10 Jan 2020 19:33:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4DBDF1C2D77;
        Fri, 10 Jan 2020 19:33:19 +0100 (CET)
Date:   Fri, 10 Jan 2020 18:33:19 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] lib/vdso: Make __cvdso_clock_getres() static
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191128111719.8282-1-vincenzo.frascino@arm.com>
References: <20191128111719.8282-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <157868119905.30329.14304133573747134138.tip-bot2@tip-bot2>
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

Commit-ID:     ffd08731b2d632459428612431060cf902324a8d
Gitweb:        https://git.kernel.org/tip/ffd08731b2d632459428612431060cf902324a8d
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Thu, 28 Nov 2019 11:17:19 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Jan 2020 19:29:01 +01:00

lib/vdso: Make __cvdso_clock_getres() static

Fix the following sparse warning in the generic vDSO library:

  linux/lib/vdso/gettimeofday.c:224:5: warning: symbol
  '__cvdso_clock_getres' was not declared. Should it be static?

Make it static and also mark it __maybe_unsed.

Fixes: 502a590a170b ("lib/vdso: Move fallback invocation to the callers")
Reported-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191128111719.8282-1-vincenzo.frascino@arm.com
---
 lib/vdso/gettimeofday.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9ecfd3b..42bd8ab 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -221,6 +221,7 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
 	int ret = __cvdso_clock_getres_common(clock, res);
