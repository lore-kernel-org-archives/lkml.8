Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtNJv9u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA1R4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:56:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46053 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1R4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:56:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so1279741oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZY7xaJn7n2xK8pyc24KAivSTBtQ7s0DFRl/UfjgiFDQ=;
        b=CtNJv9u6gdgcpEgO+F9AYTS+Y/zbse1lthV5QHgKUjesjrGCTPaCMLny7uJCmY3C3X
         wOMApwMDTaji20lnDHokBwKeHHspyli2JrF4qHiina6D2KkhhfcvvIIDgwi3JWHhQ9u4
         NdG3fdQHa2LGLGGV8/TGvZwCUd9m1WdD8QFAX2mX78OVSGgacCH5NuksHeyeKeqrTnsn
         zlnMHgESkru9PG5WE6QWNifpIMgKLTcCzxPjKAM9levONhdEkdvHIvA5IFGAWGUgsmTb
         waJDbzcFC5gSf1P0o4boXjpCOBQNSUwQ9kVgH2XG4N9a5204bzS9DFtCY5biZ+92h0Tb
         gwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZY7xaJn7n2xK8pyc24KAivSTBtQ7s0DFRl/UfjgiFDQ=;
        b=b+WIhl0OnGZhA6w/ZYLCJx4asymlVtqxfel/Pq+lXibRoIiw5/vbQWgO2x1CsmPPP4
         Yej4vFL8T5wFxOL2mphtcL8Y9n23wmKxl53reh4VnikewpiarhUO2WHxd7pqDR8gW6cq
         T+cMbensq+0F6EO3O3CLqXOHsMAPbKc5TSXV9YCozoKKrN6y58+PERnZDilqkd6zcV1h
         6kwknx53zXwp3v/GdYMuXs6EAP0dUPtvTmeQWCusJiUSnYkgKxEKDwXzjjPLsk0OtKrb
         SrnFdhg3sCZrD7Bh6qkpNNH1gYnfmUCbbnwCWWw1AMt9ZpjAurdCpMfPvbhy/PEsBaA7
         esRg==
X-Gm-Message-State: APjAAAV9DN4VHFxp61PRU5fUOtb0k9ivbANiwbOBvF//wQEu7i3jhKo3
        8fOzw+k0KAnDrZAhkVaHwEDyDgnnGRvZnORhSzHTqQ==
X-Google-Smtp-Source: APXvYqxCYyjifBuv/9egesfFRvxA48CiSpZTWog2nxs8Fpmz0MZ1X+yuH41tBlafJu/bslupZq7PRUe23zMfh1iGeEQ=
X-Received: by 2002:aca:c551:: with SMTP id v78mr3694137oif.161.1580234162434;
 Tue, 28 Jan 2020 09:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20200127193046.110258-1-john.stultz@linaro.org> <87sgjz90lt.fsf@kernel.org>
In-Reply-To: <87sgjz90lt.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 28 Jan 2020 09:55:50 -0800
Message-ID: <CALAqxLVH6znY-1QrVXdG7YTBd8RuBSm4tHDNqyR3wMERsfvh=Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 5:23 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> John Stultz <john.stultz@linaro.org> writes:
>
> > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >
> > The current code in dwc3_gadget_ep_reclaim_completed_trb() will
> > check for IOC/LST bit in the event->status and returns if
> > IOC/LST bit is set. This logic doesn't work if multiple TRBs
> > are queued per request and the IOC/LST bit is set on the last
> > TRB of that request.
> >
> > Consider an example where a queued request has multiple queued
> > TRBs and IOC/LST bit is set only for the last TRB. In this case,
> > the core generates XferComplete/XferInProgress events only for
> > the last TRB (since IOC/LST are set only for the last TRB). As
> > per the logic in dwc3_gadget_ep_reclaim_completed_trb()
> > event->status is checked for IOC/LST bit and returns on the
> > first TRB. This leaves the remaining TRBs left unhandled.
> >
> > Similarly, if the gadget function enqueues an unaligned request
> > with sglist already in it, it should fail the same way, since we
> > will append another TRB to something that already uses more than
> > one TRB.
> >
> > To aviod this, this patch changes the code to check for IOC/LST
> > bits in TRB->ctrl instead.
> >
> > At a practical level, this patch resolves USB transfer stalls seen
> > with adb on dwc3 based HiKey960 after functionfs gadget added
> > scatter-gather support around v4.20.
> >
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Yang Fei <fei.yang@intel.com>
> > Cc: Thinh Nguyen <thinhn@synopsys.com>
> > Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> > Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > Cc: Jack Pham <jackp@codeaurora.org>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Linux USB List <linux-usb@vger.kernel.org>
> > Cc: stable <stable@vger.kernel.org>
> > Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
> > Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
> > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > [jstultz: forward ported to mainline, reworded commit log, reworked
> >  to only check trb->ctrl as suggested by Felipe]
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Rework to only check trb->ctrl as suggested by Felipe
> > * Reword the commit message to include more of Felipe's assessment
> > ---
> >  drivers/usb/dwc3/gadget.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 154f3f3e8cff..9a085eee1ae3 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2420,7 +2420,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
> >       if (event->status & DEPEVT_STATUS_SHORT && !chain)
> >               return 1;
> >
> > -     if (event->status & DEPEVT_STATUS_IOC)
> > +     if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
> > +         (trb->ctrl & DWC3_TRB_CTRL_LST))
>
> why the LST bit here? It wasn't there before. In fact, we never set LST
> in dwc3 anymore :-)

So, it was in the patch before, just on separate lines:
  https://lore.kernel.org/lkml/20200122222645.38805-2-john.stultz@linaro.org/

- if (event->status & DEPEVT_STATUS_IOC)
+ if ((event->status & DEPEVT_STATUS_IOC) &&
+    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+ return 1;
+
+ if ((event->status & DEPEVT_STATUS_LST) &&
+    (trb->ctrl & DWC3_TRB_CTRL_LST))
  return 1;

So I just merged the two checks into one line. But I'm ok to drop the
CTRL_LST check if that really isn't used.  Let me know and I'll rework
and resend.

thanks
-john
