Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB012074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgJst9QM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7M3MaSQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHWIlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHWIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:41:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BCC061574;
        Sun, 23 Aug 2020 01:40:59 -0700 (PDT)
Date:   Sun, 23 Aug 2020 08:40:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598172057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5py+LxhKqsq41gvD/8FMrN4Y2kSbhnb76DTvPWvQIQ=;
        b=NgJst9QMGDUH9uWtLtsETXPHtcYTjXFADBp+aFSw1VyXJHoxxGN7W8JQSdgT9QI10TxB+H
        BDN6x0wQrMFSm6cFRLkcL3z9HymJyx/0ECfoHjhDhPv01bZHysC/i8eAeNFQqMcddsj3E4
        O5ldEFnVy9ZR3CuGfM5gqSmAyrww59ZGCh5w4J2Fd1EvBYKOYlwUN3wq0K8QepKhBuA80m
        Ilb8KvZMTCOhsGDu3vX2UuPi8bHjHqgAIXPJ1hEWPeYy+2duE4huw4u1wtzocWmztPIbya
        PlLryZHmsYEKUYx1mzQCoYGbOChhcJo0rt8bIPD+Xv07N981COBkWo0i7Kaazw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598172057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5py+LxhKqsq41gvD/8FMrN4Y2kSbhnb76DTvPWvQIQ=;
        b=7M3MaSQM/8/Is/OGEH07ptDekGUIZlT2pz3JJn09ND8z4/PcgO5TNVMqDOvewF2wg6Sec+
        HPDnkISbcljGJoDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Utilize local_clock() for NMI safe
 timekeeper during early boot
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814115512.041422402@linutronix.de>
References: <20200814115512.041422402@linutronix.de>
MIME-Version: 1.0
Message-ID: <159817205716.389.11069569301352194455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     71419b30cab099f7ca37e61bf41028d8b7d4984d
Gitweb:        https://git.kernel.org/tip/71419b30cab099f7ca37e61bf41028d8b7d4984d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 14 Aug 2020 12:19:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Aug 2020 10:38:24 +02:00

timekeeping: Utilize local_clock() for NMI safe timekeeper during early boot

During early boot the NMI safe timekeeper returns 0 until the first
clocksource becomes available.

This prevents it from being used for printk or other facilities which today
use sched clock. sched clock can be available way before timekeeping is
initialized.

The obvious workaround for this is to utilize the early sched clock in the
default dummy clock read function until a clocksource becomes available.

After switching to the clocksource clock MONOTONIC and BOOTTIME will not
jump because the timekeeping_init() bases clock MONOTONIC on sched clock
and the offset between clock MONOTONIC and BOOTTIME is zero during boot.

Clock REALTIME cannot provide useful timestamps during early boot up to
the point where a persistent clock becomes available, which is either in
timekeeping_init() or later when the RTC driver which might depend on I2C
or other subsystems is initialized.

There is a minor difference to sched_clock() vs. suspend/resume. As the
timekeeper clock source might not be accessible during suspend, after
timekeeping_suspend() timestamps freeze up to the point where
timekeeping_resume() is invoked. OTOH this is true for some sched clock
implementations as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Petr Mladek <pmladek@suse.com>                                                                                                                                                                                                                                      
Link: https://lore.kernel.org/r/20200814115512.041422402@linutronix.de

---
 kernel/time/timekeeping.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f38..57d064d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -54,6 +54,9 @@ static struct {
 
 static struct timekeeper shadow_timekeeper;
 
+/* flag for if timekeeping is suspended */
+int __read_mostly timekeeping_suspended;
+
 /**
  * struct tk_fast - NMI safe timekeeper
  * @seq:	Sequence counter for protecting updates. The lowest bit
@@ -73,28 +76,42 @@ static u64 cycles_at_suspend;
 
 static u64 dummy_clock_read(struct clocksource *cs)
 {
-	return cycles_at_suspend;
+	if (timekeeping_suspended)
+		return cycles_at_suspend;
+	return local_clock();
 }
 
 static struct clocksource dummy_clock = {
 	.read = dummy_clock_read,
 };
 
+/*
+ * Boot time initialization which allows local_clock() to be utilized
+ * during early boot when clocksources are not available. local_clock()
+ * returns nanoseconds already so no conversion is required, hence mult=1
+ * and shift=0. When the first proper clocksource is installed then
+ * the fast time keepers are updated with the correct values.
+ */
+#define FAST_TK_INIT						\
+	{							\
+		.clock		= &dummy_clock,			\
+		.mask		= CLOCKSOURCE_MASK(64),		\
+		.mult		= 1,				\
+		.shift		= 0,				\
+	}
+
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
 	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
-/* flag for if timekeeping is suspended */
-int __read_mostly timekeeping_suspended;
-
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
