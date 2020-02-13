Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D57BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F14217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581618123;
	bh=JoDhUINe7wOHKEq2Yzj/yvlxxkUYjM/TtvzskHmcDD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0ICJZwrvNAMmRpC248FAEuBN9tOei8M9kuBdIBvagavSP0kMSv025Cm33j1qLn7V
	 3noh4sJ8G1L7Utb6w/xivYWd2Mu8P1xv3dbt/u4qI8dWhyrkoYn3Mtas/LfQQ6PFLq
	 fGe7u0MRS8Ib7Y3i8IPZGzsfbHJH3UR3ntKimupQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBMSWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:22:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:22:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACFE6328;
        Thu, 13 Feb 2020 10:21:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300043F68E;
        Thu, 13 Feb 2020 10:21:59 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:21:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5/9] ASoC: meson: aiu: add hdmi codec control support
Message-ID: <20200213182157.GJ4333@sirena.org.uk>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
 <20200213155159.3235792-6-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline
In-Reply-To: <20200213155159.3235792-6-jbrunet@baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 04:51:55PM +0100, Jerome Brunet wrote:

> +int aiu_add_component(struct device *dev,
> +		      const struct snd_soc_component_driver *component_driver,
> +		      struct snd_soc_dai_driver *dai_drv,
> +		      int num_dai,
> +		      const char *debugfs_prefix)
> +{
> +	struct snd_soc_component *component;
> +
> +	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
> +	if (!component)
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	component->debugfs_prefix = debugfs_prefix;
> +#endif

You really shouldn't be doing this as it could conflict with something
the machine driver wants to do however it's probably not going to be an
issue in practice as it's not like there's going to be multiple SoCs in
the card at once and if there were there'd doubltess be other issues.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Fk8QACgkQJNaLcl1U
h9CAhwf/cuQA52n4KErDZvZn7/DzU7OY4w6BULQb6pd6r1CgFm/rd1Fgf9QLK2yQ
Yu4cKdsOCcT4YH0Abf5r7n0uNFnCdd4U9c+L+MnQ912Yu8ZV70+X9D9OniFif59u
WVmnNC/sRTatvyefGnTDu//nHF29Yc10S6V+wPbFFACYONJ2s9SKEWCGZrclawkE
mIopqJBFRcz7q2iCaPI8onRuIe5VtF7SeEk0XkFRQsdqPacrJF0JQQFuui2vYBq5
Nu1SDN2ma7iXiSssC9Oy/iCv70WpDLMtYTHz35XiooaHkYKxi2xKkluXWOpy/Dcc
hMVncK5RF58ft+ILMKSg9TXFiEcN0w==
=iCR2
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
