Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D6CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4AF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgD2OIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:08:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35545 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727108AbgD2OIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:08:22 -0400
Received: (qmail 29755 invoked by uid 500); 29 Apr 2020 10:08:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2020 10:08:21 -0400
Date:   Wed, 29 Apr 2020 10:08:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <CAAeHK+yVWgLD9DLNea_vBt3zj=3fLfw2Ai5U8=9sJ+QvmK0o-Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004291006500.28180-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, Andrey Konovalov wrote:

> On Wed, Apr 29, 2020 at 3:14 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 28 Apr 2020, Andrey Konovalov wrote:
> >
> > > Hi Alan,
> > >
> > > This patch uses the approach that I mentioned in the discussion about
> > > endpoint selection. Does this look acceptable?
> >
> > I haven't had time to look through it yet.
> >
> > > I'm not sure which endpoint limits it makes sense to expose via
> > > USB_RAW_IOCTL_EPS_INFO. I'm more or less sure about maxpacket_limit
> > > and max_streams, but I don't exactly know what maxburst is used for.
> > > Maybe there are some others?
> >
> > maxburst is a USB-3 thing.  It mainly affects just throughput, not
> > functionality, and it's handled pretty much entirely by the hardware.
> > You shouldn't worry about it, at least, not now.
> 
> The question is whether it will be needed when/if I ever add proper
> USB3 support. It would be good to figure out which endpoint attributes
> we need to expose now, rather than having to add another ioctl later.

You might as well expose anything that looks like it might be relevant.  
Better to include things that will never be needed than to omit things
which may be needed later.

Alan Stern

