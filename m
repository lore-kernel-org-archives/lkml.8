Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461AC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DE42072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581956816;
	bh=rF5n1LALgS1QdHMLdIt6JdEOXWZA/nrceOeMB/9wLqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+9f3KQ+d/HY0VggpjxIPkeEO5ewWt9xUQXPvvXJbL3DTujZi/WIV2LB7MMVnB2my
	 UiKM2XBffBd2OO5JcYofxM1UTQYGP49DBdwLlMmymNQad/44JTo2OGa7ggMoiXNpMb
	 WWK815ZF5bjQGzdrY729dm+2DHJyrD4n1MEPgkoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgBQQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:26:55 -0500
Received: from foss.arm.com ([217.140.110.172]:38182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgBQQ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:26:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3729C30E;
        Mon, 17 Feb 2020 08:26:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9143F68F;
        Mon, 17 Feb 2020 08:26:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:26:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/34] sun8i-codec fixes and new features
Message-ID: <20200217162652.GO9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:16AM -0600, Samuel Holland wrote:

> There are several trivial fixes in here, and there are several commits
> that just add new features without changing any existing behavior, but
> there is enough changing that I thought it would be best to send the
> whole thing as an RFC. I'm more than happy to reorganize this into one
> or several patchsets in future revisions. It doesn't have to all go in
> at once.

This could definitely use being both split up and reordered, it's a 34
patch series as things stand which is just far too big and I don't
understand the ordering within the series - there's a mix of fixes,
cleanups and new features which should come in that order but don't.
This makes it difficult to get a handle on what's going on because what
the series is doing jumps about a lot.  There's also a lot of overuse of
fixes tags and stable tags which also makes things less clear.  I'd
suggest first sending all the clear fixes as a separate series with the
cleanups and new functionality separate.

With regard to the ABI breaks they *may* be OK for mainline if we're
confident that there's not going to be anyone broken by them but we
should be looking to maintain compatibility if we can even if that's the
case.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KvssACgkQJNaLcl1U
h9AFkAf+PTXKlVW0kwCz5ifw7rANYaEVuHbffAG8xTZ4xnAb6OOQp6nrRyjbeCh+
CVeQiWco9iMv0s3ViZrPNRu0cAY0q5yT9/3PtcSUnf9kdZU0j2NGgVcd8M1r36nG
rqo32+9t3pM7PVuMFxprSYIWowjL4imVnijbUr4HKqMfgcSv11/A8/vrgeFDVw7s
iaICzpZ7eEo7wz23UocFb3ZTLamvSqlUen7jJj8l2KlMZute7NlbH9WOZVV7KHoE
i/eafDrmflwnVDqYffboBROuzLF3fBWbcvyBHsqt9ox5N4YIv9+IBp9u1JORKCPX
tAZBXTMe3EN10DSbE3X0iXvk+gwzRw==
=106H
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
