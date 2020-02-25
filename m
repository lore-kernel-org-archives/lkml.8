Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF7C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80122525
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="W5pZkJuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgBYDI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:08:28 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38580 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgBYDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:08:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so10711614qkj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czy4TADuB5bsGvxmnxW7ivChVVUNSrZgPzlTYMcyuIQ=;
        b=W5pZkJuHrdFd4lHHumAcstAq5SCYfgAYaY7X3Hji4zTWZK60JZ0iG8cdWleXklD5I3
         WPY3WIsRojFXAH2Fay2W/LCJ0mTMyKn62K8SZtvhKvGiziiBhWsVVQgCVVQmDXmAx1bh
         /WpcCHUm+qrHUG1jzWG3BDE3b5y+TDxw+CyqC3692YY0ReYC3JrA0WOkO+IdNWHZJDue
         t/Y8qlxcMTL+Qyx+aSYZSufmGe+q+OQ+ooCabgOeM2V70I1W01+Bg0bIbgD47y+uosP+
         ewmp/S2Q8zM0JLtTMT88tg97KN8KCe2woW0vD4yiIFgnjS/jXVOdh5Ky1w+Y+QP0qKI/
         5d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czy4TADuB5bsGvxmnxW7ivChVVUNSrZgPzlTYMcyuIQ=;
        b=L90Qb+iI5uRld5Av/njcvetedQDTgMm2IgRAPemF14VIdpBcp+1Oi3AmEs0DXZ2jps
         aFcNJrKkE0ZarQo6E7oYYpqU/kU3+/xGDRYY9ujWD5SvJfiAb2fol6N8X7eW/BnCrNs0
         TqoikPX73A0dm5mXETvA6AoepYUdCGqdNL0nzewZtHMkfHhXtKMgvJkyLQ+pIVd8tW4B
         7jz7AHOqy4L4cZgXS9U/5JCQM6z/2L9+BqudlA/43YA0ljvM9ktfRzzngsiCQbu5T9MA
         ZhP2Y3EYzuc5wMwE4omI/5eVaKQRznm+QueNxz/64fOZCviOT2oPwzg7htBegHVjfFVH
         lRNw==
X-Gm-Message-State: APjAAAVuhy0qXiLYVMVVvzT1Z+8DzifenqetqMZ8txfuodw7Sr1JMHbu
        gl62ZGx0QC+S/AWHHNrhc/5Zig==
X-Google-Smtp-Source: APXvYqwZgzbXZyY17bBjqWnjmGcc7nmUcbkNt8juBskAZl+S6ZFY+tJusS6IHPIB9iWQCEK4kE4rcg==
X-Received: by 2002:a37:4f93:: with SMTP id d141mr53357449qkb.125.1582600106383;
        Mon, 24 Feb 2020 19:08:26 -0800 (PST)
Received: from ovpn-121-71.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y190sm1670457qkb.130.2020.02.24.19.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 19:08:25 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, fweisbec@gmail.com, mingo@kernel.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
Date:   Mon, 24 Feb 2020 22:08:08 -0500
Message-Id: <20200225030808.1207-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_do_timer_cpu could be accessed concurrently where both plain writes
and plain reads are not protected by a lock. Thus, it could result in
data races. Fix them by adding pairs of READ|WRITE_ONCE(). The data
races were reported by KCSAN,

 write to 0xffffffffb2dc94ac of 4 bytes by interrupt on cpu 98:
  tick_sched_do_timer+0x77/0x90
  tick_sched_do_timer at kernel/time/tick-sched.c:136
  tick_sched_timer+0x35/0xc0
  __hrtimer_run_queues+0x217/0x7c0
  hrtimer_interrupt+0x1d4/0x3e0
  smp_apic_timer_interrupt+0x107/0x460
  apic_timer_interrupt+0xf/0x20
  cpuidle_enter_state+0x15e/0x980
  cpuidle_enter+0x69/0xc0
  call_cpuidle+0x23/0x40
  do_idle+0x248/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 read to 0xffffffffb2dc94ac of 4 bytes by interrupt on cpu 67:
  tick_sched_do_timer+0x31/0x90
  tick_sched_do_timer at kernel/time/tick-sched.c:132
  tick_sched_timer+0x35/0xc0
  __hrtimer_run_queues+0x217/0x7c0
  hrtimer_interrupt+0x1d4/0x3e0
  smp_apic_timer_interrupt+0x107/0x460
  apic_timer_interrupt+0xf/0x20
  cpuidle_enter_state+0x15e/0x980
  cpuidle_enter+0x69/0xc0
  call_cpuidle+0x23/0x40
  do_idle+0x248/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 read to 0xffffffffb2dc94ac of 4 bytes by task 0 on cpu 107:
  tick_nohz_idle_stop_tick+0x149/0x5f0
  tick_nohz_stop_tick at kernel/time/tick-sched.c:774
  (inlined by) __tick_nohz_idle_stop_tick at kernel/time/tick-sched.c:967
  (inlined by) tick_nohz_idle_stop_tick at kernel/time/tick-sched.c:988
  do_idle+0x235/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 read to 0xffffffffb2dc94ac of 4 bytes by task 0 on cpu 21:
  tick_nohz_next_event+0x19b/0x2c0
  tick_nohz_next_event at kernel/time/tick-sched.c:740
  tick_nohz_get_sleep_length+0xae/0xe0
  menu_select+0x8b/0xc29
  cpuidle_select+0x50/0x70
  do_idle+0x214/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/time/tick-sched.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21cac64..54bcf4eff238 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -129,16 +129,16 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (unlikely(READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON(tick_nohz_full_running);
 #endif
-		tick_do_timer_cpu = cpu;
+		WRITE_ONCE(tick_do_timer_cpu, cpu);
 	}
 #endif
 
 	/* Check, if the jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	if (READ_ONCE(tick_do_timer_cpu) == cpu)
 		tick_do_update_jiffies64(now);
 
 	if (ts->inidle)
@@ -737,8 +737,9 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	if (cpu != READ_ONCE(tick_do_timer_cpu) &&
+	    (READ_ONCE(tick_do_timer_cpu) != TICK_DO_TIMER_NONE ||
+	     !ts->do_timer_last))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -771,10 +772,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * do_timer() never invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
-	if (cpu == tick_do_timer_cpu) {
-		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+	if (cpu == READ_ONCE(tick_do_timer_cpu)) {
+		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
 		ts->do_timer_last = 1;
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (READ_ONCE(tick_do_timer_cpu) != TICK_DO_TIMER_NONE) {
 		ts->do_timer_last = 0;
 	}
 
-- 
2.21.0 (Apple Git-122.2)

