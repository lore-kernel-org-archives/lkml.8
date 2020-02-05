Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B43C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C920720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YszJYyBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBEVEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:04:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40107 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBEVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:04:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so3355117otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhhrbRrU672kDfFvJ/EE5w3I5wNtcQx8aaM6dlL4Ong=;
        b=YszJYyBcS4DOYwixJ/e1RscrCZo6Yl869OtkWsZPh/TX7OxgmffJyik12Zbfsk9T4t
         Si/FvvYgIj+xeVHtf8JfJ6t0G0TptFr0d7IE3nfLEdtoL4nKP2PYNQeP/eN2NWXiqoYY
         ttgAEXvDYCfedt3To6+LFyxnEAsHbfam/9SvSP1Zi+Xrb0YtBNQKFJKosabsEMgy3ZDT
         AeJEsLiEXE6hOinKHlfBxXtXhg22JBKGJGycc3HbrQkpr1rLXoZjVFI9ecy64YvI6yEE
         DMTHYH78o6h4YKj7mmrx3GgA0YfjmIgJyUnyYzETcJTVkGOUiaGTkQtl8FIJoa6c2URd
         GK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhhrbRrU672kDfFvJ/EE5w3I5wNtcQx8aaM6dlL4Ong=;
        b=n6dH52hX7dRnwq/lwamnGt7yvbTXQjp5tEPS30og3q9oWukcIpVKdZ1ImK4mWz2k3+
         gembLe5wZ4nLrNNegc1FxsHOjNot49AGvbF17jAv+Fb+IFDt+UFBZXsJ/oL8iR1imHdZ
         Tf2fFJDsUOGrDbsjtD6co3NGujPc76S6BQCO2rwjUhxJ+3My/0fzcfXLMeHpcqkNO9Np
         84BQVScBAt7F83JL+PxwtiFTLDv9mKhs2yhw38bdOBk10sb2QRLrFBupcCrY4RjiNVdU
         WI6x7NOMlargwfAuodgiQdETEOV6mJKCk1uKZx5itFDErhe4FfYNKsoV5evaIpri5jmP
         SO9w==
X-Gm-Message-State: APjAAAU4///vgDp5EzjrAGWoappKgWzNsvBaXcAwWrbgljz6q7n1UU2Y
        yCbQHLAIwt9Is/xf3dmm6Jmvof7n34x1g+4HsVFjrw==
X-Google-Smtp-Source: APXvYqwEZgLTmny3kZxqipEZCRMaUGI2QI9rcoYlZUPDPd6XFWVDdfFX2KipP2EpgaU5XEPCIU7MbwfXtslZUoAGmwI=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr14936423otk.332.1580936642315;
 Wed, 05 Feb 2020 13:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122222645.38805-1-john.stultz@linaro.org>
 <ef64036f-7621-50d9-0e23-0f7141a40d7a@collabora.com> <02E7334B1630744CBDC55DA8586225837F9EE280@ORSMSX102.amr.corp.intel.com>
 <87o8uu3wqd.fsf@kernel.org> <02E7334B1630744CBDC55DA8586225837F9EE335@ORSMSX102.amr.corp.intel.com>
 <87lfpy3w1g.fsf@kernel.org>
In-Reply-To: <87lfpy3w1g.fsf@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 5 Feb 2020 13:03:51 -0800
Message-ID: <CALAqxLUQ0ciJTLrmEAu9WKCJHAbpY9szuVm=+VapN2QWWGnNjA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Avoiding DWC3 transfer stalls/hangs when using
 adb over f_fs
To:     Felipe Balbi <balbi@kernel.org>
Cc:     "Yang, Fei" <fei.yang@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 9:46 AM Felipe Balbi <balbi@kernel.org> wrote:
> >>>>>
> >>>>> Since ~4.20, when the functionfs gadget enabled scatter-gather
> >>>>> support, we have seen problems with adb connections stalling and
> >>>>> stopping to function on hardware with dwc3 usb controllers.
> >>>>> Specifically, HiKey960, Dragonboard 845c, and Pixel3 devices.
...
> >>
> >> I'm pretty sure this should be solved at the DMA API level, just want to confirm.
> >
> > I have sent you the tracepoints long time ago. Also my analysis of the
> > problem (BTW, I don't think the tracepoints helped much). It's
> > basically a logic problem in function dwc3_gadget_ep_reclaim_trb_sg().
>
> AFAICT, this is caused by DMA API merging pages together when map an
> sglist for DMA. While doing that, it does *not* move the SG_END flag
> which sg_is_last() checks.
>
> I consider that an overlook on the DMA API, wouldn't you? Why should DMA
> API users care if pages were merged or not while mapping the sglist? We
> have for_each_sg() and sg_is_last() for a reason.
>

From an initial look, I agree this is pretty confusing.   dma_map_sg()
can coalesce entries in the sg list, modifying the sg entires
themselves, however, in doing so it doesn't modify the number of
entries in the sglist (nor the end state bit).  That's pretty subtle!

My initial naive attempt to fix the dma-iommu path to set the end bit
at the tail of __finalize_sg() which does the sg entry modifications,
only caused trouble elsewhere, as there's plenty of logic that expects
the number of entries to not change, so having sg_next() return NULL
before that point results in lots of null pointer traversals.

Further, looking at the history, while apparently quirky, this has
been the documented behavior in DMA-API.txt for over almost 14 years
(at least).  It clearly states that that dma_map_api can return fewer
mapped entries then sg entries, and one should loop only that many
times (for_each_sg() having a max number of entries to iterate over
seems specifically for this purpose).  Additionally, it says one must
preserve the original number of entries (not # mapped entries) for
dma_unmap_sg().

So I'm not sure that sg_is_last() is really valid for iterating on
mapped sg lists.

Should it be? Probably (at least with my unfamiliar eyes), but
sg_is_last() has been around for almost as long coexisting with this
behavioral quirk, so I'm also not sure this is the best hill for the
dwc3 driver to die on. :)

The fix here:
  https://lore.kernel.org/lkml/20200122222645.38805-3-john.stultz@linaro.org/
Or maybe the slightly cleaner varient here:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=61a5816aa71ec719e77df9f2260dbbf6bcec7c99
seems like it would correctly address things following the
documentation and avoid the failures we're seeing.

As to if dma_map_sg() should fixup the state bits or properly shrink
the sg list when it coalesces entries, that seems like it would be a
much more intrusive change across quite a bit of the kernel that was
written to follow the documented method. So my confidence that such a
change would make it upstream in a reasonable amount of time isn't
very high, and it seems like a bad idea to block the driver from
working properly in the meantime.

Pulling in Christoph and Jens as I suspect they have more context on
this, and maybe can explain thats its not so quirky with the right
perspective?

Thoughts? Maybe there is an easier way to make it less quirky then
what I imagine?

thanks
-john
