Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E1C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35C72071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="swVH/DQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgDXRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:12:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57443 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgDXRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:12:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587748373; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=DdFev81PpJ4OFYGieuBtmhlG31iK4G1naQBhU5oUxIE=; b=swVH/DQWRyEN2DJdD4DCURrWgDSM5bd8bXCC1AaslmdZscYoxPb9NOnuEkVLr6xvLPi7d228
 nn3SVL08mRk6JUCoRYYm2xhYpM4vp+XlqUHShbwZuiptD6kCZ/xZ6lywdhWhRTZlCIUbFtAY
 9b3FXccgPabtTmEj62GGNO3jpQ4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea31e15.7f3cfcb26ea0-smtp-out-n02;
 Fri, 24 Apr 2020 17:12:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E49D8C433CB; Fri, 24 Apr 2020 17:12:52 +0000 (UTC)
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F312AC433F2;
        Fri, 24 Apr 2020 17:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F312AC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Fri, 24 Apr 2020 10:12:47 -0700
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
Message-ID: <20200424171247.GA20167@jackp-linux.qualcomm.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
 <877dyfsv00.fsf@kernel.org>
 <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
 <CALAqxLWEdHrsU+efgsp2EHsgNGA8n7SE16XNnZHcfXjdM4v-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWEdHrsU+efgsp2EHsgNGA8n7SE16XNnZHcfXjdM4v-WQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey John,

On Tue, Apr 21, 2020 at 10:09:27PM -0700, John Stultz wrote:
> On Tue, Apr 21, 2020 at 9:38 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Thu, Apr 16, 2020 at 1:19 AM Felipe Balbi <balbi@kernel.org> wrote:
> > > One thing I noticed is that we're missing a giveback on ep1out. Here's a
> > > working case:
> > >
> >
> > Hey Felipe,
> >   So I found some time to dig around on this today and I started
> > trying to understand this issue that you've pointed out about missing
> > the giveback.
> >
> > It seems part of the issue is we get to a point where we have some req
> > where pending_sgs is more than one.
> >
> > We call dwc3_prepare_one_trb_sg() on it:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n1068
> >
> > And we process the sg list incrementing req->num_queued_sgs for each one.
> >
> > then later, dwc3_gadget_ep_cleanup_completed_request() is called on the request:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2522
> >
> > We call dwc3_gadget_ep_reclaim_trb_sg()
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2470
> >
> > Where we iterate over the req->sg, ideally decrementing
> > num_pending_sgs each time and return.
> >
> > But back in dwc3_gadget_ep_cleanup_completed_request()  and there
> > we're hitting the:
> >   if (!dwc3_gadget_ep_request_completed(req) ||
> >       req->num_pending_sgs) {
> > case which causes us to skip the call to dwc3_gadget_giveback().
> >
> > Looking as to why the num_pending_sgs is non zero, that's because in
> > dwc3_gadget_ep_reclaim_trb_sg we're hitting the case where the trb has
> > the DWC3_TRB_CTRL_HWO ctrl flag set, which breaks us out of the loop
> > early before we decrement num_pending_sgs.
> >
> > For that trb, we're setting the HWO flag in __dwc3_prepare_one_trb()
> > (called from dwc3_prepare_one_trb_sg() back at the beginning):
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n921
> >
> > I added logic showing every time we set or clear that flag, and it
> > seems like we're always setting it but never clearing it. And often
> > that's not an issue as we only have one sg entry. But if its set on a
> > trb in a request with multiple sgs, that's where it seems to be
> > causing the issue.
> >
> > I'll continue to dig around to try to understand where it might be
> > going awry (why we never clear the HWO flag). But figured I'd try to
> > explain this much in case it rings any bells to you.
> 
> I was looking some more at this and it seems a little odd...
> 
> In dwc3_gadget_ep_reclaim_trb_sg():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2470
> 
> The check for (trb->ctrl & DWC3_TRB_CTRL_HWO) which breaks us out of
> the loop happens before we call
> dwc3_gadget_ep_reclaim_completed_trb():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2406
> 
> Which is what clears the DWC3_TRB_CTRL_HWO flag (outside of
> dwc3_gadget_ep_skip_trbs()).
> 
> So on a whim I dropped that check, and things go back to working on
> HiKey960, no more adb stalls!
> 
> Does something like this make sense? It's not causing trouble on
> db845c either so far in my testing.

Ok I'll bite...

I'm now curious why it hasn't been a problem with the Qualcomm HW. Do
you mind please capturing a similar trace log on the db845c?  Would be
good to see a side-by-side comparison and see if, first of all, whether
the same S/G path is getting exercised (i.e. 16KiB OUT requests from ADB
userspace using AIO which then get broken up into 4K chunks by f_fs),
and what the behaviors of the reclaim_trb and giveback are when the
transfer is completed.

Preferably if you could get a trace without your patch applied that
would be great. And maybe also one after your patch just to see if the
traces are truly identical or not.

Thanks for digging into this!
Jack

> (sorry gmail will whitespace corrupt this code paste - just want to
> communicate what I did clearly, not to apply)
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4d3c79d90a6e..2a26d33520ce 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2457,9 +2457,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct
> dwc3_ep *dep,
>         for_each_sg(sg, s, pending, i) {
>                 trb = &dep->trb_pool[dep->trb_dequeue];
> 
> -               if (trb->ctrl & DWC3_TRB_CTRL_HWO)
> -                       break;
> -
>                 req->sg = sg_next(s);
>                 req->num_pending_sgs--;

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
