Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52297C34037
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582025563;
	bh=2b1XwxH8MZNa/x4vH9fIYj1CqGENzpjeWAElEh1a/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SX7uDa4v+2KYvxLpG18GEGzHhlUkvQT00nx+sIDzoTbxCFxhUerxa8/25dpWbluAU
	 tslG6jjz0y3VX7GIocdYH4ePQf1tFr2DicGoY0xzJxhTvPgyQQWwGwfV2+FWXPOs8c
	 F7793ZDgLCe0/bbUE5eMlLbSdQ/XPWE67ZX1DG1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBRLcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:32:42 -0500
Received: from foss.arm.com ([217.140.110.172]:50372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgBRLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:32:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 705721FB;
        Tue, 18 Feb 2020 03:32:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92BA3F703;
        Tue, 18 Feb 2020 03:32:40 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:32:39 +0000
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
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [RFC PATCH 05/34] ASoC: sun8i-codec: Remove incorrect
 SND_SOC_DAIFMT_DSP_B
Message-ID: <20200218113239.GB4232@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-6-samuel@sholland.org>
 <20200217150208.GG9304@sirena.org.uk>
 <1cdcbc0d-39c7-25f2-68eb-a44e815fb9b8@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <1cdcbc0d-39c7-25f2-68eb-a44e815fb9b8@sholland.org>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 07:35:08PM -0600, Samuel Holland wrote:
> On 2/17/20 9:02 AM, Mark Brown wrote:
> > On Mon, Feb 17, 2020 at 12:42:21AM -0600, Samuel Holland wrote:

> >> DSP_A and DSP_B are not interchangeable. The timing used by the codec in
> >> DSP mode is consistent with DSP_A. This is verified with an EG25-G modem
> >> connected to AIF2, as well as by comparing with the BSP driver.

> > This can only break things for existing systems using stable, if they
> > haven't noticed a problem with DSP B they'll certainly notice failing to
> > set up the DAI at all without it.

> Are you suggesting that I drop this patch entirely, or only that I remove the CC
> to stable (and/or Fixes: tag)? Is this something that can't be removed once it's
> there, or is the concern about making user-visible changes on stable?

Remove the stable tag, if someone is relying on the DSP B support in
stable this will break it.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Ly1YACgkQJNaLcl1U
h9CFEQf8D9YL5SadnjL9dOFFrzy8yoRe7dCBkHfRxS2YavdoyZPsbCrDOcY93rEL
/VkLJwslj6K1LCmAYYJ4/Qo+q+hPV2bnnzcslJD4Mk19RhLuBbLR8/kfP0mgnlb4
igA2RgQJlN1GubExF4orNfkGrQxaTORV9EmceHayvRL232NkBdwGqu6wcG4Gk3YR
dA0GaD0uBoCMBucCRvveNRdwJAD9aStpZZwC2Qb4Iv3lMAD6do8XCz99kT+ptlFs
8N/oDBbmQpwJTkXmTphUhhkCkxA/bMZMw8QxPHZnG5SuemVyfYJ/WYevARSnpaTp
zPxaVojES71xzKzOJUh3NURlUBhKcg==
=Hx/L
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
