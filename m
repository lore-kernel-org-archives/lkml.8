Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2CC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA06E21924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPEwmfL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392895AbgDPSAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727794AbgDPSAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:00:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B9C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:00:41 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q204so17289096oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9ZAMBg2vdwwpLVEuXAoTECtGhzfLx2qbHDWEvpNchU=;
        b=NPEwmfL1JMCaTWWUANGSj2blrmx0ViBkc2hFfZ8v1wD3cY1ONyJZ9azbaKuMfgAuDQ
         OtFdmHtsN74vHXcQMqt7tHIWcKFlXTbYBee4wUljV7x6bhuLjlcTzFeyXEHX1m5OkFcF
         Xd+a4RbYgyXuJ5cvk8ovXnZ1LoBpSaqvQ1DRdSfmYyDm2iPwutt2TITfXq2AsKLox+6y
         VVqKVjzsd89zTfGXqcutLPuvFX0Wsi4j9r+2ueSHqSnTOEBygbm6zHrKP1OKvLPobhzz
         1LSxDSQ2KVLF3el3/35KhJpjMhkU/40OBDq1/CPTAFLx5l0Jj18r6OIgunIOt3zInuBR
         OC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9ZAMBg2vdwwpLVEuXAoTECtGhzfLx2qbHDWEvpNchU=;
        b=lQqmoO0lt8HjcZM99Jc0ED5750Mnp/ZMzDRBYwrPvQY6Sj3MlpeTCSVBwTrEp9BJp7
         zNMPnRGlxIy5EVfxjijQ6UU1X8+JeKj1e2cvfFB2dc1FFqzyuvUDVZsR+1tPB8IozmgT
         F8+2+/fnEZda8vGPDam3aA71U6NNa8c1MkK52ObO7PapNDktEfPBxTnYLbjVHD2lxmgg
         Yjvfjf/NQ4HfKv9KMuA8hR2Yf2arpzDTEA+aQCmhuA+U/WClNTIc1j8QtaUOisbELGQx
         wbEdHwDD6U0BCn5k079LncPMnclaLrKUADXBLS29cP8Zqm0GA8QPMUjonyOL+qFytM7E
         DRCA==
X-Gm-Message-State: AGi0PuZdQeg3gzSs1evIlTdPNsd4k6c736rD514FP8HAgoRODy6BxTAD
        ADiK1waT1FI+QxI3RXz+zqtXCoc/xBDifwJfjsmZDA==
X-Google-Smtp-Source: APiQypIvdvp3OpPC+cD9y4/s6lTdKgfKrnT/fij55o0gBawWaBLry3JTHCVTYtJx71t0YCUq8QFFL7/5GxjkOVfCHxc=
X-Received: by 2002:aca:c311:: with SMTP id t17mr3523165oif.169.1587060039256;
 Thu, 16 Apr 2020 11:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
 <877dyfsv00.fsf@kernel.org>
In-Reply-To: <877dyfsv00.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Apr 2020 11:00:29 -0700
Message-ID: <CALAqxLUgQHLf4C=+0f4T_WfKct10nS=4SJJsW4Q0S9T9tT=Qzw@mail.gmail.com>
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
> John Stultz <john.stultz@linaro.org> writes:
> > Hey Felipe,
> >   Last week or so, a change[1] in AOSP to adbd seemingly uncovered
> > another issue with dwc3 gadget scatter-gather support on HiKey960.
> >
> > Interestingly it doesn't seem to affect the Dragonboard 845c, which
> > uses the same dwc3 driver and has had its own issues in the past.
> >
> > The behavior is the same as we saw last time around with both devices.
> > After booting the device, running "adb logcat -d" (or really any adb
> > command that transfers more than a trivial amount of data) on the host
> > will result in the adb output seeming to stall. Any further adb
> > invocations to the device will hang indefinitely.
> >
> > I've captured trace events for before the change (works), after the
> > change (broken), and after the change with the sg_enabled flag turned
> > off (which works around the problem).
> >
> > Let me know if there is anything else useful for me to share.
>
> First the obvious questions: Which kernel version is this?

Apologies. v5.7-rc1, though the same behavior was seen with v5.6 and
v5.4 kernels.

>  What does
> "before" and "after" refer to in our traces?

Before and after the userland changes to adb were made.


> What are first working and
> first failing versions? Can you run git bisect?

It's not directly a kernel regression. But it seems like an uncovered
issue by changes in userland.


> One thing I noticed is that we're missing a giveback on ep1out. Here's a
> working case:
>
>    UsbFfs-worker-580   [002] d..1    66.704886: dwc3_alloc_request: ep1out: req 0000000011c55648 length 0/0 zsI ==> 0
>    UsbFfs-worker-580   [002] d..2    66.704889: dwc3_ep_queue: ep1out: req 0000000011c55648 length 0/16384 zsI ==> -115
>    UsbFfs-worker-580   [002] d..2    66.704892: dwc3_prepare_trb: ep1out: trb 000000003559c11c (E27:D7) buf 000000008843b000 size 16384 ctrl 00000819 (HlcS:sC:normal)
>    UsbFfs-worker-580   [002] d..2    66.704897: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705053: dwc3_event: event (00006084): ep1out: Transfer In Progress [0] (SIm)
>      irq/65-dwc3-522   [000] d..1    66.705054: dwc3_complete_trb: ep1out: trb 000000008c350fb3 (E27:D8) buf 0000000089d6b000 size 16360 ctrl 00000818 (hlcS:sC:normal)
>      irq/65-dwc3-522   [000] d..1    66.705058: dwc3_gadget_giveback: ep1out: req 0000000001b9ed3f length 24/16384 zsI ==> 0
>    kworker/u16:2-260   [001] ....    66.705097: dwc3_free_request: ep1out: req 0000000001b9ed3f length 24/16384 zsI ==> 0
>
> and the failure point:
>
>    UsbFfs-worker-580   [002] d..1    66.705129: dwc3_alloc_request: ep1out: req 0000000067a34de4 length 0/0 zsI ==> 0
>    UsbFfs-worker-580   [002] d..2    66.705131: dwc3_ep_queue: ep1out: req 0000000067a34de4 length 0/16384 zsI ==> -115
>    UsbFfs-worker-580   [002] d..2    66.705134: dwc3_prepare_trb: ep1out: trb 00000000f3db4076 (E28:D8) buf 000000008843f000 size 16384 ctrl 00000819 (HlcS:sC:normal)
>    UsbFfs-worker-580   [002] d..2    66.705141: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705309: dwc3_event: event (00006084): ep1out: Transfer In Progress [0] (SIm)
>      irq/65-dwc3-522   [000] d..1    66.705310: dwc3_complete_trb: ep1out: trb 0000000092deef41 (E28:D9) buf 00000000ba8f1000 size 4072 ctrl 0000001c (hlCS:sc:normal)
>      irq/65-dwc3-522   [000] d..1    66.705318: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705323: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705329: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705334: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705339: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705344: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705349: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>      irq/65-dwc3-522   [000] d..1    66.705354: dwc3_gadget_ep_cmd: ep1out: cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status: Successful
>
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

I'll try to take a deeper look at these points and get back to you. I
really appreciate your eyes on this!

Thanks for the feedback!
-john
