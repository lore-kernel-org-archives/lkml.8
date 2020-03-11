Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E94DC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C3222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583928756;
	bh=QVxsETcRPWoRCxOeA/nWhlzZD95AnU1bOrahp1dqXog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DLq2OwO8DerQVj+tQQcdA49q7JF2iXOuG/F3012u2FZjdoRKj+mycY3zoZ8YK6iu0
	 67LKc+lBQJa+fIryHqu59d/3vn5JAPBp82Z7XvfKAwX+j+SyWH7jZ1jRNh5qtGjLlp
	 OlV1ZfQlRPUg6ujHxsPArAjWXKvR3rmdH9mIPeps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgCKMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:12:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgCKMMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141AC1FB;
        Wed, 11 Mar 2020 05:12:34 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8914C3F6CF;
        Wed, 11 Mar 2020 05:12:33 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:12:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eason Yen <eason.yen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, jiaxin.yu@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] ASoC: codec: mediatek: add mt6359 codec driver
Message-ID: <20200311121232.GB5411@sirena.org.uk>
References: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
 <1583465622-16628-3-git-send-email-eason.yen@mediatek.com>
 <20200309131346.GF4101@sirena.org.uk>
 <1583918544.19248.69.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <1583918544.19248.69.camel@mtkswgap22>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 05:22:24PM +0800, Eason Yen wrote:
> On Mon, 2020-03-09 at 13:13 +0000, Mark Brown wrote:
> > On Fri, Mar 06, 2020 at 11:33:42AM +0800, Eason Yen wrote:

> > This looks like things that might be better exposed via pinctrl and
> > gpiolib for board specific configuration - what exactly are these GPIOs
> > doing?  A lot of this code looks like it might be board specific.

> MT6359 has some gpios (pad_aud_*) for downlink/uplink.
> And these pins is connected between AP part and PMIC part.
> (1) For AP part, user need to set gpio pinmux for these gpio using DT.
> (2) For pmic part, gpio are configured at codec driver by default.

> For PMIC part, user need to set in these register :
> GPIO_MODE1/GPIO_MODE2/GPIO_MODE3

> The following functions are used to set:
> - playback_gpio_set/playback_gpio_reset
> - capture_gpio_set/capture_gpio_reset
> - vow_gpio_set/vow_gpio_reset

This sounds like it should be handled at the machine driver level, it's
possible some system integrator will wire things up differently.

> > > +/* use only when not govern by DAPM */
> > > +static int mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
> > > +{

> > Why might this sometimes be controlled outside of DAPM?

> mt6359_set_dcxo is used at mt6359_mtkaif_calibration_enable/disable.

> mtkaif_calibration process needs be completed at booting stage once.
> And it has a specific control sequence provided by codec designer.
> So it need to be controlled outside of DAPM.

OK, this should explicitly say that this is for use during calibration
then.

> > > +static const char *const mic_type_mux_map[] =3D {
> > > +	"Idle",
> > > +	"ACC",
> > > +	"DMIC",
> > > +	"DCC",
> > > +	"DCC_ECM_DIFF",
> > > +	"DCC_ECM_SINGLE",
> > > +	"VOW_ACC",
> > > +	"VOW_DMIC",
> > > +	"VOW_DMIC_LP",
> > > +	"VOW_DCC",
> > > +	"VOW_DCC_ECM_DIFF",
> > > +	"VOW_DCC_ECM_SINGLE"
> > > +};

> > This looks like something that should be being set by DT or other
> > platform data rather than at runtime - we're not likely to change from a
> > digital to analogue microphone at runtime for example.

> For mic1, it's mic_type can set one of mic_type_mux_map[] at different
> scenario.
> (1) When mic1 is not used, it should be set as "Idle"
> (2) When mic1 is ACC mode and used at normal capture scenario, it should
> be set as "ACC"
> (3) When mic1 is ACC mode and used at Voice Wakeup scenario, it should
> be set as "VOW_ACC"

That still doesn't mean you should have control over things like if the
microphone is single ended or differential at runtime.  This at least
needs to be a higher level control, it should be integrated with both
board data and DAPM.  You can at least select idle mode with DAPM, and
you may be able to select voice wakeup that way too (by looking at where
things are routed).

> > > +	SOC_SINGLE_EXT_TLV("LineoutR Volume",
> > > +			   MT6359_ZCD_CON1, 7, 0x12, 0,
> > > +			   snd_soc_get_volsw, mt6359_put_volsw, playback_tlv),

> > These should be stereo controls not pairs of mono controls.

> It is more flexible for customization.

> For example, customer may use lineout path for stereo speaker amp.
> And for specific amp, it need different gain on channel L and channel R.

You can set the gains of stereo pairs independently, that's not a
problem.

> > > +static const char * const lo_in_mux_map[] =3D {
> > > +	"Open", "Playback_L_DAC", "Playback", "Test Mode"
> > > +};
> > > +
> > > +static int lo_in_mux_map_value[] =3D {
> > > +	0x0, 0x1, 0x2, 0x3,
> > > +};
> >=20
> > Why use a value enum here, a normal mux should be fine?
> >=20

> Could I modify as follow:

> /* LOL MUX */
> enum {
> 	LO_MUX_OPEN =3D 0,
> 	LO_MUX_L_DAC,
> 	LO_MUX_3RD_DAC,
> 	LO_MUX_TEST_MODE,
> 	LO_MUX_MASK =3D 0x3,
> };

> static const char * const lo_in_mux_map[] =3D {
> 	"Open", "Playback_L_DAC", "Playback", "Test Mode"
> };

> static int lo_in_mux_map_value[] =3D {
> 	LO_MUX_OPEN,
> 	LO_MUX_L_DAC,
> 	LO_MUX_3RD_DAC,
> 	LO_MUX_TEST_MODE,
> };

Why bother with the value mapping at all?

> > > +static int mt_delay_250_event(struct snd_soc_dapm_widget *w,
> > > +			      struct snd_kcontrol *kcontrol,
> > > +			      int event)
> > > +{
> > > +	switch (event) {
> > > +	case SND_SOC_DAPM_POST_PMU:
> > > +	case SND_SOC_DAPM_PRE_PMD:
> > > +		usleep_range(250, 270);

> > Why would having a sleep before power down be useful?

> It is based on designer's control sequence to add some delay while
> PMU/PMD.

But how does the designer know when the sequence starts?  Don't they
mean to have a delay *after* power down?

> > > +static int mt6359_codec_probe(struct snd_soc_component *cmpnt)
> > > +{
> > > +	struct mt6359_priv *priv =3D snd_soc_component_get_drvdata(cmpnt);
> > > +	int ret;
> > > +
> > > +	snd_soc_component_init_regmap(cmpnt, priv->regmap);
> > > +
> > > +	snd_soc_add_component_controls(cmpnt,
> > > +				       mt6359_snd_vow_controls,
> > > +				       ARRAY_SIZE(mt6359_snd_vow_controls));

> > Use the controls member of the component driver struct.

> Do you mean that I should merge mt6359_snd_vow_controls into
> mt6359_snd_controls?

Yes, you're unconditionally registering these so there's no sense in
splitting them.

> > > +	priv->avdd_reg =3D devm_regulator_get(priv->dev, "vaud18");
> > > +	if (IS_ERR(priv->avdd_reg)) {
> > > +		dev_err(priv->dev, "%s(), have no vaud18 supply", __func__);
> > > +		return PTR_ERR(priv->avdd_reg);
> > > +	}

> > The driver should request resources during device model probe rather
> > than component probe.

> Do you mean that it need be requested at mt6359_platform_driver_probe()
> instead of mt6359_codec_probe() ?

Yes.

> > > +	ret =3D regulator_enable(priv->avdd_reg);
> > > +	if (ret)
> > > +		return ret;
> > > +

> > There's nothing to disable this on remove.

> Do you mean that I should add a remove function to execute
> regulator_disable()?

Yes.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5o1a8ACgkQJNaLcl1U
h9A3ZAf/fSGW262FFfaBIN8zruvv1AU7r7tMppnvX4z8VgxGv4Lky42aOvGd8NGT
4KyygigtShycEcaPm32mKpgw7t9cEpGEhqMwHbS+k8xNWDNmsQLKoGuV+7EcNQxA
LxvONiREyb+/DQvqvttPiS9KiWXz7b3DRVbI3gLFNEcECcYre6+A2lDxravhNRu5
SflQyk+sW2S1Br54xNSeJu4d+FOatyVgxYg2GKSOoLrIhleu8p20cL6pZlWRVFMO
lf7gMTnU0jwvL8/sjKSYWdAzLaFlOXYD7UtXyVHcQoVl+nEAnI4HSC3FLaWufL7M
tWazpUSkZz0rbfpeN+E3z4NoL/cJPg==
=i3NB
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
