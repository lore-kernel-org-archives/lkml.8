Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71672C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4115724683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579696445;
	bh=YkMbe5GpP4VDjIwVHsoJprcnaVZrqN9ErPnnX3+2jro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ZtP8LUVXgA5PhqlN7D1nz6oNSzuuApm3A7jm2y88aZsEi0DVXK4QVHKwY2pKImkX
	 7L1Wb6cbpp7FnaEDKxDp3eO9EWbtlmreH9XZTnWrmlLhlzFnncz6/PXWkBWnCsGtt/
	 jJFSLOzdXd1CWNL+pWyjrlRFOzioevxWCaa5ZiCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAVMeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:34:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAVMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:34:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ECCE328;
        Wed, 22 Jan 2020 04:34:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34943F52E;
        Wed, 22 Jan 2020 04:34:02 -0800 (PST)
Date:   Wed, 22 Jan 2020 12:34:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 3/4] regulator: mt6359: Add support for MT6359 regulator
Message-ID: <20200122123401.GD3833@sirena.org.uk>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
 <1579506450-21830-4-git-send-email-Wen.Su@mediatek.com>
 <20200120190427.GO6852@sirena.org.uk>
 <1579659806.6612.12.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <1579659806.6612.12.camel@mtkswgap22>
X-Cookie: Sorry.  Nice try.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 10:23:26AM +0800, Wen Su wrote:
> On Mon, 2020-01-20 at 19:04 +0000, Mark Brown wrote:

> > This looks like you should be using regulator_list_voltage_table() and
> > associated functions, probably map_voltage_ascend() or _iterate() and
> > just a simple set_voltage_sel_regmap().

> Thanks for your suggestion.
> Currently it's using regulator_list_voltage_table() and
> regulator_map_voltage_iterate() as below:

> The reason to use mt6359_set_voltage_sel() is to convert selector value
> to hardware register index value:
> 	idx =3D pvol[selector];

The whole idea behind regulator_list_voltage_table() is that it does the
selector to voltage conversion for you, you shouldn't need to do any
additional mapping.

> To avoid using mt6359_set_voltage_sel(), the *_voltages array need to be
> filled with zeros as below:=20
> Current:
> static const u32 vemc_voltages[] =3D {
> 	2900000, 3000000, 3300000,
> };
> static const u32 vemc_idx[] =3D {
> 	10, 11, 13,
> };

> change to:
> static const u32 vxo22_voltages[] =3D {
> 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2900000, 3000000, 0, 3300000,
> };

That's fine, the table is small and it only needs to be iterated in
contexts where we're doing I2C I/O.  If it's really a problem introduce
generic helpers for this rather than open coding.

> > > +	switch (mode) {
> > > +	case REGULATOR_MODE_FAST:
> > > +		if (curr_mode =3D=3D REGULATOR_MODE_IDLE) {
> > > +			WARN_ON(1);
> > > +			dev_notice(&rdev->dev,
> > > +				   "BUCK %s is LP mode, can't FPWM\n",
> > > +				   rdev->desc->name);
> > > +			return -EIO;

> > I'd expect the device to go out of low power mode then into force PWM
> > mode if it has to do that rather than reject the operation.

> The device low power mode may control by hardware pad, so that the
> reason to reject the operation is the device low power mode can not go
> out by software.

If this is being forced by hardware you need to check for that directly
rather than just rejecting it without even trying (but hopefully the
user set their constraints such that this doesn't happen).

> Another scenario is one user set the device to low power mode, we think
> it's not suitable to change device mode to _FAST mode by another user.

It's not your driver's problem to worry about arbitrating between higher
level users, let the framework deal with that (and notice that we have
no code in kernel that actually sets the mode directly at runtime).
That way we will have consistent behaviour between devices rather than
devices trying to enforce their own policies.

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4oQTgACgkQJNaLcl1U
h9D4Ygf+Nziq8bZrmbOIKqexjp2v9TvNwy09gwUlAJs9KJ9MjXFHTprK96JdeRLn
qfl46x/Qb1TgrDRaFus46RApEELBHLOJ8MjMIz0MSlaVeJqyHwn46vTild91pSl3
6vHfkJKRFHx3Ix2wudcdRcvpGn/HHGCydNn8+mLDOR9GDaZCOn2aOq2LVTU01izu
7ulyEaYk3jIE86BfISfoXXGZ8eyHYaSynQia91odZsZD4J6W9IaGXFms9MORVIbm
Ii3wwPwOufroxvff+6HOucaYbNN6UpVbKsvxJ4f0S9U5+T77RgDDdv6Jp6jv/Kjx
jzkOyueUpjLzFBvhEKl52FhmXf74Vg==
=ZzAE
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
