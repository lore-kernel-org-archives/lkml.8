Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A549EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7944520409
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="n3yfRISi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgCFPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:02:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41905 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:02:57 -0500
Received: by mail-qv1-f67.google.com with SMTP id s15so1041232qvn.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZwOxDEE6FTlabp1Erp1Tw5Doyf6ABG7BAUGaMzAXBE=;
        b=n3yfRISiL7NMWNlXjtM+56EXcJApssI1b+rz0/YnhKXR9fp6xJQExtQrvKwmje9c7+
         zxQJdzbo2rcRpaCjNr5UYpYkwd8FRe/Gnib9Y27v53voEcY0Dgc/Qim2IgTzG62RFxvA
         hqiWH5v7W/HpKS7ODeOG7x+xepP9SVuj30XyhvZ3mOS91+jiw/5RyYV1Z31yHq00M3O7
         iHyb+1tm2UmUCrkCZwdE8/D0zEFnZJrTMcZ84yzlJLSDdsyZueUcmOtMtwHP3JpX28kj
         gGrv+N5lQLBO6TpOmdpz6Sbfp7lS8m6+8PcivYJPEMfvID1NFbQc5DOVyAG7G81kGoR5
         qhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZwOxDEE6FTlabp1Erp1Tw5Doyf6ABG7BAUGaMzAXBE=;
        b=ZyeZ1+ZeC5YPXDRnNAXAC4eTzicHz+g7aIqfzYlRBIp0ft9EdNu33jZnduDhOaLVws
         KkC9yC2j485xmOluSxS7Fszkfw1zyFSwUcEP32HLpTsSmDVegDsY+t2aL6NGHIBKGaiN
         ruB1imXL0Cyq06HJONzOU09cEA3nqq69A6IcWfxTSDDps+puvtmlVS9tG3OLkcW2E40V
         llbHy4uxVgqAMcGSJ1KbKTbZ53XsVIswTMG3Y9jv/pEMgiP6EpMDSK93au43QTsaGvOB
         9drt5x7ZiwrHowu8Wa1ETv1hBgqlI3wZwJ4f4Wzl3bi3hiBKmeBRu3YkJVF+KZZKdQ41
         iArQ==
X-Gm-Message-State: ANhLgQ2BjUbJ5MBuzFwL3uHn2DWgJ9wceX5ci9pquPMEtLTsJyBGoFoW
        JtBjQLIeK8zJ0KFWumgJXrTt7g==
X-Google-Smtp-Source: ADFU+vtv/a+oV26fQHbhc8g7zTvQfdaDOkdGTbfwTgmj0AHRuzSl0XeAkTmOf/oiqW99G3TPIlEoOQ==
X-Received: by 2002:a0c:bf05:: with SMTP id m5mr3287276qvi.26.1583506976090;
        Fri, 06 Mar 2020 07:02:56 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 62sm14856664qkk.84.2020.03.06.07.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 07:02:55 -0800 (PST)
Message-ID: <1583506974.7365.160.camel@lca.pw>
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fweisbec@gmail.com, mingo@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 06 Mar 2020 10:02:54 -0500
In-Reply-To: <1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw>
References: <87tv34laqq.fsf@nanos.tec.linutronix.de>
         <1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 06:20 -0500, Qian Cai wrote:
> > On Mar 4, 2020, at 4:39 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > They are reported, but are they actually a real problem?
> > 
> > This completely lacks analysis why these 8 places need the
> > READ/WRITE_ONCE() treatment at all and if so why the other 14 places
> > accessing tick_do_timer_cpu are safe without it.
> > 
> > I definitely appreciate the work done with KCSAN, but just making the
> > tool shut up does not cut it.
> 
> Looks at tick_sched_do_timer(), for example,
> 
> if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
> #ifdef CONFIG_NO_HZ_FULL
> 		WARN_ON(tick_nohz_full_running);
> #endif
> 		tick_do_timer_cpu = cpu;
> 	}
> #endif
> 
> /* Check, if the jiffies need an update */
> if (tick_do_timer_cpu == cpu)
> 	tick_do_update_jiffies64(now);
> 
> Could we rule out all compilers and archs will not optimize it if !CONFIG_NO_HZ_FULL to,
> 
> if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE) || tick_do_timer_cpu == cpu)
>          tick_do_update_jiffies64(now);
> 
> So it could save a branch or/and realized that tick_do_timer_cpu is not used later in this cpu, so it could discard the store?
> 
> I am not all that familiar with all other 14 places if it is possible to happen concurrently as well, so I took a pragmatic approach that for now only deal with the places that KCSAN confirmed, and then look forward for an incremental approach if there are more places needs treatments later once confirmed.

If you don't think that will be happening and dislike using READ/WRITE_ONCE()
for documentation purpose, we could annotate those using the data_race() macro.
Is that more acceptable?

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21cac64..08ce4088da87 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -129,7 +129,7 @@ static void tick_sched_do_timer(struct tick_sched *ts,
ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (unlikely(data_race(tick_do_timer_cpu == TICK_DO_TIMER_NONE))) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON(tick_nohz_full_running);
 #endif
@@ -138,7 +138,7 @@ static void tick_sched_do_timer(struct tick_sched *ts,
ktime_t now)
 #endif
 
 	/* Check, if the jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	if (data_race(tick_do_timer_cpu == cpu))
 		tick_do_update_jiffies64(now);
 
 	if (ts->inidle)
@@ -737,8 +737,9 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts,
int cpu)
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	if (data_race(cpu != tick_do_timer_cpu) &&
+	    (data_race(tick_do_timer_cpu != TICK_DO_TIMER_NONE) ||
+	    !ts->do_timer_last))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -771,10 +772,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int
cpu)
 	 * do_timer() never invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
-	if (cpu == tick_do_timer_cpu) {
+	if (data_race(cpu == tick_do_timer_cpu)) {
 		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
 		ts->do_timer_last = 1;
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (data_race(tick_do_timer_cpu != TICK_DO_TIMER_NONE)) {
 		ts->do_timer_last = 0;
 	}
 
