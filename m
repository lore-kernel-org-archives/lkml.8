Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1901C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8B21789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592418412;
	bh=M23eumFEO7m/18Vd2RTbYzvO5gTDfCEQeB96lyrqjig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oZHxrMrsOD1vkeJfIoMpfv9aW6+83SV1xuHCV+2+KFzcmtxCppve/g6VSyf11UyR6
	 5Jhvn2jxt3NBWvwyTx7I8IJC37SJgUmO3LgDATPynQkNEw46I741dg9izzH0ELUkD5
	 CnqMrQYvu4Q/Nol6NEvpC+lSXYpWv3fEgJm4vxgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgFQS0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgFQS0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:26:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CAE21532;
        Wed, 17 Jun 2020 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592418410;
        bh=M23eumFEO7m/18Vd2RTbYzvO5gTDfCEQeB96lyrqjig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pq0sGFVdooyFB5uxgUau3OLPLl6eNuT7I0DR2QsvqmhDBO76cA9EFFl+sNyStu2g3
         qzRCGyD2Yv1rtfJ7oT2X8QVxjFgk89+YqtBlmMeZGCQthIBjHrl7EAGmNAcdKGhZG1
         F64Xnjn4r3BKT+0Rivkvbl1OY+fhG8JskhCVj5Pc=
Date:   Wed, 17 Jun 2020 19:26:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH] regmap: fix memory leak with map->patch
Message-ID: <20200617182648.GI4613@sirena.org.uk>
References: <20200617163900.17674-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
In-Reply-To: <20200617163900.17674-1-pierre-louis.bossart@linux.intel.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2020 at 11:39:00AM -0500, Pierre-Louis Bossart wrote:
> kmemleak throws the following error on devices using
> regmap_register_patch().  map->patch is allocated dynamically with
> krealloc() but never freed.

Charles sent a patch fixing this already.

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7qYGcACgkQJNaLcl1U
h9AQdAf/aiCzQWniNM/HM/QaHuMRCb9zM4tE5u3RHXkPzh7XABNQ1QYM9dr/3gJv
aR7eMbcI6JWime0fhShgF8X0kmSiHHnqjpXrGbtRoXs0OqfA4jKrV55tq4KtKL+y
kPo4J2qJYL4bAknKyHDC1/Cf20en8iBrH97lmvm3dXMvUgri04kgRrfSN3LA/KcD
NDNwztpwJZDnkD1Pcw0n+iET/ECR4kLG6bvfW8Gk1xGqJ7g8Yco4CcHnlW4JSlpZ
S87QCNXphLsMCBA1OHLJ7vug7a9N6vH0PirQip01gQYRqTwN4V1/Q9iGAIZ+gy9b
wvxfPZYErcY41RAidImH7LxLAYXimA==
=uQWJ
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
