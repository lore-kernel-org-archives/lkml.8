Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF808C33CB8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB5420882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579539827;
	bh=DatVHOYXXNDi0/8OZMdAHBsSW/ZiGzcyrJeR63NW79g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmK+8UGJJmDqmtDq6gKKkIL2EBHLYmRzgvM07rG3e0ocKpo8DwMjxBFtwm/TPZHs/
	 NTdBNn6hL7tbS/bYIAE8OuxCACRu4b2b8O/4tiYwThqwxKsYWB/xWRTXp/qCdP5Sps
	 pGO8I+WTDJKK5CdGNEUCWgjHpGg8f1Agibdi0IlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgATRDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:03:47 -0500
Received: from foss.arm.com ([217.140.110.172]:34672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:03:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC74E31B;
        Mon, 20 Jan 2020 09:03:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D6C3F68E;
        Mon, 20 Jan 2020 09:03:45 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:03:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/7] drm/panfrost: Add support for multiple regulators
Message-ID: <20200120170343.GE6852@sirena.org.uk>
References: <20200114071602.47627-1-drinkcat@chromium.org>
 <20200114071602.47627-5-drinkcat@chromium.org>
 <7e82cac2-efbf-806b-8c2e-04dbd0482b50@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <7e82cac2-efbf-806b-8c2e-04dbd0482b50@arm.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 02:43:10PM +0000, Steven Price wrote:

> From discussions offline, I think I've come round to the view that
> having a "soft PDC" in device tree isn't the right solution. Device tree
> should be describing the hardware and that isn't actually a hardware
> component.

You can use an implementation like that separately to it being in the
device tree, it is perfectly possible to instantiate devices that have
no representation at all in device tree based on other things that are
there like board or SoC information, or as subdevices of things that are
there.

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l3W8ACgkQJNaLcl1U
h9DW1Qf+O1rhi1Qf46h1FjTMYWukB9iEFgJeJZ9xZby51p6qFhhoaf/vJWQgPgqC
PY+Tcxt1Dsk+84dKcLHXZVzsyFLanGZHI9TA2a0j5E1viknxKbaHP84RFmHU4y3s
lJQbgllRUQwkDF2ixZWfipql08kA3v/54BnAN8RsmJMrFN6mpSojTwQlT7390aaA
o2cjkfI/9GOUZ+mGsWzOmr/REEcE/+/aiFXvXnNFyRUzWHoHaEP3eIRegFGjp4E1
kV3GIOpFTkavPF8xb5LRChqYobnVhIizFJiFnlV9h9g/jG7OG1SUifQEtbSsOBT7
fvMX0psaSlV+9wp2Ei3MLvjGH1vemA==
=zekS
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
