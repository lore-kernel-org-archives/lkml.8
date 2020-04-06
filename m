Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA072072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDFT0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:26:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40821 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725933AbgDFT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:26:24 -0400
Received: (qmail 28308 invoked by uid 500); 6 Apr 2020 15:26:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Apr 2020 15:26:23 -0400
Date:   Mon, 6 Apr 2020 15:26:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] usb: raw-gadget: fix raw_event_queue_fetch locking
In-Reply-To: <CAAeHK+wdEByqpv90WCtb2=E9Xx6WpkDxn7xq__8JwSh8ROZn7w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004061504580.26186-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, Andrey Konovalov wrote:

> On Mon, Apr 6, 2020 at 8:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, 6 Apr 2020, Andrey Konovalov wrote:
> >
> > > If queue->size check in raw_event_queue_fetch() fails (which normally
> > > shouldn't happen, that check is a fail-safe), the function returns
> > > without reenabling interrupts. This patch fixes that issue, along with
> > > propagating the cause of failure to the function caller.
> > >
> > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >
> > > Greg, this should apply cleanly on top of Dan's "usb: raw-gadget: Fix
> > > copy_to/from_user() checks" patch.
> > >
> > > ---
> > >  drivers/usb/gadget/legacy/raw_gadget.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > > index e490ffa1f58b..1582521ec774 100644
> > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > @@ -81,6 +81,7 @@ static int raw_event_queue_add(struct raw_event_queue *queue,
> > >  static struct usb_raw_event *raw_event_queue_fetch(
> > >                               struct raw_event_queue *queue)
> > >  {
> > > +     int ret;
> > >       unsigned long flags;
> > >       struct usb_raw_event *event;
> > >
> > > @@ -89,11 +90,14 @@ static struct usb_raw_event *raw_event_queue_fetch(
> > >        * there's at least one event queued by decrementing the semaphore,
> > >        * and then take the lock to protect queue struct fields.
> > >        */
> > > -     if (down_interruptible(&queue->sema))
> > > -             return NULL;
> > > +     ret = down_interruptible(&queue->sema);
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > >       spin_lock_irqsave(&queue->lock, flags);
> > > -     if (WARN_ON(!queue->size))
> > > +     if (WARN_ON(!queue->size)) {
> > > +             spin_unlock_irqrestore(&queue->lock, flags);
> > >               return NULL;
> >
> > Suppose the WARN_ON triggers, and you return NULL here.  Then where do
> > you reverse the down_interruptible() on queue->sema?
> >
> > > +     }
> > >       event = queue->events[0];
> > >       queue->size--;
> > >       memmove(&queue->events[0], &queue->events[1],
> > > @@ -522,10 +526,17 @@ static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
> > >       spin_unlock_irqrestore(&dev->lock, flags);
> > >
> > >       event = raw_event_queue_fetch(&dev->queue);
> > > -     if (!event) {
> > > +     if (PTR_ERR(event) == -EINTR) {
> > >               dev_dbg(&dev->gadget->dev, "event fetching interrupted\n");
> > >               return -EINTR;
> > >       }
> > > +     if (IS_ERR_OR_NULL(event)) {
> > > +             dev_err(&dev->gadget->dev, "failed to fetch event\n");
> > > +             spin_lock_irqsave(&dev->lock, flags);
> > > +             dev->state = STATE_DEV_FAILED;
> > > +             spin_unlock_irqrestore(&dev->lock, flags);
> > > +             return -ENODEV;
> > > +     }
> >
> > Not here, obviously.  Does the semaphore ever get released?
> 
> If this warning triggered, something has already gone horribly wrong,
> so we set the device stated to "failed".
> 
> But even if we ignore that, should the semaphore be "released"? The
> initial semaphore's counter value is 0, so one up()+down() sequence of
> events leaves it with the initial value. So it's the down() event that
> brings it to the initial state (unless there were multiple up()s of
> course). Unless I misunderstand something.

Okay, now I get it.  It's an invariant of the driver: the semaphore's
value is always equal to queue->size.  You might consider putting this
in a comment, in some future update.

Incidentally, how often do you expect the queue to contain more than
one entry?  If that happens a lot, it would be more efficient to
implement the queue as a ring (with first and last pointers) than to
call memmove() every time an entry is removed.

Alan Stern

