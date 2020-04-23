Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92151C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB712075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587633767;
	bh=6mspW+S53oSp3oT4FxTYiAhnsmgiActuWBLOr5dpNYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=IHHNUDhy4DeoD7mpzPmXLcIKy0BpkeePE1cTT3jaxNhaTnx7qDdaLAo5ZLuUFA13j
	 4sI8bEV24rsJfZXxBaP5OocQHRa626MOzGDeoDM/mKSSeLFCC83WmFoP6gpdb6QWBB
	 mfGqCRcpWwNJUiVAgzC38Xr1aiw9YHI2AaZmjbgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgDWJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDWJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:22:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5446C03C1AF;
        Thu, 23 Apr 2020 02:22:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so5463499ljn.7;
        Thu, 23 Apr 2020 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5doi24Y6gjm8FI56UPIWnNVv3Prw/IrGAiEig/4smDw=;
        b=r1i7tA6ZpF5x24N31aCJa9XQ248HyRRE+7gqnCxI0hcsDh55i5qzhbrEK6F45Zp/pp
         jIKFz/5dT4h4OptGYTOpkxMN1G9z8yq7MIVjq+j680OEDAFlC/fqT69TAtThLJ9lWxLn
         ypPHOvms5aeq4mLOMaOIc+bJbXyrgkuxsIPNtAOS0vrX8oYp0WtNnY3w9Mmw/QJobb6o
         2KZ0CVoF1NFMk3k9gsm46IiNKUKkiSTurI2aTIJdvgNw16/ANlgl9mqphpl/P5fFu0rR
         8jG3sPeFsw6hcldR82vmmnduoMzgyPO0afjmO7mSBn3S9yFaDV0EaZpzY2g+Y0NlI7wi
         O7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=5doi24Y6gjm8FI56UPIWnNVv3Prw/IrGAiEig/4smDw=;
        b=TdfYaIqe35Mtf53SyqYZWLvI0M8WVNCKKCenjIsuNxX32PjoAiiGtZ+nZ2g4GPMUVP
         +b3yYgflvsJ+tGNjzHtmTwvuNMpuhnMwWW5i0TEjt7CpL3gIRuLXoAQF2KcRL5dDZHGk
         CEvutgDzqFVZFghOpk9/o9r2z66lHP7JWlUf84niXDGMJPvmiufi8l6cBZqNpAFefRny
         FWiCm9nkRU+C47dkMy1j+AC0SqEodj/kdbyzHLwdX2xiuozBMM8SuWP0cMDMtT2Cs3uL
         oJmGtqXnw2qCGcjF1SYQrU4ddQg4LT22jsGGZ3SrKF/6QwGzvxagjBRWIR7yZEooct/C
         Ix5w==
X-Gm-Message-State: AGi0PuYGKPjdHjmXizaTTNJ9Eas805HZ9fGivKYCXmm6mIB6GSAvJqE6
        xcTfiYvoHgZgWRjfNNjkmduYiW4dOs8=
X-Google-Smtp-Source: APiQypIoCacksgsXd8LiZPoRDZM/Zgr5dUAB5/J0YcHYLgZMSBNCJCn8A1md3qcx1la1OAHOLf02Xg==
X-Received: by 2002:a05:651c:515:: with SMTP id o21mr1854567ljp.91.1587633763869;
        Thu, 23 Apr 2020 02:22:43 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id y8sm1275341ljh.83.2020.04.23.02.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 02:22:42 -0700 (PDT)
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
In-Reply-To: <CALAqxLXkY2veX7DKAhXn-uxtMYygfKrJQaPiSKKLbnDvQnHinA@mail.gmail.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com> <877dyfsv00.fsf@kernel.org> <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com> <87blnkcb6i.fsf@kernel.org> <CALAqxLXkY2veX7DKAhXn-uxtMYygfKrJQaPiSKKLbnDvQnHinA@mail.gmail.com>
Date:   Thu, 23 Apr 2020 12:22:32 +0300
Message-ID: <87k1261rqf.fsf@kernel.org>
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
> On Tue, Apr 21, 2020 at 11:00 PM Felipe Balbi <balbi@kernel.org> wrote:
>> John Stultz <john.stultz@linaro.org> writes:
>> > On Thu, Apr 16, 2020 at 1:19 AM Felipe Balbi <balbi@kernel.org> wrote:
>> >> One thing I noticed is that we're missing a giveback on ep1out. Here'=
s a
>> >> working case:
>> >>
>> >
>> > Hey Felipe,
>> >   So I found some time to dig around on this today and I started
>> > trying to understand this issue that you've pointed out about missing
>> > the giveback.
>> >
>> > It seems part of the issue is we get to a point where we have some req
>> > where pending_sgs is more than one.
>> >
>> > We call dwc3_prepare_one_trb_sg() on it:
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n1068
>> >
>> > And we process the sg list incrementing req->num_queued_sgs for each o=
ne.
>> >
>> > then later, dwc3_gadget_ep_cleanup_completed_request() is called on th=
e request:
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2522
>> >
>> > We call dwc3_gadget_ep_reclaim_trb_sg()
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2470
>> >
>> > Where we iterate over the req->sg, ideally decrementing
>> > num_pending_sgs each time and return.
>> >
>> > But back in dwc3_gadget_ep_cleanup_completed_request()  and there
>> > we're hitting the:
>> >   if (!dwc3_gadget_ep_request_completed(req) ||
>> >       req->num_pending_sgs) {
>> > case which causes us to skip the call to dwc3_gadget_giveback().
>>
>> This logic was modified recently. Can you check if today's linus/master
>> works for you?
>
> I was testing this against 5.7-rc2, but I updated to linus/master and
> I'm not seeing any change.

good

>> > Looking as to why the num_pending_sgs is non zero, that's because in
>> > dwc3_gadget_ep_reclaim_trb_sg we're hitting the case where the trb has
>> > the DWC3_TRB_CTRL_HWO ctrl flag set, which breaks us out of the loop
>> > early before we decrement num_pending_sgs.
>> >
>> > For that trb, we're setting the HWO flag in __dwc3_prepare_one_trb()
>> > (called from dwc3_prepare_one_trb_sg() back at the beginning):
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n921
>> >
>> > I added logic showing every time we set or clear that flag, and it
>> > seems like we're always setting it but never clearing it. And often
>>
>> HW clears HWO flag. We only have to manually clear in one or two cases.
>
> I guess the bit that worries me with the current code is in
> dwc3_gadget_ep_reclaim_completed_trb():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2406
>
> There is the logic:
>   if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
>            trb->ctrl &=3D ~DWC3_TRB_CTRL_HWO;
>
> But that will never trip, as the only time we call
> dwc3_gadget_ep_reclaim_completed_trb() with chain=3D=3Dtrue is from
> dwc3_gadget_ep_reclaim_trb_sg():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/usb/dwc3/gadget.c?h=3Dv5.7-rc2#n2470
>
> Where if the trb->ctrl has the HWO flag set, we break out before
> calling  dwc3_gadget_ep_reclaim_completed_trb().
>
> So the logic quoted above seems to be effectively dead code (despite
> the big comment as to why we need it)

There is another situation when we use CHN bit. If we're starting an OUT
transfer and the length is not aligned to wMaxPacketSize.

> That's why I suspected the HWO check in
> dwc3_gadget_ep_reclaim_trb_sg() is problematic.

okay

>> > that's not an issue as we only have one sg entry. But if its set on a
>> > trb in a request with multiple sgs, that's where it seems to be
>> > causing the issue.
>>
>> The issue is completing with HWO set, which should never happen. Can you
>> collect tracepoints with linus/master of this particular situation?
>
> Will do, though again, its a little tough as often we hit the stall
> state pretty quickly at bootup, before I can even try to enable
> tracing, so it may take a few tries.

IIRC there's a way to configure tracepoints from cmdline, I never tested
it though.

>> >> One interesting thing is that TRB addresses are "odd". I can't find a
>> >> proper lifetime for these TRBs. Do you have IOMMU enabled? Can you run
>> >> without it? For example, nowhere in the log can I find the place where
>> >> trb 0000000092deef41 was first enqueue. I'm assuming the log to be
>> >> ordered, which means that trb is the same as 00000000f3db4076. But why
>> >> are the addresses different?
>> >>
>> >> Another weird thing is that even though we CHN bit being set in
>> >> 0000000092deef41, we don't see where the second trb (the one its chai=
ned
>> >> to) was prepared. It seems like it was *never* prepared, what gives?
>> >
>> > I suspect these bits were due to the tracing happening after some
>> > minor amount of initial adb traffic began at bootup? So the trace
>> > isn't capturing all the events.
>>
>> No, no. That's more likely to be IOMMU mucking up the addresses. ADB is
>> very sequential in its behavior and USB transfers requests in
>> order. Please run linus/master without IOMMU.
>
> So I didn't have any IOMMU support enabled in the config I was testing
> with. I went through and added IOMMU options in my config with
> linus/master as well and that didn't seem to change the behavior
> either.

pretty odd that the TRB addresses change like that.

> I'll get back to you with further trace logs.

thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6hXlsACgkQzL64meEa
mQZk3xAAv30RrB564Z2Wt3UlrD5nQVIKXRIkgaINWSlDMiESJH4Oi8j1pxmVO4A2
46UDXELuwxLWr5S8glicqGJ2evU3M3zRVFsByGguFsLGgZiD2RT6vuSwZJ17QBvK
yEu1J6SttHHIuFGv7UdfH2Q6Z+Rqa4c+HBrFCZL5OcYK2688ks/TB/DFyXLo0+cL
MwIZk/7vg51wrJZr7cEJsMPMXb2hOt/MgvW0e+KtstMF98zPotGLZHZxZL5wQEXQ
xPlW/XlLrr6I5A8PXM0i5zJ331UW3lH/ztCOZkfk7T4avk1ulWzEgHy2HR/1Ka/J
eJosIh9EQMi5ewsRw3d0RH3/cxS70mTlk/GrlhvVMCzVzZAe3pLwgIKR4gB0MQ0Y
OCejw/pSNcz2fzH5YmujwPEzdlQ3CX2343C1fVspwrsWAzAGdiiNBjDKb/5vksgL
qOYAeUAdohIJBXaPK8xpEfzdaKBPdRbr1OEDNGfArLr/6797otuUOuWKamPK4MLg
MlKUXXVYDazJ8FCSdSww3BxxMUZjgbZK7v+qRczbxJ1leC26b977kvVDxXWsaIKI
N427yeZ2cY+eWKqRrQ8aItNhZv/Ezu6qeFczY3PAkSd9qWTxM0DE4UqTpSNdT6V4
48WRrS7M3BmOmMNrA77NsTf3oHz790JulLMdq8qxX0NmFe9YLh4=
=HbNo
-----END PGP SIGNATURE-----
--=-=-=--
