Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3812207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590611697;
	bh=SWyqYEQCDoRue0+CIOWM9wmxZncnv5uHibQu8rwrX6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=popIRAmE579/RN+tjCYLe/YCnmp7IrQMZyUyDxVdMezEKEqC3PKTZdyfwFNeGoQNJ
	 hfShqu+ngxt1N9FgOrcnKH4ibXcPTSf7bIkrLl04al9p8QDE2jbj5V6GSUvNMeQ9yL
	 W633boraFX0UbEOmCu1FRt28wLxDVZmm/KgxKmIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgE0Ue4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgE0Ue4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:34:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCA7204EF;
        Wed, 27 May 2020 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590611695;
        bh=SWyqYEQCDoRue0+CIOWM9wmxZncnv5uHibQu8rwrX6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJbdtKPQNGtj9+AEuZ69Hu92Sm+ntLrpEZSE/akdYCqJjia7evIzn2PaYRWrwzgdo
         oQXTH22k45C6suu+8CUWetx8Pu6L15fR+VVv2dxz0wCtkgIm6b0HbpMkAcG6UmqtDB
         otpmUxpJO9TIXuWHDC6qsh7AYtHAG8NpmZl7gND8=
Date:   Wed, 27 May 2020 21:34:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
Message-ID: <20200527203453.GJ5308@sirena.org.uk>
References: <20200527074057.246606-1-saravanak@google.com>
 <20200527111750.GB5308@sirena.org.uk>
 <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 10:17:21AM -0700, Saravana Kannan wrote:

> If fw_devlink is off or not supported by the firmware (Eg: ACPI), the
> behavior doesn't change. We act as if there are no consumers and turn
> stuff off 30s after late_initcall_sync(). If fw_devlink is on, then it
> makes sure all the consumers (in DT) are linked to the regulator
> device as soon as it is added. So that solves your "we don't know if
> there'll ever be consumers".

No, it doesn't help at all with figuring out if consumers will ever
instantiate...

> The next concern is, "will the drivers ever be loaded for these
> consumers". To handle these cases, I can update the "30s timeout code"
> to just release all the "hold state". And I can make the time out a
> kernel command line param that if set to 0, then it will actually wait
> for all the consumers.

=2E..due to this issue.  The DT describes the hardware, not the software
that will run on it.  Making the timeout configurable is fine.

> Does that seem like something that'd work for you? That way, if no one
> sets this command line param, it won't affect them. And if they set
> it, then things work as intended when the system is configured so that
> everything does eventually come up.

This still leaves you with the problem that we're going to just ignore
operations that happen while implementation of operations is blocked.
If we queue up actually implementing changes to the hardware until after
we claimed we'd done them then that's asking for trouble, especally with
voltage changes - they need to be complete when regulator_set_voltage()
returns, we can't defer syncing that to the hardware to some later
point.=20

Actually now I try to make sense of the code I *think* that rather than
holding off on writing changes out like sync_state() and your changelog
suggests this is only trying to defer disables.  That's a bit safer
but then again it won't help as soon as we run into a system with a
device that glitches due to some other change like a voltage being
changed unexpectedly and it's adding complexity.  The entire patch is
super unclear though, I can't understand what sync_supply is supposed to
be.  It appears to functionally just be a flag but it's done using this
weirdly allocated and manipulated struct regulator.

> > > This commit adds a regulator_sync_state() helper function that
> > > takes
> > > care of all the "boot on" regulator clean up for any regulator driver.
> > > All one needs to do is add the following line to the driver struct.

> > None of the issues around this have *anything* to do with individual
> > drivers,

> Fair enough. I was just trying to give a way for systems that don't
> have the "consumers might never come up" issue (Eg: Android phones) a
> way to start using this while we try to figure out what to do for the
> systems where it might be a problem.

Drivers can be run on multiple systems, this is not a decision that can
be made based on the driver.

> > all this is doing is forcing us to go through and add this to
> > every single driver which doesn't accomplish anything.

> I don't see what's wrong with that. The kernel has made plenty of
> changes where all the drivers using an API had to be updated in one
> shot. This patch doesn't even require a one shot change. Anyway, if

We do gradual API updates when there are actual changes required in
drivers.  This change requires *zero* changes to drivers, there is
absolutely nothing driver specific or relevant about it.  Nothing about
the driver tells you if the flag should be set or not (it's a callback
in the code but since there's only one possible implementation it's
really a flag) so there's no purpose in having a flag in the driver in
the first place.

> > Please go and look at the previous discussions of this topic, this needs
> > to work for other users as well.

> I'd be happy to, if you can point me to some of them. Sorry, I didn't
> know what to even search for to get a meaningful list of search
> results.

The first hits I found were:

   https://lore.kernel.org/linux-arm-kernel/1368076726-11492-1-git-send-ema=
il-skannan@codeaurora.org/#t
   https://lore.kernel.org/linux-arm-kernel/CAKON4OzO427-MU4FqmF8AP5V=3DCXH=
uGdV1GTptiaJiRY7DLfDRA@mail.gmail.com/

Search around for deferred initcall, regulator_late_init() and so on.
Please also talk to your colleagues, IIRC a good proportion of the
variations on this have come from them.

You haven't mentioned an actual use case here (your changelog just
declares the solution) but in general these things are init ordering
issues, if some device (typically the display stuff) is going to cause
user visible glitches during init then things will work best if the
system tries to ensure that that device gets started as early as
possible.  In general these things are best addressed at the system
level rather than by bodging some low level thing.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OzuwACgkQJNaLcl1U
h9DYlwf/fcLV4PmkNSTr+3MS5VXLR2A7uvp1DFDnC61shOhoij7AbMgt48oT3p/V
8mQbJJPUfThsTjZdMQ45l4K0CUW67qCO771ZNC1JnlC1/trZFC93mY1ZSGkFxwPy
3sIDZ2ZiaGYhNBUPj8Se+kiWHHZW4lrEl/Yjf2POJfEzlB4DiPXVKRx/PnjplrPA
q1Tr2fz8EAPJactAN378b1G+uB/D5hQyUmj/pBKGUzwO99x6xg0ciC0oR4PFPHDt
5gcFsyyPnRPvx0ST/ciWc7N+ybOmd5ETkz2081aK2LhNz5DBBFpPMU2wpC532IhK
b35faLTUc51uF0187CoXs7pWUXbAtQ==
=m8io
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
