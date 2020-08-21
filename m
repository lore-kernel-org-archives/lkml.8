Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A965DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D220738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598007720;
	bh=RuQ3tAsSpGBjNhThS2+HWBKVcKCmLZrkBeKh8fCgBp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWKaZtyKmTB4sHwxh1TEfAb9MNDo0D7UFgZC+Le2/gsDt5y0SIwpLBOAT4ORq0SuL
	 cqpXwrvpZ2UOX6kxxDpCNITqFEW8SvqGxsUJbbeVusJkWOF0LRR74Ar5Oz3t/4+xPs
	 0UMlb2YASbD3g8dsJEWmwqXnFu8THAWkYofRoD1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgHULB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgHULBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:01:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A79A20738;
        Fri, 21 Aug 2020 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598007711;
        bh=RuQ3tAsSpGBjNhThS2+HWBKVcKCmLZrkBeKh8fCgBp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bumbYinV45FvdPicWwbx/xtAosfsueSLyBe3Ea6CzYNab0wkirrcIjFGFKpjE72g0
         hkHAnaPYfbFIAc9VG0WZ0pu93JzpSnp/YSWc72QyP+eQKSjGuBt2QHNxhHiIZ0YxE/
         OY0nx7ohbAHQ1iKKO5y47jXNHLPq4DsCuVOw1zhE=
Date:   Fri, 21 Aug 2020 12:01:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: linux-next: build warnings after merge of the sound-asoc-fixes
 tree
Message-ID: <20200821110117.GC4870@sirena.org.uk>
References: <20200821093901.4257afdc@canb.auug.org.au>
 <a8b47ba9-7b45-bef1-08a2-820fe48c4cc4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <a8b47ba9-7b45-bef1-08a2-820fe48c4cc4@linux.intel.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 07:01:15PM -0500, Pierre-Louis Bossart wrote:

> There is a companion patch 1eb629363aa35 ("ASoC: SOF: Intel: hda: import
> SOUNDWIRE_INIT namespace") that does the import, not sure what causes the
> warning?

A patch which was not sent as part of the same series and where no
dependency was mentioned :(

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8/qX0ACgkQJNaLcl1U
h9Arggf/d9LIC/aumFY+tjivgrwS8qGt3j9UBJjw41fmICZBc6kxoeJAP58PaD7K
wM3Lpp5P+jD1v5NHo86poZpXhcGLtrmTh8KACphaK8fnCyuqrPGxZsyz+JBxVUbo
PmPHwcqIZWmrkN4+Ixnl/D6cvDy4SEiDSlksqsykhXXZSzJNqOchK1D0dnzee5tT
0TJJN/ZCqgtisYTo2HydpcgCbpXdDG2frjnb8u5F89MVyBugalwxU7La7Vd3Yj/N
6bkfTk9kRRoQ1Eqle8Pwq/RQUSnTpeWSu/twSqCUDfz4ShvxQZ/w9sMRzhD/sGV5
VATmFxretXyPUgHFiFZBceNvyqB0Rg==
=UXdR
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
