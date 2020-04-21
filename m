Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA62C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD36B206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587489609;
	bh=Tkhv5FZI2lpcXSiwylUJy+SpFY9x+7AFo3ppBxZ0m70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zflJiWKVjOYsTTS07w0gDNTE1Qa/N296H+zppdQdA6r5Htdtzk5KIiduRbOXiA/BC
	 wkwZg4Gl+3xuGJgQVLZ82rr2Gc4dFm4xu4hXPmzayAOROBg5K7pMq+wMFGaMpn5CdO
	 Hx3GPGDDQbodPq7FDS7ximxqZ6PfaDi4rKMK8Uuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDURUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgDURUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:20:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A816206D5;
        Tue, 21 Apr 2020 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587489608;
        bh=Tkhv5FZI2lpcXSiwylUJy+SpFY9x+7AFo3ppBxZ0m70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YsZKbRvFLNmt7aYxNscTQiCjhYPZi4jt46Kt10VY0Vg0MMOtzBUQ6wd9/YvnaByj
         JaWR/j0BcX3xft91Hm6mJpEkiefM8zCqeHqM9+Bzc5n7BBPDPTzr/g3Mf+rd01VinX
         56m7GnDg1ks2mcSPB64l/RX8A50NO0bow8BFgiGo=
Date:   Tue, 21 Apr 2020 18:20:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200421172005.GG4540@sirena.org.uk>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
 <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
 <20200421171558.GE4540@sirena.org.uk>
 <0d91f426-e767-2e69-bcb7-ddc4d7611861@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <0d91f426-e767-2e69-bcb7-ddc4d7611861@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2020 at 10:17:10AM -0700, Florian Fainelli wrote:

> > That then doesn't work with git itself unfortunately, someone's got to
> > loose out :/

> Could you provide both links with a market at the front, e.g.:

> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> for-5.7
> CGIT URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7

Ask Konstantin to implement it (I'm using b4 ty now) and I might!

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6fK0QACgkQJNaLcl1U
h9CXvAf/UAZv8UO4t1Uin3jqj6OCGFmCstSiXzKLQb6UC83EXEXtZndbgTidnKMv
42qXpXqGgImz//y91Bv35peHhy3Ugd6d2NpBGOpgozLfUiyJXJEWXGAvr9cpd/v7
TgLtQSuXEvKixIV6byhSNRI8huDsoFIRRcUUrLk1eg/zXY5sjQURC6O6fHZwCKXz
/bSEIKCUTohvzJC6wh/wVxWXzlBuy85zvsUnG2WgJ9u58IxFJIJGZGpqkoipqNtJ
357ztZeYezZAYB+St91NNk12GPW/n6IkWptiI52wrIGBoyBUU4QZTk6/jsxaOPve
I9M/jwmVHX3d2H18f47isum/9rP01Q==
=93nF
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
