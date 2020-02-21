Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D9C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1312071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582288746;
	bh=sNAVKTRBngWU+2TyxJb4sGncGp00AoX91Oj9U2SgxNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LpVBgOTSYK4vBOJ+15nOlW9JPKLBZlf6l1O09vqRnki/K9Z9b1VRU1l35WMxZxwhV
	 pNd6tjf5JKHOIi7n4XCdujuluvZTpNdgx9n8dulRihLUxw9rGxMMC5xZ0WzUp9fXqU
	 N2g/Cku0DcxRIwpKh4a+G12DBSH5OxRO6nHFRQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBUMjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:39:05 -0500
Received: from foss.arm.com ([217.140.110.172]:38474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgBUMjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:39:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590A130E;
        Fri, 21 Feb 2020 04:39:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5D5B3F68F;
        Fri, 21 Feb 2020 04:39:03 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:39:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: [PATCH v3 01/10] dt-bindings: sound: tegra: add DT binding for
 AHUB
Message-ID: <20200221123902.GC5546@sirena.org.uk>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <1582180492-25297-2-git-send-email-spujar@nvidia.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 12:04:43PM +0530, Sameer Pujar wrote:
> Audio Hub (AHUB) comprises a collection of hardware accelerators for audio
> pre-processing and post-processing and a programmable full crossbar for
> audio routing across these accelerators. This patch adds YAML schema for DT

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Pz2UACgkQJNaLcl1U
h9AHeQf+Piae6cY2B5ePno99lDsl5PHxfR24xDy2XG2/hPqCtEqWXT3EcJlRacLQ
a6tlKMXvOgdQ4wYzctGGH1SBj00qM6k/Wl4hYaCqxyNdk/6L9VlDM/3S2Aab8Src
CQ9RHkGUgsWqeAH5KsZ/nFWy9jJ43f+s6hhuJXizxMhAylNlMMvFF7cbahu0nqnu
K/sB0GN3f+TYIkqCjbuSRdIobC54aMU2mubTk7a0dgEKHfl69Zb8HBVHgjhkSBGf
r8av9AKtl0yOFQIqVA9PhlOkgwsYdCa5mJKULWK728W/pbPGr+c96RqEgo8vijQg
bKLrSY6B+ljUVJnpaT5KvMMEYSPevQ==
=SKbZ
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
