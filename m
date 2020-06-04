Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F186CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF746207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591277991;
	bh=a8wHNkwWkFqf5+XQaD/hLiY3eO+xKNajms4eYM3X5Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pmEI02SlB/CjA9qHBT95nrmZ+rgZkN3gg+qY7XJVJ7EvL7dmQczJMzbqZppF1eHO8
	 IpVSwH2qwJ9oFo9zsMX8/02UCEbdYncZTlKF5OGHHJr14iV3HcTYFdcgd4CFR2nwRw
	 xAF04ZSy77zhnp3BWSaoBbxjpZRzCFjuYxuknHE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFDNjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgFDNjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:39:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D0B206E6;
        Thu,  4 Jun 2020 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591277986;
        bh=a8wHNkwWkFqf5+XQaD/hLiY3eO+xKNajms4eYM3X5Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwdC6HrVD8bGrwrQZZr5uLGot92oYLSbeHZrBiWEVTv3OpEUSA94yK6rIRMaK31xh
         YDTq6srJeMsUYylPDg27kY820ipoxkJ9+mcY8OSvZIi5E322iSR+zv9unnBeE3MMs3
         GcFuchpIvNQXNVI7neT42ZSFZWTcZh5dvMK74Xwg=
Date:   Thu, 4 Jun 2020 14:39:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH] regulator: mt6360: Add support for MT6360 regulator
Message-ID: <20200604133943.GE6644@sirena.org.uk>
References: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 03:06:27PM +0800, Gene Chen wrote:

This looks nice and simple, a few fairly small comments below but high
level it's basically fine.

> --- /dev/null
> +++ b/drivers/regulator/mt6360-regulator.c
> @@ -0,0 +1,571 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.

Please make the entire comment a C++ one so things look more
intentional.

> +	for (i = 0; i < devdata->num_irq_descs; i++) {
> +		irq_desc = devdata->irq_descs + i;
> +		if (unlikely(!irq_desc->name))
> +			continue;

Do we really need an unlikely here?  This shouldn't be a hot path.

> +static int mt6360_regulator_set_mode(
> +				  struct regulator_dev *rdev, unsigned int mode)
> +{

> +	switch (1 << (ffs(mode) - 1)) {
> +	case REGULATOR_MODE_NORMAL:

I don't understand why this isn't just a straight switch on mode?

> +static unsigned int mt6360_regulator_get_mode(struct regulator_dev *rdev)
> +{
> +	const struct mt6360_regulator_desc *desc =
> +			       (const struct mt6360_regulator_desc *)rdev->desc;
> +	int shift = ffs(desc->mode_get_mask) - 1, ret;
> +	unsigned int val = 0;
> +
> +	default:
> +		ret = 0;
> +	}

If we can't parse a valid value from the hardware then that's an error.

> +static int mt6360_regulator_reg_write(void *context,
> +				      unsigned int reg, unsigned int val)
> +{
> +	struct mt6360_regulator_data *mrd = context;
> +	u8 chunk[4] = {0};
> +
> +	/* chunk 0 ->i2c addr, 1 -> reg_addr, 2 -> reg_val 3-> crc8 */
> +	chunk[0] = (mrd->i2c->addr & 0x7f) << 1;
> +	chunk[1] = reg & 0x3f;
> +	chunk[2] = (u8)val;
> +	chunk[3] = crc8(mrd->crc8_table, chunk, 3, 0);
> +	/* also dummy one byte */
> +	return i2c_smbus_write_i2c_block_data(mrd->i2c, chunk[1], 3, chunk + 2);
> +}

Oh, wow - that's a fun I/O interface!

> +static const struct of_device_id __maybe_unused mt6360_regulator_of_id[] = {
> +	{
> +		.compatible = "mediatek,mt6360_pmic",
> +		.data = (void *)&mt6360_pmic_devdata,
> +	},
> +	{
> +		.compatible = "mediatek,mt6360_ldo",
> +		.data = (void *)&mt6360_ldo_devdata,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_regulator_of_id);

I don't see any DT bindings documentation for this, documentation is
required for all new bindings.

> +	mrd->regmap = devm_regmap_init(&(mrd->i2c->dev),
> +				       NULL, mrd, devdata->regmap_config);
> +	if (IS_ERR(mrd->regmap)) {
> +		dev_err(&pdev->dev, "Failed to register regmap\n");
> +		return PTR_ERR(mrd->regmap);
> +	}

This looks like a MFD so it's surprising to see us defining a regmap at
this level.  Why are we doing this?

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Y+Z8ACgkQJNaLcl1U
h9DRUgf/Q07BCU3NVKHL/ESM60sLn9muFqxQNcAmFlGBR5bDLKsDToWTKNlTLQuv
W2REKAvgWpj9dLzCIWOnMEJob8jsw3SSx5fzUNDq+WJLlzhf4MPQkG+/B5kOs7A8
aCE35WQGvrfMs8zbQmA9VJxUVOHqnyoaUK86E73iUPAWShBSxH2AaVsi1WUqN53g
LPnVfJ2MvnJLE3z6nmcMof9PXxdA48vrM2Wes0XL3rVUQkuxz9xPKThmtGUUqDoe
Rx7F5rOP4r8Rq1lT1ac/U1X3AvqMyTK+9jniD9efE6zlLzlquzOjHyMxul1Z6Ok1
MusCOVNvor+RxHuCDiY2mnZXflShXQ==
=4cA0
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
