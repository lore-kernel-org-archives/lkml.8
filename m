Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58350C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCBE20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MHIkv1YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDXWtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:49:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17757 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgDXWtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:49:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768546; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FU5XkGQPbB1A0pLWx0Yc91zreZZRuFBUjh0H32lUTWI=; b=MHIkv1YGqIlog9ptzjNdlt4tafMdbO76n2s6dzxLm7Vd9/+lHLuEq7AW50m+NeuiRzYc5GfA
 wPwcsxAxkiKLaZXM8qHFm/SowCt/nkgAmt+avMUzMByXAXPAqOfArP1AbI0qREnMr1o7fhHI
 6vS0667PO68d3lm1O22cQ+JY5bo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36cd0.7fa74d5c8730-smtp-out-n02;
 Fri, 24 Apr 2020 22:48:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC946C4478C; Fri, 24 Apr 2020 22:48:46 +0000 (UTC)
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39E0EC433D2;
        Fri, 24 Apr 2020 22:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39E0EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Fri, 24 Apr 2020 15:48:43 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Josh Gao <jmgao@google.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: More dwc3 gadget issues with adb
Message-ID: <20200424224843.GB20167@jackp-linux.qualcomm.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
 <877dyfsv00.fsf@kernel.org>
 <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
 <CALAqxLWEdHrsU+efgsp2EHsgNGA8n7SE16XNnZHcfXjdM4v-WQ@mail.gmail.com>
 <20200424171247.GA20167@jackp-linux.qualcomm.com>
 <CALAqxLUkg8gqY6kN1D=NbpgLDd_yMdvxOJCksrmXw0v8McHodw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUkg8gqY6kN1D=NbpgLDd_yMdvxOJCksrmXw0v8McHodw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Apr 24, 2020 at 11:36:24AM -0700, John Stultz wrote:
> On Fri, Apr 24, 2020 at 10:12 AM Jack Pham <jackp@codeaurora.org> wrote:
> > On Tue, Apr 21, 2020 at 10:09:27PM -0700, John Stultz wrote:
> > > Does something like this make sense? It's not causing trouble on
> > > db845c either so far in my testing.
> >
> > Ok I'll bite...
> >
> > I'm now curious why it hasn't been a problem with the Qualcomm HW. Do
> > you mind please capturing a similar trace log on the db845c?  Would be
> > good to see a side-by-side comparison and see if, first of all, whether
> > the same S/G path is getting exercised (i.e. 16KiB OUT requests from ADB
> > userspace using AIO which then get broken up into 4K chunks by f_fs),
> > and what the behaviors of the reclaim_trb and giveback are when the
> > transfer is completed.
> >
> > Preferably if you could get a trace without your patch applied that
> > would be great. And maybe also one after your patch just to see if the
> > traces are truly identical or not.
> 
> Sure. I've captured logs in the same manner with and without on db845c
> (against 5.7-rc2). See attached.

Thank you!
 
> I suspect the difference is the db845c is using an iommu (I don't
> think it will boot without it) where hikey960 isn't, but I'll let you
> take a look.

Yes I think that's exactly what's happening. Those 16KiB requests on
ep1out would normally be passed as 4x4KiB sglists from f_fs.c but after
the call to usb_gadget_map_request() the IOMMU is coalescing them back
into a single entry, so for each of those requests we end up preparing
just a single unchained TRB.

   UsbFfs-worker-532   [007] d..1    96.025897: dwc3_alloc_request: ep1out: req 0000000075c0b6d7 length 0/0 zsI ==> 0
   UsbFfs-worker-532   [007] d..2    96.025898: dwc3_ep_queue: ep1out: req 0000000075c0b6d7 length 0/16384 zsI ==> -115
   UsbFfs-worker-532   [007] d..2    96.025908: dwc3_prepare_trb: ep1out: trb 00000000c0c9cf9f (E217:D209) buf 00000000ff930000 size 16384 ctrl 00000819 (HlcS:sC:normal)
                                                                              ^^^^^^^^^^^^^^^^
-> trb c0c9cf9f enqueued at position 216 in the ring (enqueue pointer 217)
We can see the pointer to the DMA address and it's 16KiB, and the chain
bit is off.

   UsbFfs-worker-532   [007] d..2    96.025912: dwc3_readl: addr 00000000ab36a89f value 00002400
   UsbFfs-worker-532   [007] d..2    96.025915: dwc3_writel: addr 00000000057ac193 value 00000000
   UsbFfs-worker-532   [007] d..2    96.025917: dwc3_writel: addr 000000009c937859 value 00000000
   UsbFfs-worker-532   [007] d..2    96.025919: dwc3_writel: addr 00000000a91887be value 00000000
   UsbFfs-worker-532   [007] d..2    96.025922: dwc3_writel: addr 00000000679c8ad6 value 00020007
   UsbFfs-worker-532   [007] d..2    96.025924: dwc3_readl: addr 00000000679c8ad6 value 00020007
   UsbFfs-worker-532   [007] d..2    96.025925: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful

...

    irq/142-dwc3-529   [000] d..1    96.027952: dwc3_event: event (00006084): ep1out: Transfer In Progress [0] (SIm)
    irq/142-dwc3-529   [000] d..1    96.027955: dwc3_complete_trb: ep1out: trb 00000000c0c9cf9f (E224:D217) buf 00000000ff930000 size 16360 ctrl 00000818 (hlcS:sC:normal)
                                                                               ^^^^^^^^^^^^^^^^
    irq/142-dwc3-529   [000] d..1    96.027965: dwc3_gadget_giveback: ep1out: req 0000000075c0b6d7 length 24/16384 zsI ==> 0

That same trb c0c9cf9f is completed, 24 (16384 - 16360) bytes were
transferred, and dwc3 gives back the request to the function driver.
TRB dequeue pointer advanced by one to position 217.

    irq/142-dwc3-529   [000] d..1    96.027970: dwc3_readl: addr 0000000054b9cc02 value 80001000
    irq/142-dwc3-529   [000] d..1    96.027971: dwc3_writel: addr 0000000054b9cc02 value 00001000
    irq/142-dwc3-529   [000] d..1    96.027974: dwc3_writel: addr 00000000e4e556e6 value 80000000
    irq/142-dwc3-529   [000] d..1    96.027976: dwc3_writel: addr 000000001139226c value 00000001

So it's interesting that with IOMMU always enabled on the db845c we
don't hit the bug as we avoid preparing an SG/chained TRB list.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
