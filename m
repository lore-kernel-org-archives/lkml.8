Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA752C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933772087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSii1uJw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ayKYX/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHNL4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHNL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:56:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87415C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:56:24 -0700 (PDT)
Message-Id: <20200814115512.041422402@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597406182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eSTyF9kDS+nOlZFrl0lkthyUeG7bZQYhwerMq/E443w=;
        b=eSii1uJwezFWOLCkTPOk8HyubAT1l0OuVOUPWdphPXK2lsgJnGbW7dRuFLi7+RTB4eL21M
        lsSMW38dL7qTHFWBwdH3ksXWFBBTwdxKmE0TbxxhjJKFaJ4Nfv98PNelqzXD5mpxe8j78L
        TNE3ylI6XKCtuNBhl3/RcR/ABTEnoyoKsgRUwzeU+YXggLhs86ZX28FFr5Vbm1L9YA9sAT
        HYADHdt3b3VxzKNj255WQpMYcWTlQtKIZdQv//cFPGooIUFjjpWo/hQRsSY/9Pe+4f692C
        +hVhYnREeW2poGSZfWB1ubCTkTvKPFZtaU6/6GKi6a3O5q/sa7B7aPXNoRm75A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597406182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eSTyF9kDS+nOlZFrl0lkthyUeG7bZQYhwerMq/E443w=;
        b=/ayKYX/377+0VvBcPIHSp0Z28SukZ8gbo6foYRtCMySeTmD/u4GuXyVQs040jO4IIufLPn
        ENjTgJ7D/FFVS0DQ==
Date:   Fri, 14 Aug 2020 12:19:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: [patch 1/2] timekeeping: Utilize local_clock() for NMI safe
 timekeeper during early boot
References: <20200814101933.574326079@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename*0*=utf-8''timekeeping--Utilize-local_clock---for-NMI-safe-timekeepe;
 filename*1*=r-during-early-boot.patch
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/time/timekeeping.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -53,6 +53,9 @@ static struct {
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
+/* flag for if timekeeping is suspended */
+int __read_mostly timekeeping_suspended;
+
 /**
  * struct tk_fast - NMI safe timekeeper
  * @seq:	Sequence counter for protecting updates. The lowest bit
@@ -72,26 +75,40 @@ static u64 cycles_at_suspend;
 
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
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
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

