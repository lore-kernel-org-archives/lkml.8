Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277CC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58262206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAJQgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:36:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42860 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728209AbgAJQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:36:44 -0500
Received: (qmail 4548 invoked by uid 2102); 10 Jan 2020 11:36:43 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2020 11:36:43 -0500
Date:   Fri, 10 Jan 2020 11:36:43 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
In-Reply-To: <CAAd53p56QynOLJPi3kKiQB1iScrDxj3X1FiycuVF7tP75yPD8A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2001101135450.1467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020, Kai-Heng Feng wrote:

> On Fri, Jan 10, 2020 at 11:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 10 Jan 2020, Kai-Heng Feng wrote:
> >
> > > Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> > > bus when bringing underlying ports from U3 to U0.
> > >
> > > Disabling LPM on the hub during setting link state is not enough, so
> > > let's disable LPM completely for this hub.
> > >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/usb/core/quirks.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > > index 6b6413073584..2fb7c1602280 100644
> > > --- a/drivers/usb/core/quirks.c
> > > +++ b/drivers/usb/core/quirks.c
> > > @@ -371,6 +371,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> > >       { USB_DEVICE(0x0b05, 0x17e0), .driver_info =
> > >                       USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> > >
> > > +     /* Realtek hub in Dell WD19 (Type-C) */
> > > +     { USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> > > +
> > >       /* Action Semiconductor flash disk */
> > >       { USB_DEVICE(0x10d6, 0x2200), .driver_info =
> > >                       USB_QUIRK_STRING_FETCH_255 },
> > >
> >
> > This is a very partial patch.  There were four hunks in the original
> > version but there's only one hunk in V2.
> 
> Because the original approach is insufficient, it significantly
> reduced the fail rate but the issue is still there.
> USB_QUIRK_NO_LPM is used instead so no other parts are needed.

Oh, all right.  This change looks okay to me.  Has AceLan Kao tested 
it?

Alan Stern

