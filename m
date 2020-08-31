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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943FF20EDD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO71JFCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHaMJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHaMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:09:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7BC061573;
        Mon, 31 Aug 2020 05:09:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d11so8087929ejt.13;
        Mon, 31 Aug 2020 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Unu49ykbOe62UJ6hfhQMQxQUKYYTm838oAdPCMhX9Y=;
        b=mO71JFCw5R6VlX2+LMfNXQHMxMK9WagGkJUUYEOQ8iePyeVPAftHQvGTJy0OeQN35W
         WRgu+KE4H42Pf4fh7IWWux5Dk15Vy/fyOyO3+sCGqQDPW/KRKmcmuMHzfmlhezcB6RbP
         p2gcc2nvUSJgO09EbLOPHW0dKcPwyHTntnyyp2vjRaBKge5W53ionoOBkBE9ueyOrmys
         ij4VVAt9ftqkQxZKqtiM50W3UEDbdXhvvDH2J7YWV0L4eQH7K/6vk6JpMRFyu6X9iy2c
         l/tcKRfvPuohV6j5y2UNYXLWttpPU6YRdhKTteI+/VtqvZtuVqsh+idEtwygYHznaR67
         qOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Unu49ykbOe62UJ6hfhQMQxQUKYYTm838oAdPCMhX9Y=;
        b=IDTxWXWlwMRf4iOcHQPysqN/MZKVRJZ6cE1CwleUugm+EZXszcN/bEHIN4p1jSomzs
         1dfhjaeGPlLZUP419q7n8LR4sEFC6HHupvWx1i1AzT3IcDtdhrOPcyWKJvyCmB9YeAxH
         C7TRQlGaDBhv08aI7tc2fWbOpK3m+XVxWAFRxEnuFw7fN0aoeoGWeojypnU0N0xrQUdV
         pdHkO5AL2ikLrzpDRhnzsgwAB67upfPwYV8bxZuP9gSOA+Cdkkp2D27TvruGLdkGTNOk
         MRwdvOJN4rdmTYF8v/dQ1vj08qpt8Y0XYge1HIcVsUGrLzPpvT1AQefGKXZTgpBxxih0
         NdjA==
X-Gm-Message-State: AOAM531CIE1kkGK7kYIjfb2rfZtQ2I7lQylEJxsKkJr5zxDdKmhmALXC
        BhtjKIx7ukQpuPbjHTThTgs=
X-Google-Smtp-Source: ABdhPJxSF7PvESnsLyseSn1BrphMlvXxYC2Q7IdafnhrEJI6Y40jd4vGdMUcqIlrlshBTLgxnGhWnA==
X-Received: by 2002:a17:906:3c47:: with SMTP id i7mr843963ejg.554.1598875751255;
        Mon, 31 Aug 2020 05:09:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r12sm7520787edx.59.2020.08.31.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:09:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:09:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 06/12] soc/tegra: pmc: provide usb sleepwalk register
 map
Message-ID: <20200831120908.GD1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-7-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-7-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:40:37PM +0800, JC Kuo wrote:
> This commit implements a register map which grants USB (UTMI and HSIC)
> sleepwalk registers access to USB phy drivers. The USB sleepwalk logic
> is in PMC hardware block but USB phy drivers have the best knowledge
> of proper programming sequence. This approach prevents using custom
> pmc APIs.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 89 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Same comment as in earlier patches regarding the subject and "USB PHY"
in the commit message.

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index d332e5d9abac..03317978915a 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -43,6 +43,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/regmap.h>
> =20
>  #include <soc/tegra/common.h>
>  #include <soc/tegra/fuse.h>
> @@ -102,6 +103,9 @@
> =20
>  #define PMC_PWR_DET_VALUE		0xe4
> =20
> +#define PMC_USB_DEBOUNCE_DEL		0xec
> +#define PMC_USB_AO			0xf0
> +
>  #define PMC_SCRATCH41			0x140
> =20
>  #define PMC_WAKE2_MASK			0x160
> @@ -133,6 +137,13 @@
>  #define IO_DPD2_STATUS			0x1c4
>  #define SEL_DPD_TIM			0x1c8
> =20
> +#define PMC_UTMIP_UHSIC_TRIGGERS	0x1ec
> +#define PMC_UTMIP_UHSIC_SAVED_STATE	0x1f0
> +
> +#define PMC_UTMIP_TERM_PAD_CFG		0x1f8
> +#define PMC_UTMIP_UHSIC_SLEEP_CFG	0x1fc
> +#define PMC_UTMIP_UHSIC_FAKE		0x218
> +
>  #define PMC_SCRATCH54			0x258
>  #define  PMC_SCRATCH54_DATA_SHIFT	8
>  #define  PMC_SCRATCH54_ADDR_SHIFT	0
> @@ -145,8 +156,18 @@
>  #define  PMC_SCRATCH55_CHECKSUM_SHIFT	16
>  #define  PMC_SCRATCH55_I2CSLV1_SHIFT	0
> =20
> +#define  PMC_UTMIP_UHSIC_LINE_WAKEUP	0x26c
> +
> +#define PMC_UTMIP_BIAS_MASTER_CNTRL	0x270
> +#define PMC_UTMIP_MASTER_CONFIG		0x274
> +#define PMC_UTMIP_UHSIC2_TRIGGERS	0x27c
> +#define PMC_UTMIP_MASTER2_CONFIG	0x29c
> +
>  #define GPU_RG_CNTRL			0x2d4
> =20
> +#define PMC_UTMIP_PAD_CFG0		0x4c0
> +#define PMC_UTMIP_UHSIC_SLEEP_CFG1	0x4d0
> +#define PMC_UTMIP_SLEEPWALK_P3		0x4e0
>  /* Tegra186 and later */
>  #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
>  #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
> @@ -334,6 +355,7 @@ struct tegra_pmc_soc {
>  	const struct pmc_clk_init_data *pmc_clks_data;
>  	unsigned int num_pmc_clks;
>  	bool has_blink_output;
> +	bool has_usb_sleepwalk;
>  };
> =20
>  static const char * const tegra186_reset_sources[] =3D {
> @@ -2495,6 +2517,67 @@ static void tegra_pmc_clock_register(struct tegra_=
pmc *pmc,
>  			 err);
>  }
> =20
> +#define regmap_reg(x) regmap_reg_range(x, x)

This doesn't seem like a good idea. What if anyone ever thought it was a
good idea to add this to the core regmap header? We'd get a naming
conflict that would first have to get resolved.

> +static const struct regmap_range pmc_usb_sleepwalk_ranges[] =3D {
> +	regmap_reg_range(PMC_USB_DEBOUNCE_DEL, PMC_USB_AO),
> +	regmap_reg_range(PMC_UTMIP_UHSIC_TRIGGERS, PMC_UTMIP_UHSIC_SAVED_STATE),
> +	regmap_reg_range(PMC_UTMIP_TERM_PAD_CFG, PMC_UTMIP_UHSIC_FAKE),
> +	regmap_reg(PMC_UTMIP_UHSIC_LINE_WAKEUP),
> +	regmap_reg_range(PMC_UTMIP_BIAS_MASTER_CNTRL, PMC_UTMIP_MASTER_CONFIG),
> +	regmap_reg_range(PMC_UTMIP_UHSIC2_TRIGGERS, PMC_UTMIP_MASTER2_CONFIG),
> +	regmap_reg_range(PMC_UTMIP_PAD_CFG0, PMC_UTMIP_UHSIC_SLEEP_CFG1),
> +	regmap_reg(PMC_UTMIP_SLEEPWALK_P3),
> +};

Since we only have two usages of the regmap_reg() macro, perhaps just
use regmap_reg_range() with the same parameter used twice?

> +
> +static const struct regmap_access_table pmc_usb_sleepwalk_table =3D {
> +	.yes_ranges =3D pmc_usb_sleepwalk_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(pmc_usb_sleepwalk_ranges),
> +};
> +
> +static int tegra_pmc_regmap_readl(void *context, unsigned int reg, unsig=
ned int *val)

s/reg/offset/ to make it clearer what this really is. Also: s/val/value/ to
avoid potential confusion with "valid".

> +{
> +	struct tegra_pmc *pmc =3D context;
> +
> +	*val =3D tegra_pmc_readl(pmc, reg);
> +	return 0;
> +}
> +
> +static int tegra_pmc_regmap_writel(void *context, unsigned int reg, unsi=
gned int val)
> +{
> +	struct tegra_pmc *pmc =3D context;
> +
> +	tegra_pmc_writel(pmc, val, reg);
> +	return 0;
> +}

Same here.

> +
> +static const struct regmap_config usb_sleepwalk_regmap_config =3D {
> +	.name =3D "usb_sleepwalk",
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.fast_io =3D true,
> +	.rd_table =3D &pmc_usb_sleepwalk_table,
> +	.wr_table =3D &pmc_usb_sleepwalk_table,
> +	.reg_read =3D tegra_pmc_regmap_readl,
> +	.reg_write =3D tegra_pmc_regmap_writel,
> +};
> +
> +static int tegra_pmc_regmap_init(struct tegra_pmc *pmc)
> +{
> +	struct regmap *regmap;
> +
> +	if (pmc->soc->has_usb_sleepwalk) {
> +		regmap =3D devm_regmap_init(pmc->dev, NULL, (__force void *)pmc,

Do you really need that __force in there?

> +					  &usb_sleepwalk_regmap_config);
> +		if (IS_ERR(regmap)) {
> +			dev_err(pmc->dev, "failed to allocate register map\n");

Maybe output the error code here?

> +			return PTR_ERR(regmap);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_pmc_probe(struct platform_device *pdev)
>  {
>  	void __iomem *base;
> @@ -2613,6 +2696,10 @@ static int tegra_pmc_probe(struct platform_device =
*pdev)
>  	pmc->base =3D base;
>  	mutex_unlock(&pmc->powergates_lock);
> =20
> +	err =3D tegra_pmc_regmap_init(pmc);
> +	if (err < 0)
> +		goto cleanup_powergates;

You could call this perhaps a little bit earlier to avoid having to
clean up powergates? Since you register with devm_regmap_init() you
won't have to clean this up manually.

For that reason it makes sense as a general rule to initialize devm
things before anything that's not managed (unless, of course, if it
doesn't make any sense).

> +
>  	tegra_pmc_clock_register(pmc, pdev->dev.of_node);
>  	platform_set_drvdata(pdev, pmc);
> =20
> @@ -2976,6 +3063,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc =
=3D {
>  	.pmc_clks_data =3D tegra_pmc_clks_data,
>  	.num_pmc_clks =3D ARRAY_SIZE(tegra_pmc_clks_data),
>  	.has_blink_output =3D true,
> +	.has_usb_sleepwalk =3D true,
>  };
> =20
>  static const char * const tegra210_powergates[] =3D {
> @@ -3094,6 +3182,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc =
=3D {
>  	.pmc_clks_data =3D tegra_pmc_clks_data,
>  	.num_pmc_clks =3D ARRAY_SIZE(tegra_pmc_clks_data),
>  	.has_blink_output =3D true,
> +	.has_usb_sleepwalk =3D true,
>  };
> =20
>  #define TEGRA186_IO_PAD_TABLE(_pad)                                     =
     \

I'd prefer if we explicitly set this to false on SoC generations where
we don't have sleepwalk support (or don't need to deal with it in the
kernel). That avoids confusion as to whether this was simply forgotten
or whether the omission was on purpose.

Thierry

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M6GIACgkQ3SOs138+
s6EaqxAAmPRgHbu6YpzkiKoq+XbNk+lFnWWy7ZVbp680XlcbUXFC14Li1NsWoNDb
XVmk2NIfxIpZWR1oPNlOYKCMZTF8cg3XeL4lTanUQDkpFLMCpa/dYjs8BdOu0EyS
yhz2ICzzt71Przr4FUxsJznmXPak10JIkq8SCF2vXRv5UhM1KiPzmUII7VE16UY4
OXkyQoFhF6NmrVHumw1yFPiHiRFwM506yraFBZULyBvJrkYfH5COocy5n1oIFO0P
u4wr3wwvf5XAlCSYeR3GynsGCc2e1qZ1pIw9FrptAgBnuyHOwGrzBZ+l/FWgrEo1
2t8v2eim/Jb5IvL5C/rs/67tAvY0zITf4N+0iH0JYA8RZ5NSlWxKOo7QhUP/0ixd
r1vlbceA8wYfTarrKnl26HMf1iJAqawxD/7nNgptRo179w8vaWPNN8eZZfmtkO9n
w/95A4hIf5lV+OpLH6jt91qeKgIpX/lCXW2L61ZW3DGHrc9W7EJ942HtV6MKrk5U
Z3Mar/SVM1fAv590MlVTlYhyfgAyMGyhzhJ0K8n6/fbVK0htAhkBKR5+ovwAxAx+
bzTQsB1k48GyFf9oO+JHJa1D0q7QAjVo/iw+vYLbhAoRKFkc/3OkzXL3idX8Kwso
BT/jqEvd5pMOxoAmkh4ZREk1GT0uTkxhzLG+guWTvKKId9hRgqM=
=G5F3
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
