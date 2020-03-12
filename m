Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC6C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF55206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584040090;
	bh=hHx6t98S977SRA4TCBM82gCidPzjcUUx/jzGeZah5ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWLWUr+s/A0WONTjWAWKnOdDBZVEKbwUp8AaZqGqifIQFr7ZfOcCfQKPy0Mvec6Op
	 fbWzEUizLoTjeQ6GRP7h4gxNxffy0ckssY+8e4ZxyqCIU57dQHBgCnquitmb7PYlZH
	 UALM0F4WpOBV5USGAjpHsWLT9jSLXir2/VDyOIRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCLTIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:08:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLTII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB4931B;
        Thu, 12 Mar 2020 12:08:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC0D3F67D;
        Thu, 12 Mar 2020 12:08:07 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:08:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eason Yen <eason.yen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, jiaxin.yu@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] ASoC: codec: mediatek: add mt6359 codec driver
Message-ID: <20200312190805.GJ4038@sirena.org.uk>
References: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
 <1583465622-16628-3-git-send-email-eason.yen@mediatek.com>
 <20200309131346.GF4101@sirena.org.uk>
 <1583918544.19248.69.camel@mtkswgap22>
 <20200311121232.GB5411@sirena.org.uk>
 <1583995387.19248.93.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <1583995387.19248.93.camel@mtkswgap22>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 02:43:07PM +0800, Eason Yen wrote:
> On Wed, 2020-03-11 at 12:12 +0000, Mark Brown wrote:
> > On Wed, Mar 11, 2020 at 05:22:24PM +0800, Eason Yen wrote:
> > > On Mon, 2020-03-09 at 13:13 +0000, Mark Brown wrote:

> > > The following functions are used to set:
> > > - playback_gpio_set/playback_gpio_reset
> > > - capture_gpio_set/capture_gpio_reset
> > > - vow_gpio_set/vow_gpio_reset

> > This sounds like it should be handled at the machine driver level, it's
> > possible some system integrator will wire things up differently.

> machine driver will set default at booting stage to execute
> mt6359_mtkaif_calibration_enable and mt6359_mtkaif_calibration_disable.

> And at runtime stage, it is triggered by mt_dl_gpio_event and
> mt_ul_gpio_event while playback or capture.

What I'm suggesting is moving those to the machine driver (you could
provide helpers in the CODEC driver for the common case I guess...  I'd
need to review).

> OK. So it is better to fix mic_type (ACC/DMIC/DCC/DCC_*) at init stage
> because it will not be changed at runtime.

> And use another dpam mux or kcontrol to enable/disable vow for low power
> scenario.

> Is it right?

Yes.

> enum {
> 	LO_MUX_OPEN =3D 0,
> 	LO_MUX_L_DAC,
> 	LO_MUX_3RD_DAC,
> 	LO_MUX_TEST_MODE,
> 	LO_MUX_MASK =3D 0x3,
> };
>=20
> static const char * const lo_in_mux_map[] =3D {
> 	"Open", "Playback_L_DAC", "Playback", "Test Mode"
> };
>=20
> static SOC_ENUM_SINGLE_DECL(lo_in_mux_map_enum,
> 			    SND_SOC_NOPM, 0, lo_in_mux_map);
>=20
> static const struct snd_kcontrol_new lo_in_mux_control =3D
> 	SOC_DAPM_ENUM("LO Select", lo_in_mux_map_enum);

That looks OK.

> > > > > +static int mt_delay_250_event(struct snd_soc_dapm_widget *w,
> > > > > +			      struct snd_kcontrol *kcontrol,
> > > > > +			      int event)
> > > > > +{
> > > > > +	switch (event) {
> > > > > +	case SND_SOC_DAPM_POST_PMU:
> > > > > +	case SND_SOC_DAPM_PRE_PMD:
> > > > > +		usleep_range(250, 270);

> > > > Why would having a sleep before power down be useful?

> > > It is based on designer's control sequence to add some delay while
> > > PMU/PMD.

> > But how does the designer know when the sequence starts?  Don't they
> > mean to have a delay *after* power down?

> For PMU, designer think=20
> "AUD_CK" --> wait at least 250ms --> "AUDIF_CK" --> next ...

> For PMD, designer think=20
> "AUDIF_CK" --> wait at least 250ms --> "AUD_CK" --> next ...

I think you need some comments about this in the code, it looks like a
mistake - it relies on the use of sequenced widgets, you should
reference that.

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qiJQACgkQJNaLcl1U
h9A1Mwf+N1pO4sNF/LaBs+cSdnnU3sQLV3n1MkuRRMZt7mBBrI4zc75gKrHYR8nk
aXh9Y8JGea1xMogpaaY2+7j6xlgNh6mctmrnljUJ+SZLp/rQJ+AaLxEvmvGmnVck
vYqpYD+1Q171m6WHnnJhSmMTP8ptnc5RDK7OAAmKz17ffZNUKpjn7pumtMqOYNtN
MoPdDMMwxGkAcjhcjtK503TYkKKuQz2dWjg6EFfNR3JMI7T5i4xCTx5HmUAy3Ggf
8KHYZsTMjmB/Kqqvxn8cMZolERI4bgPdqxexQIhLppLEF1l2VFLedSkTP3ltOkXn
V3AsCh8wfX9bzNY5xnfbKelzrJ+rbQ==
=zxsQ
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
