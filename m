Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D473DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0020702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gekr6qeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBERZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:25:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37728 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBERZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:25:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so1288194pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQNBfWoHDbfQqe6R2hgbu/PI6hvc3X2tSeWtPXIXvoM=;
        b=gekr6qeJNiVT4y2Vx0W8jav06Cj5lTmlCMycNQSopUmBB6zpV3r9OfXuNAvxkDseKj
         TIB5xqLdD/8ik3e7GrcpnyxfNb6nJJK+kOxaqCMfycR0LoFYD4PT/diU1Ao6zfVGeRwk
         8Va69JSQM0+A8zTEF4kQIzpR+LBxMbcfWw235WeWCthR3hQ0L4jMw+7nGd0efva7K8w+
         EBFRzKazsSeV3ia+Gt5rwM/dZVdy4IMWPCyyrHSd6WIRprjZLedsoL9FQRpCdoy2tFvC
         5H3bLLZvJASpi+gFiU/O1HwrtCEATbiCtA8vGK1BPpxRS2hzPilHDqx+Ef4saAhOsU5q
         Rssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQNBfWoHDbfQqe6R2hgbu/PI6hvc3X2tSeWtPXIXvoM=;
        b=TaKEoMxhqYKW6oq1C7WFuT7ko1blHifzVb0XsJYGicFBewkoYDsMgb5UZlHTJAerZH
         8SqeQtNwvd13vseWZocAuxQV3B/gv88O9sQvG6mSpSEs+vLK33YY5U0V3yZwzjyO04WE
         +HqYCJAY/OwJQzRuN1s1JrjdhrpiX2cGi2eS/oGT1mTwyq4SVf1vKGUeJP+jbQpb0Msk
         hnKpaK5ksMKLL5YOHtoYbBgY2+TOvnZpmpkT0M6jNwJca/I12p1NpTCY/ZotFJhrAKEW
         HIOv7Di0AoXnjZQ61CiwUSaAIF5Pbi71taGm4XagdDFcHmT7cAHrm5FRtAwRGOYNSRN8
         73FA==
X-Gm-Message-State: APjAAAWWzfPxYluKVmjiljRg2B++74o2TSNI/OmbIGe6eIwvBlC3dCfk
        85hzEaytx+a71QVzVZ0lKB4e5suNWcu3m+yhzN3D/tpBkE8=
X-Google-Smtp-Source: APXvYqzJ5K1bH4NzXBspEaMGghiLHRqOF+eKBB3Oig9ZfyTDoMinjCqya9BC384JIHka1LRkuwfoIRmldt3qBZ3iGxE=
X-Received: by 2002:a63:34e:: with SMTP id 75mr19231500pgd.286.1580923536731;
 Wed, 05 Feb 2020 09:25:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
 <87a7637ise.fsf@kernel.org> <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com>
 <87tv4556ke.fsf@kernel.org>
In-Reply-To: <87tv4556ke.fsf@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 5 Feb 2020 18:25:25 +0100
Message-ID: <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
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

On Wed, Feb 5, 2020 at 5:42 PM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Andrey Konovalov <andreyknvl@google.com> writes:
> >> >> > +static int raw_event_queue_add(struct raw_event_queue *queue,
> >> >> > +     enum usb_raw_event_type type, size_t length, const void *data)
> >> >> > +{
> >> >> > +     unsigned long flags;
> >> >> > +     struct usb_raw_event *event;
> >> >> > +
> >> >> > +     spin_lock_irqsave(&queue->lock, flags);
> >> >> > +     if (WARN_ON(queue->size >= RAW_EVENT_QUEUE_SIZE)) {
> >> >> > +             spin_unlock_irqrestore(&queue->lock, flags);
> >> >> > +             return -ENOMEM;
> >> >> > +     }
> >> >> > +     event = kmalloc(sizeof(*event) + length, GFP_ATOMIC);
> >> >>
> >> >> I would very much prefer dropping GFP_ATOMIC here. Must you have this
> >> >> allocation under a spinlock?
> >> >
> >> > The issue here is not the spinlock, but that this might be called in
> >> > interrupt context. The number of atomic allocations here is restricted
> >> > by 128, and we can reduce the limit even further (until some point in
> >> > the future when and if we'll report more different events). Another
> >> > option would be to preallocate the required number of objects
> >> > (although we don't know the required size in advance, so we'll waste
> >> > some memory) and use those. What would you prefer?
> >>
> >> I think you shouldn't do either :-) Here's what I think you should do:
> >>
> >> 1. support O_NONBLOCK. This just means conditionally removing your
> >>    wait_for_completion_interruptible().
> >
> > I don't think non blocking read/writes will work for us. We do
> > coverage-guided fuzzing and need to collect coverage for each syscall.
> > In the USB case "syscall" means processing a USB request from start to
> > end, and thus we need to wait until the kernel finishes processing it,
> > otherwise we'll fail to associate coverage properly (It's actually a
> > bit more complex, as we collect coverage for the whole initial
> > enumeration process as for one "syscall", but the general idea stands,
> > that we need to wait until the operation finishes.)
>
> Fair enough, but if the only use case that this covers, is a testing
> scenario, we don't gain much from accepting this upstream, right?

We gain a lot, even though it's just for testing. For one thing, once
the patch is upstream, all syzbot instances that target upstream-ish
branches will start fuzzing USB, and there won't be any need for me to
maintain a dedicated USB fuzzing branch manually. Another thing, is
that syzbot will be able to do fix/cause bisection (at least for the
bugs that are fixed/introduced after this patch is merged). And
finally, once this is upstream, we'll be able to backport this to
Android kernels and start testing them as well.

> We can
> still support both block and nonblock, but let's at least give the
> option.
>
> >> 2. Every time user calls write(), you usb_ep_alloc(), allocate a buffer
> >>    with the write size, copy buffer to kernel space,
> >>    usb_ep_queue(). When complete() callback is called, then you free the
> >>    request. This would allow us to amortize the cost of copy_from_user()
> >>    with several requests being queued to USB controller.
> >
> > I'm not sure I really get this part. We'll still need to call
> > copy_from_user() and usb_ep_queue() once per each operation/request.
> > How does it get amortized? Or do you mean that having multiple
> > requests queued will allow USB controller to process them in bulk?
>
> yes :-)
>
> > This makes sense, but again, we"ll then have an issue with coverage
> > association.
>
> You can still enqueue one by one, but this would turn your raw-gadget
> interface more interesting for other use cases.
>
> >> 3. Have a pre-allocated list of requests (128?) for read(). Enqueue them
> >>    all during set_alt(). When user calls read() you will:
> >>
> >>    a) check if there are completed requests to be copied over to
> >>       userspace. Recycle the request.
> >>
> >>    b) if there are no completed requests, then it depends on O_NONBLOCK
> >>
> >>       i) If O_NONBLOCK, return -EWOULDBLOCK
> >>       ii) otherwise, wait_for_completion
> >
> > See response to #1, if we prequeue requests, then the kernel will
> > start handling them before we do read(), and we'll fail to associate
> > coverage properly. (This will also require adding another ioctl to
> > imitate set_alt(), like the USB_RAW_IOCTL_CONFIGURE that we have.)
>
> set_alt() needs to be supported if we're aiming at providing support for
> various USB classes to be implemented on top of what you created :-)

What do you mean by supporting set_alt() here? AFAIU set_alt() is a
part of the composite gadget framework, which I don't use for this.
Are there some other actions (besides sending/receiving requests) that
need to be exposed to userspace to implement various USB classes? The
one that I know about is halting endpoints, it's mentioned in the TODO
section in documentation.

>
> >> I think this can all be done without any GFP_ATOMIC allocations.
> >
> > Overall, supporting O_NONBLOCK might be a useful feature for people
> > who are doing something else other than fuzzing, We can account for
> > potential future extensions that'll support it, so detecting
> > O_NONBLOCK and returning an error for now makes sense.
> >
> > WDYT?
>
> If that's the way you want to go, that's okay. But let's, then, prepare
> the code for extension later on. For example, let's add an IOCTL which
> returns the "version" of the ABI. Based on that, userspace can detect
> features and so on.

This sounds good to me. Let's concentrate on implementing the part
that is essential for testing/fuzzing, as it was the initial reason
why I started working on this, instead of using e.g. GadgetFS. I'll
add such IOCTL in v6.

Re GFP_ATOMIC allocations, if we're using the blocking approach,
should I decrease the limit of the number of such allocations or do
something else?

Re licensing comments, do I need to change anything after all?
