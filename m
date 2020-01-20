Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C314C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E3E22527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579547071;
	bh=MC3N+Wv4sZDY/KTjQ16DtpX5lwEApgsdi4mGAlS3ahk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJYQ2u4HHsEITwX1RHjVrNYz3iik6v5w96mN8badL0VOnzxsiDXv+iNWHsU/RmXED
	 gszDY74d2htY29vlqFsomHN3rZm6EYJ6+3YN/vfYjbtmwYYXo1ejTy81epOXFGIIid
	 odprPeakdo2osM6fRqnCjODkUgpoL6eO3XlnKm70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgATTEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:04:30 -0500
Received: from foss.arm.com ([217.140.110.172]:35904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATTEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:04:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A43931B;
        Mon, 20 Jan 2020 11:04:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08FCE3F68E;
        Mon, 20 Jan 2020 11:04:28 -0800 (PST)
Date:   Mon, 20 Jan 2020 19:04:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 3/4] regulator: mt6359: Add support for MT6359 regulator
Message-ID: <20200120190427.GO6852@sirena.org.uk>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
 <1579506450-21830-4-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qa0ccP92Gc0Ko3P8"
Content-Disposition: inline
In-Reply-To: <1579506450-21830-4-git-send-email-Wen.Su@mediatek.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qa0ccP92Gc0Ko3P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 03:47:29PM +0800, Wen Su wrote:

This seems pretty good, a few comments below but they're fairly small
and should be easy to address:

> +static int mt6359_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	int idx, ret;
> +	const u32 *pvol;
> +	struct mt6359_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	pvol = info->index_table;
> +
> +	idx = pvol[selector];
> +	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
> +				 info->desc.vsel_mask,
> +				 idx << info->vsel_shift);
> +
> +	return ret;
> +}

This looks like you should be using regulator_list_voltage_table() and
associated functions, probably map_voltage_ascend() or _iterate() and
just a simple set_voltage_sel_regmap().

> +static int mt6359_get_status(struct regulator_dev *rdev)
> +{
> +	int ret;
> +	u32 regval;
> +	struct mt6359_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	ret = regmap_read(rdev->regmap, info->status_reg, &regval);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return (regval & info->qi) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;

Please write normal conditionl statements rather than using the ternery
operator to improve legibility.

> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		if (curr_mode == REGULATOR_MODE_IDLE) {
> +			WARN_ON(1);
> +			dev_notice(&rdev->dev,
> +				   "BUCK %s is LP mode, can't FPWM\n",
> +				   rdev->desc->name);
> +			return -EIO;

I'd expect the device to go out of low power mode then into force PWM
mode if it has to do that rather than reject the operation.

--Qa0ccP92Gc0Ko3P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l+boACgkQJNaLcl1U
h9CShAf/WdS4iLv8FmqgPQ6jxUZsWIHU4beM7oDoeI16KydYH71AEzVsF5AmZ/Fi
q6qUuiabJm+9IVCwXc55mWA5IlFDMSoYM5VCt+QwxsUxaO2QoCjs/FgdkZcvNPyu
KJfmVJdGPE3ZzA6UjDC7tVOR1CYCC8ey8U6Y45rhPU6ln4RDxTnVAFFtKlUM5UM7
/Mw/NwmnR3AtdQvHw20WbLhTqWiNR8m5XAryzMRd+H35WuF/3xRlPSRvrGYjxkAL
7R3Wbs2KsQ7J+bPCPbLf0N9WSvZurn/hMT++bQJKqeAei0V+bo2Phk66Iq7rQkgJ
TGSDUr+2JcIj+zZtLcbRkcrnQUCt1w==
=Vsrk
-----END PGP SIGNATURE-----

--Qa0ccP92Gc0Ko3P8--
