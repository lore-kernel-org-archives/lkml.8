Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC110C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75727206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582228286;
	bh=BZllZP0S6mHq3M1d/mWw0S2QK7ydm/Mjik/9RGjRhL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GI7Gpn5FbTl/hjoJGnQxYNM4FNlz8pPiXEgoWKtIgoMM4bJ3LQnTRmmvsDTWDdrkW
	 ehks4UrfRGMg3vtsAnK+XlBH4gdqs5g0tnftbq9UFi5GbZvr+u7L8aR8C3GaUkWwLR
	 u3z2ElKN6EEMRNTcV8ml/ii6l7cKpthLSjUDUjTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBTTvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:51:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgBTTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:51:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90DF30E;
        Thu, 20 Feb 2020 11:51:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF083F68F;
        Thu, 20 Feb 2020 11:51:24 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:51:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Message-ID: <20200220195122.GL3926@sirena.org.uk>
References: <20200215065826.739102-1-gch981213@gmail.com>
 <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 07:58:06AM +0800, Chuanhong Guo wrote:
> On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie@kernel.org> wrote:

> > This is an ABI break so you shouldn't be doing this, if the existing
> > binding works it should continue to work.

> The missing spi-max-frequency is the only part preventing old
> device tree to work with this driver.
> If the goal is to make existing dt binding work, I could patch dt using
> of_add_property in v2. I saw similar device tree patching for legacy
> bindings in pinctrl-single driver.

That's fine I think, so long as old DTs continue to work.

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4zkACgkQJNaLcl1U
h9CnhQf/csTFVBvPtYuq5Xz1OdgQcpPuRzKFr7JAXvgpfAUv5qPV/34M4juJxze6
ei2b2s9UlxK2Naa8GFKqAEKOK79jnk5HrI7QkELb2UpQPSJQKubjc8iHzDsQ8rgC
V7Qf/2Lv2J/NW4R2XzC0ZXMeSnEMBQepx/pUCQnwXOqReWiy/l2X7pLEJsI4J4pR
ba9BzEWWAXYoP4SYj/cVlqhWrBh807h6owmwTlV86VrwRRh2cxosTUZVMx6nRNq6
MBFLZ/vayfFd9LF7BQ5r2isKv+BUrZZ8bd06Gt8vZrrLBoH4YiGhXDLL3CGWvFhk
6M/bBGLDrkTKwSBb6zMaLOsygszigQ==
=rZ8a
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
