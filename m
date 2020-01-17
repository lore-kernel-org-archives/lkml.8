Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E77FC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179E32083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579286346;
	bh=6rm5uepdIyjw+aZoxr4SzBFKL0Tg5MKu9jhMt9uBjGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rkkuJ7tNOvGObX1hjfRz8b3B/GqrBBpRUhz//qPs4TBaqZSi6fX5vH8hTShWjVkj+
	 LtJRGJ0JHjW3ElIbeawpSa9fDRCIBS6oMBEu9sh5wOcdMqv3sJRUuF3Q0/GPM4O/WU
	 jB0IwDPE7Q7T/PSQulSfMi8euRxaC9Kilj6+rD+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAQSjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:39:05 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B122072B;
        Fri, 17 Jan 2020 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579286344;
        bh=6rm5uepdIyjw+aZoxr4SzBFKL0Tg5MKu9jhMt9uBjGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWzHbgtEjfc9srjAIxQV6fbaWdY6wToG6L4lKDAdWOKc8scRm4r13SqQpktEw0axz
         xxGlxYZFS6YL+bi0X/wE/Hw/Ns1pw1l4zJbygQhCfBsGRgt/kWhVj33wMHi+AzumNR
         IrpnQ4XJpt9NhT2AC/ztRfkeRDYphvHxlvRf6zyc=
Date:   Fri, 17 Jan 2020 19:39:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Use internal
 oscillator
Message-ID: <20200117183901.lkieha3hu6nz2hoj@gilmour.lan>
References: <20200113180720.77461-1-jernej.skrabec@siol.net>
 <20200116080652.mp5z7dtrtj3nyhpq@gilmour.lan>
 <20509747.EfDdHjke4D@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pymbu5lgw5irb6p6"
Content-Disposition: inline
In-Reply-To: <20509747.EfDdHjke4D@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pymbu5lgw5irb6p6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 05:47:12PM +0100, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 16. januar 2020 ob 09:06:52 CET je Maxime Ripard napisa=
l(a):
> > Hi Jernej,
> >
> > On Mon, Jan 13, 2020 at 07:07:20PM +0100, Jernej Skrabec wrote:
> > > Tanix TX6 doesn't have external 32 kHz oscillator, so switch RTC clock
> > > to internal one.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > > While this patch gives one possible solution, I mainly want to start
> > > discussion why Allwinner SoC dtsi reference external 32 kHz crystal
> > > although some boards don't have it. My proposal would be to make clock
> > > property optional, based on the fact if external crystal is present or
> > > not. However, I'm not sure if that is possible at this point or not.
> >
> > It's probably a bit of a dumb question but.. are you sure the crystal
> > is missing?
>
> Although I don't have schematic, I'm pretty sure. Without this patch or o=
ne at
> [1], RTC gives a lot of errors in dmesg. I think that unpopulated XC2 pads
> near SoC (see [2]) are probably reserved for crystal.
>
> With patch in [1], which enables automatic switching in case of error, I =
saw
> that on this box RTC always switched to internal RC.
>
> >
> > The H6 datasheet mentions that the 32kHz crystal needs to be there,
> > and it's part of the power sequence, so I'd expect all boards to have
> > it.
>
> Can you be more specific where it is stated that crystal is mandatory?

I was mostly referring to the power sequence mentionned in the H6
Datasheet (not the user manual, the smaller one).

https://linux-sunxi.org/images/5/5c/Allwinner_H6_V200_Datasheet_V1.1.pdf

Page 74

> Note that schematic of some boards, like OrangePi PC2 (H5) or OrangePi Ze=
ro
> (H3) don't even have 32K crystal in them.

And we can't use the compatible for these..

> >
> > > Driver also considers missing clock property as deprecated (old DT) [=
1],
> > > so this might complicate things even further.
> > >
> > > What do you think?
> >
> > I'm pretty sure (but that would need to be checked) that we never got
> > a node without the clocks property on the H6. If that's the case, then
> > we can add a check on the compatible.
>
> Yes, that would be nice solution. I can work something out if you agree t=
hat
> this is the way.

So if we want to have something that works for the H3 too, then I
guess we need to revert the patch that switches the 32kHz clock source
to the external one all the time, and do it only if we have a clock
provided.

If we don't, we would run from the internal oscillator (which would
work for both the H3 and H6 boards you have I guess?) and if we do we
will still use the better, more accurate, clock.

That would change a bit the behaviour of the old DTs again and revert
to the old behaviour we had, but we didn't hear anything the first
time we did, so I wouldn't be overly concerned.

Does that make sense?
Maxime

--pymbu5lgw5irb6p6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH/RQAKCRDj7w1vZxhR
xbfcAP9i1ZlK+Y2jyWhOcBVCr7LdqTqBFTaqpH+3E3F0/+TWaAD/bYjxs8/lrxo+
1KQCUUoscHHEne5JK4ivcaQbvqiZ4gw=
=bHvI
-----END PGP SIGNATURE-----

--pymbu5lgw5irb6p6--
