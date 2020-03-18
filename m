Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD52C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA37220724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3+JC7u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCRCJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:09:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40774 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgCRCJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:09:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id t20so8869120uao.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwkKxZxz8ZvxgUWRtQYqaELKYeJh+ujm7OIHIKvAQ24=;
        b=m3+JC7u+yGHBnU2SLiHuAd5FssLpnXd7UNNlz4eMMZl1UkqnuIQuL5O40R1w9mJ54S
         v4zUhBVMr4czXz1CHURsJPXct+NL8ccSkth/07C/5IAYiN5hhE9r4jOSPZf1RkJGPq9j
         zg7F9h63MbrZcedrw5JQVJW0jrjGvTA+wiVczCLT1aHmXOafA4JH/Q6NRkzXtzjIv2qX
         1uujsd+ajQEJz7UaN07mdRSr/PVHk5kWa6z64rSQpA8XiPAOrittTeEIyhD0OLVJR+rB
         bpv34H7kFvIgwAnvsKO2gv+MXvL8NFshzDBsgVUYfEKTYhUciyceBVyBwNt/XWDQUo1T
         Qj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwkKxZxz8ZvxgUWRtQYqaELKYeJh+ujm7OIHIKvAQ24=;
        b=CCW4FMHcyKBuXZ0uOOkjseBtxZ+rpC8QlW40tDUPbIbPiB+iqFjN/Mhxw2Zuywwu1W
         9XlbFRNpJJZdhpV4s+TrVpYB5Qz1tms+wIzeVaNVVI4B/NRwBJ5ve7YrT2S0ZPvJZSF7
         ZS37a5WzNq+ginsrEoO03EpSC69MvLT20piR+lrVWEArM2f27z8wa6g3zwZ+p1OAHBrW
         szTvmoTNY7IMSm+xZZM+Uae9T7+duL+s3vg+1BBmTjpnOhgjghh/KhfC/w4qMnRqmvZD
         EemFOw7Y9SueETcbnMwE/JOAO9FrDhcJD4BWo+ZEzknvd0Fyxz00hnwfVU27YLV9J/OY
         Ye4A==
X-Gm-Message-State: ANhLgQ3H0Evvl/JKoabd9oxiKRbeAexSLpQzmjWrF0k6vu0X4h0yF47V
        Zgk+y0jMDyRR5YF7X2gFi4XbaaeYA4v8dJNva/K52Q==
X-Google-Smtp-Source: ADFU+vsnF1aRH8O6N9SVMvEpD5gSdpQyYCirL6AEmo6hXMvN0XUXHZ9W4av/eAlnpKV/YTlSr0lSypmcELPfTGseOjo=
X-Received: by 2002:ab0:911:: with SMTP id w17mr1424994uag.60.1584497388970;
 Tue, 17 Mar 2020 19:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200313231024.17601-1-kim.phillips@amd.com>
In-Reply-To: <20200313231024.17601-1-kim.phillips@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 17 Mar 2020 19:09:37 -0700
Message-ID: <CABPqkBS8TUMTEz_motpd+8xK599tLXAonUHwp-CWMyU2RhcbQg@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] perf/amd/uncore: Prepare L3 thread mask code for
 Family 19h support
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> In order to better accommodate the upcoming Family 19h support,
> given the 80-char line limit, move the existing code into a new
> l3_thread_slice_mask function.
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> ---
> v2: split into two parts, this one being the mechanical
>     move based on Boris' review comments:
>
>         https://lkml.org/lkml/2020/3/12/581
>
>  arch/x86/events/amd/uncore.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index a6ea07f2aa84..dcdac001431e 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -180,6 +180,20 @@ static void amd_uncore_del(struct perf_event *event, int flags)
>         hwc->idx = -1;
>  }
>
> +/*
> + * Convert logical cpu number to L3 PMC Config ThreadMask format
> + */
> +static u64 l3_thread_slice_mask(int cpu)
> +{
> +       int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
> +
> +       if (smp_num_siblings > 1)
> +               thread += cpu_data(cpu).apicid & 1;
> +
> +       return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
> +               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
> +}
> +
>  static int amd_uncore_event_init(struct perf_event *event)
>  {
>         struct amd_uncore *uncore;
> @@ -209,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
>          * SliceMask and ThreadMask need to be set for certain L3 events in
>          * Family 17h. For other events, the two fields do not affect the count.
>          */
> -       if (l3_mask && is_llc_event(event)) {
> -               int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
> -
> -               if (smp_num_siblings > 1)
> -                       thread += cpu_data(event->cpu).apicid & 1;
> -
> -               hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
> -                               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
> -       }
> +       if (l3_mask && is_llc_event(event))
> +               hwc->config |= l3_thread_slice_mask(event->cpu);
>
By looking at this code, I realized that even on Zen2 this is wrong.
It does not work well.
You are basically saying that the L3 event is tied to the CPU the
event is programmed to.
But this does not work with the cpumask programmed for the amd_l3 PMU. This mask
shows, as it should, one CPU/CCX. So that means that when I do:

$ perf stat -a amd_l3/event=llc_event/

This only collects on the CPUs listed in the cpumask: 0,4,8,12 ....
That means that L3 events generated by the other CPUs on the CCX are
not monitored.
I can easily see the problem by pinning a memory bound program to
CPU64, for instance.

I think the thread mask should be exposed to the user. If not
specified, then set the mask to
cover all CPUs of the CCX. That way you can pick and choose what you
want. And with one event/CCX
you can monitor  for all CPUs. I can send a patch that does that.

With what you have now, you have to force the list of CPUs with -C to
work around
the cpumask. And forcing the cpumask to 0-255 does not make sense because not
all L3 events necessarily need the L3 mask, so you don't want to program them on
all CPUs especially with 8 cpus/CCX and only 6 counters.


On Fri, Mar 13, 2020 at 4:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> In order to better accommodate the upcoming Family 19h support,
> given the 80-char line limit, move the existing code into a new
> l3_thread_slice_mask function.
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> ---
> v2: split into two parts, this one being the mechanical
>     move based on Boris' review comments:
>
>         https://lkml.org/lkml/2020/3/12/581
>
>  arch/x86/events/amd/uncore.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index a6ea07f2aa84..dcdac001431e 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -180,6 +180,20 @@ static void amd_uncore_del(struct perf_event *event, int flags)
>         hwc->idx = -1;
>  }
>
> +/*
> + * Convert logical cpu number to L3 PMC Config ThreadMask format
> + */
> +static u64 l3_thread_slice_mask(int cpu)
> +{
> +       int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
> +
> +       if (smp_num_siblings > 1)
> +               thread += cpu_data(cpu).apicid & 1;
> +
> +       return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
> +               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
> +}
> +
>  static int amd_uncore_event_init(struct perf_event *event)
>  {
>         struct amd_uncore *uncore;
> @@ -209,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
>          * SliceMask and ThreadMask need to be set for certain L3 events in
>          * Family 17h. For other events, the two fields do not affect the count.
>          */
> -       if (l3_mask && is_llc_event(event)) {
> -               int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
> -
> -               if (smp_num_siblings > 1)
> -                       thread += cpu_data(event->cpu).apicid & 1;
> -
> -               hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
> -                               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
> -       }
> +       if (l3_mask && is_llc_event(event))
> +               hwc->config |= l3_thread_slice_mask(event->cpu);
>
>         uncore = event_to_amd_uncore(event);
>         if (!uncore)
> --
> 2.25.1
>
