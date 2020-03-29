Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6BCC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8A72073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgC2QEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:04:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgC2QEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:04:01 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIaPh-0007uo-LA; Sun, 29 Mar 2020 18:03:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 21D9C101178;
        Sun, 29 Mar 2020 18:03:53 +0200 (CEST)
Date:   Sun, 29 Mar 2020 16:03:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.6
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
Message-ID: <158549780514.2870.11802053793870612265.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-03-29

up to:  749da8ca978f: clocksource/drivers/hyper-v: Make sched clock return nanoseconds correctly

A single fix for the Hyper-V clocksource driver to make sched clock
actually return nanoseconds and not the virtual clock value which
increments at 10e7 HZ (100ns).


Thanks,

	tglx

------------------>
Yubo Xie (1):
      clocksource/drivers/hyper-v: Make sched clock return nanoseconds correctly


 drivers/clocksource/hyperv_timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 9d808d595ca8..eb0ba7818eb0 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -343,7 +343,8 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
 
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc() - hv_sched_clock_offset;
+	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static void suspend_hv_clock_tsc(struct clocksource *arg)
@@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
 
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr() - hv_sched_clock_offset;
+	return (read_hv_clock_msr() - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static struct clocksource hyperv_cs_msr = {

