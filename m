Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBBFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86202080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597083018;
	bh=A9FKcX5EBqiorEL9HLWJlxmumGSzbx6WR5Pdk4J/UiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZqaqklZVkmtYME/2PEwz43J0NoFozeQrWeDZbppt2jiiTDswgE2BnEZcwvuIDI4W
	 UCY4D+3BcAgc33rjfkY5Ism7xzES11XO+bctShxOgXgudkpf6rluv/ZxHYBC7BgufK
	 bOMwonlRBuL8b8JK9yKmEBshQ7CQTI1ZPXlVv5VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHJSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHJSKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:10:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AAB2080C;
        Mon, 10 Aug 2020 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597083015;
        bh=A9FKcX5EBqiorEL9HLWJlxmumGSzbx6WR5Pdk4J/UiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAjpnXS7+ReczNH05xDab46oCfy/sUeK6848Ko8TbPqKMI756s0agQf93zU5jOnnd
         ApZrQdhExKtCsdWxH/ZUbbjRDBzOOt9ga+JwrMc4lADt4gCMeD0U7lZPXl+EH4p5Up
         mgAb8bAtQq2y6Th4glB7cUeyeauFQ6m9UNU2b+3Q=
Date:   Mon, 10 Aug 2020 19:09:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: Fix comment typo malforned=>malformed
Message-ID: <20200810180949.GA12108@sirena.org.uk>
References: <20200806130222.1.I832b2b45244c80ba2550a5bbcef80b574e47c57e@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20200806130222.1.I832b2b45244c80ba2550a5bbcef80b574e47c57e@changeid>
X-Cookie: McDonald's -- Because you're worth it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 01:02:26PM -0700, Douglas Anderson wrote:
> Silly typo.  You go squish now.  Was introduced in commit 299632e54b2e
> ("regmap: debugfs: Don't sleep while atomic for fast_io regmaps").

This doesn't apply against current code, please check and resend.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xjW0ACgkQJNaLcl1U
h9CbVgf9FnXNEEd4gU8d9VDwA6s9w8zQp+E6EoIpFYjfBveMgxenKClxaJoA0gRC
RgUOhsTIviGGms2iNfyaszwMuEVaLdgPOqVT9h4qMaiVbldwx0sog4sL6wiLWab0
KbaSJp90YzYpL+sO1djLICBR94Np5y3+d273aQg+T9EjFX8KMfoAMZOw2wxLD9IX
Kx6/4tLBvMeY274h3H7D6aLUgwhD50WnO+yCgZeZRlipyRpEYeBHtyF9rYJcQKDa
PtAVwutaPPz8I/NNXFXmq1t7l3OoooPTRYx2LIP3lEuODvy8Reutx0mpEycPqSdJ
8fTPOSRfM0EQbQV3af8niBmov5bybg==
=gQpZ
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
