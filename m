Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A07C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B61207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590672529;
	bh=9QJwwGWsp8hwAWmIKUl9/OFqCBaZim9J8JpR/AXprbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I98lehzS1r0frhvkRaXJlfQ1moDGOfwZqYSI2WG+TEO2ew30I4asD5w6Rh28j7poF
	 fNxwPpZpYE/4e53JnEs+oXWWa+pAc6KS5SXnqO9HEaBrmYpfIrfITtluyfALl20AjJ
	 U/aKczfBqQpcUREtEvATcxxXgQk8PKA+RJA5lc5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgE1N2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390378AbgE1N1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:27:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8932B207D3;
        Thu, 28 May 2020 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590672470;
        bh=9QJwwGWsp8hwAWmIKUl9/OFqCBaZim9J8JpR/AXprbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTM2FjUyRRLXViwazNlf69EuLlh0GaBcN5pCJdEliuyA6tHT/hPv8qeAF7VPvWCBH
         9Z9BNZ/iwmFT0DCPltiDOfeXP3PN5rIGokFbsaraO3LIunBZCHVAt8fwamepsJtbJx
         wONwi7hlpuA/BBSfIT0RU+2iwOqmU9STe4K1v+FQ=
Date:   Thu, 28 May 2020 14:27:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
Message-ID: <20200528132746.GB3606@sirena.org.uk>
References: <20200527074057.246606-1-saravanak@google.com>
 <20200527111750.GB5308@sirena.org.uk>
 <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com>
 <20200527203453.GJ5308@sirena.org.uk>
 <CAGETcx_2W4YG+KcoDpRMRDUJ=o9GC-f=e0GSPyx=_ZpnDrFkxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <CAGETcx_2W4YG+KcoDpRMRDUJ=o9GC-f=e0GSPyx=_ZpnDrFkxQ@mail.gmail.com>
X-Cookie: Small is beautiful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 07:16:26PM -0700, Saravana Kannan wrote:
> On Wed, May 27, 2020 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 27, 2020 at 10:17:21AM -0700, Saravana Kannan wrote:

> > > If fw_devlink is off or not supported by the firmware (Eg: ACPI), the

> > No, it doesn't help at all with figuring out if consumers will ever
> > instantiate...

> It doesn't help with knowing IF all the consumers will instantiate,
> but it does help put an upper bound on when it's okay to release the
> "boot on" regulators/resources.

It's helping with a lower bound, not an upper bound, and it's the upper
bound that's the problem.

> > ...due to this issue.  The DT describes the hardware, not the software
> > that will run on it.  Making the timeout configurable is fine.

> Right, but knowing the hardware descriptions allows us to put an upper
> bound on how long we'll have to wait. And for cases where we don't
> want to listen to hardware description for whatever reason, we can
> have the timeout option to be backwards compatible.

On larger server systems boot can take a surprisingly long time, and
it's possible that someone might do something like put modules on
encrypted storage and need the user to authenticate before they can
load.  There were concerns that the existing 30 second timeout is not
long enough, though the systems where there's fragilities are mainly
laptops which boot much more quickly.  I'm also worrying that there may
be cases where our current behaviour is helping the system run,
especially in warm boot situations where the hardware may not have been
entirely reset.  Such systems are a bit fragile obviously but so's your
proposal.

You can't assume server type hardware runs ACPI, there are some very big
semi-embedded systems for applications like telephony switches or larger
medical devices that look like a server with a bunch of specialist
hardware bolted on the side.

> The idea is to keep the settings at a minimum of what the boot loader
> left the "boot on" regulators at. For voltage, we can just do this for
> regulators that support "get_voltage" and it's fairly trivial to do
> with sync_supply. For "load" there is no "get_load" because it kinda
> doesn't make sense (most regulator can't measure the load?), but maybe
> we can add something like get_max_load() (current max load it can
> support) and then set that as the minimum load the regulator needs to
> support.

If you're trying to bodge this by adding an extra consumer that won't
work since the current requirements from consumers are additive.

> > We do gradual API updates when there are actual changes required in
> > drivers.  This change requires *zero* changes to drivers, there is
> > absolutely nothing driver specific or relevant about it.  Nothing about
> > the driver tells you if the flag should be set or not (it's a callback
> > in the code but since there's only one possible implementation it's
> > really a flag) so there's no purpose in having a flag in the driver in
> > the first place.

> Well, for a device that registers with multiple frameworks, they might
> implement their own sync_state() that then calls into the helpers
> provided by multiple frameworks. Or they might want to do additional
> clean up over what regulator_sync_state() does, etc. So it makes sense
> for the callback to go to the driver and it's not just a flag. But in
> the context of this patch, I get what you are saying and I agree.

A device that's in multiple frameworks is probably a MFD, especially the
regulator portion.

> Both of those threads are from a long time back. And one of them was
> from me :) Things have changed a lot since then -- device links,
> sync_state(), fw_devlinks, wanting this to work for modules, etc. And
> what they are proposing is very different from what I'm suggesting
> here. And some of the older arguments against this aren't valid
> either. I'm happy to shoot them down if they are brought up here.

The requirement for modules has always been there, that's what causes
problems for most of the things people propose.  Like I said above I
don't think fwlink helps for the cases that cause problems, it can only
confirm that nothing will ever load without an overlay, it can't tell us
if anything is actually going to appear.

> > but in general these things are init ordering
> > issues, if some device (typically the display stuff) is going to cause
> > user visible glitches during init then things will work best if the
> > system tries to ensure that that device gets started as early as
> > possible.

> There's no way to order/guarantee device probe ordering. The closest
> we can get to that is initcall ordering or module load ordering. But
> that has a couple of problems:

This is overly pessimistic, we can do a lot better than we currently do
especially when things are built as modules.

> - Can't handle cases where the same driver probes two different
> devices with different ordering requirements.
> - Falls apart when a driver defers probe of a device.
> - Doesn't work with async probing

> Initcall can only order driver registration, which isn't really very
> useful for what we need here.

These really only apply to trying to do things with initcall ordering,
and even there there's room for improvement - if we were going to try to
do things in some sort of dependency directed order we could just defer
actually binding anything until much later on in init, there's no *need*
to do immediate binds.  Similarly for async probing, the dependency
information could be used there.  With module loading userspace gets to
pick what order it does things in, especially with the initial coldplug
step, so it should be easier still to look at what's a priority and what
the dependencies are and optimize the ordering.

> Anyway, I'll rework my patch to do the timeout and/or do this for all
> drivers and we'll take it from there?

Sure.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7PvFEACgkQJNaLcl1U
h9AkAQf+MaD6RtbCbGcXh59s/oqGm2KHuvGILW4LZqUdWoVNw1JY85sR/skzXJOU
sVI6PB4Rr3A62w4Pc6xB2wSi0BoIe8XgfUacGZifgvR3qLMrKB03ObT0Vw5phfCw
Q7iHStM3v4zFbpzuHPrMKtGok0c0IFjx9LRA+2aZaUdGBFsE5jEx2v/1kEfEogzA
MWRTBjgOL7nNjvKDjwMyGjmeUdavCVZpAeUKkb28NsezgEu5fyjZxksFMgrS7Vyn
qMFHuoF4UUgPt72dNDOIRNEOLA/Hz6Ka+XjeCvonB6VFmEQ77//WUuroIxoFE5lp
OM0yJPh1wUuiII8QfgHApQTFE8wI1A==
=3bHd
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
