Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66754C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4315C2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591097565;
	bh=8NYIhj0/kKsZqCFmjmwu9q0gjA28YKuqxfadnnfPUkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KLXvBeQ7tLeKM3UjgRVKp3sMAf8GgzGwJsXUL5aTZ9gFocggoGgyHRNi1jM9Y9i4B
	 fIOK63TL7SIrdVqd7kkXbskHlhnowd8VpojXvH8qSjFJRyM2ODru7+eq6MYisuE1O9
	 PxROT0Sy2BhcWakNY3+64Mj8G3uWZcx+CvRK1+MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgFBLco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgFBLco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:32:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BE72068D;
        Tue,  2 Jun 2020 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591097563;
        bh=8NYIhj0/kKsZqCFmjmwu9q0gjA28YKuqxfadnnfPUkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0VBAOeBauhdWe72p5lqDnXQzLU7OUFL026MuZlgPoOtLPQnIQgcuGeX53dwDv6SjH
         aTP13MEgG4KD3lsuLp7j39azO0Y/tTlYi1qDvlj8StFEz5xgAmFvRph8nNFNsKvi+h
         y9tobRhav37jJEJ6i95k9H8Ed6Q9wb2sgMzsMYoE=
Date:   Tue, 2 Jun 2020 12:32:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH v4 4/5] regulator: qcom: Add labibb driver
Message-ID: <20200602113241.GE5684@sirena.org.uk>
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-5-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <20200602100924.26256-5-sumit.semwal@linaro.org>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 03:39:23PM +0530, Sumit Semwal wrote:

> +static int qcom_labibb_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct labibb_regulator *reg = rdev_get_drvdata(rdev);
> +
> +	ret = regmap_read(reg->regmap, reg->base + REG_LABIBB_STATUS1, &val);
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Read register failed ret = %d\n", ret);
> +		return ret;
> +	}
> +	return !!(val & LABIBB_STATUS1_VREG_OK_BIT);
> +}

This should be a get_status() callback...

> +static int qcom_labibb_regulator_enable(struct regulator_dev *rdev)
> +{
> +	return regulator_enable_regmap(rdev);
> +}
> +
> +static int qcom_labibb_regulator_disable(struct regulator_dev *rdev)
> +{
> +	return regulator_disable_regmap(rdev);
> +}

...is_enabled() should just be regulator_is_enabled_regmap() and these
functions should just be removed entirely, you can use the regmap
operations directly as the ops without the wrapper.

> +	match = of_match_device(qcom_labibb_match, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	for (reg_data = match->data; reg_data->name; reg_data++) {
> +		child = of_get_child_by_name(pdev->dev.of_node, reg_data->name);
> +
> +		if (WARN_ON(child == NULL))
> +			return -EINVAL;

This feels like the DT bindings are confused - why do we need to search
like this?

> +		dev_info(dev, "Registering %s regulator\n", child->full_name);

This is noise, remove it.  The regulator framework will announce new
regulators anyway.

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7WONgACgkQJNaLcl1U
h9BWjwgAgnVxrlieHh9AH/2qQhpxWtvryQlFpO+YrWNrGAC38xh3OCdOu4v3RtHO
XA5PIkwX6cfQBCmdPO0xPzJNIZ8xXpkF8BTeBA2NwJZuyzjz7QvLnvPz8iwBQBcn
eQSdw+y0kmRkSQo52S4JLL1q1HEJohebQ5ZvpOGFWVWYFMGm6xiIist03Kgsjav7
w0d2WQ60HbG4CS+Wu9Eol/DLNeXFQXrdDlL/XGni+L41XbsQ/JwFkod/Pn/B0UnB
m5ITBspUSfNG+nEGGWHHrQh1sxv1EjVYsOvfe33eleTnmEpXQKFBCLTkoQAnI8z+
Cdf/O4avA4nPwuxRStgnozgEN4IuCA==
=kLbo
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
