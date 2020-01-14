Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8234C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48162467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgANNCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgANNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpy-0004jB-Au; Tue, 14 Jan 2020 14:02:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FDA71C0833;
        Tue, 14 Jan 2020 14:02:19 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:19 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Use clock_get_ktime() in common_timer_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-11-dima@arista.com>
References: <20191112012724.250792-11-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693919.396.5081348938759568990.tip-bot2@tip-bot2>
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

Commit-ID:     198fa445d5c4c1a1c6c1d39f962559f8d008e79d
Gitweb:        https://git.kernel.org/tip/198fa445d5c4c1a1c6c1d39f962559f8d008e79d
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:26:59 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:52 +01:00

posix-timers: Use clock_get_ktime() in common_timer_get()

Now, when the clock_get_ktime() callback exists, the suboptimal
timespec64-based conversion can be removed from common_timer_get().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-11-dima@arista.com


---
 kernel/time/posix-timers.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a1f6b96..fe1de4f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -665,7 +665,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -683,12 +682,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get_timespec(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
