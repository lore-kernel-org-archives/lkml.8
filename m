Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053AF205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETNri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:47:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:14401 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:47:37 -0400
IronPort-SDR: 91FYcLaZWk5SZlRE7DgeiJHC3PuV5qj9lYAePcjlkZE0zZdIfTCUVH+QtAs9v9s1zsYDrljOoK
 TjB8Z9oCxWMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 06:47:36 -0700
IronPort-SDR: YVqKstJZAo/sdpxfBobGZ7tUK7GvIPb/f6rblNQ4LPlm9okxiPxYULhbLXjEVTksEqYmC26gIT
 baFrOHQQvwhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="466390121"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 06:47:32 -0700
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
To:     Rik van Riel <riel@surriel.com>,
        linux-usb <linux-usb@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <296d1b03-fbc3-6107-950e-00d38633ea1f@linux.intel.com>
Date:   Wed, 20 May 2020 16:50:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.5.2020 14.26, Rik van Riel wrote:
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

Note that isoch endpoints should generate buffer overrun instead of
babble detect error on TD babble conditions. 
See xHCI spec 6.4.5 additional note 115.

Or maybe a frame babble could halt an isoc endpoint, see xhci 4.10.2.4.1
but then you should see a port error and port going to disabled state.

Any logs of this?

mount -t debugfs none /sys/kernel/debug
echo 'module xhci_hcd =p' >/sys/kernel/debug/dynamic_debug/control
echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
< trigger the issue >
Send output of dmesg
Send content of /sys/kernel/debug/tracing/trace

> 
> However, the USB sound driver seems to have no idea that this
> error happened. The function retire_capture_urb looks at the
> status of each isochronous frame, but seems to be under the
> assumption that the sound device just keeps on running.
> 
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
> stopped device. Looking at the call trace usb_submit_urb ->
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
> - should snd_complete_urb do something with these
>   errors, too, in case they happen on the sync frames
>   and not the data frames?
> - does the XHCI code need to ring the doorbell when
>   submitting an URB to a stopped device, or is it
>   always up to the higher-level driver to fully reset
>   the device before it can do anything useful?

xhci driver should ring the doorbell.

xhci_queue_isoc_tx()
  giveback_first_trb()
    xhci_ring_ep_doorbell()

when we are talking about babble or transaction errors the device might be
completely unaware of the situation. Device side of the endpoint is not necessarily halted.
xHC host will only halt its internal endpoint state, and it needs a reset
endopoint command from the xhci driver to clear the internal halt state. 

-Mathias

> - if a device in stopped state does not do anything
>   useful, should usb_submit_urb return an error?
> - how should the USB sound driver recover from these
>   occasional and/or one-off errors? stop the sound
>   stream, or try to reinitialize the device and start
>   recording again?
> 
> I am willing to write patches and can test with my
> setup, but both the sound code and the USB code are
> new to me so I would like to know what direction I
> should go in :)
> 

