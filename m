Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B88207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HknauRAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHUCjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgHUCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:39:14 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:39:14 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id i129so131187vsi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATzzWYs+KVYDQm4ODJ6A/MRFRb4qw5XmLoXvOYBjQeE=;
        b=HknauRAelv+awTG11z2ms/wbIkkbDlXKONPWMwHo6Axvkpce0knAKrOQgSNvEqsGpb
         7crJHINAz47tYgDwbQe8/j6N1cOyAhABm3x+qlU38WF1AQItiwlIveLjPK+xyHsoPwnJ
         t4wJLKxMw5zoz0bqW8nn+BieSqxP055TB9oD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATzzWYs+KVYDQm4ODJ6A/MRFRb4qw5XmLoXvOYBjQeE=;
        b=Arsc06tfPjk6i5VvDUdMCkj87tL5VhXVE0mFycBkGrCc+hSZVVd6mAL7PbFAD5Ra6E
         WrU1oFjPKYg/O4C0p4/aQLiCSsHbxDzX2iJc5ULTMSvX095631t/dmPB4dkz9hROLalb
         32bi4DvLDY4M4nC455p12Y2EsCBbDkg3yhfWkLPeyxN87MkNmRuKfsIGFE3vb5AISLsk
         T8kMcef7xD8bXgT1Aq/YqNGQecNQVGDN4ofNhm3xqgg1rXJyEOz/Rk5o2sEIIzNOW2/E
         elcQzbF/FqNxe5Q/bD4UVBrznG9z4KzSCgivqpJubpz25M/9/hyRPY5Rp2f8uauyPf67
         sswA==
X-Gm-Message-State: AOAM530lLfDX1JheFWqZTkEWjlq2kpxfXhr6Uu9mwZVFumRBz5kgHLV/
        MfrIfE7E2aLUjGjfr4dI8oNaFOf5EB37t+XWmNuqLQ==
X-Google-Smtp-Source: ABdhPJxI0XsWTYVDjT+S9dMJzFMqukJVk1zWrjVresd73e30y68GbLUwP1QE5T0R3Eko8pOPMFGk4sINfN/UDY79vMY=
X-Received: by 2002:a67:68d2:: with SMTP id d201mr555874vsc.186.1597977553269;
 Thu, 20 Aug 2020 19:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
 <20200820170951.v4.3.I066d89f39023956c47fb0a42edf196b3950ffbf7@changeid>
 <20200820102347.15d2f610@oasis.local.home> <CANMq1KCoEZVj=sjxCqBhqLZKBab57+82=Rk_LN7fc3aCuNHMUw@mail.gmail.com>
 <20200820203601.4f70bf98@oasis.local.home> <CANMq1KAAgXG9MKMZ_D9zYFV-j0oVreA_AeSw-8FoyJgZ9eWQpg@mail.gmail.com>
 <20200820215701.667f02b2@oasis.local.home>
In-Reply-To: <20200820215701.667f02b2@oasis.local.home>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Aug 2020 10:39:02 +0800
Message-ID: <CANMq1KCpV+RKCqHsK-=Xeb+Vq28qdnBVF51rcga7m9-xjqNSCg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: atomisp: Only use trace_printk if allowed
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 21 Aug 2020 09:39:19 +0800
> Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > On Fri, Aug 21, 2020 at 8:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 21 Aug 2020 08:13:00 +0800
> > > Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > > On Thu, Aug 20, 2020 at 10:23 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > On Thu, 20 Aug 2020 17:14:12 +0800
> > > > > Nicolas Boichat <drinkcat@chromium.org> wrote:
> > > > >
> > > > > > Technically, we could only initialize the trace_printk buffers
> > > > > > when the print env is switched, to avoid the build error and
> > > > > > unconditional boot-time warning, but I assume this printing
> > > > > > framework will eventually get removed when the driver moves out
> > > > > > of staging?
> > > > >
> > > > > Perhaps this should be converting into a trace event. Look at what bpf
> > > > > did for their bpf_trace_printk().
> > > > >
> > > > > The more I think about it, the less I like this series.
> > > >
> > > > To make it clear, the primary goal of this series is to get rid of
> > > > trace_printk sprinkled in the kernel by making sure some randconfig
> > > > builds fail. Since my v2, there already has been one more added (the
> > > > one that this patch removes), so I'd like to land 2/3 ASAP to prevent
> > > > even more from being added.
> > > >
> > > > Looking at your reply on 1/3, I think we are aligned on that goal? Is
> > > > there some other approach you'd recommend?
> > > >
> > > > Now, I'm not pretending my fixes are the best possible ones, but I
> > > > would much rather have the burden of converting to trace events on the
> > > > respective driver maintainers. (btw is there a short
> > > > documentation/tutorial that I could link to in these patches, to help
> > > > developers understand what is the recommended way now?)
> > > >
> > >
> > > I like the goal, but I guess I never articulated the problem I have
> > > with the methodology.
> > >
> > > trace_printk() is meant to be a debugging tool. Something that people
> > > can and do sprinkle all over the kernel to help them find a bug in
> > > areas that are called quite often (where printk() is way too slow).
> > >
> > > The last thing I want them to deal with is adding a trace_printk() with
> > > their distro's config (or a config from someone that triggered the bug)
> > > only to have the build to fail, because they also need to add a config
> > > value.
> > >
> > > I add to the Cc a few developers I know that use trace_printk() in this
> > > fashion. I'd like to hear their view on having to add a config option
> > > to make trace_printk work before they test a config that is sent to
> > > them.
> >
> > Gotcha, thanks. I have also used trace_printk in the past, as
> > uncommitted changes (and understand the usefulness ,-)). And in Chrome
> > OS team here, developers have also raised this concern: how do we make
> > the developer flow convenient so that we can add trace_printk to our
> > code for debugging, without having to flip back that config option,
> > and _yet_ make sure that no trace_printk ever makes it into our
> > production kernels. We have creative ways of making that work (portage
> > USE flags and stuff). But I'm not sure about other flows, and your
> > concern is totally valid...
> >
> > Some other approaches/ideas:
> >  1. Filter all lkml messages that contain trace_printk. Already found
> > 1 instance, and I can easily reply to those with a semi-canned answer,
> > if I remember to check that filter regularly (not sustainable in the
> > long run...).
>
> Added Joe Perches to the thread.
>
> We can update checkpatch.pl to complain about a trace_printk() that it
> finds in the added code.

Oh, that's a good and simple idea.

>
> >  2. Integration into some kernel test robot? (I will not roll my own
> > for this ,-)) It may be a bit difficult as some debug config options
> > do enable trace_printk, and that's ok.
> >  3. In Chromium OS, I can add a unit test (i.e. something outside of
> > the normal kernel build system), but that'll only catch regressions
> > downstream (or when we happen to backport patches).
> >
> > Down the line, #3 catches what I care about the most (Chromium OS
> > issues: we had production kernels for a few days/weeks showing that
> > splat on boot), but it'd be nice to have something upstream that
> > benefits everyone.
> >
>
> What about an opposite config. That is, not have a config to enable it.
> But one to disable it. If it is disabled and a trace_printk is found,
> it will fail the build. This way your builds will not allow your kernel
> to get out the door with one.
>
> #ifdef CONFIG_DISABLE_TRACE_PRINTK
> #define trace_printk    __this_function_is_disabled
> #endif

I'm not sure how that helps? I mean, the use case you have in mind is
somebody reusing a distro/random config and not being able to use
trace_printk, right? If that config has CONFIG_DISABLE_TRACE_PRINTK=y,
then the developer will still need to flip that back.

Note that the option I'm added has default=y (_allow_ trace_printk),
so I don't think default y or default n really matters?

>
> ?
>
> -- Steve
