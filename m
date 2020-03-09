Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67DBC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E5122525
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583759631;
	bh=35FQ8G3j5ksoqdAlW7Zk4d/LBcnIMm9U8mBsQ+8SyYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohiLf6l47IGIwrsJTXf0/Q/0GuAdLstj21xJJ2SbgepcDc9icc56uKeeT2Zs5q2La
	 k665MnmmgZMrYKz3gT5jxPF7MiM0196MoTrrSXgHIx0nhQgIBsr/SzmtUVilbLomSK
	 poTBqem0ptF1wL973OYDDlQUvKmUuyRybDRz2w2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCINNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:13:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCINNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:13:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ACD630E;
        Mon,  9 Mar 2020 06:13:49 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6AE3F67D;
        Mon,  9 Mar 2020 06:13:48 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:13:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eason Yen <eason.yen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, jiaxin.yu@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] ASoC: codec: mediatek: add mt6359 codec driver
Message-ID: <20200309131346.GF4101@sirena.org.uk>
References: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
 <1583465622-16628-3-git-send-email-eason.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <1583465622-16628-3-git-send-email-eason.yen@mediatek.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2020 at 11:33:42AM +0800, Eason Yen wrote:

> +static void capture_gpio_reset(struct mt6359_priv *priv)
> +{
> +	/* set pad_aud_*_miso to GPIO mode and dir input
> +	 * reason:
> +	 * pad_aud_clk_miso, because when playback only the miso_clk
> +	 * will also have 26m, so will have power leak
> +	 * pad_aud_dat_miso*, because the pin is used as boot strap
> +	 */

This looks like things that might be better exposed via pinctrl and
gpiolib for board specific configuration - what exactly are these GPIOs
doing?  A lot of this code looks like it might be board specific.

> +/* use only when not govern by DAPM */
> +static int mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
> +{

Why might this sometimes be controlled outside of DAPM?

> +/* reg idx for -40dB*/
> +#define PGA_MINUS_40_DB_REG_VAL 0x1f
> +#define HP_PGA_MINUS_40_DB_REG_VAL 0x3f
> +static const char *const dl_pga_gain[] = {
> +	"8Db", "7Db", "6Db", "5Db", "4Db",
> +	"3Db", "2Db", "1Db", "0Db", "-1Db",
> +	"-2Db", "-3Db",	"-4Db", "-5Db", "-6Db",
> +	"-7Db", "-8Db", "-9Db", "-10Db", "-40Db"
> +};
> +
> +static const char *const hp_dl_pga_gain[] = {
> +	"8Db", "7Db", "6Db", "5Db", "4Db",
> +	"3Db", "2Db", "1Db", "0Db", "-1Db",
> +	"-2Db", "-3Db",	"-4Db", "-5Db", "-6Db",
> +	"-7Db", "-8Db", "-9Db", "-10Db", "-11Db",
> +	"-12Db", "-13Db", "-14Db", "-15Db", "-16Db",
> +	"-17Db", "-18Db", "-19Db", "-20Db", "-21Db",
> +	"-22Db", "-40Db"
> +};

I can't see any users of these tables in the driver?  That's good since
the driver should be translating these into TLV controls rather than
using enums but these variables aren't used then so should be removed.

> +
> +	if (!is_valid_hp_pga_idx(from) || !is_valid_hp_pga_idx(to))
> +		dev_warn(priv->dev, "%s(), volume index is not valid, from %d, to %d\n",
> +			 __func__, from, to);

Shouldn't we return an error then?

> +
> +	dev_info(priv->dev, "%s(), from %d, to %d\n",
> +		 __func__, from, to);

At most this should be a dev_dbg(), having a dev_info() log is going to
be far too verbose.  There's a lot of these in the driver.

> +static const char *const mic_type_mux_map[] = {
> +	"Idle",
> +	"ACC",
> +	"DMIC",
> +	"DCC",
> +	"DCC_ECM_DIFF",
> +	"DCC_ECM_SINGLE",
> +	"VOW_ACC",
> +	"VOW_DMIC",
> +	"VOW_DMIC_LP",
> +	"VOW_DCC",
> +	"VOW_DCC_ECM_DIFF",
> +	"VOW_DCC_ECM_SINGLE"
> +};

This looks like something that should be being set by DT or other
platform data rather than at runtime - we're not likely to change from a
digital to analogue microphone at runtime for example.

> +static int mt6359_put_volsw(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +			snd_soc_kcontrol_component(kcontrol);
> +	struct mt6359_priv *priv = snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +			(struct soc_mixer_control *)kcontrol->private_value;
> +	unsigned int reg;
> +	int index = ucontrol->value.integer.value[0];
> +	int ret;
> +
> +	ret = snd_soc_put_volsw(kcontrol, ucontrol);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mc->reg) {
> +	case MT6359_ZCD_CON2:
> +		regmap_read(priv->regmap, MT6359_ZCD_CON2, &reg);
> +		priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] =
> +			(reg >> RG_AUDHPLGAIN_SFT) & RG_AUDHPLGAIN_MASK;
> +		priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] =
> +			(reg >> RG_AUDHPRGAIN_SFT) & RG_AUDHPRGAIN_MASK;
> +		break;

It's unclear what's going on with this custom function.  As far as I can
see all it's doing is taking a copy of the gain setting for later use by
rampig functions but since we're immediately writing the set value into
the register map surely we don't need that as we can just read the value
back from the register?

> +static const struct snd_kcontrol_new mt6359_snd_controls[] = {
> +	/* dl pga gain */
> +	SOC_SINGLE_EXT_TLV("HeadsetL Volume",
> +			   MT6359_ZCD_CON2, 0, 0x1E, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw,
> +			   hp_playback_tlv),
> +	SOC_SINGLE_EXT_TLV("HeadsetR Volume",
> +			   MT6359_ZCD_CON2, 7, 0x1E, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw,
> +			   hp_playback_tlv),
> +	SOC_SINGLE_EXT_TLV("LineoutL Volume",
> +			   MT6359_ZCD_CON1, 0, 0x12, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw, playback_tlv),
> +	SOC_SINGLE_EXT_TLV("LineoutR Volume",
> +			   MT6359_ZCD_CON1, 7, 0x12, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw, playback_tlv),

These should be stereo controls not pairs of mono controls.

> +	/* ul pga gain */
> +	SOC_SINGLE_EXT_TLV("PGAL Volume",
> +			   MT6359_AUDENC_ANA_CON0, RG_AUDPREAMPLGAIN_SFT, 4, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw, capture_tlv),
> +	SOC_SINGLE_EXT_TLV("PGAR Volume",
> +			   MT6359_AUDENC_ANA_CON1, RG_AUDPREAMPRGAIN_SFT, 4, 0,
> +			   snd_soc_get_volsw, mt6359_put_volsw, capture_tlv),

Same here.

> +static const char * const lo_in_mux_map[] = {
> +	"Open", "Playback_L_DAC", "Playback", "Test Mode"
> +};
> +
> +static int lo_in_mux_map_value[] = {
> +	0x0, 0x1, 0x2, 0x3,
> +};

Why use a value enum here, a normal mux should be fine?

> +static int mt_delay_250_event(struct snd_soc_dapm_widget *w,
> +			      struct snd_kcontrol *kcontrol,
> +			      int event)
> +{
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +	case SND_SOC_DAPM_PRE_PMD:
> +		usleep_range(250, 270);

Why would having a sleep before power down be useful?

> +static int mt6359_codec_probe(struct snd_soc_component *cmpnt)
> +{
> +	struct mt6359_priv *priv = snd_soc_component_get_drvdata(cmpnt);
> +	int ret;
> +
> +	snd_soc_component_init_regmap(cmpnt, priv->regmap);
> +
> +	snd_soc_add_component_controls(cmpnt,
> +				       mt6359_snd_vow_controls,
> +				       ARRAY_SIZE(mt6359_snd_vow_controls));

Use the controls member of the component driver struct.

> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] = 8;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] = 8;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1] = 3;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2] = 3;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP3] = 3;

These should be left at the hardware defaults.

> +	priv->avdd_reg = devm_regulator_get(priv->dev, "vaud18");
> +	if (IS_ERR(priv->avdd_reg)) {
> +		dev_err(priv->dev, "%s(), have no vaud18 supply", __func__);
> +		return PTR_ERR(priv->avdd_reg);
> +	}

The driver should request resources during device model probe rather
than component probe.

> +	ret = regulator_enable(priv->avdd_reg);
> +	if (ret)
> +		return ret;
> +

There's nothing to disable this on remove.

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mQQkACgkQJNaLcl1U
h9DX5Af/ZXEkllI5PwLFc3+3O8BAAFuHXUMEpdJcOuRRbpDI/b75g0ksRcz1vyXG
UYtDhpLHnj5zofuVANdhydI13V32Yx034ouL9Q0S6aS/fGRIa802yamSKh0O4fys
Of5CMYR/5WaN7l6s143v3MlBJidu0bkw9XVX/Gl/MveEnXRM8Ch0Jbme29Wah+9c
IUtxbwU9s5y0ARbxUsm5vYILnoWIGADDQBDRYJDKYwvgUskiERFiR0+PWUie9hs9
hmImd1VmfXoKe6bC3NGFu96DuzTv6GOlA8JhfJpddifrIATZwAL3CksEzBaylQl6
PJSoObx4lvvIWT0DWP9kUrcsytDe7g==
=XoPC
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
