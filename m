Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9724CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A52073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCWTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:54:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42692 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCWTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:54:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGT9Y-00065W-JG; Mon, 23 Mar 2020 20:54:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0CA61C0470;
        Mon, 23 Mar 2020 20:54:27 +0100 (CET)
Date:   Mon, 23 Mar 2020 19:54:27 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Fix clocksource.h macro detection
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323133920.46546-1-vincenzo.frascino@arm.com>
References: <20200323133920.46546-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158499326733.28353.8842220324373081169.tip-bot2@tip-bot2>
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

Commit-ID:     ca214e2c1793058e3a1387f9e343cc5b1731db15
Gitweb:        https://git.kernel.org/tip/ca214e2c1793058e3a1387f9e343cc5b1731db15
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:39:20 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Mar 2020 18:51:08 +01:00

vdso: Fix clocksource.h macro detection

CONFIG_GENERIC_GETTIMEOFDAY is a sufficient condition to verify if an
architecture implements asm/vdso/clocksource.h or not. The current
implementation wrongly assumes that the same is true for the config
option CONFIG_ARCH_CLOCKSOURCE_DATA.

This results in a series of build errors on ia64/sparc/sparc64 like this:

  In file included from ./include/linux/clocksource.h:31,
                   from ./include/linux/clockchips.h:14,
                   from ./include/linux/tick.h:8,
                   from fs/proc/stat.c:15:
  ./include/vdso/clocksource.h:9:10: fatal error: asm/vdso/clocksource.h:
  No such file or directory
      9 | #include <asm/vdso/clocksource.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~~~

Fix the issue removing the unneeded config condition.

Fixes: 14ee2ac618e4 ("linux/clocksource.h: Extract common header for vDSO")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200323133920.46546-1-vincenzo.frascino@arm.com
---
 include/vdso/clocksource.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/vdso/clocksource.h b/include/vdso/clocksource.h
index ab58330..c682e7c 100644
--- a/include/vdso/clocksource.h
+++ b/include/vdso/clocksource.h
@@ -4,10 +4,9 @@
 
 #include <vdso/limits.h>
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-	defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <asm/vdso/clocksource.h>
-#endif /* CONFIG_ARCH_CLOCKSOURCE_DATA || CONFIG_GENERIC_GETTIMEOFDAY */
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 enum vdso_clock_mode {
 	VDSO_CLOCKMODE_NONE,
