Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FA4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGeTnGvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896590AbgDPP7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896089AbgDPP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:59:00 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:59:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t199so13578171oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKkzesvk5cYfKkW+cuVfyJJ4B3TfqgCX4qySMMGKGlg=;
        b=MGeTnGvI/2k6bxRBviIyd1LSkMZNOawQBC63cTOw3eNT0E2cqiGkqP5WM1LyY9cMCd
         O8yJOXkdTY9vlwgcQZEdCBZkjsiMs3JQEKv/w07/loPznlTIv0qQfB+83EaslJL1jHkk
         QH0H/Oka1VIrsQPXERMd/sv/kAn1gX1q4CJAHf8eRMVOIBks6PtE+Pks7rIMGXpx+kdr
         gm+GETzmhGS5ichB041ZwaGZFAxNB4gCONZf2UN1wWrfDm+u6Jo6rrQ3HgGJaQNta4yz
         Oyg+mE8xJ43OI3nc5YKILs3NLr2uH1ld2+XpCXKn0sHlE3V5pdNa7vaex7HxtTiNbdU5
         YI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKkzesvk5cYfKkW+cuVfyJJ4B3TfqgCX4qySMMGKGlg=;
        b=KjcAGPdSFXh9/fKvaNf/GSsgsVjpp9tOTEJDXTRhFn6R1WcEYEqBW+ulTDbVAYbTve
         +9AYP1o4/MChVukN36+iNErV6EcTC/Uc71r3S9qvVgj3oVgAzaeu+9lOvfbk3bLlUzD5
         6wGT8TmBEZTNVM+YTLvIB7qC615fHh7VqoKIV7Ar700VC6JyUtrdvMj6Ytgh1IxTAbaG
         52Lq/fdMxwcoe2wkuGaTpwTb63OzbViwAMaVUg7a3FpzMzXhV/pGzO3H0vv6rHOslwhA
         LjUW8NGB11Z6Fe4nS5DbPjSXKtaf5UKRx/IFqh+YIP9kZJY7XLBWukZ60QitCIggz1M8
         KTug==
X-Gm-Message-State: AGi0PuaV1QQ8u/s11wneXWJLHhhjCSJ7qFjWu2t1Ud7jAU6DDRPBgyQS
        7Mv7HpahKh1xKLIBSIUWEAhn3YD2AXUI+6mGaNmaLQ==
X-Google-Smtp-Source: APiQypL37Ygn1cZS2h8rp5duKkw4wQjuaqjVXMf73uWNup7h9A6Akm1TUOoiCtGtBN76Q4Q8+Bnc9jARMpQqUlQlZIA=
X-Received: by 2002:aca:56c2:: with SMTP id k185mr3169314oib.141.1587052739351;
 Thu, 16 Apr 2020 08:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200415210512.805-10-valentin.schneider@arm.com> <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
 <jhj4ktjpw2z.mognet@arm.com> <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com>
 <CAKfTPtD5x_NQ1KfHhTiAR3eNA85+k13nfSR-9_PKLp6FgVu08A@mail.gmail.com> <jhjv9lz78nv.mognet@arm.com>
In-Reply-To: <jhjv9lz78nv.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 17:58:47 +0200
Message-ID: <CAKfTPtDFD7KMcSK-2_LP-_APN2m05pWVhzKvJOVnD+Nacn846w@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers
 for wakeup sd_flag scan
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 17:27, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 16/04/20 14:36, Vincent Guittot wrote:
> >> Coming back to the v2 discussion on this patch
> >>
> >> https://lore.kernel.org/r/20200311181601.18314-10-valentin.schneider@arm.com
> >>
> >> SD_BALANCE_WAKE is not used in mainline anymore, so wakeups are always
> >> fast today.
> >>
> >> I.e. you wouldn't need a per_cpu(sd_balance_wake, cpu) since it's always
> >> NULL.
> >>
> >> I.e. want_affine logic and the 'for_each_domain(cpu, tmp)' isn't needed
> >> anymore.
> >>
> >> This will dramatically simplify the code in select_task_rq_fair().
> >>
> >> But I guess Vincent wants to keep the functionality so we're able to
> >> enable SD_BALANCE_WAKE on certain sd's?
> >
> > I looked too quickly what was done by this patch. I thought that it
> > was adding a per_cpu pointer for all cases including the fast path
> > with wake affine but it only skips the for_each_domain loop for the
> > slow paths which don't need it because they are already slow.
> >
> > It would be better to keep the for_each_domain loop for slow paths and
> > to use a per_cpu pointer for fast_path/wake affine. Regarding the
> > wake_affine path, we don't really care about looping all domains and
> > we could directly use the highest domain because wake_affine() that is
> > used in the loop, only uses the imbalance_pct of the sched domain for
> > wake_affine_weight() and it should not harm to use only the highest
> > domain and then select_idle_sibling doesn't use it but the llc or
> > asym_capacity pointer instead.
>
> So Dietmar's pointing out that sd will always be NULL for want_affine,
> because want_affine can only be true at wakeups and we don't have any
> topologies with SD_BALANCE_WAKE anymore. We would still want to call
> wake_affine() though, because that can change new_cpu.
>
> What you are adding on top is that the only sd field used in wake_affine()
> is the imbalance_pct, so we could take a shortcut and just go for the
> highest domain with SD_WAKE_AFFINE; i.e. something like this:
>
> ---
> if (want_affine) {
>         // We can cache that at topology buildup
>         sd = highest_flag_domain(cpu, SD_WAKE_AFFINE);

Yes and this one should be cached at topology buildup

>
>         if (cpumask_test_cpu(prev_cpu, sched_domain_span(sd) &&
>             cpu != prev_cpu)
>                 new_cpu = wake_affine();
>
>         // Directly go to select_idle_sibling()
>         goto sis;
> }
>
> // !want_affine logic here
> ---
>
> As for the !want_affine part, we could either keep the current domain walk
> (IIUC this is what you are suggesting) or go for the extra cached pointers
> I'm introducing.
>
> Now if we are a bit bolder than that, because there are no more
> (mainline) topologies w/ SD_BALANCE_WAKE, we could even turn the above
> into:
>
> ---
> if (wake_flags & WF_TTWU) {
>         if (want_affine) {
>                 // We can cache that at topology buildup
>                 sd = highest_flag_domain(cpu, SD_WAKE_AFFINE);
>
>                 if (cpumask_test_cpu(prev_cpu, sched_domain_span(sd) &&
>                     cpu != prev_cpu)
>                         new_cpu = wake_affine();
>
>         }
>         // Directly go to select_idle_sibling()
>         goto sis;
> }
>
> // !want_affine logic here
> ---
>
> This in turns mean we could get rid of SD_BALANCE_WAKE entirely... I'm a
> bit more reluctant to that only because the last SD_BALANCE_WAKE setter was

For now, we should probably skip the additional test above: "if
(wake_flags & WF_TTWU) {" and keep SD_BALANCE_WAKE so we will continue
to loop in case of !want_affine.

We can imagine that we might want at the end to be a bit more smart
for SD_BALANCE_WAKE and the slow path... like with the latency nice
proposal and latency-nice=19 as a example

> removed fairly recently, see
>   a526d466798d ("sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems")
