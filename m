Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA096C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B0A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xahOxVv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgCPL1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:27:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57980 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbgCPL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:27:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584358069; h=Content-Type: Cc: To: Subject: Message-ID:
 Date: From: In-Reply-To: References: MIME-Version: Sender;
 bh=8AhoRulK+Wx1g03sgzSt5h6cmvFffKNX5bBFnXkzqcY=; b=xahOxVv4mPohHuMR1TUdI2JVDl83VG/BJB3SFhQjpbwkFCTk9IrvymIa7AD9cEcnWwIVnwGs
 bxIMNsOspHIqdrt3z/DSfpu2+r4XD5qHK8a6d8DnsbtPoVfrgEGX235D1sTWL0PhbGEJvihy
 pPKVfD+EZp4HRcflhTBiEAvk6G0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f62a6.7f675edb7378-smtp-out-n02;
 Mon, 16 Mar 2020 11:27:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27F90C44788; Mon, 16 Mar 2020 11:27:33 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D99EC433D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D99EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Received: by mail-ed1-f47.google.com with SMTP id b23so21585301edx.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 04:27:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3A2Y0lYOQIYrUz7QibaQruPGbxe7/IxTljqFAbYv0/CFWYct5k
        fQMBYZEXGvPBBM62fN0GVZ2FQmo/DXhrUaPSOws=
X-Google-Smtp-Source: ADFU+vv/536hA54zgXvN5nJM9F1df6ZOW/WKdTpNHboHuz6b9eEBQ6fIc+xXAUAfG2JNaLr5pOMIvWbZzN2HAOjmA+s=
X-Received: by 2002:a50:951e:: with SMTP id u30mr25583228eda.144.1584358051134;
 Mon, 16 Mar 2020 04:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org> <1584326350-30275-3-git-send-email-psodagud@codeaurora.org>
In-Reply-To: <1584326350-30275-3-git-send-email-psodagud@codeaurora.org>
From:   Pavan Kondeti <pkondeti@codeaurora.org>
Date:   Mon, 16 Mar 2020 16:57:19 +0530
X-Gmail-Original-Message-ID: <CAEU1=PnmhRGmTHPikj5y0OVcp2NO81JgSBYyg4o=CPaNkuF-5Q@mail.gmail.com>
Message-ID: <CAEU1=PnmhRGmTHPikj5y0OVcp2NO81JgSBYyg4o=CPaNkuF-5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Add a check for cpu unbound deferrable timers
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, saravanak@google.com,
        tsoni@codeaurora.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On Mon, Mar 16, 2020 at 8:42 AM Prasad Sodagudi <psodagud@codeaurora.org> wrote:
>
> Add a check for cpu unbound deferrable timer expiry and raise
> softirq for handling the expired timers so that the CPU can
> process the cpu unbound deferrable times as early as possible
> when a cpu tries to enter/exit idle loop.
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  include/linux/timer.h    |  3 +++
>  kernel/time/tick-sched.c |  6 ++++++
>  kernel/time/timer.c      | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 1e6650e..25a1837 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -172,6 +172,9 @@ extern int del_timer(struct timer_list * timer);
>  extern int mod_timer(struct timer_list *timer, unsigned long expires);
>  extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
>  extern int timer_reduce(struct timer_list *timer, unsigned long expires);
> +#ifdef CONFIG_SMP
> +extern bool check_pending_deferrable_timers(int cpu);
> +#endif
>
>  /*
>   * The jiffies value which is added to now, when there is no timer
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index a792d21..fe0836a 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/irq_work.h>
>  #include <linux/posix-timers.h>
> +#include <linux/timer.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
>
> @@ -948,6 +949,11 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
>         ktime_t expires;
>         int cpu = smp_processor_id();
>
> +#ifdef CONFIG_SMP
> +       if (check_pending_deferrable_timers(cpu))
> +               raise_softirq_irqoff(TIMER_SOFTIRQ);
> +#endif
> +
>         /*
>          * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
>          * tick timer expiration time is known already.

Since this is called outside interrupt context, ksoftirqd task is always woken
up to serve the TIMER softirq. Given that, this CPU exited idle due to an
interrupt, we could probably check this condition and raise the softirq prior
to irq_exit. To make the discussion easier, providing the diff. This will make
sure that TIMER softirq is served after serving the IRQ and avoids waking
ksoftirqd. This should also cover the case, Thoms mentioned in the other
email.

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21..d9d1915 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1268,8 +1268,19 @@ static inline void tick_nohz_irq_enter(void)
        now = ktime_get();
        if (ts->idle_active)
                tick_nohz_stop_idle(ts, now);
-       if (ts->tick_stopped)
+       if (ts->tick_stopped) {
                tick_nohz_update_jiffies(now);
+               /*
+                * TODO: check the possibility of doing this only
+                * when jiffies is updated.
+                *
+                * __raise_softirq_irqoff() marks the softirq pending.
+                * The softirq is served after this IRQ is served from
+                * irq_exit()
+                */
+               if (check_pending_deferrable_timers())
+                       __raise_softirq_irqoff(TIMER_SOFTIRQ);
+       }
 }

 #else


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
