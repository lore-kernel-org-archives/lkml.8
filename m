Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D377C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D751A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587635299;
	bh=6f93in9YcZ9OhdTMxf5Mihzim5szkipPsbUrmK0PUvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=YV8snjEzBNSdmLfSwtrZuQ2gk8X1azi/Z91gpP7aKVRHQgDulfSgGJ0bYqk0eoIHZ
	 8VZa3U+jeRt94iMhPcyHYnM/PLqU7TCH8HJIRWHzaiYZYVsM6zQJEUVfFBXSrqQhPQ
	 lmfUR+xXfILXaueMg1hJPq7BBdKeRBSwgf+ysd0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgDWJsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDWJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:48:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B46C03C1AF;
        Thu, 23 Apr 2020 02:48:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so5499233ljg.12;
        Thu, 23 Apr 2020 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gW1OIDZVg26tyBCo83quPVFFODgrG9/kkIUh/NhpYog=;
        b=B/eId1pyjzj9cj6nF6u90sAuxar1KQuGeOnN2LnGmz/QHHerMZVrDKIToc3/tL+Ztv
         4u/ungT5X99cKJVpv7yTcnEkDKESzPJUX0YLDtCLo/aAFHq344TZ6mafy+sCWn2Uavq5
         +sRVG8HBUZZsAWFNN5WAFysjJMLroLAwhtkEH2wiQwcZ71EI7A6YLjUgLp2NiUqdJOkT
         0jR4wYfP19yuAdn4+O1AIsYU9J2Oe7f9yYW4lLqg6pYH6I73pBxWtZn6lfBiBngOghfU
         qmUxDYxJI3l/gd2DqonW5jSpVjuSYe7fd/vcUND7/f4I0vSMQaq+jCteeVXiuzhb4vnU
         jFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=gW1OIDZVg26tyBCo83quPVFFODgrG9/kkIUh/NhpYog=;
        b=RsKLQOO3hFtjx0N7sKC6SF5BSKXCBtcoE8wg8yy2KvxCN+5Y14R/4EqtZERNkJ7bmd
         VFe8mrwpdO1s5MlFySFsaX/hxju1tnSsbhrbv22rl9C30nwq4CRn3UCMu586QwMHtqHK
         fvDl3mFw61qZOgoNWLJ25y/tKC73Dc9b2tDpxldLL1bVQq9AXJiShwBG6xjxriBRMEB7
         UKa9uZB3Up7aTagVj964490SpVyq+AeASLn18ushfBDzzBkzsOkE2JHzB/mZfV84x6R+
         KJbYU+9ySCYLtLNk66Mm3+EbvtyCoqMbQ8xOyCw7fTQk38zCHVECz/Uyy0Q3mFMkARfN
         wq6A==
X-Gm-Message-State: AGi0PubbKZhc5Bq09zRlQp+Bja/EwYeo6D8cROEkDDbmECxuI7doj3ra
        wSFHc/qktKsP5LxR7XW8BCeKnpCjZXY=
X-Google-Smtp-Source: APiQypI7e18p78qJ1nNVbGu4hOR0W2FauM8BCQZ/5vUWMtvCbyhgVu7l8bZIhjoZd8Q9B3ZNPc34xQ==
X-Received: by 2002:a05:651c:3ce:: with SMTP id f14mr1891949ljp.98.1587635296023;
        Thu, 23 Apr 2020 02:48:16 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 12sm2061ljq.0.2020.04.23.02.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 02:48:14 -0700 (PDT)
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
In-Reply-To: <CALAqxLUZTj8hQzBxpxRJa1+0_J_zbu2zfx7A_8WXAMP1N0nvZQ@mail.gmail.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com> <877dyfsv00.fsf@kernel.org> <CALAqxLUdzKRV6nrcLpWsykK+WPnqhUK4iwRe4_Xmo-TvEV5KOg@mail.gmail.com> <87blnkcb6i.fsf@kernel.org> <CALAqxLXkY2veX7DKAhXn-uxtMYygfKrJQaPiSKKLbnDvQnHinA@mail.gmail.com> <CALAqxLUZTj8hQzBxpxRJa1+0_J_zbu2zfx7A_8WXAMP1N0nvZQ@mail.gmail.com>
Date:   Thu, 23 Apr 2020 12:48:10 +0300
Message-ID: <87h7xa1qjp.fsf@kernel.org>
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

John Stultz <john.stultz@linaro.org> writes:

> On Wed, Apr 22, 2020 at 11:32 AM John Stultz <john.stultz@linaro.org> wro=
te:
>> On Tue, Apr 21, 2020 at 11:00 PM Felipe Balbi <balbi@kernel.org> wrote:
>> > John Stultz <john.stultz@linaro.org> writes:
>> > > that's not an issue as we only have one sg entry. But if its set on a
>> > > trb in a request with multiple sgs, that's where it seems to be
>> > > causing the issue.
>> >
>> > The issue is completing with HWO set, which should never happen. Can y=
ou
>> > collect tracepoints with linus/master of this particular situation?
>>
>> Will do, though again, its a little tough as often we hit the stall
>> state pretty quickly at bootup, before I can even try to enable
>> tracing, so it may take a few tries.
>>
>> > >> One interesting thing is that TRB addresses are "odd". I can't find=
 a
>> > >> proper lifetime for these TRBs. Do you have IOMMU enabled? Can you =
run
>> > >> without it? For example, nowhere in the log can I find the place wh=
ere
>> > >> trb 0000000092deef41 was first enqueue. I'm assuming the log to be
>> > >> ordered, which means that trb is the same as 00000000f3db4076. But =
why
>> > >> are the addresses different?
>> > >>
>> > >> Another weird thing is that even though we CHN bit being set in
>> > >> 0000000092deef41, we don't see where the second trb (the one its ch=
ained
>> > >> to) was prepared. It seems like it was *never* prepared, what gives?
>> > >
>> > > I suspect these bits were due to the tracing happening after some
>> > > minor amount of initial adb traffic began at bootup? So the trace
>> > > isn't capturing all the events.
>> >
>> > No, no. That's more likely to be IOMMU mucking up the addresses. ADB is
>> > very sequential in its behavior and USB transfers requests in
>> > order. Please run linus/master without IOMMU.
>>
>> So I didn't have any IOMMU support enabled in the config I was testing
>> with. I went through and added IOMMU options in my config with
>> linus/master as well and that didn't seem to change the behavior
>> either.
>>
>> I'll get back to you with further trace logs.
>
> Ok. Attached are trace logs. Two bad cases, which are linus/master w/
> all IOMMU configs disabled.
>
> Then I have a good case where I've removed the
>   if (trb->ctrl & DWC3_TRB_CTRL_HWO)
>                   break;
> logic in dwc3_gadget_ep_reclaim_trb_sg().

Okay, here's the failing case:

   UsbFfs-worker-574   [001] d..2   261.788895: dwc3_ep_queue: ep1out: req =
000000006efef4fb length 0/16384 zsI =3D=3D> -115
   UsbFfs-worker-574   [001] d..2   261.788922: dwc3_prepare_trb: ep1out: t=
rb 00000000fa0a991a (E11:D4) buf 00000000ab3d1000 size 4096 ctrl 0000001d (=
HlCS:sc:normal)
   UsbFfs-worker-574   [001] d..2   261.788927: dwc3_prepare_trb: ep1out: t=
rb 000000007f6b91bb (E12:D4) buf 00000000a9534000 size 4096 ctrl 0000001d (=
HlCS:sc:normal)
   UsbFfs-worker-574   [001] d..2   261.788930: dwc3_prepare_trb: ep1out: t=
rb 00000000a64ab194 (E13:D4) buf 00000000d6447000 size 4096 ctrl 0000001d (=
HlCS:sc:normal)
   UsbFfs-worker-574   [001] d..2   261.788934: dwc3_prepare_trb: ep1out: t=
rb 00000000571f893b (E14:D4) buf 00000000d666a000 size 4096 ctrl 00000819 (=
HlcS:sC:normal)
   UsbFfs-worker-574   [001] d..2   261.788962: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-515   [000] d..1   261.821056: dwc3_event: event (00006084=
): ep1out: Transfer In Progress [0] (SIm)
     irq/65-dwc3-515   [000] d..1   261.821057: dwc3_complete_trb: ep1out: =
trb 00000000fa0a991a (E22:D11) buf 00000000ab3d1000 size 4072 ctrl 0000001c=
 (hlCS:sc:normal)

So, ffs enqueued a request for 16kiB but only 24 bytes were sent by the
host. This is a short-packet case. It seems like that logic is, indeed,
incorrect. I added it for a reason, though I can't be sure based on the
commit log alone.

I think I was trying to cover the case where we didn't prepare all TRBs
for an SG-list because they didn't fit, but I don't think that's the
right way to achieve what I meant :-p

Could you prepare a patch and Cc stable?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6hZFoACgkQzL64meEa
mQa6GQ/8DUn3CeqNK5ufYqfOBC5tp7oZbWBoo/9iRAafD9th3Q4K8OGt6uPUZNbO
4KuQ224V79S5LmHcxlPAByhAgM63cxQnWoNo9KibtOE+CjiRg3yW0w8LOZa1kDuf
R2ufUoIC70w2GtEcsHtUqzGltmcI+8Gf3pSik8rmOy1Rj4ZjxjXnQrIH8otZeukS
rsaUyGOsrcIifdrX+2n0yP36k74OaFyIsWmXuP4ik7xvvo8wB1e5lm8GbPZCaPAD
sSL43tzGrwBRCOuIt5brS+ky5+iLtO5+t6/0ldqdaLfiL6rSd2FKZ9MhlZD6QJh4
pGdXL5UFuP8voyLMeu1U+SJD9CuKTbMp9LPG8D17F6aA9R+bwPNUzvO9nC5kJBIZ
tsaJBZ+fusG1JbNq1v5MenL+yw3FL3s6cEkDfrpdqj3DVQziv/evpnGIsZ6lK2Oz
L0uAroZy5PR7pcOVPxafyu0ZcoB6uEzYjKTwZW/S3LbqbbfdgtoxKpJQo9/ztuFx
vgMG9P2t/Ec2sOhWJEaJAPys9atQmGQAZUJenucbw+4i+QCjC8KaaqJ9idRXc/1l
dvvIndz0aYt9rB2Lsl4grE0aOxT0n4zXrYO5QailKg+VtHQJ9cJi+mDClM3rVT7s
U+yM4nvyfEwjtzfO5t3XYmbeX0mKTGC60PehUPzwX6lcQpbLGI0=
=4Gav
-----END PGP SIGNATURE-----
--=-=-=--
