Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F064207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgETUeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:34:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49257 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726860AbgETUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:34:19 -0400
Received: (qmail 23997 invoked by uid 1000); 20 May 2020 16:34:17 -0400
Date:   Wed, 20 May 2020 16:34:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
Message-ID: <20200520203417.GA23602@rowland.harvard.edu>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
 <20200520163840.GA11084@rowland.harvard.edu>
 <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:21:44PM -0400, Rik van Riel wrote:
> On Wed, 2020-05-20 at 12:38 -0400, Alan Stern wrote:
> > On Wed, May 20, 2020 at 07:26:57AM -0400, Rik van Riel wrote:
> > > After a few more weeks of digging, I have come to the tentative
> > > conclusion that either the XHCI driver, or the USB sound driver,
> > > or both, fail to handle USB errors correctly.
> > > 
> > > I have some questions at the bottom, after a (brief-ish)
> > > explanation
> > > of exactly what seems to go wrong.
> > > 
> > > TL;DR: arecord from a misbehaving device can hang forever
> > > after a USB error, due to poll on /dev/snd/timer never returning.
> > > 
> > > The details: under some mysterious circumstances, the PCM290x
> > > family sound chips can send more data than expected during an
> > > isochronous transfer, leading to a babble error. Those
> > 
> > Do these chips connect as USB-3 devices or as USB-2?  (I wouldn't
> > expect 
> > an audio device to use USB-3; it shouldn't need the higher
> > bandwidth.)
> 
> USB-2

Okay.  In that case, xhci-hcd should appear to act just like a USB-2 
host controller.

> > In general, errors such as babble are not supposed to stop
> > isochronous 
> > endpoints.
> 
> However, it seems that they do. The urb never
> gets an answer after snd_complete_urb refiles
> it with usb_submit_urb.
> 
> > > However, the USB sound driver seems to have no idea that this
> > > error happened. The function retire_capture_urb looks at the
> > > status of each isochronous frame, but seems to be under the
> > > assumption that the sound device just keeps on running.
> > 
> > This is appropriate, for the reason mentioned above.
> 
> Having arecord get stuck forever does not seem like
> the right behavior, though :)

No, it isn't.

> > > This leads me to a few questions:
> > > - should retire_capture_urb call snd_pcm_stop_xrun,
> > >   or another function like it, if it sees certain
> > >   errors in the iso frame in the URB?
> > 
> > No.  Isochronous endpoints are expected to encounter errors from time
> > to 
> > time; that is the nature of isochronous communications.  You're
> > supposed 
> > to ignore the errors (skip over any bad data) and keep going.
> 
> ...
> 
> > The notion of "stopped state" is not part of USB-2.  As a result, it 
> > should be handled entirely within the xhci-hcd driver.
> 
> Interesting. That makes me really curious why things are
> getting stuck, now...

This could be a bug in xhci-hcd.  Perhaps the controller's endpoint 
state needs to be updated after one of these errors occurs.  Mathias 
will know all about that.

> > > - how should the USB sound driver recover from these
> > >   occasional and/or one-off errors? stop the sound
> > >   stream, or try to reinitialize the device and start
> > >   recording again?
> > 
> > As far as I know, it should do its best to continue (perhaps fill in 
> > missing data with zeros).
> 
> That was my first intuition as well, given the documented
> behavior of isochronous frames.
> 
> However, given that the device appears to stop sending
> frames after that error, at least usbmon is not seeing
> any, I am not sure what needs to happen in order to get
> that behavior.

The device won't send any data unless the host controller tells it to.  
If something is wrong with the host controller then usbmon won't see any 
data.

Alan Stern
