Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F634C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E51720747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ms+K8s9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgDVEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:39:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD287C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 21:39:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so972960otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt4/ztWQX7l3/GFDSwRI0poYgzm8SApTLy1yRylnRrs=;
        b=Ms+K8s9vGayQbGKsGM+C0KlnVreJYEoJ20U5iNjNm/pJucpJBic9v36obxdfUBciLA
         ij2T0w5B4mNyNS0l/hGwWJFjaX5tTmTECf6wyGMqx5745jjfS3J6sfD6vrcudcQVTLYP
         32Q2FzjYwTgkblmo7757zGdwtrYB2ekI+RsaCSVYJ5yWakE0SOK6KMCtYXOuNdZKngxg
         eH7ec0eE1Wzal6T22mDAzOsWdOLgxW2uP6xVVXsKIwUcKpzBv3pn5qF0nKXUYZUmrkxQ
         3ScQ01RZ1m8L5TSEKzhY46zTQUSn7rGwhOaq/1DC/xmOUnp7rY4j4ocpVzbsWpKbYSjG
         ANsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt4/ztWQX7l3/GFDSwRI0poYgzm8SApTLy1yRylnRrs=;
        b=sCZxc26aabRsP9MiV4loecO9dJcpAZE5Npv+CMmuizU3k/2hgXMaaecXcCnVESY3P4
         /YjpO6DPAk26OkQWVMJD6vFaQ/YZ6xjDZNX5+TIUIGGazV0WiEKWdrOvJlYCUaZjObo7
         S6mT8rBAYpUs15UAbv2ZmEz0GT4gvPNrl1InLRk+zMDoLM61JjdNaGEYpCC33zsDZ17t
         vDO/ukaOuFxsScotoaaWUrDWaQgMG468m5ZCRz231OExwV2DdlievmpGnxLwIxr4CFRb
         KOS9Hc1ZrlGuw64e0Prs4RW9xhzJYD8JafAx8uRS5c66rhnhluhbEiQPzDHVDqMs4dVz
         Tk8w==
X-Gm-Message-State: AGi0PubkPbL4+qqFFk6SauspStnB7EOgjtE22CmkVNmtePxhDAFDcUT8
        WZX0KHYCWbOiGEN+xhUBnHx9a/g0H53wKd3XDdtK6A==
X-Google-Smtp-Source: APiQypIPvoiR+OVAY+4X9VXHWpz3nXyPotCS0e6nQSeSFBGmGlNCCmsSfv3M6ctyg8ejIf4mxu+roaQ+e6cU7xoGKgs=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr15429216otc.221.1587530339961;
 Tue, 21 Apr 2020 21:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
 <877dyfsv00.fsf@kernel.org>
In-Reply-To: <877dyfsv00.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 21 Apr 2020 21:38:47 -0700
Message-ID: <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
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

On Thu, Apr 16, 2020 at 1:19 AM Felipe Balbi <balbi@kernel.org> wrote:
> One thing I noticed is that we're missing a giveback on ep1out. Here's a
> working case:
>

Hey Felipe,
  So I found some time to dig around on this today and I started
trying to understand this issue that you've pointed out about missing
the giveback.

It seems part of the issue is we get to a point where we have some req
where pending_sgs is more than one.

We call dwc3_prepare_one_trb_sg() on it:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n1068

And we process the sg list incrementing req->num_queued_sgs for each one.

then later, dwc3_gadget_ep_cleanup_completed_request() is called on the request:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2522

We call dwc3_gadget_ep_reclaim_trb_sg()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n2470

Where we iterate over the req->sg, ideally decrementing
num_pending_sgs each time and return.

But back in dwc3_gadget_ep_cleanup_completed_request()  and there
we're hitting the:
  if (!dwc3_gadget_ep_request_completed(req) ||
      req->num_pending_sgs) {
case which causes us to skip the call to dwc3_gadget_giveback().

Looking as to why the num_pending_sgs is non zero, that's because in
dwc3_gadget_ep_reclaim_trb_sg we're hitting the case where the trb has
the DWC3_TRB_CTRL_HWO ctrl flag set, which breaks us out of the loop
early before we decrement num_pending_sgs.

For that trb, we're setting the HWO flag in __dwc3_prepare_one_trb()
(called from dwc3_prepare_one_trb_sg() back at the beginning):
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c?h=v5.7-rc2#n921

I added logic showing every time we set or clear that flag, and it
seems like we're always setting it but never clearing it. And often
that's not an issue as we only have one sg entry. But if its set on a
trb in a request with multiple sgs, that's where it seems to be
causing the issue.

I'll continue to dig around to try to understand where it might be
going awry (why we never clear the HWO flag). But figured I'd try to
explain this much in case it rings any bells to you.



> One interesting thing is that TRB addresses are "odd". I can't find a
> proper lifetime for these TRBs. Do you have IOMMU enabled? Can you run
> without it? For example, nowhere in the log can I find the place where
> trb 0000000092deef41 was first enqueue. I'm assuming the log to be
> ordered, which means that trb is the same as 00000000f3db4076. But why
> are the addresses different?
>
> Another weird thing is that even though we CHN bit being set in
> 0000000092deef41, we don't see where the second trb (the one its chained
> to) was prepared. It seems like it was *never* prepared, what gives?

I suspect these bits were due to the tracing happening after some
minor amount of initial adb traffic began at bootup? So the trace
isn't capturing all the events.

Let me know if that doesn't sound reasonable and I'll try to dig a bit
futher on those questions.

thanks
-john
