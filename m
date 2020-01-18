Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DE1C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798524696
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579373272;
	bh=YuKlyQzhObK/h95SD9vxlOXVD82XEveJuyvT3wrPIzM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ByQNNSGWSsrZiebsx9vQO2D1/9qwL4wbuMsQ/PfO7zjLiyWrywFdUC3s4yX8jDMLQ
	 gPtNS68HNRK5UQcFVN5Wf5JzHWVgglGS9mEp83mmZq/eAxl2nYposdbnF5GHDIA5uZ
	 yW+Rgb83E/IDLhgkUezZkvcugYqpo+Ie/iRMM4d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgARSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:47:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:47:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so10502242wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d6T0gGNVBdPLj1T19HA4JqbwOAmh0wPx3kF4J0JU9nw=;
        b=Zj0QWMGXPbLtLKrmSI89WXtyjbhihhgEP+J2TceP14h3zt9GN9EtcG0JfRaeaCQkdq
         Z7gdCfNfTY71R4opZ6+/lJKzdUrsl5SngJSwUiLViRNL9fqwK8wpwwhWB6IRw0bqLYTw
         efQ1hyafcyWeF/p9Ldr7byPDyLuYrKa42FBt7rvNLhIc93OyI1EtmUcUG64FXkvy8Mr8
         q4v9gQHwhuIw0RrRvNMkqMzFZ53+IF++sw1YU+dPjGOSM5VCmq5PbwaXCuacDRDQSQKs
         8PExzUre+EZLGSRAqMv9nlEFlRwDvaMMd07UO6PQCFJREa8Mt6NWgQzg7RGRy4u95hJ9
         Y+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=d6T0gGNVBdPLj1T19HA4JqbwOAmh0wPx3kF4J0JU9nw=;
        b=mD6mGMYMwMDdlchQ3xYsfeqSRHG+COsMG9pjVWETtyFj5pE8fHaCO80VwP/M7KlEZW
         zRXCUySm5FJancpkmmiCuhniyrCB/SBHiPEwl/EtFUiGdpL5JAafhn6YcN6OiDZzhayq
         wELSVrFrhb4EFt10UIFNnLlzUrWav4o7LQ7YyTt3ShZoBG4i+nbQ2iFHRnXO2ZZ9TFwh
         vQ/DOD/65S91sbbWtlXxFpINe5Wotc87k/NOoqDuDQrPAhJ72HDapWOfyPxJgLRyvju8
         KI0Ag+At9KrO7bwgFfB0diD94IJbRDcBz+9gcPe0HXA8wQhxVlsyQO3sz1fAlAgJy6Co
         5oNg==
X-Gm-Message-State: APjAAAXlec/P0on4sAtUSvY283ZoU/WfV672yDW6WQB/IeCBkRrOKQTE
        mv5iOobjU9MecJPXBt7mMFGI1fl7
X-Google-Smtp-Source: APXvYqz/Y79ApPS5wqfIi+Hv2gWyaeZ0dLX9woPpIrNgvD2uhAZfT9JYsbGp3+19avDyeNqcT3Urtg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr10740056wmi.178.1579373268748;
        Sat, 18 Jan 2020 10:47:48 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f17sm1105495wmc.8.2020.01.18.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 10:47:48 -0800 (PST)
Date:   Sat, 18 Jan 2020 19:47:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timers fixes
Message-ID: <20200118184746.GA120588@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: de95a991bb72e009f47e0c4bbc90fc5f594588d5 tick/sched: Annotate lockless access to last_jiffies_update

Three fixes: fix link failure on Alpha, fix a Sparse warning and 
annotate/robustify a lockless access in the NOHZ code.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      time/posix-stubs: Provide compat itimer supoprt for alpha

Eric Dumazet (1):
      tick/sched: Annotate lockless access to last_jiffies_update

Vincenzo Frascino (1):
      lib/vdso: Make __cvdso_clock_getres() static


 kernel/time/posix-stubs.c |  3 +++
 kernel/time/tick-sched.c  | 14 +++++++++-----
 lib/vdso/gettimeofday.c   |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..20c65a7d4e3a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -151,6 +151,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYS_NI(timer_create);
+#endif
+
+#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b192e67aabc..a792d21cac64 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -58,8 +58,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	/*
 	 * Do a quick check without holding jiffies_lock:
+	 * The READ_ONCE() pairs with two updates done later in this function.
 	 */
-	delta = ktime_sub(now, last_jiffies_update);
+	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
 	if (delta < tick_period)
 		return;
 
@@ -70,8 +71,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 	if (delta >= tick_period) {
 
 		delta = ktime_sub(delta, tick_period);
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		/* Pairs with the lockless read in this function. */
+		WRITE_ONCE(last_jiffies_update,
+			   ktime_add(last_jiffies_update, tick_period));
 
 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -79,8 +81,10 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 			ticks = ktime_divns(delta, incr);
 
-			last_jiffies_update = ktime_add_ns(last_jiffies_update,
-							   incr * ticks);
+			/* Pairs with the lockless read in this function. */
+			WRITE_ONCE(last_jiffies_update,
+				   ktime_add_ns(last_jiffies_update,
+						incr * ticks));
 		}
 		do_timer(++ticks);
 
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9ecfd3b547ba..42bd8ab955fa 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -221,6 +221,7 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
 	int ret = __cvdso_clock_getres_common(clock, res);
