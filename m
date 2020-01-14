Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A749AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED624687
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgANNCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgANNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLq5-0004ny-Cn; Tue, 14 Jan 2020 14:02:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B0F31C0852;
        Tue, 14 Jan 2020 14:02:22 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:22 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Avoid duplication in __cvdso_clock_getres()
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cfdf1a968a8f7edd61456f1689ac44082ebb19c15=2E15771?=
 =?utf-8?q?11367=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
References: =?utf-8?q?=3Cfdf1a968a8f7edd61456f1689ac44082ebb19c15=2E157711?=
 =?utf-8?q?1367=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <157900694207.396.9782329695399222834.tip-bot2@tip-bot2>
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

Commit-ID:     cdb7c5a9c897ab2e5c56df647dd84c84e150e925
Gitweb:        https://git.kernel.org/tip/cdb7c5a9c897ab2e5c56df647dd84c84e150e925
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Mon, 23 Dec 2019 14:31:09 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:47 +01:00

lib/vdso: Avoid duplication in __cvdso_clock_getres()

VDSO_HRES and VDSO_RAW clocks are handled the same way.

Avoid the code duplication.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/fdf1a968a8f7edd61456f1689ac44082ebb19c15.1577111367.git.christophe.leroy@c-s.fr


---
 lib/vdso/gettimeofday.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 5a5ec89..fac9e86 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -193,7 +193,7 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	 * clocks are handled in the VDSO directly.
 	 */
 	msk = 1U << clock;
-	if (msk & VDSO_HRES) {
+	if (msk & (VDSO_HRES | VDSO_RAW)) {
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
@@ -203,11 +203,6 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 		 * Preserves the behaviour of posix_get_coarse_res().
 		 */
 		ns = LOW_RES_NSEC;
-	} else if (msk & VDSO_RAW) {
-		/*
-		 * Preserves the behaviour of posix_get_hrtimer_res().
-		 */
-		ns = hrtimer_res;
 	} else {
 		return -1;
 	}
