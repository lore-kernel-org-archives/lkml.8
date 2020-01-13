Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA49C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D014A24655
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAMTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:10:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAMTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55o-00016e-7W; Mon, 13 Jan 2020 20:09:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A20B11C18EA;
        Mon, 13 Jan 2020 20:09:30 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:30 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Rename gettime() callback to get_ktime()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-8-dima@arista.com>
References: <20191112012724.250792-8-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894257052.19145.16061166224105251961.tip-bot2@tip-bot2>
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

Commit-ID:     7599bee13643a1401e1dca26cfaf18cacc444c65
Gitweb:        https://git.kernel.org/tip/7599bee13643a1401e1dca26cfaf18cacc444c65
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:26:56 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:49 +01:00

alarmtimer: Rename gettime() callback to get_ktime()

The upcoming support for time namespaces requires to have access to:

  - The time in a tasks time namespace for sys_clock_gettime()
  - The time in the root name space for common_timer_get()

struct alarm_base needs to follow the same naming convention, so rename
.gettime() callback into get_ktime() as a preparation for introducing
get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-8-dima@arista.com

---
 kernel/time/alarmtimer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 62b06cf..22b6f9b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -36,13 +36,13 @@
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
- * @gettime:		Function to read the time correlating to the base
+ * @get_ktime:		Function to read the time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
-	ktime_t			(*gettime)(void);
+	ktime_t			(*get_ktime)(void);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -207,7 +207,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->gettime());
+		restart = alarm->function(alarm, base->get_ktime());
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (restart != ALARMTIMER_NORESTART) {
@@ -217,7 +217,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	}
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_fired(alarm, base->gettime());
+	trace_alarmtimer_fired(alarm, base->get_ktime());
 	return ret;
 
 }
@@ -225,7 +225,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	return ktime_sub(alarm->node.expires, base->gettime());
+	return ktime_sub(alarm->node.expires, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 
@@ -270,7 +270,7 @@ static int alarmtimer_suspend(struct device *dev)
 		spin_unlock_irqrestore(&base->lock, flags);
 		if (!next)
 			continue;
-		delta = ktime_sub(next->expires, base->gettime());
+		delta = ktime_sub(next->expires, base->get_ktime());
 		if (!min || (delta < min)) {
 			expires = next->expires;
 			min = delta;
@@ -364,7 +364,7 @@ void alarm_start(struct alarm *alarm, ktime_t start)
 	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_start(alarm, base->gettime());
+	trace_alarmtimer_start(alarm, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_start);
 
@@ -377,7 +377,7 @@ void alarm_start_relative(struct alarm *alarm, ktime_t start)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	start = ktime_add_safe(start, base->gettime());
+	start = ktime_add_safe(start, base->get_ktime());
 	alarm_start(alarm, start);
 }
 EXPORT_SYMBOL_GPL(alarm_start_relative);
@@ -414,7 +414,7 @@ int alarm_try_to_cancel(struct alarm *alarm)
 		alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_cancel(alarm, base->gettime());
+	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(alarm_try_to_cancel);
@@ -474,7 +474,7 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	return alarm_forward(alarm, base->gettime(), interval);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
@@ -500,7 +500,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 		return;
 	}
 
-	delta = ktime_sub(absexp, base->gettime());
+	delta = ktime_sub(absexp, base->get_ktime());
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
 	if (!freezer_delta || (delta < freezer_delta)) {
@@ -632,7 +632,7 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
 	if (!absolute)
-		expires = ktime_add_safe(expires, base->gettime());
+		expires = ktime_add_safe(expires, base->get_ktime());
 	if (sigev_none)
 		alarm->node.expires = expires;
 	else
@@ -670,7 +670,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->gettime());
+	*tp = ktime_to_timespec64(base->get_ktime());
 	return 0;
 }
 
@@ -747,7 +747,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 		struct timespec64 rmt;
 		ktime_t rem;
 
-		rem = ktime_sub(absexp, alarm_bases[type].gettime());
+		rem = ktime_sub(absexp, alarm_bases[type].get_ktime());
 
 		if (rem <= 0)
 			return 0;
@@ -816,7 +816,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
-		ktime_t now = alarm_bases[type].gettime();
+		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
 	}
@@ -882,9 +882,9 @@ static int __init alarmtimer_init(void)
 
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
-	alarm_bases[ALARM_REALTIME].gettime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
-	alarm_bases[ALARM_BOOTTIME].gettime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
