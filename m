Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E9A2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2ynRbma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHGDcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:32:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YbuYyA4IMdVfuOhHIO7dKqUHeSPwm+jdQMQG0UmsUg8=; b=u2ynRbmaaL4IB2OMGpNPB6qxYj
        EvXm1kt8r8sRtPB+rdFIGqgh1xRz5/EAZwjXPW8a2B6pkAXl6+pzCV1+uoHIWeJcbc6hxB8Hy+54X
        PK31Mas34zv6oDUe+QKt/49Eb2iVbO4+VhNqBKx1dSYgQa9n2sa4ibeDv3dUTpA3nifLoXbzC5d+N
        FeGImQVk0H3qa0zvpLv9g/HP6dAwrDmfzoYCEkTo09RSfcBY8NM9Imcbkm79EZq8Vz2FIt4o02fUQ
        7x29lPEPZJq1dERqiFBNuBuEwkFWYkqxfpKwiQYhHe1j9gx3m2wjZysLMP89SR1K1csqkVA6yVU/z
        2ZHcjnXQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t7k-0006qv-3M; Fri, 07 Aug 2020 03:32:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernel: time: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:32:48 -0700
Message-Id: <20200807033248.8452-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/time/.
{when, one, into}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c  |    2 +-
 kernel/time/sched_clock.c |    2 +-
 kernel/time/timekeeping.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200806.orig/kernel/time/alarmtimer.c
+++ linux-next-20200806/kernel/time/alarmtimer.c
@@ -192,7 +192,7 @@ static void alarmtimer_dequeue(struct al
  * When a alarm timer fires, this runs through the timerqueue to
  * see which alarms expired, and runs those. If there are more alarm
  * timers queued for the future, we set the hrtimer to fire when
- * when the next future alarm timer expires.
+ * the next future alarm timer expires.
  */
 static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 {
--- linux-next-20200806.orig/kernel/time/sched_clock.c
+++ linux-next-20200806/kernel/time/sched_clock.c
@@ -229,7 +229,7 @@ void __init generic_sched_clock_init(voi
 {
 	/*
 	 * If no sched_clock() function has been provided at that point,
-	 * make it the final one one.
+	 * make it the final one.
 	 */
 	if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
 		sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
--- linux-next-20200806.orig/kernel/time/timekeeping.c
+++ linux-next-20200806/kernel/time/timekeeping.c
@@ -2001,7 +2001,7 @@ static inline unsigned int accumulate_ns
  * logarithmic_accumulation - shifted accumulation of cycles
  *
  * This functions accumulates a shifted interval of cycles into
- * into a shifted interval nanoseconds. Allows for O(log) accumulation
+ * a shifted interval nanoseconds. Allows for O(log) accumulation
  * loop.
  *
  * Returns the unconsumed cycles.
