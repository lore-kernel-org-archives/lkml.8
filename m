Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52075C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ABF206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581614315;
	bh=us1MMTCogBjdT2JfyOsRefkIeb9nYIIBpdj2wwEdxZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fFgIBeltUXpPlwcST8SdNP19lozqDfMAxPyfLWp2khmjTUs3eiIc3WV8ccs/dPrt8
	 Q09al6rGuZk9wT/lIHFRSV4eCGiVMImgSbQ/X/1yksOj1yo4LOVU9yoc51WFWYU7Kv
	 bHORfmkzaCZz3VQxha5mGxv8VA3bwLKeV885PeYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgBMRSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:18:34 -0500
Received: from foss.arm.com ([217.140.110.172]:51294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBMRSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:18:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CDC6328;
        Thu, 13 Feb 2020 09:18:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204453F6CF;
        Thu, 13 Feb 2020 09:18:31 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:18:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/9] ASoC: core: allow a dt node to provide several
 components
Message-ID: <20200213171830.GH4333@sirena.org.uk>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
 <20200213155159.3235792-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <20200213155159.3235792-2-jbrunet@baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 04:51:51PM +0100, Jerome Brunet wrote:

> At the moment, querying the dai_name will stop of the first component
> matching the dt node. This does not allow a device (single dt node) to
> provide several ASoC components which could then be used through DT.

> This change let the search go on if the xlate function of the component
> returns an error, giving the possibility to another component to match
> and return the dai_name.

My first question here would be why you'd want to do that rather than
combine everything into a single component since the hardware seems to
be doing that anyway.  Hopefully the rest of the series will answer this
but it'd be good in the changelog here.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FhOUACgkQJNaLcl1U
h9CqPgf+L/Xt6fytZ8T0Qto2jS45qM+J0JJtBuwbWI1qn00Rangat1H8RPcg9vlo
3gwlnj9jjdCCvGNB3+ECaCtCeh5QihLVZXSs8qXYIZF502avt/atdjVBfK7XT5jb
uKjjMM+fn5wwvTfZsi3OOxXtUMbpSkuDJ82c8zFDgQBss4F7T94Lq3Qzw5f6Bvub
/m1zvfVuh4LiTa7HADtrrD9Az0o9gO/Ielc0xH0mHydZtuv4qIMOxPQXwT/14tU1
hLQwfy9VkkBfA0xuKKVJ0vjyWhi7A0SdE6RdbR9D0QUSBuSD2iPV28XaJD+jFwX3
k0q3tgreqtSmKkmnySuAGJ+wTQIzVg==
=Cn3Z
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
