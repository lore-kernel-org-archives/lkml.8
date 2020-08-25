Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D29F2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598357515;
	bh=lLcZy5Wo6jWvC7rPiDhmximohADFk1jbAXM/KoH5hVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ew+4xvpdWsRL6z645ciH1l2WLx5YbEQYOKuyAIeHwo27lcVRWn1p3g/xp1h7lYubx
	 +wFtYnpTsaJJUEKmTTteMJ7V4WUEpFsXdK21O9GkjEMMalcIYgzILJv9L+U3eke9ll
	 Nik8XWr0ubZjn/6FunPHPZfV8RGR0DSN/zUr+gr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgHYMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgHYMLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:11:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B355920706;
        Tue, 25 Aug 2020 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598357498;
        bh=lLcZy5Wo6jWvC7rPiDhmximohADFk1jbAXM/KoH5hVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtoEFfPQ4QExLDKzsR29XM4M/Hv+Kf1cudKSei+JdGaz0fTh1snxnWmUmgHiCwQJi
         WPgVVcN4Pu2OE2jRcg8B69zc0BULmNtSPu9Z/m7CPUYkS5AZ7faPAbV5PL4t7IyHXy
         6yW0DhQ13Ay17zkd3EdsQTxsjBq5yQ242NBffaf4=
Date:   Tue, 25 Aug 2020 13:11:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        xobs@kosagi.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-es8328: add missing kfree() call in
 imx_es8328_probe()
Message-ID: <20200825121102.GF5379@sirena.org.uk>
References: <20200825120531.1479304-1-yukuai3@huawei.com>
 <20200825120531.1479304-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20200825120531.1479304-2-yukuai3@huawei.com>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 08:05:30PM +0800, Yu Kuai wrote:
> If memory allocation for 'data' or 'comp' succeed, imx_es8328_probe()
> doesn't have corresponding kfree() in exception handling. Thus add
> kfree() for this function implementation.

> @@ -151,7 +151,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
>  	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
>  	if (!comp) {

The allocation is being done using devm_ which means no explicit kfree()
is needed, the allocation will be automatically unwound when the device
is unbound.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E/9YACgkQJNaLcl1U
h9By5wf9GsLAxwbWBAbrnKCxyu9PM9ucYMMERlrYpCaWXat0bBzG/zblA6fGcCVd
UtSA/ON7K+KTqqXX7wYEK1HebOUSfemHcJDZ9OvUfpFkswXpZqkhAmcm4n4wZ0Jo
ARFpyf9ifjltEU43SfqNs9iwVW6Dj/RXghoQ6/iTh4vzXokipE6IuXiPNnxsJ09g
SjeN6JJJe0SLYLhPIcrPb7tSIv5ZB5no846dUSUdgpxKN7g0G3nGFeQjYjh63P1u
ghEhEfq9nUvhjfMZmajC1CtiUjrgf+Y+3eXDByE0p/goE9PH/nQbgTYOsHoSEExC
BviLGNDWPywLcqIgIv9fsj+ewCVfVg==
=kko3
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
