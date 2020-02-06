Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D4BC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBAB20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJPJPukf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBFTWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:22:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36094 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgBFTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:22:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv17so406332pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zSiPQfNqsKOSQ+rCM+XFyBgpWJvhAy9MKkDpcX17vQ=;
        b=iJPJPukfBxzLPW8M9OZNtPgF2ezCKyyw6sBxjOJWXw2X0DMDZPoEmbzeoQDLYW7ovK
         hVY7LvcFohZD25hkba4Z0cKJe1ve485A62kFQBWbl7qNRyyYwyF2+qVwX56dscgY6H1D
         vG440KpztEvhwvMNYj4X0IMVpNWjigi13HMv+iCMFOR/TpOiJE6eRzOPeWdv9NGUXqYz
         ZVJs4iXfwkzFHSmwjCin1jJmb6dE50MM+XkJmgRQHuQrVK8dOjNLjKkd3XSJTJx2Te3m
         8eQy0Hh9dTLeAvam4gqqYvPdfqpRDP/TvIklYN/zV7ohdLslNeZijkteq3Ux2oigqQiG
         TnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zSiPQfNqsKOSQ+rCM+XFyBgpWJvhAy9MKkDpcX17vQ=;
        b=bWLDRyy8w/0cFqbNDubZd0nb2vNWLb/SOe7iOj8PyxYdki/hL0y3WsBnIM9dAQo7Mm
         SBZXEdTaZ07VuuOiQLhjtaaa5jyzIJXzbH3DbKQobAC6afshA4VMbgYxFPqJIAj+vUyc
         hdW+3fv0j3Q3yLMSX3UBefUVX3HGWOlZSW0vaBZ7aH4IxaqFtu65Fpy6NI3J1ruN4vf5
         Uavr2S2u/wHKFXX2d2qToelI1NUCWqwsNvSKfdm7Ke1PoS45buUzLdMoVSXDuMXW0/lN
         4/s7Y8V07J/XSNG3xtL7u1Dr25Fu0aMOQn82g+ZKRDYgrxsKfl6Rrt4PvErypxXkSg27
         RJaw==
X-Gm-Message-State: APjAAAVWrA+NVXjGxnyNZCT+ELCHiK1lPuChKecxpnWJwrVLTCphrekq
        pFaqcfs/id84G1tmA1fhGA9uWLZyMsuoiUkkarlK4Q==
X-Google-Smtp-Source: APXvYqylkjjyuctiEBTDyHjHYrRMvThZy5FVqY6JsnURAH4xabFlpMVouLzkKGKvqTXRhZpZgS0ZIIR6FT61viBRT0g=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr6296546pjp.47.1581016929097;
 Thu, 06 Feb 2020 11:22:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
 <87a7637ise.fsf@kernel.org> <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com>
 <87tv4556ke.fsf@kernel.org> <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
 <87o8uc5jbk.fsf@kernel.org>
In-Reply-To: <87o8uc5jbk.fsf@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Feb 2020 20:21:58 +0100
Message-ID: <CAAeHK+yj7qZSi0tuX4zovMFvx8YriOJR6zb4cVk5WsX__cGNwg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
To:     Felipe Balbi <balbi@kernel.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 7:19 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Andrey Konovalov <andreyknvl@google.com> writes:
> >> Andrey Konovalov <andreyknvl@google.com> writes:
> >> >> >> > +static int raw_event_queue_add(struct raw_event_queue *queue,
> >> >> >> > +     enum usb_raw_event_type type, size_t length, const void *data)
> >> >> >> > +{
> >> >> >> > +     unsigned long flags;
> >> >> >> > +     struct usb_raw_event *event;
> >> >> >> > +
> >> >> >> > +     spin_lock_irqsave(&queue->lock, flags);
> >> >> >> > +     if (WARN_ON(queue->size >= RAW_EVENT_QUEUE_SIZE)) {
> >> >> >> > +             spin_unlock_irqrestore(&queue->lock, flags);
> >> >> >> > +             return -ENOMEM;
> >> >> >> > +     }
> >> >> >> > +     event = kmalloc(sizeof(*event) + length, GFP_ATOMIC);
> >> >> >>
> >> >> >> I would very much prefer dropping GFP_ATOMIC here. Must you have this
> >> >> >> allocation under a spinlock?
> >> >> >
> >> >> > The issue here is not the spinlock, but that this might be called in
> >> >> > interrupt context. The number of atomic allocations here is restricted
> >> >> > by 128, and we can reduce the limit even further (until some point in
> >> >> > the future when and if we'll report more different events). Another
> >> >> > option would be to preallocate the required number of objects
> >> >> > (although we don't know the required size in advance, so we'll waste
> >> >> > some memory) and use those. What would you prefer?
> >> >>
> >> >> I think you shouldn't do either :-) Here's what I think you should do:
> >> >>
> >> >> 1. support O_NONBLOCK. This just means conditionally removing your
> >> >>    wait_for_completion_interruptible().
> >> >
> >> > I don't think non blocking read/writes will work for us. We do
> >> > coverage-guided fuzzing and need to collect coverage for each syscall.
> >> > In the USB case "syscall" means processing a USB request from start to
> >> > end, and thus we need to wait until the kernel finishes processing it,
> >> > otherwise we'll fail to associate coverage properly (It's actually a
> >> > bit more complex, as we collect coverage for the whole initial
> >> > enumeration process as for one "syscall", but the general idea stands,
> >> > that we need to wait until the operation finishes.)
> >>
> >> Fair enough, but if the only use case that this covers, is a testing
> >> scenario, we don't gain much from accepting this upstream, right?
> >
> > We gain a lot, even though it's just for testing. For one thing, once
> > the patch is upstream, all syzbot instances that target upstream-ish
> > branches will start fuzzing USB, and there won't be any need for me to
> > maintain a dedicated USB fuzzing branch manually. Another thing, is
> > that syzbot will be able to do fix/cause bisection (at least for the
> > bugs that are fixed/introduced after this patch is merged). And
> > finally, once this is upstream, we'll be able to backport this to
> > Android kernels and start testing them as well.
>
> A very respectable goal :-)
>
> I just want to take the opportunity to turn this into something more
> generic so we stop depending on kernel patches to support newer USB
> classes.
>
> I'll try to allocate some time during next week (this week, I'm totally
> swamped) to carefully review your submission.

OK, looking forward to it, thank you!

In case you'll find it helpful for view, here's a userspace
implementation of a USB keyboard via Raw Gadget:

https://github.com/xairy/raw-gadget/blob/master/examples/keyboard.c

>
> >> >> 3. Have a pre-allocated list of requests (128?) for read(). Enqueue them
> >> >>    all during set_alt(). When user calls read() you will:
> >> >>
> >> >>    a) check if there are completed requests to be copied over to
> >> >>       userspace. Recycle the request.
> >> >>
> >> >>    b) if there are no completed requests, then it depends on O_NONBLOCK
> >> >>
> >> >>       i) If O_NONBLOCK, return -EWOULDBLOCK
> >> >>       ii) otherwise, wait_for_completion
> >> >
> >> > See response to #1, if we prequeue requests, then the kernel will
> >> > start handling them before we do read(), and we'll fail to associate
> >> > coverage properly. (This will also require adding another ioctl to
> >> > imitate set_alt(), like the USB_RAW_IOCTL_CONFIGURE that we have.)
> >>
> >> set_alt() needs to be supported if we're aiming at providing support for
> >> various USB classes to be implemented on top of what you created :-)
> >
> > What do you mean by supporting set_alt() here? AFAIU set_alt() is a
> > part of the composite gadget framework, which I don't use for this.
> > Are there some other actions (besides sending/receiving requests) that
> > need to be exposed to userspace to implement various USB classes? The
> > one that I know about is halting endpoints, it's mentioned in the TODO
> > section in documentation.
>
> Yeah, halting endpoints, cancelling all pending requests, tell userspace
> about it, and so on.
>
> >> >> I think this can all be done without any GFP_ATOMIC allocations.
> >> >
> >> > Overall, supporting O_NONBLOCK might be a useful feature for people
> >> > who are doing something else other than fuzzing, We can account for
> >> > potential future extensions that'll support it, so detecting
> >> > O_NONBLOCK and returning an error for now makes sense.
> >> >
> >> > WDYT?
> >>
> >> If that's the way you want to go, that's okay. But let's, then, prepare
> >> the code for extension later on. For example, let's add an IOCTL which
> >> returns the "version" of the ABI. Based on that, userspace can detect
> >> features and so on.
> >
> > This sounds good to me. Let's concentrate on implementing the part
> > that is essential for testing/fuzzing, as it was the initial reason
> > why I started working on this, instead of using e.g. GadgetFS. I'll
> > add such IOCTL in v6.
>
> Greg doesn't want it, so let's stop that for now.
>
> > Re GFP_ATOMIC allocations, if we're using the blocking approach,
> > should I decrease the limit of the number of such allocations or do
> > something else?
>
> I would prefer to not see GFP_ATOMIC at all here and I think it's
> totally doable, but I could be wrong.
>
> --
> balbi
