Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F6FC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F282078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c28LT2nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDGOWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:22:18 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37238 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgDGOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:22:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so829224pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBta2dvsE/8BQDUZIv4+0XBQsmidsJtftVziTz+qjVI=;
        b=c28LT2nIa6FgFzpPwxLup032GZK4L8K4ouge31SEjUG/gH9vs53p+caNuH4KRTVMsk
         tVc0HmW8GMW8AlzvfXM3b6AYR4uOGnjCLRsxi67DjOcKDi5ohZ/u1J7elPzXAABDZ3YM
         6L9cOKtezf6q5Lh7SlNKOmKI4kkJ3w3bXjc4gF0JSAIdy+LJjCDE/+PUnk3Ki/fEit63
         yehjzBhgD/zFGCA1/rpMREUFGLHhAxiZ7/X2T4XFm9bpTVkImM84HI7g1q+29iOcYtVi
         nNdZtP6Sjf+cD+SeM+ytFgM+TCZSbTO0qCTuX5oiHuBRvUjIYXrSj4vnxwIRePK6Nv8Z
         odcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBta2dvsE/8BQDUZIv4+0XBQsmidsJtftVziTz+qjVI=;
        b=Frs7TJ0VPIumhnMDOj4huAo/z9ghIDOSMHmNVQ4S1eFMQPLyKDuleHUIfn24RvW1oe
         jaHp4zQuk+73+zkYVd7ANWCWu0HaiLl4VeBsaHoimE6gaIC/NlrOB8xSLKlazyGkc8pN
         ACMPi1KWxDcqQxVKYTeWoiAFgq2BmbdLl6CgIMbZA9lNfzEmtFA6liYRpp+D137Y/27g
         7N+hkQ2BFq/1NRaQl9suA7SZQDfV5l3RcIy9F16cVdvUW3F/iShpuaOh8fBb6M2qrHE4
         SAw4PHhVftzQM57/pkMcgtKyJhsfRw2Ror6EnkiHNEYKgrL3lqgB2nSuer11TLqPlCKf
         FUpw==
X-Gm-Message-State: AGi0PuYvCqRzAS91XDzQJDHx8DtFHFpY9gflRUVD3BXEoFQShuZ6m07T
        7CHkFkVXhfgrIHI94F5Yiv9QnSlMCBKl2EmDwljGBA==
X-Google-Smtp-Source: APiQypKZy79cap6HgorbVpseb0/JOuDvypQMsLjHHCuUy0YK4idmEXVVvDW6zlhXlExk9NXf9f9+2LY/uYJ0dRuDLBw=
X-Received: by 2002:a17:90a:2541:: with SMTP id j59mr3073585pje.128.1586269335956;
 Tue, 07 Apr 2020 07:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+wdEByqpv90WCtb2=E9Xx6WpkDxn7xq__8JwSh8ROZn7w@mail.gmail.com>
 <Pine.LNX.4.44L0.2004061504580.26186-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004061504580.26186-100000@netrider.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 7 Apr 2020 16:22:04 +0200
Message-ID: <CAAeHK+zrn_9L+FyKaw=vX8jfM4K7TJDjqadw8Q0HwSavz5qr3w@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: fix raw_event_queue_fetch locking
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:26 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 6 Apr 2020, Andrey Konovalov wrote:
>
> > On Mon, Apr 6, 2020 at 8:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Mon, 6 Apr 2020, Andrey Konovalov wrote:
> > >
> > > > If queue->size check in raw_event_queue_fetch() fails (which normally
> > > > shouldn't happen, that check is a fail-safe), the function returns
> > > > without reenabling interrupts. This patch fixes that issue, along with
> > > > propagating the cause of failure to the function caller.
> > > >
> > > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >
> > > > Greg, this should apply cleanly on top of Dan's "usb: raw-gadget: Fix
> > > > copy_to/from_user() checks" patch.
> > > >
> > > > ---
> > > >  drivers/usb/gadget/legacy/raw_gadget.c | 19 +++++++++++++++----
> > > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > > > index e490ffa1f58b..1582521ec774 100644
> > > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > > @@ -81,6 +81,7 @@ static int raw_event_queue_add(struct raw_event_queue *queue,
> > > >  static struct usb_raw_event *raw_event_queue_fetch(
> > > >                               struct raw_event_queue *queue)
> > > >  {
> > > > +     int ret;
> > > >       unsigned long flags;
> > > >       struct usb_raw_event *event;
> > > >
> > > > @@ -89,11 +90,14 @@ static struct usb_raw_event *raw_event_queue_fetch(
> > > >        * there's at least one event queued by decrementing the semaphore,
> > > >        * and then take the lock to protect queue struct fields.
> > > >        */
> > > > -     if (down_interruptible(&queue->sema))
> > > > -             return NULL;
> > > > +     ret = down_interruptible(&queue->sema);
> > > > +     if (ret)
> > > > +             return ERR_PTR(ret);
> > > >       spin_lock_irqsave(&queue->lock, flags);
> > > > -     if (WARN_ON(!queue->size))
> > > > +     if (WARN_ON(!queue->size)) {
> > > > +             spin_unlock_irqrestore(&queue->lock, flags);
> > > >               return NULL;
> > >
> > > Suppose the WARN_ON triggers, and you return NULL here.  Then where do
> > > you reverse the down_interruptible() on queue->sema?
> > >
> > > > +     }
> > > >       event = queue->events[0];
> > > >       queue->size--;
> > > >       memmove(&queue->events[0], &queue->events[1],
> > > > @@ -522,10 +526,17 @@ static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
> > > >       spin_unlock_irqrestore(&dev->lock, flags);
> > > >
> > > >       event = raw_event_queue_fetch(&dev->queue);
> > > > -     if (!event) {
> > > > +     if (PTR_ERR(event) == -EINTR) {
> > > >               dev_dbg(&dev->gadget->dev, "event fetching interrupted\n");
> > > >               return -EINTR;
> > > >       }
> > > > +     if (IS_ERR_OR_NULL(event)) {
> > > > +             dev_err(&dev->gadget->dev, "failed to fetch event\n");
> > > > +             spin_lock_irqsave(&dev->lock, flags);
> > > > +             dev->state = STATE_DEV_FAILED;
> > > > +             spin_unlock_irqrestore(&dev->lock, flags);
> > > > +             return -ENODEV;
> > > > +     }
> > >
> > > Not here, obviously.  Does the semaphore ever get released?
> >
> > If this warning triggered, something has already gone horribly wrong,
> > so we set the device stated to "failed".
> >
> > But even if we ignore that, should the semaphore be "released"? The
> > initial semaphore's counter value is 0, so one up()+down() sequence of
> > events leaves it with the initial value. So it's the down() event that
> > brings it to the initial state (unless there were multiple up()s of
> > course). Unless I misunderstand something.
>
> Okay, now I get it.  It's an invariant of the driver: the semaphore's
> value is always equal to queue->size.  You might consider putting this
> in a comment, in some future update.

Correct. Sent v2 with a comment.

> Incidentally, how often do you expect the queue to contain more than
> one entry?  If that happens a lot, it would be more efficient to
> implement the queue as a ring (with first and last pointers) than to
> call memmove() every time an entry is removed.

Currently not often (we can have one CONNECT and one CONTROL in the
queue at the same time), but that might change if we ever add more
event types. I'm not sure if it makes sense to change the
implementation right now, as this isn't a bottleneck. But if it ever
becomes one, I'll certainly do that, thanks for a suggestion!
