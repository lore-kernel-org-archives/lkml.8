Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81967C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A123208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgEAUKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:10:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35739 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726307AbgEAUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:10:04 -0400
Received: (qmail 2454 invoked by uid 500); 1 May 2020 16:10:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 May 2020 16:10:03 -0400
Date:   Fri, 1 May 2020 16:10:03 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Arnd Bergmann <arnd@arndb.de>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 08/15] usb: ehci: avoid gcc-10 zero-length-bounds warning
In-Reply-To: <CAK8P3a19DSnyvzSRCFr6fQGAMudQwhZY7Wy2yS6HL8y3TsfoLw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2005011609140.903-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020, Arnd Bergmann wrote:

> On Fri, May 1, 2020 at 4:42 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 30 Apr 2020, Arnd Bergmann wrote:
> 
> >
> > No, they don't.
> 
> > >       /* PORTSC: offset 0x44 */
> > > -     u32             port_status[0]; /* up to N_PORTS */
> > > +     union {
> > > +             u32             port_status[9]; /* up to N_PORTS */
> >
> > This array can have up to 15 elements, meaning that it can extend out
> > to offset 0x80.
> 
> Ok, thanks for the clarification!
> 
> > >  /* EHCI 1.1 addendum */
> > >  #define PORTSC_SUSPEND_STS_ACK 0
> > >  #define PORTSC_SUSPEND_STS_NYET 1
> > > @@ -165,7 +166,8 @@ struct ehci_regs {
> > >  #define PORT_CONNECT (1<<0)          /* device connected */
> > >  #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
> > >
> > > -     u32             reserved3[9];
> > > +             u32             reserved3[9];
> > > +     };
> > >
> > >       /* USBMODE: offset 0x68 */
> > >       u32             usbmode;        /* USB Device mode */
> >
> > As you see, this next field actually lies inside the preceding array.
> > It's not a real conflict; any hardware which supports the usbmode field
> > uses only the first element of the port_status array.
> >
> > I don't know how you want to handle this.  Doing
> >
> > #define usbmode port_status[9]
> >
> > doesn't seem like a very good approach, but I can't think of anything
> > better at the moment.  Maybe just set the array size to 9, as you did,
> > but with a comment explaining what's really going on.
> 
> The easiest change would be to use an anonymous struct like this
> 
>         /* PORTSC: offset 0x44 */
>         union {
>                 u32             port_status[15]; /* up to N_PORTS */
> /* EHCI 1.1 addendum */
> #define PORTSC_SUSPEND_STS_ACK 0
> ...
> #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
>                 struct {
>                         u32             reserved3[9];
> 
>         /* USBMODE: offset 0x68 */
>                         u32             usbmode;        /* USB Device mode */
> #define USBMODE_SDIS    (1<<3)          /* Stream disable */
> #define USBMODE_BE      (1<<2)          /* BE/LE endianness select */
> #define USBMODE_CM_HC   (3<<0)          /* host controller mode */
> #define USBMODE_CM_IDLE (0<<0)          /* idle state */
> 
>                         u32             reserved4[5];
>                 };
>         };
>         u32             reserved5;
> 
> It doesn't really improve readability, but it should correctly
> reflect the layout as you described it.

Sounds good.  Please go ahead and update the patch.

Alan Stern

