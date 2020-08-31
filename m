Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC19C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CF42098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0MfFI/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHaLxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaLxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECDC061573;
        Mon, 31 Aug 2020 04:53:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n22so716725edt.4;
        Mon, 31 Aug 2020 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GXk7qI7N4bQmfsEAs5tr94//1pxOpXUujDZHPwZhTbY=;
        b=t0MfFI/VvF3AgjVOr2OHiF3lYvL3eCHzR1fJ2mOyq+lHuQrkRAs35aw3SNjCdGXCn6
         uj2iNqgITBUKQyXGZIZMdsxpN6G4BNcrUCJEImuqTEtCfLAc6yxWChJyc/7TQEEOnYzl
         Ifty2wQ5KO8foMvO4QuEfGxL2tAaQHxnwYkkvy09LcqbZFnUy2qWnJtMA2RhQv6J8MtO
         LiPeEtHz3Xge7bpIJNEsYpGErrcPGmYxPUGmDqdjkVAybBXl0YSlk5YxN1ZrtVfUIp89
         gFxjKFkyEVdwjPpDT+cD8Dh8iyiwJRQb6V4LiXqsj6M2gjthUkbOfjHyGHog6h76d7hO
         5JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GXk7qI7N4bQmfsEAs5tr94//1pxOpXUujDZHPwZhTbY=;
        b=X6UpsrDFcl/JI1QDn8Ur4lHEuQx+AZZZpJIZoMzxvzwRSQTLLfC5mf05tQ16Qm5ts3
         fV34BHtyeRXLuLAhMdtCBLiFJLs9k3zqLdSd0NU4860r0llj8YeMeXgINPzgpWNUu5tr
         YZLrQF3V4VtqbKpYNgzLngGbIAbCYiFdoXjF35vWUpMwN4HkJJIR6UeEE41d4Fj39Ffb
         As5FTGMuvmLU3UMI/q1r+JQzj5G/inOgE5g/8J7gnUJxG0d8SV/J+oGDNLoTcLVIkp/2
         +fmPTUapLkhGHXio+Nzv1oo6U1vj0de/sMJ4un0D9kcacRWVdxqFaALelnm1Ps3KjdQ6
         fvAg==
X-Gm-Message-State: AOAM532HSUM3GfCPtf3bEqrMHLjOFtVfbrUXbf2pHaw1XXhqNq0IXEN/
        6FyGGHpL1rVM+YA0kKWadBA=
X-Google-Smtp-Source: ABdhPJzkhTekhK2NnvINKM71d6x+uStF50c9YcO/gEbkyLskv8ZfDqA1DyhgZbQXKcC8xiR1gNfbww==
X-Received: by 2002:a05:6402:10d3:: with SMTP id p19mr916991edu.380.1598874817936;
        Mon, 31 Aug 2020 04:53:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g25sm7328404edp.22.2020.08.31.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:53:36 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:53:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 04/12] phy: tegra: xusb: t210: add lane_iddq operations
Message-ID: <20200831115330.GB1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-5-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-5-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:40:35PM +0800, JC Kuo wrote:
> As per Tegra210 TRM, before changing lane assignments, driver should
> keep lanes in IDDQ and sleep state; after changing lane assignments,
> driver should bring lanes out of IDDQ.
> This commit implements the required operations.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 94 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.c          |  6 ++
>  drivers/phy/tegra/xusb.h          |  4 +-
>  3 files changed, 103 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-t=
egra210.c
> index 3a2d9797fb9f..fe1ab440424d 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -198,6 +198,18 @@
>  #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_TERM_EN BIT(18)
>  #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_MODE_OVRD BIT(13)
> =20
> +#define XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(x) (0x464 + (x) * 0x40)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ BIT(0)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD BIT(1)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK (0x3 << 4)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL (0x3 << 4)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD BIT(24)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ BIT(8)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD BIT(9)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK (0x3 << 12)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL (0x3 << 12)
> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD BIT(25)
> +
>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL1 0x860
> =20
>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL2 0x864
> @@ -209,6 +221,7 @@
>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL8 0x87c
> =20
>  #define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL1 0x960
> +#define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2 0x964
> =20
>  #define XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(x) (0xa60 + (x) * 0x40)
>  #define XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT 16
> @@ -1636,6 +1649,63 @@ static const struct tegra_xusb_pad_soc tegra210_hs=
ic_pad =3D {
>  	.ops =3D &tegra210_hsic_ops,
>  };
> =20
> +static void
> +tegra210_uphy_lane_iddq_enable(struct tegra_xusb_padctl *padctl, unsigne=
d lane)
> +{
> +	u32 val, offset;
> +
> +	if (lane <=3D 6)
> +		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
> +	else if (lane =3D=3D 7)
> +		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
> +	else {
> +		WARN(true, "invalid lane %u\n", lane);
> +		return;
> +	}
> +
> +	val =3D padctl_readl(padctl, offset);
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
> +	padctl_writel(padctl, val, offset);
> +}
> +
> +static void
> +tegra210_uphy_lane_iddq_disable(struct tegra_xusb_padctl *padctl, unsign=
ed lane)
> +{
> +	u32 val, offset;
> +
> +	if (lane <=3D 6)
> +		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
> +	else if (lane =3D=3D 7)
> +		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
> +	else {
> +		WARN(true, "invalid lane %d\n", lane);
> +		return;
> +	}
> +
> +	val =3D padctl_readl(padctl, offset);
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
> +	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
> +	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
> +	padctl_writel(padctl, val, offset);
> +}
> +
> +
>  static const char *tegra210_pcie_functions[] =3D {
>  	"pcie-x1",
>  	"usb3-ss",
> @@ -1808,9 +1878,21 @@ static void tegra210_pcie_lane_remove(struct tegra=
_xusb_lane *lane)
>  	kfree(pcie);
>  }
> =20
> +static void tegra210_pcie_lane_iddq_enable(struct tegra_xusb_lane *lane)
> +{
> +	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index);
> +}
> +
> +static void tegra210_pcie_lane_iddq_disable(struct tegra_xusb_lane *lane)
> +{
> +	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index);
> +}
> +
>  static const struct tegra_xusb_lane_ops tegra210_pcie_lane_ops =3D {
>  	.probe =3D tegra210_pcie_lane_probe,
>  	.remove =3D tegra210_pcie_lane_remove,
> +	.iddq_enable =3D tegra210_pcie_lane_iddq_enable,
> +	.iddq_disable =3D tegra210_pcie_lane_iddq_disable,
>  };
> =20
>  static int tegra210_pcie_phy_init(struct phy *phy)
> @@ -1971,9 +2053,21 @@ static void tegra210_sata_lane_remove(struct tegra=
_xusb_lane *lane)
>  	kfree(sata);
>  }
> =20
> +static void tegra210_sata_lane_iddq_enable(struct tegra_xusb_lane *lane)
> +{
> +	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index + 7);
> +}
> +
> +static void tegra210_sata_lane_iddq_disable(struct tegra_xusb_lane *lane)
> +{
> +	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index + 7);
> +}

This looks like abstraction at the wrong level. You introduce this
arbtitrary offset 7 to differentiate between the two types, whereas what
you really only seem to be after is to get the correct offset.

Can't we instead make tegra210_uphy_lane_iddq_{enable,disable}() take
the offset instead and push the logic to pick the offset into the
callers? We could then have an extra helper that determines the offset
=66rom the lane if we want to avoid duplicating that logic.

Or perhaps an even better way would be to store the offset to this MISC
register in struct tegra_xusb_lane_soc? Something like this perhaps:

    struct tegra_xusb_lane_soc {
        ...
        struct {
            unsigned int misc;
        } regs;
    };

That way we don't even have to go through two layers but instead can
operate on the struct tegra_xusb_lane directly.

> +
>  static const struct tegra_xusb_lane_ops tegra210_sata_lane_ops =3D {
>  	.probe =3D tegra210_sata_lane_probe,
>  	.remove =3D tegra210_sata_lane_remove,
> +	.iddq_enable =3D tegra210_sata_lane_iddq_enable,
> +	.iddq_disable =3D tegra210_sata_lane_iddq_disable,
>  };
> =20
>  static int tegra210_sata_phy_init(struct phy *phy)
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index b48b590aa0c1..74abd67e3a31 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -321,11 +321,17 @@ static void tegra_xusb_lane_program(struct tegra_xu=
sb_lane *lane)
>  	if (soc->num_funcs < 2)
>  		return;
> =20
> +	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
> +		lane->pad->ops->iddq_enable(lane);

You can drop the second check because it isn't relevant here.

> +
>  	/* choose function */
>  	value =3D padctl_readl(padctl, soc->offset);
>  	value &=3D ~(soc->mask << soc->shift);
>  	value |=3D lane->function << soc->shift;
>  	padctl_writel(padctl, value, soc->offset);
> +
> +	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
> +		lane->pad->ops->iddq_disable(lane);

Similarly, the first check can be dropped here because only the second
is relevant. It might make sense to only support IDDQ if both callbacks
are implemented, but that's not something we need to check at this
level. The check here is only to avoid calling a NULL function. If you
absolutely want to do sanity checks, do them at ->probe() time. But I
don't think we need that here. It's up to the developer to get this
right.

>  }
> =20
>  static void tegra_xusb_pad_program(struct tegra_xusb_pad *pad)
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 0c828694cf2d..485b692a3b15 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -22,6 +22,7 @@ struct phy;
>  struct phy_provider;
>  struct platform_device;
>  struct regulator;
> +struct tegra_xusb_padctl;
> =20
>  /*
>   * lanes
> @@ -126,6 +127,8 @@ struct tegra_xusb_lane_ops {
>  					 struct device_node *np,
>  					 unsigned int index);
>  	void (*remove)(struct tegra_xusb_lane *lane);
> +	void (*iddq_enable)(struct tegra_xusb_lane *lane);
> +	void (*iddq_disable)(struct tegra_xusb_lane *lane);
>  };
> =20
>  bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane, const char *fun=
ction);
> @@ -134,7 +137,6 @@ bool tegra_xusb_lane_check(struct tegra_xusb_lane *la=
ne, const char *function);
>   * pads
>   */
>  struct tegra_xusb_pad_soc;
> -struct tegra_xusb_padctl;
> =20
>  struct tegra_xusb_pad_ops {
>  	struct tegra_xusb_pad *(*probe)(struct tegra_xusb_padctl *padctl,

These last two hunks look like leftovers. I don't see why they are
needed here.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M5LQACgkQ3SOs138+
s6Ghkw//YI4c0PDUp2NZlN2Sk6ZPCpsy/Tztt0WRmu6b9WMymhXr4D9+jykl97BF
7LlDt9fi/E+vXdnTqHyTgACDq7zO5AeXrzE8g4az2/EeKRmxIN7eNxnnz2JAOipY
A7Q8GxBK40CmwgnuYAXk53jEFRRNRMQ9net9U9rX/ivJhNSuo2/L8oxXPdcXi9lS
AGsIy17GPYTBabxP1Eann2mgqjLQvH4JsQgkNOK0U3n7W6SdOpUWFOZjf9q8XhKH
Wj3brktQFS8bOg997ohdMZiif11QVieQmHsdOxbtbWwaLzOqalgCHQmUV7H6/aWJ
tdg/V4LNg+NzAiupC3pyB0Z9FFt3b5prJs36oECeBYkRhp6qKs6uhBBnJ4eToFbI
IAvbfaPqg6s+T9lwXkV93pTPP/vwKUQb6miXBKVIyYLfLlTZtCrVfJEzJ1Y5nXxW
s03X2KM//HRynwGuV602vYJ8xzLEIkGyjDWpumYQkIkt6KjNabSbZs1EIGQONa76
C/OZzIQVorHX/w5LAkR9aP8ulYcKNqXz/cXJyoacDeR6q5U9symFPWMQGDCbKD5m
6/KELU+TRrzpv4c8VoWIllZBTAm9hXDzYb4g6+FD6wpEFfkZ6GkwcMn+V0xXsGBQ
ZGKeKddkQtbYH+SwHl4Z/TRWJ4PgM6mvrPwevOasAniNiq9DTSE=
=hbGZ
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
