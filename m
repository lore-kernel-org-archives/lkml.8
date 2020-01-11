Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE50C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB2C2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578719615;
	bh=VfNQMl8cgP6Aq4h1FNNSFRYjQ2+soJJipV7tLxByGwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=p1q3aexu2a4emvnN9VOYc36sZPj7kYUIcvUtgCsMFDbZazeVLeJBJXk5Af034FF26
	 QhCHnUVLGishxVfna92e3NOWguppAvpm1ebe2fqDkYwXRMyjttY6JJxwozKHcgHkMu
	 t97R+uWcxB2ND62LDlvaV+1ywvnG3EfUuJbGJh/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgAKFNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 00:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgAKFNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 00:13:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69B52077C;
        Sat, 11 Jan 2020 05:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578719610;
        bh=VfNQMl8cgP6Aq4h1FNNSFRYjQ2+soJJipV7tLxByGwk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rYcvO1RXQ88dYk/lm2ZyJgv+OQp2DNTfq1bqIU/0uiL/XdMz1SHu9xLnZUy/AdAlZ
         jd7alyP5QZWxrVKaTQV3iBVcYwA8DXCO9DP0bdQ/Rhnj3O32yW4ZNndpCvvAqyvNTs
         OWPI/LWVvEDYchzjzpPk8rYasui2vP2HbsVhMZwc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 859AD3522887; Fri, 10 Jan 2020 21:13:30 -0800 (PST)
Date:   Fri, 10 Jan 2020 21:13:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -rcu 2/2] kcsan: Rate-limit reporting per data races
Message-ID: <20200111051330.GG13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200109152322.104466-1-elver@google.com>
 <20200109152322.104466-3-elver@google.com>
 <CANpmjNNt_+EQHLFZyV5_Wq1frU3A=Rh8y5P7Zjp-0cAU2X7N6w@mail.gmail.com>
 <CANpmjNOcjdr6HNaSP4Q7GTR72vx4bSMa_2O=_9oQwcz3xFk=Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOcjdr6HNaSP4Q7GTR72vx4bSMa_2O=_9oQwcz3xFk=Wg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:54:09PM +0100, Marco Elver wrote:
> On Fri, 10 Jan 2020 at 19:20, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 9 Jan 2020 at 16:23, Marco Elver <elver@google.com> wrote:
> > >
> > > Adds support for rate limiting reports. This uses a time based rate
> > > limit, that limits any given data race report to no more than one in a
> > > fixed time window (default is 3 sec). This should prevent the console
> > > from being spammed with data race reports, that would render the system
> > > unusable.
> > >
> > > The implementation assumes that unique data races and the rate at which
> > > they occur is bounded, since we cannot store arbitrarily many past data
> > > race report information: we use a fixed-size array to store the required
> > > information. We cannot use kmalloc/krealloc and resize the list when
> > > needed, as reporting is triggered by the instrumentation calls; to
> > > permit using KCSAN on the allocators, we cannot (re-)allocate any memory
> > > during report generation (data races in the allocators lead to
> > > deadlock).
> > >
> > > Reported-by: Qian Cai <cai@lca.pw>
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  kernel/kcsan/report.c | 112 ++++++++++++++++++++++++++++++++++++++----
> > >  lib/Kconfig.kcsan     |  10 ++++
> > >  2 files changed, 112 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > > index 9f503ca2ff7a..e324af7d14c9 100644
> > > --- a/kernel/kcsan/report.c
> > > +++ b/kernel/kcsan/report.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >
> > >  #include <linux/kernel.h>
> > > +#include <linux/ktime.h>
> > >  #include <linux/preempt.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/sched.h>
> > > @@ -31,12 +32,101 @@ static struct {
> > >         int                     num_stack_entries;
> > >  } other_info = { .ptr = NULL };
> > >
> > > +/*
> > > + * Information about reported data races; used to rate limit reporting.
> > > + */
> > > +struct report_time {
> > > +       /*
> > > +        * The last time the data race was reported.
> > > +        */
> > > +       ktime_t time;
> > > +
> > > +       /*
> > > +        * The frames of the 2 threads; if only 1 thread is known, one frame
> > > +        * will be 0.
> > > +        */
> > > +       unsigned long frame1;
> > > +       unsigned long frame2;
> > > +};
> > > +
> > > +/*
> > > + * Since we also want to be able to debug allocators with KCSAN, to avoid
> > > + * deadlock, report_times cannot be dynamically resized with krealloc in
> > > + * rate_limit_report.
> > > + *
> > > + * Therefore, we use a fixed-size array, which at most will occupy a page. This
> > > + * still adequately rate limits reports, assuming that a) number of unique data
> > > + * races is not excessive, and b) occurrence of unique data races within the
> > > + * same time window is limited.
> > > + */
> > > +#define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
> > > +#define REPORT_TIMES_SIZE                                                      \
> > > +       (CONFIG_KCSAN_REPORT_ONCE_IN_MS > REPORT_TIMES_MAX ?                   \
> > > +                REPORT_TIMES_MAX :                                            \
> > > +                CONFIG_KCSAN_REPORT_ONCE_IN_MS)
> > > +static struct report_time report_times[REPORT_TIMES_SIZE];
> > > +
> > >  /*
> > >   * This spinlock protects reporting and other_info, since other_info is usually
> > >   * required when reporting.
> > >   */
> > >  static DEFINE_SPINLOCK(report_lock);
> > >
> > > +/*
> > > + * Checks if the data race identified by thread frames frame1 and frame2 has
> > > + * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
> > > + */
> > > +static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
> > > +{
> > > +       struct report_time *use_entry = &report_times[0];
> > > +       ktime_t now;
> > > +       ktime_t invalid_before;
> > > +       int i;
> > > +
> > > +       BUILD_BUG_ON(CONFIG_KCSAN_REPORT_ONCE_IN_MS != 0 && REPORT_TIMES_SIZE == 0);
> > > +
> > > +       if (CONFIG_KCSAN_REPORT_ONCE_IN_MS == 0)
> > > +               return false;
> > > +
> > > +       now = ktime_get();
> > > +       invalid_before = ktime_sub_ms(now, CONFIG_KCSAN_REPORT_ONCE_IN_MS);
> >
> > Been thinking about this a bit more, and wondering if we should just
> > use jiffies here?  Don't think we need the precision.
> 
> Sent v2: http://lkml.kernel.org/r/20200110184834.192636-1-elver@google.com
> I think it's also safer to use jiffies, as noted in the v2 patch.
> 
> Paul: sorry for sending v2, seeing you already had these in your tree.
> Hope this is ok.

Not a problem!  Pulling in the replacements shortly.

							Thanx, Paul
