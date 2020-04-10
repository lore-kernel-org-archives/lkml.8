Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A082C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463820936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491315;
	bh=sMaKLDHuSGb03d76wtSoUZJF0vZ1jrMZoochBfYH8rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0l2RBznRcVF0b6o7wfpbkTD0MuTycFenkWuU5s24U4k7oyx0XnAP1pgqsg0JaoZAC
	 zhypKtw15/3eK6Nb6y9KKmWe5t6AkXAz8bzqSA3MNeWsmvwvRqekPQ71mibTpcXwCC
	 CtizTZr9bRruIoEuCLFL39y2xHM2Z6fiEYuEFtNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgDJDrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgDJDrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455B621744;
        Fri, 10 Apr 2020 03:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490435;
        bh=sMaKLDHuSGb03d76wtSoUZJF0vZ1jrMZoochBfYH8rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEno1kA0Mi0Mibs9ODyDs3nwr5vtxG8qguJqjn9RcckrBV+LJUg23fMsvwkpjgw1U
         gSuBSgqRpamkl45+wpfycNRMfMXCXHE27yP6VQFsuqI+lNGNjfNDw4e7ggudnuPJhm
         3MBXIjgRYUTD27L7tZF9LE+FM3gFQiJKD+MBQzLs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 33/68] time/sched_clock: Expire timer in hardirq context
Date:   Thu,  9 Apr 2020 23:45:58 -0400
Message-Id: <20200410034634.7731-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

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

