Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76EC38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2B2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587535215;
	bh=v4l0tBoIjZVNjnX6L6bW/i5KCSH23SG+V1JAum8Uf4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=HvhO4By6vO5D5DFvkQq5smKw77v71ksV9wXY81dq/aOaKjeVMeF8tQyJVHc+RxI+W
	 yWFOEqm+kzD/TDpfW6BUUg3i7kM1uRJ2ZTeN276MyI4NVOZYnEh+jsGncRm9bRdPoa
	 CoCMo9dm7fwnHOtyXXm16SufXJXItPqniTOQKrtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgDVGAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:00:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2499C03C1A6;
        Tue, 21 Apr 2020 23:00:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so929148lje.10;
        Tue, 21 Apr 2020 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8wMite28CxNe4/9pqzhlBHCV6MZvYc1qSikiSwQiv+s=;
        b=kSi3rXHlS6REIAYLmvE16izFWmtg2yznhkkNR+jSrAVpVpS/EDIHGhLV7jZhJe0uwj
         D7/88+sRDcsEBNGhyXmyNH+7YOCWBhx/eZzFeXUNzOGLdY6IC6qdHeEUkiJHlOB6Gwra
         GdTuZD7g3je95pfhEfx1JcxdpDXlcWltAR7Ee+ds+OMGi//Z4gcnAMaUhQJC1HGQaph7
         dEPq5w1vlN7W+VAW4vOb98KOV6oiPUI5JKqf73jjLGpAPNN2U3HEHrKKTljnzZpeXjWo
         gfPxpjk8DhvWwK0MARq5C1h19h5ndILYWjL9TztT1vktf2Lbes5U1vNWG0GL9xDquEdW
         uY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=8wMite28CxNe4/9pqzhlBHCV6MZvYc1qSikiSwQiv+s=;
        b=RZynelq8v5YKEAPU08MPlQxSajlD+cYdVP3zixvEBc+JUegc5/lDc9UlfhTLKRgtWo
         v+7H5x/9FMRxAaDe/SB1TxIrY09dAndDZ4kclvwTmfciSgZD+05KjkvubfPudKmW7wZT
         PQ47GfGYNc9zoFH5wCvOBRpEt6wmhPlMg0Q23O4d8010YCvrMTRrZ+LxoGoZDXQgGCMO
         1ONe4h3m63PjpaOFxBFwL1hGIxNeOZgUAHlnQf7v+e+NAi0A7l4HlP75ZMxw1mHbTgvX
         X8PlA2dtDkGl69cxZ15hqzkkahn1YKXFvtzmOH+J8S1rV1VO+BsLFfR4bt41/N8V35cB
         bqTA==
X-Gm-Message-State: AGi0PubTsgM3BK7Wq4hf0Q7BNuhSGrQCefXPL77Fg3CxepAlP1YDqPHi
        UN6iFGrqNJh0vQU+pDPwC/O+E6mo
X-Google-Smtp-Source: APiQypJBcznuyvynH9gk3++Kig9KC2Xf0zB76ONcidzmQDcyu8/CU3hAkN2qAlcVInW5F6eSQXLjXw==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr583425ljj.136.1587535210832;
        Tue, 21 Apr 2020 23:00:10 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id u21sm3397040ljo.61.2020.04.21.23.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 23:00:09 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
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
Subject: Re: More dwc3 gadget issues with adb
In-Reply-To: <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com> <877dyfsv00.fsf@kernel.org> <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com>
Date:   Wed, 22 Apr 2020 09:00:05 +0300
Message-ID: <87blnkcb6i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

John Stultz <john.stultz@linaro.org> writes:
> On Thu, Apr 16, 2020 at 1:19 AM Felipe Balbi <balbi@kernel.org> wrote:
>> One thing I noticed is that we're missing a giveback on ep1out. Here's a
>> working case:
>>
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n1068
>
> And we process the sg list incrementing req->num_queued_sgs for each one.
>
> then later, dwc3_gadget_ep_cleanup_completed_request() is called on the r=
equest:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2522
>
> We call dwc3_gadget_ep_reclaim_trb_sg()
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2470
>
> Where we iterate over the req->sg, ideally decrementing
> num_pending_sgs each time and return.
>
> But back in dwc3_gadget_ep_cleanup_completed_request()  and there
> we're hitting the:
>   if (!dwc3_gadget_ep_request_completed(req) ||
>       req->num_pending_sgs) {
> case which causes us to skip the call to dwc3_gadget_giveback().

This logic was modified recently. Can you check if today's linus/master
works for you?

> Looking as to why the num_pending_sgs is non zero, that's because in
> dwc3_gadget_ep_reclaim_trb_sg we're hitting the case where the trb has
> the DWC3_TRB_CTRL_HWO ctrl flag set, which breaks us out of the loop
> early before we decrement num_pending_sgs.
>
> For that trb, we're setting the HWO flag in __dwc3_prepare_one_trb()
> (called from dwc3_prepare_one_trb_sg() back at the beginning):
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n921
>
> I added logic showing every time we set or clear that flag, and it
> seems like we're always setting it but never clearing it. And often

HW clears HWO flag. We only have to manually clear in one or two cases.

> that's not an issue as we only have one sg entry. But if its set on a
> trb in a request with multiple sgs, that's where it seems to be
> causing the issue.

The issue is completing with HWO set, which should never happen. Can you
collect tracepoints with linus/master of this particular situation?

>> One interesting thing is that TRB addresses are "odd". I can't find a
>> proper lifetime for these TRBs. Do you have IOMMU enabled? Can you run
>> without it? For example, nowhere in the log can I find the place where
>> trb 0000000092deef41 was first enqueue. I'm assuming the log to be
>> ordered, which means that trb is the same as 00000000f3db4076. But why
>> are the addresses different?
>>
>> Another weird thing is that even though we CHN bit being set in
>> 0000000092deef41, we don't see where the second trb (the one its chained
>> to) was prepared. It seems like it was *never* prepared, what gives?
>
> I suspect these bits were due to the tracing happening after some
> minor amount of initial adb traffic began at bootup? So the trace
> isn't capturing all the events.

No, no. That's more likely to be IOMMU mucking up the addresses. ADB is
very sequential in its behavior and USB transfers requests in
order. Please run linus/master without IOMMU.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6f3WUACgkQzL64meEa
mQZdyQ//R324qRyXNq8MYvp3qnlSGkCmXCbzy6OKz3lx25FvUYXMBfnCTvfjCJAV
MuDNe3mqC8EA+ubqORcmFgshfLpLbXZUTkZD40rqbyP7BgN3xtbxwE3wD0ObNe0J
EY8eY9lwCKkjylTsUQn+3AiRRuxF3RcKPoTwuQOIbuR1MOUltGfgrFhQnGuaITrn
8CD5q5Ij45LpPUYdFZ+fCB+NQLYoKjau6ATbFUo4vqkxekBQM1CA9+NnYM9nronM
UwyM1USl7YU9nSWDwr+3pUFgO/Wv3OWe1beVMR+M+jPZ4cm8j/ABld3xnYXK7RsD
/qKgXslcPGIDefmD+TLXOfw+wzOs0f72yaWWaIaxS/mBeGLiI0bCc1WnXfc+JHGt
2fpFN9ut6s+l7AdeOVd2Xz+FhmOjSyPMCw3QcYp5EYhku7Ebf+dGzfsSecZ1TYnf
iwoJOIQCR/Ij2nU07ZCtGXHLpH0XB/RXLu5B6pGCmhkTD0BRHypwHuPtTX4TYrqx
ncjWl0zT4bRwejoN7nc6IVD5T8AFwceRbY50IigGTjHhjM7TLTt2doDo8bTROnrQ
XjHzFQXtHtHIHjeSUlBG81XZWFR9yafczP7op//YGPxoATK5bel2L2ZKmlsZ8400
NHivJbppwKkEWH7zvrGli/1Sg2OFZYueRu+F/BWy2cxpcAI9Eiw=
=oteR
-----END PGP SIGNATURE-----
--=-=-=--
