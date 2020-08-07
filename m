Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C388822CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596801113;
	bh=cKfNzVoedQVmKvHvqaEn1VyOBUd+uYh5+G/kG05O8i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOGVLX2iQ6BO2DP54hKfew1D3BdcU/yQc0Vv8f7rLrSwKBqjSFNHVgKTw0weFMu47
	 oH4YagzT6QD97rE8uQKOROR159r2hq+jMEJtCUTwo8j9KsAx56EzrnIwdb0NxkP3so
	 B71cRxvI3pGmWkAJn9UCMLOrQlawXbrhNCgCcxek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgHGLvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:51:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BDB2075D;
        Fri,  7 Aug 2020 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596801110;
        bh=cKfNzVoedQVmKvHvqaEn1VyOBUd+uYh5+G/kG05O8i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEftQRvX29huLFXq9+TWsNE8Qe8nvmo3X6O+cCG15qzk3KbIHm1/xYVzzdOQOTNAb
         /NrTFQqRiYzNbASVAiDemSygf9K4zF/2u8pqVJIEv4GdrdxciPSEbYj6D0ZpgueVAF
         sxeWJt2cvD2K9Qo6/01yY0iBndmuMSPXg2ZVlPVA=
Date:   Fri, 7 Aug 2020 12:51:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 28/41] ARM: s3c24xx: move iis pinctrl config into
 boards
Message-ID: <20200807115125.GG5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-28-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-28-krzk@kernel.org>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:20:45PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The s3c_gpio_cfgall_range() function is an internal interface of the
> samsung gpio driver and should not be called directly by drivers, so
> move the iis pin initialization into the boards.

Well, it is now - that wasn't the case at the time.

Acked-by: Mark Brown <broonie@kernel.org>

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tQD0ACgkQJNaLcl1U
h9CqCwf+JA5FnrUTEVVBDbW47geQe42Qnc9Xm8NStwfOPmjgajYfUNeCXBA/hmac
FXu0yRKfw64NF52gC92PURaKRq+ZVG+3zWYf+jfKxABUiS5FZGLgQjQ7pUEtrZMc
FxspnPqX4H57ZJXAg+q3Eq76iR132c4eX7s20jBiHJrEfEnIc86n4R5+aZ+F1HSM
kYVzZacjdpEzter1onhkgDbwAR+HT9RdPsyefvCKxtrdgW1h28TvjI9s2XgNHgAz
J5BNRa7ohL/qZnXYd9Z041846uXa6CQcoU51hejVbDSkXk9hprkwVwsrkGCBar2n
58ZhRIsY5a+CLanhjLZCZoMPR6GFAQ==
=U67M
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
