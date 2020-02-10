Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77719C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473A92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581343218;
	bh=FdBYsn7ehxVf2vxq0CzmRwF7qeqYi0ygZVOOuUiyPJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbSvIVF1YPtBJHOOR9Z3hAvD7xs9kH7STdJ5HMXnpHcSCRKBNLzLeLk4VO1mpL+gf
	 XJlX5tImgF6lkRd6uqjW7yHJLL50h6+4N/GjCj4uoetNytIPSVHzy0n+a2AZCyckQZ
	 ugEasJ4sMyck/94ahQTD9kxPEWAoO0wb3o4Pvw2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgBJOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:00:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgBJOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:00:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD291FB;
        Mon, 10 Feb 2020 06:00:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC1E3F68E;
        Mon, 10 Feb 2020 06:00:16 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:00:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v4 4/7] drm/panfrost: Add support for multiple regulators
Message-ID: <20200210140015.GM7685@sirena.org.uk>
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-5-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bZ2MuwyI/0uB8yuJ"
Content-Disposition: inline
In-Reply-To: <20200207052627.130118-5-drinkcat@chromium.org>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bZ2MuwyI/0uB8yuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2020 at 01:26:24PM +0800, Nicolas Boichat wrote:
> Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
> regulator for their SRAM, let's add support for that.

Reviwed-by: Mark Brown <broonie@kernel.org>


--bZ2MuwyI/0uB8yuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BYe4ACgkQJNaLcl1U
h9CfMQf/QzQ87xi7iHEnbkDh0DvfRVBElMOh5yZEs/7vrCKXq48DQSPhy5qTSNe0
ELgi8tL9ZNzBSrkpyMdv8p/CS1J0sFo84mWLhKCukEMsBUzk5xzH0Bl8IaIq12ia
zV3bz3qMfraesjQ4Epu79BurC/81bsk+7Yr51OIajamncY7iePAnJOUdA3KsCNVa
89Klh4Je02sA9pUAg88IEA72n+YJ1Cm7S7xtA5FbJJf0EzNyD9WKY6tF3lF9bqts
5w7iGUDPe102X5urJGl38NliUpk8nkjFvREH4kDcOoyo07yZv14YGpiiqCcC3KD2
4NbAUoMEmAh9tXfdABSgDX/n414tSw==
=gI44
-----END PGP SIGNATURE-----

--bZ2MuwyI/0uB8yuJ--
