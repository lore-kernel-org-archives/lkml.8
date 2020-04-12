Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A28C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ADA20753
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBGWhKNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDLCB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 22:01:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36139 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 22:01:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id w29so4230569qtv.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 19:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MscHRnn9pDGX2Dx/EamQ+uV3xqjt7EdoA7heB1j0xo=;
        b=hBGWhKNff6eFZV2e6/NDQbgUPxt9ea/Wcr8hwP5OAzXtEMUgJBko4pLj58B+f9yYjI
         W1Hdw/KDUJpnxLGIb7O2PG2Fm8ArtPGoU/q9YaWudU8RoQMGqQqBKZvtKjTxKYPYxORu
         A5IE9sUZtUfKBh+GancjlVTsbCSn9bGQsihByvLix5qTGHtLD9VstcpkdRLizRo0e7wk
         mtZ4g9Mzyu4ulxAU9frOD1tyqKCeAs6qJTQy01FmK6TMnVik7qZkcnLk0N+jV0QgYnsz
         5yiMy1B0VU2kRFKDx03Q7sAwUL1pKPDGLz4/wsQSkCsWQk3E/gjBwERw1M2YQD3AT8An
         d1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MscHRnn9pDGX2Dx/EamQ+uV3xqjt7EdoA7heB1j0xo=;
        b=lTL9J1z+YyhkV1u8uGegzhsCC8PdFVDYUDiVCDStUJ+cMYXA1+A3vQhkYp7bzspmib
         UH8bFxmkWEvLpRusOU8ZPWcy67ojvX5CV9tg17/K0t6YPrTUTEBynALPHUj1S0auKFTN
         /LFOa47/hkyh8oPSjesKZLQ5pnyw8BmBJKz6kW1WV87sYFpHHvQywlwz3BxfWz+g7QCY
         BlEbk4lStX6aQ+8nh+22npbLwRWuq7yO/puHKaoP4NbskpwgD4qkXlwOcqsOypwb8inw
         TwhlOKjXWXiFZT3KJy8tRQ0akeAlVEh6TqFcaCphKaNWvExiYSc9KJuK71rVtLMcTsJZ
         qX7w==
X-Gm-Message-State: AGi0PubRERn3bBrJIx7OlnVE99QhM3mPct9vcdCmQSGE/0LpDE1cpQ3N
        bA1C7o1OT2uYhdXHAZrQd/j8PnZcndtUKNyk0cmxMQ==
X-Google-Smtp-Source: APiQypK3WKF81DxAzzdzWBJK1VSD9CRSHF60sOZoU4Nj2ltVMYbOjelUF3G899sW+vKxS0PUF4G05q43BMqutdYqEuk=
X-Received: by 2002:ac8:6942:: with SMTP id n2mr5707612qtr.238.1586656916987;
 Sat, 11 Apr 2020 19:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200410225208.109717-1-joshdon@google.com> <20200410225208.109717-3-joshdon@google.com>
In-Reply-To: <20200410225208.109717-3-joshdon@google.com>
From:   Josh Don <joshdon@google.com>
Date:   Sat, 11 Apr 2020 19:01:45 -0700
Message-ID: <CABk29NtBxtJeAowLTGC4xQRD5MNtoiKLTLV7O3zLWp1CtW4nvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: remove distribute_running from CFS bandwidth
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, pauld@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 3:52 PM Josh Don <joshdon@google.com> wrote:
>
> This is mostly a revert of baa9be4ff.
>
> The primary use of distribute_running was to determine whether to add
> throttled entities to the head or the tail of the throttled list. Now
> that we always add to the tail, we can remove this field.
>
> The other use of distribute_running is in the slack_timer, so that we
> don't start a distribution while one is already running. However, even
> in the event that this race occurs, it is fine to have two distributions
> running (especially now that distribute grabs the cfs_b->lock to
> determine remaining quota before assigning).
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c  | 13 +------------
>  kernel/sched/sched.h |  1 -
>  2 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3fb986c52825..24b5e12efb40 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4930,14 +4930,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
>         /*
>          * This check is repeated as we release cfs_b->lock while we unthrottle.
>          */
> -       while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> -               cfs_b->distribute_running = 1;
> +       while (throttled && cfs_b->runtime > 0) {
>                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>                 /* we can't nest cfs_b->lock while distributing bandwidth */
>                 distribute_cfs_runtime(cfs_b);
>                 raw_spin_lock_irqsave(&cfs_b->lock, flags);
>
> -               cfs_b->distribute_running = 0;
>                 throttled = !list_empty(&cfs_b->throttled_cfs_rq);
>         }
>
> @@ -5051,10 +5049,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>         /* confirm we're still not at a refresh boundary */
>         raw_spin_lock_irqsave(&cfs_b->lock, flags);
>         cfs_b->slack_started = false;
> -       if (cfs_b->distribute_running) {
> -               raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> -               return;
> -       }
>
>         if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
>                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> @@ -5064,9 +5058,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>         if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
>                 runtime = cfs_b->runtime;
>
> -       if (runtime)
> -               cfs_b->distribute_running = 1;
> -
>         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>
>         if (!runtime)
> @@ -5075,7 +5066,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>         distribute_cfs_runtime(cfs_b);
>
>         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -       cfs_b->distribute_running = 0;
>         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>
> @@ -5217,7 +5207,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>         cfs_b->period_timer.function = sched_cfs_period_timer;
>         hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         cfs_b->slack_timer.function = sched_cfs_slack_timer;
> -       cfs_b->distribute_running = 0;
>         cfs_b->slack_started = false;
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..7198683b2869 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -349,7 +349,6 @@ struct cfs_bandwidth {
>
>         u8                      idle;
>         u8                      period_active;
> -       u8                      distribute_running;
>         u8                      slack_started;
>         struct hrtimer          period_timer;
>         struct hrtimer          slack_timer;
> --
> 2.26.0.110.g2183baf09c-goog
>

+pauld@redhat.com
