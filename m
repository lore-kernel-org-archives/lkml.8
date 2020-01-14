Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2AE2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgANNEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:04:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgANNCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpw-0004gf-4o; Tue, 14 Jan 2020 14:02:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2C0441C0805;
        Tue, 14 Jan 2020 14:02:18 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:18 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Make timer_settime() time namespace aware
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-15-dima@arista.com>
References: <20191112012724.250792-15-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693801.396.4434514969684868264.tip-bot2@tip-bot2>
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

Commit-ID:     7da8b3a44bb426a43670b3a97ed61085018a9d43
Gitweb:        https://git.kernel.org/tip/7da8b3a44bb426a43670b3a97ed61085018a9d43
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:03 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:54 +01:00

posix-timers: Make timer_settime() time namespace aware

Wire timer_settime() syscall into time namespace virtualization.

sys_timer_settime() calls the ktime->timer_set() callback. Right now,
common_timer_set() is the only implementation for the callback.

The user-supplied expiry value is converted from timespec64 to ktime and
then timens_ktime_to_host() can be used to convert namespace's time to the
host time.

Inside a time namespace kernel's time differs by a fixed offset from a
user-supplied time, but only absolute values (TIMER_ABSTIME) must be
converted.

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-15-dima@arista.com


---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d26b915..473082b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -885,6 +885,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
