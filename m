Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E2F2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgETQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:38:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48387 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726545AbgETQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:38:41 -0400
Received: (qmail 12889 invoked by uid 1000); 20 May 2020 12:38:40 -0400
Date:   Wed, 20 May 2020 12:38:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
Message-ID: <20200520163840.GA11084@rowland.harvard.edu>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:26:57AM -0400, Rik van Riel wrote:
> After a few more weeks of digging, I have come to the tentative
> conclusion that either the XHCI driver, or the USB sound driver,
> or both, fail to handle USB errors correctly.
> 
> I have some questions at the bottom, after a (brief-ish) explanation
> of exactly what seems to go wrong.
> 
> TL;DR: arecord from a misbehaving device can hang forever
> after a USB error, due to poll on /dev/snd/timer never returning.
> 
> The details: under some mysterious circumstances, the PCM290x
> family sound chips can send more data than expected during an
> isochronous transfer, leading to a babble error. Those

Do these chips connect as USB-3 devices or as USB-2?  (I wouldn't expect 
an audio device to use USB-3; it shouldn't need the higher bandwidth.)

> circumstances seem to in part depend on the USB host controller
> and/or the electrical environment, since the chips work just
> fine for most people.
> 
> Receiving data past the end of the isochronous transfer window
> scheduled for a device results in the XHCI controller throwing
> a babble error, which moves the endpoint into halted state.
> 
> This is followed by the host controller software sending a
> reset endpoint command, and moving the endpoint into stopped
> state, as specified on pages 164-165 of the XHCI specification.

In general, errors such as babble are not supposed to stop isochronous 
endpoints.

> However, the USB sound driver seems to have no idea that this
> error happened. The function retire_capture_urb looks at the
> status of each isochronous frame, but seems to be under the
> assumption that the sound device just keeps on running.

This is appropriate, for the reason mentioned above.

> The function snd_complete_urb seems to only detect that the
> device is not running if usb_submit_urb returns a failure.
> 
>         err = usb_submit_urb(urb, GFP_ATOMIC);
>         if (err == 0)
>                 return;
> 
>         usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
> 
>         if (ep->data_subs && ep->data_subs->pcm_substream) {
>                 substream = ep->data_subs->pcm_substream;
>                 snd_pcm_stop_xrun(substream);
>         }
> 
> However, the XHCI driver will happily submit an URB to a
> stopped device.

Do you mean "stopped device" or "stopped endpoint"?

>  Looking at the call trace usb_submit_urb ->
> xhci_urb_enqueue -> xhci_queue_isoc_tx_prepare -> prepare_ring,
> you can see this code:
> 
>         /* Make sure the endpoint has been added to xHC schedule */
>         switch (ep_state) {
> ...
>         case EP_STATE_HALTED:
>                 xhci_dbg(xhci, "WARN halted endpoint, queueing URB anyway.\n");
>         case EP_STATE_STOPPED:
>         case EP_STATE_RUNNING:
>                 break;
> 
> This leads me to a few questions:
> - should retire_capture_urb call snd_pcm_stop_xrun,
>   or another function like it, if it sees certain
>   errors in the iso frame in the URB?

No.  Isochronous endpoints are expected to encounter errors from time to 
time; that is the nature of isochronous communications.  You're supposed 
to ignore the errors (skip over any bad data) and keep going.

> - should snd_complete_urb do something with these
>   errors, too, in case they happen on the sync frames
>   and not the data frames?
> - does the XHCI code need to ring the doorbell when
>   submitting an URB to a stopped device, or is it
>   always up to the higher-level driver to fully reset
>   the device before it can do anything useful?

In this case it is not up to the higher-level driver.

> - if a device in stopped state does not do anything
>   useful, should usb_submit_urb return an error?

The notion of "stopped state" is not part of USB-2.  As a result, it 
should be handled entirely within the xhci-hcd driver.

(A non-isochronous endpoint can be in the "halted" state.  But obviously 
this isn't what you're talking about.)

> - how should the USB sound driver recover from these
>   occasional and/or one-off errors? stop the sound
>   stream, or try to reinitialize the device and start
>   recording again?

As far as I know, it should do its best to continue (perhaps fill in 
missing data with zeros).

Alan Stern

> I am willing to write patches and can test with my
> setup, but both the sound code and the USB code are
> new to me so I would like to know what direction I
> should go in :)
