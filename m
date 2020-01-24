Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD88C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D512087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392411AbgAXUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:08:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbgAXUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:08:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv5FM-0000vj-IJ; Fri, 24 Jan 2020 21:08:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B3B821C1A6A;
        Fri, 24 Jan 2020 21:08:03 +0100 (CET)
Date:   Fri, 24 Jan 2020 20:08:03 -0000
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Make alarmtimer_get_rtcdev() a stub
 when CONFIG_RTC_CLASS=n
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200124055849.154411-4-swboyd@chromium.org>
References: <20200124055849.154411-4-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <157989648346.396.15024320326165143197.tip-bot2@tip-bot2>
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

Commit-ID:     fd928f3e32ba09381b287f8b732418434d932855
Gitweb:        https://git.kernel.org/tip/fd928f3e32ba09381b287f8b732418434d932855
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Thu, 23 Jan 2020 21:58:48 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2020 21:03:53 +01:00

alarmtimer: Make alarmtimer_get_rtcdev() a stub when CONFIG_RTC_CLASS=n

The stubbed version of alarmtimer_get_rtcdev() is not exported.
so this won't work if this function is used in a module when
CONFIG_RTC_CLASS=n.

Move the stub function to the header file and make it inline so that
callers don't have to worry about linking against this symbol.

rtcdev isn't used outside of this ifdef so it's not required to be
redefined to NULL. Drop that while touching this area.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200124055849.154411-4-swboyd@chromium.org
---
 include/linux/alarmtimer.h | 4 ++++
 kernel/time/alarmtimer.c   | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 74748e3..05e758b 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -60,7 +60,11 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, ktime_t interval);
 u64 alarm_forward_now(struct alarm *alarm, ktime_t interval);
 ktime_t alarm_expires_remaining(const struct alarm *alarm);
 
+#ifdef CONFIG_RTC_CLASS
 /* Provide way to access the rtc device being used by alarmtimers */
 struct rtc_device *alarmtimer_get_rtcdev(void);
+#else
+static inline struct rtc_device *alarmtimer_get_rtcdev(void) { return NULL; }
+#endif
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 685ff57..2ffb466 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -143,11 +143,6 @@ static void alarmtimer_rtc_interface_remove(void)
 	class_interface_unregister(&alarmtimer_rtc_interface);
 }
 #else
-struct rtc_device *alarmtimer_get_rtcdev(void)
-{
-	return NULL;
-}
-#define rtcdev (NULL)
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
 static inline void alarmtimer_rtc_timer_init(void) { }
