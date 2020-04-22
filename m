Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BAC38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C616120747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPFKKrsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVFJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 01:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDVFJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 01:09:39 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621FFC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 22:09:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b13so1066765oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 22:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5LJs8OCYtoiaa1WpPfPHy0Im1CBN5FUEi59T95x5pc=;
        b=QPFKKrsN5XoPK/cGxa3UYGDE8OE2TIzoh66phZcNzO+yLmQwwff5EqxUWG4CZlJePr
         /MtEV6Hf/4M6GfONyptmEln7jog97FZntgfVQ7zViC8d38bVtKmLOJ9gLVmMg28E/gfB
         bwEk+1Ctv0qmsJcsArUEPaDUk4M5cACjJbV2XExu6w/kxk43rKaxQEyT0U207E3VGskj
         nUKkS9PVowVv3cMjj9ujA6guMioD/Ulyq/TAQW5zDFEgKYukQih3QCsWm6BNT6IaBPXt
         3Gt8txN9wxxI7+rRCLVdoCBFFrZIp45qo2Oa4N6y/Nh2KQIEDZ4tzwuss7R3cpY9uRXA
         hWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5LJs8OCYtoiaa1WpPfPHy0Im1CBN5FUEi59T95x5pc=;
        b=MnyzX/i54/sI9nIyfSsQ+rT+rGeWoc7ds/p9hPGlfScjQXgspI40BwwfZviKdjHR32
         ykQws3Tw+ZBrfLdNamcjX8ebs4AaC+zCtF1w6igcPRkaHTOlvjg04jXTcXIXXlVQXBGw
         4znn2mQ2HIhN083QHArLvckZo60AywQsOCv2SjE2tYFo8IZ2YmPnxIwT1a9qjMhO4R/9
         LqbkYkVdmjsJPMSbtl9HvLI4J3/1eKz/JP3xHgtIZsqYApub2QB+8CDAsgaUTOC5Etdu
         c5BJ4kj+Cjg4sYv9l3dPkKC9Tn8bZpsclXO/hZ7Fw4hjrUXwo15VRDqt9wLKquGyrhjQ
         sB4g==
X-Gm-Message-State: AGi0PuYFwR0TMWM0pYbZMKHNdLZM7tKtGtlbN//doKqScyEatJP9SbKK
        3hq1rnV03Ni87oQg5YOUXddqn2KhZ7XYdmk+3dJpKQ==
X-Google-Smtp-Source: APiQypLydPr6JvsK2/NbSFiLQXuQvJ5NYLXM2YJSn85HubMHn3f0qcFO5pPoewrLCssR788jtB1qnOIs4T5PbyPsNfI=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr15530511otb.352.1587532178717;
 Tue, 21 Apr 2020 22:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
 <877dyfsv00.fsf@kernel.org> <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
In-Reply-To: <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 21 Apr 2020 22:09:27 -0700
Message-ID: <CALAqxLWEdHrsU+efgsp2EHsgNGA8n7SE16XNnZHcfXjdM4v-WQ@mail.gmail.com>
Subject: Re: More dwc3 gadget issues with adb
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Josh Gao <jmgao@google.com>, YongQin Liu <yongqin.liu@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 9:38 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Apr 16, 2020 at 1:19 AM Felipe Balbi <balbi@kernel.org> wrote:
> > One thing I noticed is that we're missing a giveback on ep1out. Here's a
> > working case:
> >
>
> Hey Felipe,
>   So I found some time to dig around on this today and I started
> trying to understand this issue that you've pointed out about missing
> the giveback.
>
> It seems part of the issue is we get to a point where we have some req
> where pending_sgs is more than one.
>
> We call dwc3_prepare_one_trb_sg() on it:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n1068
>
> And we process the sg list incrementing req->num_queued_sgs for each one.
>
> then later, dwc3_gadget_ep_cleanup_completed_request() is called on the request:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2522
>
> We call dwc3_gadget_ep_reclaim_trb_sg()
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2470
>
> Where we iterate over the req->sg, ideally decrementing
> num_pending_sgs each time and return.
>
> But back in dwc3_gadget_ep_cleanup_completed_request()  and there
> we're hitting the:
>   if (!dwc3_gadget_ep_request_completed(req) ||
>       req->num_pending_sgs) {
> case which causes us to skip the call to dwc3_gadget_giveback().
>
> Looking as to why the num_pending_sgs is non zero, that's because in
> dwc3_gadget_ep_reclaim_trb_sg we're hitting the case where the trb has
> the DWC3_TRB_CTRL_HWO ctrl flag set, which breaks us out of the loop
> early before we decrement num_pending_sgs.
>
> For that trb, we're setting the HWO flag in __dwc3_prepare_one_trb()
> (called from dwc3_prepare_one_trb_sg() back at the beginning):
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n921
>
> I added logic showing every time we set or clear that flag, and it
> seems like we're always setting it but never clearing it. And often
> that's not an issue as we only have one sg entry. But if its set on a
> trb in a request with multiple sgs, that's where it seems to be
> causing the issue.
>
> I'll continue to dig around to try to understand where it might be
> going awry (why we never clear the HWO flag). But figured I'd try to
> explain this much in case it rings any bells to you.

I was looking some more at this and it seems a little odd...

In dwc3_gadget_ep_reclaim_trb_sg():
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2470

The check for (trb->ctrl & DWC3_TRB_CTRL_HWO) which breaks us out of
the loop happens before we call
dwc3_gadget_ep_reclaim_completed_trb():
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2406

Which is what clears the DWC3_TRB_CTRL_HWO flag (outside of
dwc3_gadget_ep_skip_trbs()).

So on a whim I dropped that check, and things go back to working on
HiKey960, no more adb stalls!

Does something like this make sense? It's not causing trouble on
db845c either so far in my testing.

thanks
-john

(sorry gmail will whitespace corrupt this code paste - just want to
communicate what I did clearly, not to apply)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4d3c79d90a6e..2a26d33520ce 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2457,9 +2457,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct
dwc3_ep *dep,
        for_each_sg(sg, s, pending, i) {
                trb = &dep->trb_pool[dep->trb_dequeue];

-               if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-                       break;
-
                req->sg = sg_next(s);
                req->num_pending_sgs--;
