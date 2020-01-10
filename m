Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1410C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654912072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/6dxF5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgAJSyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:54:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36379 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgAJSyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:54:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id 19so2958951otz.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcMlx17bbe46RkMKi52DH8y3hZ3BUHEjTIS1UBwAyfk=;
        b=W/6dxF5yzDKMg1oEiW8ebWaLBsRbxzEdgsV2Zy4D7aiiuLbnsNCpxMjeRNNweJjqND
         2COiWm9jLpXFcdcgHqNInyC1u6Br+NVPEiVpSr0YUSGcZDC++HCWEKn70filZ7FDCz31
         qu9cxXaDVKOGON4heIdIXEJQDP785nqs0jiYl1UJkVqSpVlKEQ+pX/85ldwhDj5gsPlw
         QGZ51Hbm3Zn690xrrUCBSg8AMC47Wf1Q/esQ+n4G1y5SzrUItrLdyDF0yBAWyw3UMbng
         0gc9GvcqHfRWikE6FyRhlG8tmZyq2rX57IBPx4uujELRcWFq0QdNk8yh1euxx50b8Rvh
         yAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcMlx17bbe46RkMKi52DH8y3hZ3BUHEjTIS1UBwAyfk=;
        b=VncW3vKLQ60kWrscdZy/K7pQE8e/U7CxAPDWY9pwUKrEx+JE7DY5hmxTgCymhrb10A
         cyvmY3OmLO7fP4bHho9n3B1Ng6FCaP6/zt+R2f17SL+ot6K4BrNsKpoBWA0CrFn3TomA
         +4RZk4a3zXQRuJAqdUVzFT8mruyJn9W7h+wHpdzF7D/3P+Z61V5GyEhf+eVb75j55YQU
         0cbkUYrycTvpJmTeQNqv1lZkeam7GTqjT7fJYYabvoRHAmmzXcaaqE9kF8UaLhN2T7jL
         di97bp1HHzPKtJvCulk2BrEpdj8RpR37JOyYIxSMzpb3Q9CLMmhzTTTu3/cuH4a80+DF
         sZDw==
X-Gm-Message-State: APjAAAUDG+hHCK9DOjGc/kKj7RLcxOPLsLJTZaD2d0t4txcz/qlw1S6L
        7X6ZDcZVcpq2FsDXy9UbXxTaynoCo+9x8fVFjW+hMA==
X-Google-Smtp-Source: APXvYqzxnM25OTQL9khgX9z2PpEuWAEd0iwoxZnbgrx6i0URvTdLuIrl4QoYE3+xP7i2PfOPBVsDIMtSnPAANyB8A1k=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr3925122otq.17.1578682461403;
 Fri, 10 Jan 2020 10:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20200109152322.104466-1-elver@google.com> <20200109152322.104466-3-elver@google.com>
 <CANpmjNNt_+EQHLFZyV5_Wq1frU3A=Rh8y5P7Zjp-0cAU2X7N6w@mail.gmail.com>
In-Reply-To: <CANpmjNNt_+EQHLFZyV5_Wq1frU3A=Rh8y5P7Zjp-0cAU2X7N6w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Jan 2020 19:54:09 +0100
Message-ID: <CANpmjNOcjdr6HNaSP4Q7GTR72vx4bSMa_2O=_9oQwcz3xFk=Wg@mail.gmail.com>
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

On Fri, 10 Jan 2020 at 19:20, Marco Elver <elver@google.com> wrote:
>
> On Thu, 9 Jan 2020 at 16:23, Marco Elver <elver@google.com> wrote:
> >
> > Adds support for rate limiting reports. This uses a time based rate
> > limit, that limits any given data race report to no more than one in a
> > fixed time window (default is 3 sec). This should prevent the console
> > from being spammed with data race reports, that would render the system
> > unusable.
> >
> > The implementation assumes that unique data races and the rate at which
> > they occur is bounded, since we cannot store arbitrarily many past data
> > race report information: we use a fixed-size array to store the required
> > information. We cannot use kmalloc/krealloc and resize the list when
> > needed, as reporting is triggered by the instrumentation calls; to
> > permit using KCSAN on the allocators, we cannot (re-)allocate any memory
> > during report generation (data races in the allocators lead to
> > deadlock).
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/kcsan/report.c | 112 ++++++++++++++++++++++++++++++++++++++----
> >  lib/Kconfig.kcsan     |  10 ++++
> >  2 files changed, 112 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 9f503ca2ff7a..e324af7d14c9 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> >  #include <linux/kernel.h>
> > +#include <linux/ktime.h>
> >  #include <linux/preempt.h>
> >  #include <linux/printk.h>
> >  #include <linux/sched.h>
> > @@ -31,12 +32,101 @@ static struct {
> >         int                     num_stack_entries;
> >  } other_info = { .ptr = NULL };
> >
> > +/*
> > + * Information about reported data races; used to rate limit reporting.
> > + */
> > +struct report_time {
> > +       /*
> > +        * The last time the data race was reported.
> > +        */
> > +       ktime_t time;
> > +
> > +       /*
> > +        * The frames of the 2 threads; if only 1 thread is known, one frame
> > +        * will be 0.
> > +        */
> > +       unsigned long frame1;
> > +       unsigned long frame2;
> > +};
> > +
> > +/*
> > + * Since we also want to be able to debug allocators with KCSAN, to avoid
> > + * deadlock, report_times cannot be dynamically resized with krealloc in
> > + * rate_limit_report.
> > + *
> > + * Therefore, we use a fixed-size array, which at most will occupy a page. This
> > + * still adequately rate limits reports, assuming that a) number of unique data
> > + * races is not excessive, and b) occurrence of unique data races within the
> > + * same time window is limited.
> > + */
> > +#define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
> > +#define REPORT_TIMES_SIZE                                                      \
> > +       (CONFIG_KCSAN_REPORT_ONCE_IN_MS > REPORT_TIMES_MAX ?                   \
> > +                REPORT_TIMES_MAX :                                            \
> > +                CONFIG_KCSAN_REPORT_ONCE_IN_MS)
> > +static struct report_time report_times[REPORT_TIMES_SIZE];
> > +
> >  /*
> >   * This spinlock protects reporting and other_info, since other_info is usually
> >   * required when reporting.
> >   */
> >  static DEFINE_SPINLOCK(report_lock);
> >
> > +/*
> > + * Checks if the data race identified by thread frames frame1 and frame2 has
> > + * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
> > + */
> > +static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
> > +{
> > +       struct report_time *use_entry = &report_times[0];
> > +       ktime_t now;
> > +       ktime_t invalid_before;
> > +       int i;
> > +
> > +       BUILD_BUG_ON(CONFIG_KCSAN_REPORT_ONCE_IN_MS != 0 && REPORT_TIMES_SIZE == 0);
> > +
> > +       if (CONFIG_KCSAN_REPORT_ONCE_IN_MS == 0)
> > +               return false;
> > +
> > +       now = ktime_get();
> > +       invalid_before = ktime_sub_ms(now, CONFIG_KCSAN_REPORT_ONCE_IN_MS);
>
> Been thinking about this a bit more, and wondering if we should just
> use jiffies here?  Don't think we need the precision.

Sent v2: http://lkml.kernel.org/r/20200110184834.192636-1-elver@google.com
I think it's also safer to use jiffies, as noted in the v2 patch.

Paul: sorry for sending v2, seeing you already had these in your tree.
Hope this is ok.

Thanks,
-- Marco
