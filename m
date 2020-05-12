Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96639C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E4420722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589279600;
	bh=iOtZ2eVyp6uykbgj4qii/+7h1t5fhrWXPOp64vb39Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=asbTw9zm7i0ZO3GthB2gMHUsIeyaT9tvS5xPKibtd4EXK2GjNbSBcR4Q6yUR2WWhk
	 TgXpazANP4BfXIApx/m3H/O8qQN9kM8kVsvPf5wPQnHC76grox6GLiWvymS6DyU2E1
	 2PJ7g2g2mnP2DIzNDnBPTsjBN1Pflycrafw99HhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgELKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgELKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:33:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D009206DD;
        Tue, 12 May 2020 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279598;
        bh=iOtZ2eVyp6uykbgj4qii/+7h1t5fhrWXPOp64vb39Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUBRFPsWwF1B/9EwmQHd1AszTkgFtKc1UlbdnkEZkL8PWqW/9u4peAjCF+tt6E6/k
         E2WpIRHdC4aCOqXDTK9uUqPZlo4WtTgZZUCSs3QizExQM/zrBSNpO0mlLX1X4Nxi/Y
         nxYlTjJe8u1e3cUxYpbX6qxs71/8IbdwTgrMks64=
Date:   Tue, 12 May 2020 11:33:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        krzk@kernel.org, dmurphy@ti.com, jack.yu@realtek.com,
        nuno.sa@analog.com, steves.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200512103316.GB5110@sirena.org.uk>
References: <20200509031919.9006-1-steves.lee@maximintegrated.com>
 <20200511110346.GE8216@sirena.org.uk>
 <CABff4NQXs622x1X6ZvNABHNZoTMS57f4Y5sdo1Cng3JeTgboCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <CABff4NQXs622x1X6ZvNABHNZoTMS57f4Y5sdo1Cng3JeTgboCw@mail.gmail.com>
X-Cookie: The only perfect science is hind-sight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2020 at 06:13:05PM +0900, Steve Lee wrote:
> On Mon, May 11, 2020 at 8:03 PM Mark Brown <broonie@kernel.org> wrote:

> > > +static const char * const max98390_current_limit_text[] = {
> > > +     "0.00A", "0.50A", "1.00A", "1.05A", "1.10A", "1.15A", "1.20A", "1.25A",
> > > +     "1.30A", "1.35A", "1.40A", "1.45A", "1.50A", "1.55A", "1.60A", "1.65A",

> > This looks like it should be in DT too.

> Since this control  is needed while running system according to system
> battery situation.
> I'd keep this mixer for further use.

That's...  interesting for a current limit, and sounds like it would
have issues for the common case use of current limits to protect the
hardware.

> > > +static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
> > > +             struct snd_ctl_elem_value *ucontrol)
> > > +{
> > > +     struct snd_soc_component *component =
> > > +             snd_soc_kcontrol_component(kcontrol);
> > > +
> > > +     dev_warn(component->dev, "Get dsm_calib_get not supported\n");
> > > +
> > > +     return 0;
> > > +}

> > Just don't implement the operation if you can't implement it.

> If this not exist as dummy operation and all mixer was not working and
> could not implement better idea.

Could you be more specific about what you mean by "not working" or how
simply not initializing the value returned fixes things please?

> Could you consider it as with warn message ?

No, if there's a problem here we should fix it properly.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl66e2sACgkQJNaLcl1U
h9CQogf/R4loaD+oS7rnJp6kgm9vB0jnWzpi3rqYFNStSnuHqRBItJeYQU5jCjuT
A+pMPMF6GX70+4mnWRA7Lj54J5JDWqGX39pARZYckUdT82q/xwi5EJdjPN18wqQn
sP/GFgc+qi8It3N+2HJOXtHuUO+MhG12PpRVJ87lH3JVzM1pmOFsBjsb82DXTQL0
lmq8EqokSzxiY4M1b7bNjIyEqI6Lm53IGo16zfqapaNdjbvN14Y7/Ma4oVcBUhXA
0fezppgi5AzD8HgWAVhPHxfaCCUrIjW2mE8c31K6oHma6SkvXT+Ys045NXX4YUJw
qz/dy7x/0rIvjJKMcOFFXHYU/KPRPw==
=msPs
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
