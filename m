Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306CD2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590617252;
	bh=+Cuqp2vRj8HoAOVtvgOP/wR/ttfy/UKTWBrirkVhb0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=avHtCbp1kVP9/0iWTXGZeJi+LEN6x9LCSzkMW41QcrTt+fDcR1TuYr6UYrywTCvGy
	 kwSo/qIJTOYgdKeBWwAD2ydc6pQ+kMmUuaoAikz9nVUbhVvs/WiipYB5yn1Rsg/e9a
	 pkiTAK/cHkWRTP71W7lR3FNFaTpt5tYMRjG+dOcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgE0WHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgE0WHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:07:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DE0207D8;
        Wed, 27 May 2020 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590617249;
        bh=+Cuqp2vRj8HoAOVtvgOP/wR/ttfy/UKTWBrirkVhb0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7R9IjOTJVIiCOMXCZRMz6SffB/0LnacUY83H+OZIjhI7LihmaYai6wFkDVJYvkxt
         ph3MtvXFOwBqlVuBnJzqAgF/p7/yQT1XSlxIPrrQNr29zMvj38NjnW2ijSdJQsIDZi
         P2axskdIa+XHDfu/bZBqJhEyABCZL+qTSp+N55DI=
Date:   Wed, 27 May 2020 23:07:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: rt5682: split i2c driver into separate module
Message-ID: <20200527220726.GN5308@sirena.org.uk>
References: <20200527193730.930412-1-arnd@arndb.de>
 <20200527205658.GM5308@sirena.org.uk>
 <CAK8P3a2WrCGFtYx52sMu2rsWQFq6kKhEFWGEk2Tn+4gEQTLxBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WrCGFtYx52sMu2rsWQFq6kKhEFWGEk2Tn+4gEQTLxBw@mail.gmail.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 11:57:33PM +0200, Arnd Bergmann wrote:
> On Wed, May 27, 2020 at 10:57 PM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 27, 2020 at 09:34:13PM +0200, Arnd Bergmann wrote:

> > > +static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> > > +     "AVDD",
> > > +     "MICVDD",
> > > +     "VBAT",
> > > +};

> > I'm *fairly* sure the device needs power even with Soundwire?

> I have no idea how this is done with ACPI. I'm moving it

There are non-ACPI SoundWire systems - Qualcomm have some systems
upstream.

> back as an exported symbol. There should probably be
> some abstraction that handles this in the common part of
> the driver along with some of the other bits of
> rt5682_i2c_probe, but really don't want to shake things up
> too much and would let this be done by whoever needs to add
> DT support to the soundwire driver in the future and is able
> to test the changes.

Like I say the abstraction is generally just setting up the very basic
stuff and calling into a common init function with a few parameters.

> > This doesn't look very I2C specific either, nor do chunks of the rest of
> > the code.  The usual pattern with this stuff is to have the bus specific
> > code do bus specific stuff like setting up the regmap and then call into
> > a common init function for the shared parts of the chip.  I'd expect a
> > bit more unshared code here but not this much.

> Right, I was surprised the soundwire portion does not tie into
> device tree at all, and none of the other soundwire codecs seem
> to either and no dts files reference it, though there is some code
> for the subsystem and a binding.

The stuff that's upstream for DT platforms is for Qualcomm systems where
the reference designs are generally fully integrated with Qualcomm
components so there's limited overlap.  IIRC they also have a fairly
unusual system design with a mix of SoundWire and Slimbus usually (that
was the case for a while at least).

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7O5J0ACgkQJNaLcl1U
h9Aj+Qf/X4InksadO2XemtJetQPDlC78XcmQm2rlx0qZkAscN5csrmw7PXarB24l
HLrG69XfBt6+e7q7025R+xxJkYrlVDTrDq5XNdrDE+bHm1jgkQWRk+/FlsEmaaj1
kJfa5dE4CKMXKrE0k+4irNdQkNyWSfwD2knP6Ta+xaTVkSi2QON9A0gvRAUwRvaR
w5lt/HLQasP/afDGeSS9QfhsFoC5l9s99LFNYc0cWQtcoAxpmDIp4uGFXZNh8rBj
GXWexajLTUjcoH+aJ91Ec20yCjG7KpD5i0JT1Q2S/9j5FXePCWpl0verMCYuUYXq
33tGyzZ75qY6Zde6HBGvqH3/7hD3vg==
=gbu2
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
