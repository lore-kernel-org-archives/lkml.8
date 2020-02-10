Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497902070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qDQKU1ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBJNmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:42:46 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53440 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581342162; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=64lntp/RjKuHI9N8BfqV5OqivQNtIKnvsNXHWwyQdf8=;
        b=qDQKU1mlppk10PfQEw6DTCwRjCS+W+WuMUG8i8q4Gm7+ddFAanDo7Y/Agl3vd59dk6I/RN
        x4XuDmeJdN0N055GhO//rCH331ZFUeWj15tptO3AtAxEu+FkrQLoBqmLs7UQ7m8GXSyBIc
        FAXbiXbUl+72fpiDtJj+O55pA/p1wDs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 1/2] sched: Add sched_clock_register_new()
Date:   Mon, 10 Feb 2020 10:42:12 -0300
Message-Id: <20200210134213.8324-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_clock_register_new() behaves like sched_clock_register() but
takes an extra parameter which is passed to the read callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v4: New patch

 include/linux/sched_clock.h |  2 ++
 kernel/time/sched_clock.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 0bb04a96a6d4..15509487fd16 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -10,6 +10,8 @@ extern void generic_sched_clock_init(void);
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
+extern void sched_clock_register_new(u64 (*read)(void *), int bits,
+				     unsigned long rate, void *data);
 #else
 static inline void generic_sched_clock_init(void) { }
 
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index e4332e3e2d56..9ba61814ea48 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -27,6 +27,7 @@
  * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
  *			clocks.
  * @read_sched_clock:	Current clock source (or dummy source when suspended).
+ * @data:		Callback data for the current clock source.
  * @mult:		Multipler for scaled math conversion.
  * @shift:		Shift value for scaled math conversion.
  *
@@ -39,7 +40,8 @@ struct clock_read_data {
 	u64 epoch_ns;
 	u64 epoch_cyc;
 	u64 sched_clock_mask;
-	u64 (*read_sched_clock)(void);
+	u64 (*read_sched_clock)(void *);
+	void *data;
 	u32 mult;
 	u32 shift;
 };
@@ -53,6 +55,7 @@ struct clock_read_data {
  * @read_data:		Data required to read from sched_clock.
  * @wrap_kt:		Duration for which clock can run before wrapping.
  * @rate:		Tick rate of the registered clock.
+ * @data:		Callback data for the registered clock read function.
  * @actual_read_sched_clock: Registered hardware level clock read function.
  *
  * The ordering of this structure has been chosen to optimize cache
@@ -65,7 +68,8 @@ struct clock_data {
 	ktime_t			wrap_kt;
 	unsigned long		rate;
 
-	u64 (*actual_read_sched_clock)(void);
+	void			*data;
+	u64 (*actual_read_sched_clock)(void *);
 };
 
 static struct hrtimer sched_clock_timer;
@@ -73,7 +77,7 @@ static int irqtime = -1;
 
 core_param(irqtime, irqtime, int, 0400);
 
-static u64 notrace jiffy_sched_clock_read(void)
+static u64 notrace jiffy_sched_clock_read(void *d)
 {
 	/*
 	 * We don't need to use get_jiffies_64 on 32-bit arches here
@@ -103,7 +107,7 @@ unsigned long long notrace sched_clock(void)
 		seq = raw_read_seqcount(&cd.seq);
 		rd = cd.read_data + (seq & 1);
 
-		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
+		cyc = (rd->read_sched_clock(rd->data) - rd->epoch_cyc) &
 		      rd->sched_clock_mask;
 		res = rd->epoch_ns + cyc_to_ns(cyc, rd->mult, rd->shift);
 	} while (read_seqcount_retry(&cd.seq, seq));
@@ -147,7 +151,7 @@ static void update_sched_clock(void)
 
 	rd = cd.read_data[0];
 
-	cyc = cd.actual_read_sched_clock();
+	cyc = cd.actual_read_sched_clock(cd.data);
 	ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) & rd.sched_clock_mask, rd.mult, rd.shift);
 
 	rd.epoch_ns = ns;
@@ -165,7 +169,8 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 }
 
 void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+sched_clock_register_new(u64 (*read)(void *), int bits,
+			 unsigned long rate, void *data)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -192,12 +197,14 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	rd = cd.read_data[0];
 
 	/* Update epoch for new counter and update 'epoch_ns' from old counter*/
-	new_epoch = read();
-	cyc = cd.actual_read_sched_clock();
+	new_epoch = read(data);
+	cyc = cd.actual_read_sched_clock(cd.data);
 	ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) & rd.sched_clock_mask, rd.mult, rd.shift);
 	cd.actual_read_sched_clock = read;
+	cd.data = data;
 
 	rd.read_sched_clock	= read;
+	rd.data			= data;
 	rd.sched_clock_mask	= new_mask;
 	rd.mult			= new_mult;
 	rd.shift		= new_shift;
@@ -239,6 +246,12 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
 
+void __init
+sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+{
+	sched_clock_register_new((u64 (*)(void *))read, bits, rate, NULL);
+}
+
 void __init generic_sched_clock_init(void)
 {
 	/*
@@ -246,7 +259,8 @@ void __init generic_sched_clock_init(void)
 	 * make it the final one one.
 	 */
 	if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
-		sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
+		sched_clock_register_new(jiffy_sched_clock_read,
+					 BITS_PER_LONG, HZ, NULL);
 
 	update_sched_clock();
 
@@ -270,7 +284,7 @@ void __init generic_sched_clock_init(void)
  * at the end of the critical section to be sure we observe the
  * correct copy of 'epoch_cyc'.
  */
-static u64 notrace suspended_sched_clock_read(void)
+static u64 notrace suspended_sched_clock_read(void *d)
 {
 	unsigned int seq = raw_read_seqcount(&cd.seq);
 
@@ -292,7 +306,7 @@ void sched_clock_resume(void)
 {
 	struct clock_read_data *rd = &cd.read_data[0];
 
-	rd->epoch_cyc = cd.actual_read_sched_clock();
+	rd->epoch_cyc = cd.actual_read_sched_clock(cd.data);
 	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
 	rd->read_sched_clock = cd.actual_read_sched_clock;
 }
-- 
2.24.1

