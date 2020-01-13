Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A92214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAMSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:45:38 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56806 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727726AbgAMSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:45:37 -0500
Received: (qmail 4729 invoked by uid 2102); 13 Jan 2020 13:45:35 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jan 2020 13:45:35 -0500
Date:   Mon, 13 Jan 2020 13:45:35 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>,
        Felipe Balbi <balbi@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 1/1] usb: gadget: add raw-gadget interface
In-Reply-To: <CAAeHK+zKAHGAgYKxMNJEiaBhreGB0MgWNsEUFCO8Sxiqvcq57Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2001131319490.1502-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Andrey Konovalov wrote:

> On Mon, Jan 13, 2020 at 6:34 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Mon, Jan 13, 2020 at 5:50 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Mon, 13 Jan 2020, Andrey Konovalov wrote:
> > >
> > > > I've also found an issue, but I'm not sure if that is the bug in Raw
> > > > Gadget, or in the gadget layer (in the former case I'll add this fix
> > > > to v5 as well). What I believe I'm seeing is
> > > > __fput()->usb_gadget_unregister_driver()->usb_gadget_remove_driver()->gadget_unbind()
> > > > racing with dummy_timer()->gadget_setup(). In my case it results in
> > > > gadget_unbind() doing set_gadget_data(gadget, NULL), and then
> > > > gadget_setup() dereferencing get_gadget_data(gadget).
> > > >
> > > > Alan, does it look possible for those two functions to race? Should
> > > > this be prevented by the gadget layer, or should I use some kind of
> > > > locking in my gadget driver to prevent this?
> > >
> > > In your situation this race shouldn't happen, because before
> > > udc->driver->unbind() is invoked we call usb_gadget_disconnect().  If
> > > that routine succeeds -- which it always does under dummy-hcd -- then
> > > there can't be any more setup callbacks, because find_endpoint() will
> > > always return NULL (the is_active() test fails; see the various
> > > set_link_state* routines).  So I don't see how you could have ended up
> > > with the race you describe.
> >
> > I've managed to reproduce the race by adding an mdelay() into the
> > beginning of the setup() callback. AFAIU what happens is setup() gets
> > called (and waits on the mdelay()), then unbind() comes in and does
> > set_gadget_data(NULL), and then setup() proceeds, gets NULL through
> > get_gadget_data() and crashes on null-ptr-deref. I've got the same
> > crash a few times after many days of fuzzing, so I assume it can
> > happen without the mdelay() as well.
> >
> > > However, a real UDC might not be able to perform a disconnect under
> > > software control.  In that case usb_gadget_disconnect() would not
> > > change the pullup state, and there would be a real possibility of a
> > > setup callback racing with an unbind callback.  This seems like a
> > > genuine problem and I can't think of a solution offhand.
> > >
> > > What we would need is a way to tell the UDC driver to stop invoking
> > > gadget callbacks, _before_ the UDC driver's stop callback gets called.
> > > Maybe this should be merged into the pullup callback somehow.
> 
> Perhaps for the dummy driver we need to wait for setup() to finish if
> it's being executed and then stop the dummy timer in dummy_pullup()?

Yes, we need to wait for a setup callback to finish.  But dummy_timer 
should not be stopped; otherwise URBs that have already been submitted 
would never be given back.

The big problem is that usb_gadget_disconnect() can be called in
interrupt context.  In general, a UDC driver will need to call
synchronize_irq() to make sure there aren't any callbacks still
running, and that can be done only in process context.  dummy-hcd is
slightly different since it doesn't manage actual hardware; it calls
usleep_range() instead of synchronize_irq() -- but that also requires
process context.

We could change the gadget API to require that usb_gadget_disconnect()  
and related routines always be called in process context.  I don't know
if that's such a good idea though.  A gadget driver might want to
disconnect from within its setup handler or a completion routine, for
example.

A better approach would be to add a new synchronize_callbacks()  
pointer in the usb_gadget_ops structure.  But to work properly it 
would have to be mandatory for every UDC driver, and that's not so easy 
to accomplish.

Suggestions?

Alan Stern

