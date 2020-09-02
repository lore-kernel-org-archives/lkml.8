Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF13208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599039562;
	bh=rz2YWRkFtHiLU3bmkGJDyuxnYo1QLy/1GAkH2TvuQy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PdCTN4liulrBRgqKq2sRz4BadEOjm6jnXtIQGGwbncYWjJNEosUYkUFQQrWanH6kr
	 Wl9vcOcTES9By5s6PkGRLqhNhHbFOyny6Tdrc3EFXBZYXzQXXQDA3IcrT8gaLrU/uR
	 4kbdw0P/5LUbtk4FIH/Q0MAnMFgr1bTYqZZ5V3Lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBJjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBJjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:39:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAF32078B;
        Wed,  2 Sep 2020 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599039560;
        bh=rz2YWRkFtHiLU3bmkGJDyuxnYo1QLy/1GAkH2TvuQy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTaELI0X+vFIqmDdOPtbaZhwErfWjpQ0RAy/MwmQCOc8QmzTqk8EUYhTSW0i9260Q
         0Vu8qjH5yjQjwzJGRCOgC1RzcZ9DxGa4IIleV0Ptm0EUXUWS7ir/A80wCULZcRWJtR
         jQQE4bTv8OZul/4HnR41sT+Yh21vk47YRIXH6CE0=
Date:   Wed, 2 Sep 2020 10:38:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200902093839.GA6162@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
 <20200901110349.GC6262@sirena.org.uk>
 <20200902091038.GB13726@pi3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200902091038.GB13726@pi3>
X-Cookie: Prices higher in Alaska and Hawaii.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2020 at 11:10:38AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 01, 2020 at 12:03:49PM +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.

> The usual prefix for bindings is "dt-bindings: ..." so I wonder what
> type of prefix you expect:
> 1. ASoC: dt-bindings: ...

This.  Bindings aren't a separate subsystem.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9PaB4ACgkQJNaLcl1U
h9C8/Af/RVJ7XZs6bEQHCNhy0ziMmQZGspvtRHWnmX5UKETH//1s3kNWWwFDZiSW
sCUAusHo+BU1ZkDIjWW+jmdlz+brViZjKjGyiwP2OHyjC1l50v5SfBUappHthFKq
Z8H+fIgTVcCC2VF4XTWkOvzNZKBYmplCbB2QrwSARpH/FG9xwfs5DXOTTjx+eYz1
ui/iHHGilY4jpTT/qCN5aOKvnUYPimbNISqviYmYt5+zgABexoq3pDGHra1M7kHS
Sv9ghpXtt/BBqb3eNrE8ITot5fOXQ4uD7UMbCECk4XkqFB/fJPLW06LfV0qqu4Ej
6Ba2iB6hEEoMX4MGcgDNpYkcFYOybQ==
=sHL4
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
