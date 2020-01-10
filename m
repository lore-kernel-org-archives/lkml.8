Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91512064C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+bQEbU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgAJSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:20:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39410 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:20:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so2664133oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=he8cV4Je1YO1zSBdo6zOJypAxMQ+pWm4+ZlJU93BV+E=;
        b=W+bQEbU2IjV0ylxNl/v9a72bXSWiEkvIFWwkNO8UfWooQdpYzxEg6YnVlggczXkiak
         DcsmP8SU/kwoKvxBYKkj36UljUE3etMzp3pJLh3HOhZjeMjqKcXy6TfiZkIv0lUBpcx9
         qfV01rRyidajQO6ZdXtMtceVN3A1ziyig+gFoG0GrzetvlMF8DI+t4GyH6ZCtpVEk5pe
         0dLQA0U/Mo99kS+YLFFzUamxHPrrcyZIOpInNkg5fwQekS1fYlABPHR1NL5aTJ5G+Eh1
         GwNXALYGUC/se4+LgM/nCb11uputn5BA45Oo/CawCpn6j/r19eyR1hjBES8T2ar1iSQZ
         ZgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=he8cV4Je1YO1zSBdo6zOJypAxMQ+pWm4+ZlJU93BV+E=;
        b=VQQSE1Qgm/z2CTO83w4W/ugep666cPrd/IfVHcxSpeYKfg8RTKm9eYECxO92JtqsRE
         2tcR0isa5aY/RXyCBqJTv0OLSv/AozwjCo8ZgEZv5k33zm1VlKvFhV3TBg6gcW1bLYnD
         uqsurSIoHPtq71fFSw928jiMIqbPcW4/YZjHts1spz1RTdq1B1e2znvkzJ2q84CatkXN
         2bfQYHlxCT7PSl1hDixn2/oLBE6v+lOkTTce8yaGFuYlfkUH2nuZJZd9i/VI/lT9+oyV
         Q9eWnZ9YB1PxpHCd8GI14NRGGzKBtzl/e5qtOJfkI2RyHowCvvwio7ilz3/ILL9Rr/rh
         vOhw==
X-Gm-Message-State: APjAAAUSc0qvAzRLt7SRp+TXExwJUejoApOeOkquywijZIl5edd7bMk2
        VB49Bk6MeYr+V+dBB6hHuOy9vaQQTUe2z9Cg7LVeTF40E9I=
X-Google-Smtp-Source: APXvYqz7Sio3wxbQriuJQsYy5gvCA7+E5ukwnmAYAoPkEeQKZPpKrVWsp+uUnSZquFpxz4mGvTerznsLfS1lc5Qbp8E=
X-Received: by 2002:aca:36c1:: with SMTP id d184mr3344121oia.70.1578680445877;
 Fri, 10 Jan 2020 10:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20200109152322.104466-1-elver@google.com> <20200109152322.104466-3-elver@google.com>
In-Reply-To: <20200109152322.104466-3-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Jan 2020 19:20:34 +0100
Message-ID: <CANpmjNNt_+EQHLFZyV5_Wq1frU3A=Rh8y5P7Zjp-0cAU2X7N6w@mail.gmail.com>
Subject: Re: [PATCH -rcu 2/2] kcsan: Rate-limit reporting per data races
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 at 16:23, Marco Elver <elver@google.com> wrote:
>
> Adds support for rate limiting reports. This uses a time based rate
> limit, that limits any given data race report to no more than one in a
> fixed time window (default is 3 sec). This should prevent the console
> from being spammed with data race reports, that would render the system
> unusable.
>
> The implementation assumes that unique data races and the rate at which
> they occur is bounded, since we cannot store arbitrarily many past data
> race report information: we use a fixed-size array to store the required
> information. We cannot use kmalloc/krealloc and resize the list when
> needed, as reporting is triggered by the instrumentation calls; to
> permit using KCSAN on the allocators, we cannot (re-)allocate any memory
> during report generation (data races in the allocators lead to
> deadlock).
>
> Reported-by: Qian Cai <cai@lca.pw>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/kcsan/report.c | 112 ++++++++++++++++++++++++++++++++++++++----
>  lib/Kconfig.kcsan     |  10 ++++
>  2 files changed, 112 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 9f503ca2ff7a..e324af7d14c9 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/kernel.h>
> +#include <linux/ktime.h>
>  #include <linux/preempt.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h>
> @@ -31,12 +32,101 @@ static struct {
>         int                     num_stack_entries;
>  } other_info = { .ptr = NULL };
>
> +/*
> + * Information about reported data races; used to rate limit reporting.
> + */
> +struct report_time {
> +       /*
> +        * The last time the data race was reported.
> +        */
> +       ktime_t time;
> +
> +       /*
> +        * The frames of the 2 threads; if only 1 thread is known, one frame
> +        * will be 0.
> +        */
> +       unsigned long frame1;
> +       unsigned long frame2;
> +};
> +
> +/*
> + * Since we also want to be able to debug allocators with KCSAN, to avoid
> + * deadlock, report_times cannot be dynamically resized with krealloc in
> + * rate_limit_report.
> + *
> + * Therefore, we use a fixed-size array, which at most will occupy a page. This
> + * still adequately rate limits reports, assuming that a) number of unique data
> + * races is not excessive, and b) occurrence of unique data races within the
> + * same time window is limited.
> + */
> +#define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
> +#define REPORT_TIMES_SIZE                                                      \
> +       (CONFIG_KCSAN_REPORT_ONCE_IN_MS > REPORT_TIMES_MAX ?                   \
> +                REPORT_TIMES_MAX :                                            \
> +                CONFIG_KCSAN_REPORT_ONCE_IN_MS)
> +static struct report_time report_times[REPORT_TIMES_SIZE];
> +
>  /*
>   * This spinlock protects reporting and other_info, since other_info is usually
>   * required when reporting.
>   */
>  static DEFINE_SPINLOCK(report_lock);
>
> +/*
> + * Checks if the data race identified by thread frames frame1 and frame2 has
> + * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
> + */
> +static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
> +{
> +       struct report_time *use_entry = &report_times[0];
> +       ktime_t now;
> +       ktime_t invalid_before;
> +       int i;
> +
> +       BUILD_BUG_ON(CONFIG_KCSAN_REPORT_ONCE_IN_MS != 0 && REPORT_TIMES_SIZE == 0);
> +
> +       if (CONFIG_KCSAN_REPORT_ONCE_IN_MS == 0)
> +               return false;
> +
> +       now = ktime_get();
> +       invalid_before = ktime_sub_ms(now, CONFIG_KCSAN_REPORT_ONCE_IN_MS);

Been thinking about this a bit more, and wondering if we should just
use jiffies here?  Don't think we need the precision.

Thanks,
-- Marco

> +       /* Check if a matching data race report exists. */
> +       for (i = 0; i < REPORT_TIMES_SIZE; ++i) {
> +               struct report_time *rt = &report_times[i];
> +
> +               /*
> +                * Must always select an entry for use to store info as we
> +                * cannot resize report_times; at the end of the scan, use_entry
> +                * will be the oldest entry, which ideally also happened before
> +                * KCSAN_REPORT_ONCE_IN_MS ago.
> +                */
> +               if (ktime_before(rt->time, use_entry->time))
> +                       use_entry = rt;
> +
> +               /*
> +                * Initially, no need to check any further as this entry as well
> +                * as following entries have never been used.
> +                */
> +               if (rt->time == 0)
> +                       break;
> +
> +               /* Check if entry expired. */
> +               if (ktime_before(rt->time, invalid_before))
> +                       continue; /* before KCSAN_REPORT_ONCE_IN_MS ago */
> +
> +               /* Reported recently, check if data race matches. */
> +               if ((rt->frame1 == frame1 && rt->frame2 == frame2) ||
> +                   (rt->frame1 == frame2 && rt->frame2 == frame1))
> +                       return true;
> +       }
> +
> +       use_entry->time = now;
> +       use_entry->frame1 = frame1;
> +       use_entry->frame2 = frame2;
> +       return false;
> +}
> +
>  /*
>   * Special rules to skip reporting.
>   */
> @@ -132,7 +222,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>         unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
>         int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
>         int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
> -       int other_skipnr;
> +       unsigned long this_frame = stack_entries[skipnr];
> +       unsigned long other_frame = 0;
> +       int other_skipnr = 0; /* silence uninit warnings */
>
>         /*
>          * Must check report filter rules before starting to print.
> @@ -143,34 +235,34 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
>         if (type == KCSAN_REPORT_RACE_SIGNAL) {
>                 other_skipnr = get_stack_skipnr(other_info.stack_entries,
>                                                 other_info.num_stack_entries);
> +               other_frame = other_info.stack_entries[other_skipnr];
>
>                 /* @value_change is only known for the other thread */
> -               if (skip_report(other_info.access_type, value_change,
> -                               other_info.stack_entries[other_skipnr]))
> +               if (skip_report(other_info.access_type, value_change, other_frame))
>                         return false;
>         }
>
> +       if (rate_limit_report(this_frame, other_frame))
> +               return false;
> +
>         /* Print report header. */
>         pr_err("==================================================================\n");
>         switch (type) {
>         case KCSAN_REPORT_RACE_SIGNAL: {
> -               void *this_fn = (void *)stack_entries[skipnr];
> -               void *other_fn = (void *)other_info.stack_entries[other_skipnr];
>                 int cmp;
>
>                 /*
>                  * Order functions lexographically for consistent bug titles.
>                  * Do not print offset of functions to keep title short.
>                  */
> -               cmp = sym_strcmp(other_fn, this_fn);
> +               cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
>                 pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
> -                      cmp < 0 ? other_fn : this_fn,
> -                      cmp < 0 ? this_fn : other_fn);
> +                      (void *)(cmp < 0 ? other_frame : this_frame),
> +                      (void *)(cmp < 0 ? this_frame : other_frame));
>         } break;
>
>         case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
> -               pr_err("BUG: KCSAN: data-race in %pS\n",
> -                      (void *)stack_entries[skipnr]);
> +               pr_err("BUG: KCSAN: data-race in %pS\n", (void *)this_frame);
>                 break;
>
>         default:
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 3f78b1434375..3552990abcfe 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -81,6 +81,16 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
>           KCSAN_WATCH_SKIP. If false, the chosen value is always
>           KCSAN_WATCH_SKIP.
>
> +config KCSAN_REPORT_ONCE_IN_MS
> +       int "Duration in milliseconds, in which any given data race is only reported once"
> +       default 3000
> +       help
> +         Any given data race is only reported once in the defined time window.
> +         Different data races may still generate reports within a duration
> +         that is smaller than the duration defined here. This allows rate
> +         limiting reporting to avoid flooding the console with reports.
> +         Setting this to 0 disables rate limiting.
> +
>  # Note that, while some of the below options could be turned into boot
>  # parameters, to optimize for the common use-case, we avoid this because: (a)
>  # it would impact performance (and we want to avoid static branch for all
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
