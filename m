Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E67AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CFB20888
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591699882;
	bh=X/5WlMyTJqJDM8436JxxBvG2u6EdHHqalJEO6mDoWrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MeOkCYOf8Amlgi/PeoHTDQgYLQFSyuCN+/A1e8zKGno30Y1BS1IoiLRF6BlgzuKa2
	 Z1kPkWUq3oido++WmdWLs47elcDszj+Vb803CrVnwmdfWheb432ssQJaXIqZrXf34B
	 7fcvD7LaIwBpof7CSBR6zw5rKxqMRK911Ok1K2FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFIKvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIKvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:51:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670DC2078D;
        Tue,  9 Jun 2020 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591699877;
        bh=X/5WlMyTJqJDM8436JxxBvG2u6EdHHqalJEO6mDoWrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyJRjuwpr+jXEkHDrK0i+lfGu13VfSK80nO256pl5FQ6btPjoCCPaE0h4wEvmfEEw
         NNlpKzWgPnF2Ca+FkCC50rvrthYzcdDCPk4NNuQDGuOy3Tfzuh/hNBGUxStTAkXj0z
         0ooE06AvAnQxWfBhN46p99WSewWZIwl0AcQHs7wI=
Date:   Tue, 9 Jun 2020 11:51:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
Message-ID: <20200609105115.GA4583@sirena.org.uk>
References: <20200528190610.179984-1-saravanak@google.com>
 <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk>
 <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
 <20200601172323.GE45647@sirena.org.uk>
 <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2020 at 08:16:44PM -0700, Saravana Kannan wrote:
> On Mon, Jun 1, 2020 at 10:23 AM Mark Brown <broonie@kernel.org> wrote:

> > This is I think the first time anyone has suggested that this is likely
> > to be an issue - the previous concerns have all been about screens
> > glitching.

> Looks like we got at least one concrete example now in [1].

That's the Exynos VDD_INT/CPU issue.  I'm not clear that this is
entirely covered TBH, AIUI it needs a coupler all the time so it's not
just a case of waiting for the consumers.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> But it doesn't really ignore consumer requests though. In response to
> all your comments above, I haven't done a good job of explaining the
> issues and the solution. I'll try to redo that part again when I send
> v3 and hopefully I can do better.

Yes, I think a lot of this is about clarity of explanation.

> > My concern is that introducing extra delays is likely to make things
> > more fragile and complex.  As far as I can see this is just making
> > things even worse by adding spurious dependencies and delaying things
> > further.

> I wouldn't call it delaying any requests. This is just an additional
> constraint like any other consumer. This definitely makes things more
> stable in cases where all the devices probe and even in cases where
> some of those devices might never probe (example I gave in [2]).

Since your current implementation restricts things until essentially the
entire system is running this is going to affect consumers that don't
share their regulator.  Part of the reason I am so against that idea is
that when it is very important that a driver be able to change the
voltage and have that actually take effect usually the hardware will be
built such that that regulator isn't shared so shareability issues don't
apply, we have regulator_get_exclusive() for such situations though
it's wound up not as widely used as it could be for a bunch of reasons.
Things like MMC where we have to conform to a hardware spec that
includes lowering as well as raising voltages will have issues with
this.

> > At best this is working around a problem that has been
> > introduced by the decision to do everything at far too broad a level,
> > it feels like it's defeating the point of trying to track dependencies
> > at all.  The whole performance seems completely redundant if we're
> > trying to aggregate things so aggressively, we end up needing pretty
> > much every device in the system to come up before we can do anything.

> This is definitely not true on real Android phones. Keep in mind all
> of this only applies to resources actually left on by the bootloader.
> So, that drastically cuts down what all devices are affected by this.
> So, if a PMIC has 5 regulators and only 1 is left on by the
> bootloader, then this patch series would be a NOP for the 4
> regulators.

This is your systems - it is not that unusual for systems to come up
with most if not all of the regulators up in order to keep things
simpler, it's generally easier during bringup and people don't always
see any particular reason to modify the bootloader to change things (and
may not be easily able to customize what the PMIC does itself even if
they wanted to do things at that level).  Such systems will be very much
impacted by this change.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7faZ8ACgkQJNaLcl1U
h9BxNwgAg3x7XQGv2ociQ1jeYU1jrXGyijnlJ3Sl/MbZ9FQCYL4OHa77qJ8SLmDL
Csbf15VD9V88v6komLLUM8aPlN3vhiTxwRIIk34SbNJaxfJs6Peox6v4o/tC0qPd
8YxOGKANBr3B6+0enZJ28AgBg4Fjw7nKvB45slo3M8N6JnKLJsvK6vv3fG4gT+BU
cnYa2pInMcdZXg9HZFyhKn9AUkNfUKL1zELCln+1DEV0S/wMTkkwh5A287FHobDd
6FMGgNkYWf9yU8k2llVBFWzk2YxnjxkMDfRpKi1RcP0dtnQ8Zwkv6V4E5gwCv3oy
6G/CjQv5DGIzbqZ69bUChcaeW3qmAQ==
=hN8y
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
