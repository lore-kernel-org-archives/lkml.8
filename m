Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8685C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848A52063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046724;
	bh=KOpfk3F4eO15pB12X5Hbjlf5TyBcfSiuOkPp3BwAESg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BDx29FW8Z3cNYw3E6Uj2436NMFHIZSzHSrdgzduqKcyFxjHOIpJkHXF2PC6d7Yfgx
	 eswHD3LFwSBwVVDmobKmpfpGBr/DvpCJBriiv94zlDjHXJ8+fjVzGi6mg4RULaygve
	 ZFXfusa7ngEc6yXL3/U8kBLLTS+ssjGNRXEmIZ2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbgDPOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405255AbgDPNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D1721744;
        Thu, 16 Apr 2020 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045190;
        bh=KOpfk3F4eO15pB12X5Hbjlf5TyBcfSiuOkPp3BwAESg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2N4ZF1PvEM7XKxYqU6ddn9QQC2H4Oaa4DEIidyaW7id2fng/mjsETAq4MchNv5j5R
         OwFa/kYGuerS4PLxCJgc3rruadlOW9JtHM4rHzGp+y4k5H8fTMMspfLVdUK2AvoIuT
         tm79j1q0nYxG/yB7uujEYIHGF4GSzBi4U3/0YJts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 033/254] time/sched_clock: Expire timer in hardirq context
Date:   Thu, 16 Apr 2020 15:22:02 +0200
Message-Id: <20200416131330.017771573@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed S. Darwish <a.darwish@linutronix.de>

[ Upstream commit 2c8bd58812ee3dbf0d78b566822f7eacd34bdd7b ]

To minimize latency, PREEMPT_RT kernels expires hrtimers in preemptible
softirq context by default. This can be overriden by marking the timer's
expiry with HRTIMER_MODE_HARD.

sched_clock_timer is missing this annotation: if its callback is preempted
and the duration of the preemption exceeds the wrap around time of the
underlying clocksource, sched clock will get out of sync.

Mark the sched_clock_timer for expiry in hard interrupt context.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200309181529.26558-1-a.darwish@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/sched_clock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index e4332e3e2d569..fa3f800d7d763 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -208,7 +208,8 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
 	if (sched_clock_timer.function != NULL) {
 		/* update timeout for clock wrap */
-		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt,
+			      HRTIMER_MODE_REL_HARD);
 	}
 
 	r = rate;
@@ -254,9 +255,9 @@ void __init generic_sched_clock_init(void)
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
-	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	sched_clock_timer.function = sched_clock_poll;
-	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 }
 
 /*
@@ -293,7 +294,7 @@ void sched_clock_resume(void)
 	struct clock_read_data *rd = &cd.read_data[0];
 
 	rd->epoch_cyc = cd.actual_read_sched_clock();
-	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 	rd->read_sched_clock = cd.actual_read_sched_clock;
 }
 
-- 
2.20.1



