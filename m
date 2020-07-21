Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E7720771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595371283;
	bh=BotUQxfjVA9emKtHJ7bK7WZE9k8SVjbJ8o4YzULBYuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hupFn4c/WwJ+OfIsnwSDL2Zsr3p8CLQ9nhnsgrvC6Hp/dkH4x1sap152I990P5amP
	 PjzGUy625s3lTJ2hnd9fPwsIBNGQG1nDYH3PTJpnJZpY7g2PiH+vNZzk88YHZp5Pm2
	 tNYVBi5st8LyxAd7RcKQ5oJGsc/g64EZ+ju9u3YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgGUWlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:41:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9432073A;
        Tue, 21 Jul 2020 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595371281;
        bh=BotUQxfjVA9emKtHJ7bK7WZE9k8SVjbJ8o4YzULBYuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnjHqe5dFaJAjU1mdmhbOGRtUe+nabCriuQ3qMWXn72psho8i/zd9ytwmpXX+YKMH
         YaZlT7XLJ2B3bNzZAYwO5QTAIFshoo3WHyBtYoqrrIKkpQlb2jfRsXjmQT6uVQlq4C
         AOXemd3CRqZxUO8Zia8mhaBEgJGGmhl1tMrTQ7vE=
Date:   Tue, 21 Jul 2020 23:41:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, tiwai@suse.com,
        rlokhande@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, swarren@nvidia.com,
        sharadg@nvidia.com, nicoleotsuka@gmail.com, viswanathl@nvidia.com,
        nwartikar@nvidia.com, jonathanh@nvidia.com, atalambedu@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 00/11] Add ASoC AHUB components for Tegra210 and later
Message-ID: <20200721224108.GG4845@sirena.org.uk>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
 <159525589435.6792.708136378511410418.b4-ty@kernel.org>
 <72d45476-7050-187b-19d6-2ddb9b0ba97a@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <72d45476-7050-187b-19d6-2ddb9b0ba97a@nvidia.com>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2020 at 05:22:35PM +0530, Sameer Pujar wrote:

> I see that "[PATCH v5 07/11] ASoC: tegra: Add Tegra210 based ADMAIF driver"
> is not applied as part of this. I wanted to understand if this is because
> some more review comments are expected or there are other reasons?

I just hadn't got that far through the patch series yet, looks fine.

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8XbwMACgkQJNaLcl1U
h9DtvQf/e8yERKcTlsxgN756R8KDhLh+qzlkWNW3GPS8vrJKP0kOaysI2CDcHvhS
Z4dtbFFRCgzRhb+m7k42pnnjZ+kEggR2iBeof1kXKLzBybxcaujyULGvI6jtfYVd
Nvo3rNBhwseVrVNWgS6HURCkfp2aDTDqnXZIQpXrd/eaPwZMajW5vsgkO4vucjRe
bVopPMTErkT99QWK5XxSj1ZdOFUdbzqQawZvDF75+gh1ZWDp8M64GSttm96zS/rL
AiiPPVTv1F8c4nxlotfQQ59P/MyW9G5pBYdon3plnVyqYI08k6bUZYMLcHwiFYLu
HykGGaZPPnMO3stUy64AKKNZmZBxyA==
=mT4+
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
