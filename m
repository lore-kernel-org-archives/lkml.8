Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CEEC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6260207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Mua0vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHaLmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:42:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533AFC061573;
        Mon, 31 Aug 2020 04:42:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so5109484edk.6;
        Mon, 31 Aug 2020 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Duh1V085veXGe65AU6M3+q7eVYSTOZ5DljpuqDKUcVA=;
        b=V7Mua0vzsymkuA4Ully/sJn+hoJqt3u/HxARTSL+0Ytd3Hx7StMN9oj6S4TkRXJINo
         hPPcEvcBoIVfIQUK/09A1Fbp8r5STkk5ePaJT0F53hcIbwNer8JEZEU9W0+6d+UXSlir
         0etcaPK/VMVKtUdUi/SfvmCDgMb1Z7QI+NEhMJsFLZohwHhd/2MmWY5jiGNRNIABPvc+
         TDhP36uf3H6m8OZnHa3lnOd6RHpnAD64iI7g5uojPU+kiHh5OlNA/KRPOak4H0XZbmX5
         rrDuXk4HzoUZH2wc5uJsCYebex7Od9AOd+u+Z6rrIj6kFVZJ24xlvibO2Sk10sKo7W8X
         ewpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Duh1V085veXGe65AU6M3+q7eVYSTOZ5DljpuqDKUcVA=;
        b=LxMv6s+3fOZqrsmNJJtQcMr4PJ2RF+JopPNlioZsLeCClXHHhYbYNhI0PS3TBe84FI
         RSL4gnXIgc2OPwhHwf2f/SKkYJBYdCviCgSkIG2QS6WBH3UpbVPfGwjE33RFLqk/KQeY
         8GPCyUwqqEqTeio030S/nnx9A6FU0e8Z80FAHzK7ovpf7ZIx3gSlsXlFOmM5f9jhcCX7
         6psjAbQqp0mm0hMlm6JNn1fxOr0OBtxWBs97n1jZI0+PnjD9jUTJKXlfHvAqCYETJ3Vu
         2OpeDQi8vOWb/j1kqfZQu1lnlnuNDZlDGUaOBgMtkGfaj45DtIsRVZ5ZF5jYUu8voxRV
         V6JA==
X-Gm-Message-State: AOAM533XzKxOxmRd5V44kyuDIrRRxyfz4gLL+QJtZVFgsXR5j1J7ca0J
        sNPwAfSC0x03PBygUoblW7U=
X-Google-Smtp-Source: ABdhPJwsJIHZoMgqd7ZW/2RTScLUQLgKsk4NYHNIy5V6Q8TJjEGbSiQw2r3F3b4eduhRG4ndrkaChQ==
X-Received: by 2002:aa7:dcd9:: with SMTP id w25mr803949edu.280.1598874134641;
        Mon, 31 Aug 2020 04:42:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o60sm7292704eda.30.2020.08.31.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:42:13 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:42:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 03/12] phy: tegra: xusb: t210: rearrange UPHY init
Message-ID: <20200831114212.GA1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-4-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-4-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please start commit subjects with a capital letter after the prefix.
Also, please avoid t210 as abbreviation and use tegra210 instead.

The above should be something like:

    phy: tegra: xusb: tegra210: Rearrange UPHY init

Or perhaps:

    phy: tegra: xusb: Rearrange UPHY init on Tegra210

On Mon, Aug 31, 2020 at 12:40:34PM +0800, JC Kuo wrote:
> This commit is a preparation for enabling XUSB SC7 support.
> It rearranges Tegra210 XUSB PADCTL UPHY initialization sequence,
> for the following reasons:
>=20
> 1. PLLE hardware power sequencer has to be enabled only after both
>    PEX UPHY PLL and SATA UPHY PLL are initialized.
>    tegra210_uphy_init() -> tegra210_pex_uphy_enable()
>                         -> tegra210_sata_uphy_enable()
>                         -> tegra210_plle_hw_sequence_start()
>                         -> tegra210_aux_mux_lp0_clamp_disable()
>=20
> 2. Once UPHY PLL hardware power sequencer is enabled, do not assert
>    reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be
>    broken.
>    reset_control_assert(pcie->rst) and reset_control_assert(sata->rst)
>    are removed from PEX/SATA UPHY disable procedure.
>=20
> 3. At cold boot and SC7 exit, the following bits must be cleared after
>    PEX/SATA lanes are out of IDDQ (IDDQ_DISABLE=3D1).
>    a. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN,
>    b. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN_EARLY
>    c. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN
>=20
>    tegra210_pex_uphy_enable() and tegra210_sata_uphy_enable() are in
>    charge of bringing lanes out of IDDQ, and then AUX_MUX_LP0_* bits
>    will be cleared by tegra210_aux_mux_lp0_clamp_disable().
>=20
> 4. The programming sequence in tegra210_usb3_port_enable() is required
>    for both cold boot and SC7 exit, and must be performed only after
>    PEX/SATA UPHY is initialized. Therefore, this commit moves the
>    programming sequence to .power_on() stub which is invoked after
>    .init(). PEX/SATA UPHY is initialzied in .init().
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 495 ++++++++++++++++--------------
>  drivers/phy/tegra/xusb.c          |   2 +-
>  drivers/phy/tegra/xusb.h          |   6 +-
>  3 files changed, 270 insertions(+), 233 deletions(-)

You've listed 4 logically separate changes in the commit message, so I'm
wondering if it's possible to split this patch into 4 different ones. It
might not be worth doing that if they all basically fix the sequence in
one go, but it's pretty difficult to review this as-is.

>=20
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-t=
egra210.c
> index 66bd4613835b..3a2d9797fb9f 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -256,23 +256,52 @@ to_tegra210_xusb_padctl(struct tegra_xusb_padctl *p=
adctl)
>  	return container_of(padctl, struct tegra210_xusb_padctl, base);
>  }
> =20
> +static const struct tegra_xusb_lane_map tegra210_usb3_map[] =3D {
> +	{ 0, "pcie", 6 },
> +	{ 1, "pcie", 5 },
> +	{ 2, "pcie", 0 },
> +	{ 2, "pcie", 3 },
> +	{ 3, "pcie", 4 },
> +	{ 3, "pcie", 4 },
> +	{ 0, NULL,   0 }
> +};
> +
> +static int tegra210_usb3_lane_map(struct tegra_xusb_lane *lane)
> +{
> +	const struct tegra_xusb_lane_map *map;
> +
> +	for (map =3D tegra210_usb3_map; map->type; map++) {
> +		if (map->index =3D=3D lane->index &&
> +		    strcmp(map->type, lane->pad->soc->name) =3D=3D 0) {
> +			dev_dbg(lane->pad->padctl->dev,
> +				"lane =3D %s map to port =3D usb3-%d\n",

"mapped to port"?

> +				lane->pad->soc->lanes[lane->index].name,
> +				map->port);
> +			return map->port;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /* must be called under padctl->lock */
>  static int tegra210_pex_uphy_enable(struct tegra_xusb_padctl *padctl)
>  {
>  	struct tegra_xusb_pcie_pad *pcie =3D to_pcie_pad(padctl->pcie);
>  	unsigned long timeout;
>  	u32 value;
> -	int err;
> +	int err, i;

i should be unsigned to match the type of padctl->pcie->soc->num_lanes.

> =20
> -	if (pcie->enable > 0) {
> -		pcie->enable++;
> +	if (pcie->enable)
>  		return 0;
> -	}
> =20
>  	err =3D clk_prepare_enable(pcie->pll);
>  	if (err < 0)
>  		return err;
> =20
> +	if (tegra210_plle_hw_sequence_is_enabled())
> +		goto skip_pll_init;
> +
>  	err =3D reset_control_deassert(pcie->rst);

Is it guaranteed that the reset is asserted if the PLLE HW sequencer is
enabled? I suppose with the change to not enable the sequencer by
default in one of the earlier patches this may indeed be a valid
assumption.

>  	if (err < 0)
>  		goto disable;
> @@ -455,7 +484,14 @@ static int tegra210_pex_uphy_enable(struct tegra_xus=
b_padctl *padctl)
> =20
>  	tegra210_xusb_pll_hw_sequence_start();
> =20
> -	pcie->enable++;
> +skip_pll_init:
> +	pcie->enable =3D true;
> +
> +	for (i =3D 0; i < padctl->pcie->soc->num_lanes; i++) {
> +		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
> +		value |=3D XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
> +	}
> =20
>  	return 0;
> =20
> @@ -469,34 +505,42 @@ static int tegra210_pex_uphy_enable(struct tegra_xu=
sb_padctl *padctl)
>  static void tegra210_pex_uphy_disable(struct tegra_xusb_padctl *padctl)
>  {
>  	struct tegra_xusb_pcie_pad *pcie =3D to_pcie_pad(padctl->pcie);
> +	u32 value;
> +	int i;

Same as above.

> =20
> -	mutex_lock(&padctl->lock);
> -
> -	if (WARN_ON(pcie->enable =3D=3D 0))
> -		goto unlock;
> +	if (WARN_ON(!pcie->enable))
> +		return;
> =20
> -	if (--pcie->enable > 0)
> -		goto unlock;
> +	pcie->enable =3D false;
> =20
> -	reset_control_assert(pcie->rst);
> +	for (i =3D 0; i < padctl->pcie->soc->num_lanes; i++) {
> +		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
> +		value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
> +	}
>  	clk_disable_unprepare(pcie->pll);

Please leave a blank line after a block for better readability.

> -
> -unlock:
> -	mutex_unlock(&padctl->lock);
>  }
> =20
>  /* must be called under padctl->lock */
> -static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl, b=
ool usb)
> +static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl)
>  {
>  	struct tegra_xusb_sata_pad *sata =3D to_sata_pad(padctl->sata);
> +	struct tegra_xusb_lane *lane =3D tegra_xusb_find_lane(padctl, "sata", 0=
);
>  	unsigned long timeout;
>  	u32 value;
> -	int err;
> +	int err, i;

Same comment as above for "i".

> +	bool usb;
> =20
> -	if (sata->enable > 0) {
> -		sata->enable++;
> +	if (sata->enable)

Do we want a WARN_ON() here for symmetry with the implementation of
tegra210_sata_uphy_disable() below?

>  		return 0;
> -	}
> +
> +	if (!lane)
> +		return 0;
> +
> +	if (tegra210_plle_hw_sequence_is_enabled())
> +		goto skip_pll_init;
> +
> +	usb =3D tegra_xusb_lane_check(lane, "usb3-ss");
> =20
>  	err =3D clk_prepare_enable(sata->pll);
>  	if (err < 0)
> @@ -697,7 +741,14 @@ static int tegra210_sata_uphy_enable(struct tegra_xu=
sb_padctl *padctl, bool usb)
> =20
>  	tegra210_sata_pll_hw_sequence_start();
> =20
> -	sata->enable++;
> +skip_pll_init:
> +	sata->enable =3D true;
> +
> +	for (i =3D 0; i < padctl->sata->soc->num_lanes; i++) {
> +		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
> +		value |=3D XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
> +	}
> =20
>  	return 0;
> =20
> @@ -711,31 +762,26 @@ static int tegra210_sata_uphy_enable(struct tegra_x=
usb_padctl *padctl, bool usb)
>  static void tegra210_sata_uphy_disable(struct tegra_xusb_padctl *padctl)
>  {
>  	struct tegra_xusb_sata_pad *sata =3D to_sata_pad(padctl->sata);
> +	u32 value;
> +	int i;

unsigned int, please.

> =20
> -	mutex_lock(&padctl->lock);
> -
> -	if (WARN_ON(sata->enable =3D=3D 0))
> -		goto unlock;
> +	if (WARN_ON(!sata->enable))
> +		return;
> =20
> -	if (--sata->enable > 0)
> -		goto unlock;
> +	sata->enable =3D false;
> =20
> -	reset_control_assert(sata->rst);
> +	for (i =3D 0; i < padctl->sata->soc->num_lanes; i++) {
> +		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
> +		value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
> +	}
>  	clk_disable_unprepare(sata->pll);
> -
> -unlock:
> -	mutex_unlock(&padctl->lock);
>  }
> =20
> -static int tegra210_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
> +static void tegra210_aux_mux_lp0_clamp_disable(struct tegra_xusb_padctl =
*padctl)
>  {
>  	u32 value;
> =20
> -	mutex_lock(&padctl->lock);
> -
> -	if (padctl->enable++ > 0)
> -		goto out;
> -
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>  	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
> @@ -751,24 +797,12 @@ static int tegra210_xusb_padctl_enable(struct tegra=
_xusb_padctl *padctl)
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>  	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
> -
> -out:
> -	mutex_unlock(&padctl->lock);
> -	return 0;
>  }
> =20
> -static int tegra210_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
> +static void tegra210_aux_mux_lp0_clamp_enable(struct tegra_xusb_padctl *=
padctl)
>  {
>  	u32 value;
> =20
> -	mutex_lock(&padctl->lock);
> -
> -	if (WARN_ON(padctl->enable =3D=3D 0))
> -		goto out;
> -
> -	if (--padctl->enable > 0)
> -		goto out;
> -
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>  	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
> @@ -784,12 +818,36 @@ static int tegra210_xusb_padctl_disable(struct tegr=
a_xusb_padctl *padctl)
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>  	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
> +}
> +
> +static int tegra210_uphy_init(struct tegra_xusb_padctl *padctl)
> +{
> +	if (padctl->pcie)
> +		tegra210_pex_uphy_enable(padctl);
> +	if (padctl->sata)
> +		tegra210_sata_uphy_enable(padctl);
> +
> +	if (!tegra210_plle_hw_sequence_is_enabled())
> +		tegra210_plle_hw_sequence_start();
> +	else
> +		dev_dbg(padctl->dev, "PLLE is already in HW control\n");
> +
> +	tegra210_aux_mux_lp0_clamp_disable(padctl);
> =20
> -out:
> -	mutex_unlock(&padctl->lock);
>  	return 0;
>  }
> =20
> +static void __maybe_unused
> +tegra210_uphy_deinit(struct tegra_xusb_padctl *padctl)
> +{
> +	tegra210_aux_mux_lp0_clamp_enable(padctl);

Do we need tegra210_plle_hw_sequence_stop() here?

> +
> +	if (padctl->pcie)
> +		tegra210_pex_uphy_disable(padctl);
> +	if (padctl->sata)
> +		tegra210_sata_uphy_disable(padctl);

Maybe reverse the order of these two so that they are symmetrical with
tegra210_uphy_init()? Also, single blank lines between the two blocks
make this easier to read, in my opinion.

Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M4hEACgkQ3SOs138+
s6EI2hAApNax2Figu58Vn9NnvSW/ThTbFJ2/WPsRSW84s5KymTYdApMhBnb8Gbkn
xeIAdJeyrTqJuSWbRLXDb1UiypPJA40nwRjIZKWvXQId00E+F6vPf6h7ZFGWfPpU
AWBOEsQSCi7liBJWLg0oJC5LQedLv3uvRNNXMhiVmp188iWExlss5moSLg3YHVJW
DWDnHv82v+b3p/j/qMk9xKkAvyMh5uhpHuX9/6xInWwFST5Q2sHg2hsgRRma0onO
u0XaDxFqk8zgrQ6jCchL5dCnr51b9tNDWNqHwn08HZpCBeKrKkvduNhEl5oEV90J
3rhNNRCfssf/JBwwAfhA9oARxKQMvT3g6YuuJESVzZO27cZz4SFiKafUAtM/CwBL
+OpWkFe44xIovY30dJQWaQ6e/2GMJgWsRQm3ng34F67ruVLcUv0XaD758KskHcpQ
D5L2ypbi4SLQh7/PP0wn8uH84eGPQSi3ZjnjMjr6ET66VoreVGmYvVtenSEM1bEM
TYcnrEKLnwnO/FUa5LQ52isvXAes8O8roOAcW0U3HL2jhK2bjE0mQveZxSU3TSmK
0K+2YdLBNRCEnPEy3Z5uCa4ACfXip+Qs0lni6NmaHy8+gibYgpaDRDqqL1j74zoI
HbyUFTRd3n1M/FHmDcl8idFdYgikuFXZ9Yytw+4QoLsXl30agPk=
=aDUQ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
