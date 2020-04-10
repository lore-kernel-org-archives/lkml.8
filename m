Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1AC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651BC20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491004;
	bh=gXuLcjnFmu7I8/9QP80Zfyjgrdu24JxyI56rH78YD5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J5VC7k8nJxYvBlhEsvkGiPmqevco8zkAkdQQ08obOAyfjq7KIKv1G/wdbtyTiJ2Op
	 POQZ0wIkIIIfZMwv9j0J0qayi5HurL/3HRwkIS2QM7ygi2A7A9KjeLDajuIJ4a3RAO
	 ecLHmpozYSyo7rgnwFY7CiJjrXzRSh5C1NHjOpB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgDJD4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDJDta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1AD21556;
        Fri, 10 Apr 2020 03:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490570;
        bh=gXuLcjnFmu7I8/9QP80Zfyjgrdu24JxyI56rH78YD5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5wq9mO+r6irpedb5vlc/8AxJq2EAhruzyh8rXTuOnNdI/qUsMu4CTv/xcmo0L0p5
         vI7TYJ3LTuUZvD2dHWNrtMdkufeyKUBkgO3o8MFp393eBmk3XdhbIGsn+yAfxvGLtz
         1MZUeq3ZLO6F+GG5V53a09+JU2U0FkXO3uyVHBh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 17/46] time/sched_clock: Expire timer in hardirq context
Date:   Thu,  9 Apr 2020 23:48:40 -0400
Message-Id: <20200410034909.8922-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034909.8922-1-sashal@kernel.org>
References: <20200410034909.8922-1-sashal@kernel.org>
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
index dbd69052eaa66..a5538dd76a819 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -207,7 +207,8 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
 	if (sched_clock_timer.function != NULL) {
 		/* update timeout for clock wrap */
-		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt,
+			      HRTIMER_MODE_REL_HARD);
 	}
 
 	r = rate;
@@ -251,9 +252,9 @@ void __init generic_sched_clock_init(void)
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
@@ -290,7 +291,7 @@ void sched_clock_resume(void)
 	struct clock_read_data *rd = &cd.read_data[0];
 
 	rd->epoch_cyc = cd.actual_read_sched_clock();
-	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 	rd->read_sched_clock = cd.actual_read_sched_clock;
 }
 
-- 
2.20.1

