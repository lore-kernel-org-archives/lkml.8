Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEDC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4CC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588328528;
	bh=8PiUkTNj8dS4j695LU0tBOc5dYcnMnyHpPrN0SZQOK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iB7qud/v4+i2or5R+F1R1Jds3nKZ5X6i+5jToXj64KyMM6fMCWow4jMKsgRyhfgZT
	 z4riIp+gl7Samt0OqUSDPOhjSORnha6QGm4P3Z7MJAUbLL9i5GoJYM6JO1t4AhXLki
	 rPgj1mapPJU83LfPkIMMED2u3tiTJFk+Fh72Oa44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgEAKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgEAKWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:22:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD15820787;
        Fri,  1 May 2020 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588328521;
        bh=8PiUkTNj8dS4j695LU0tBOc5dYcnMnyHpPrN0SZQOK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOTspiVozJzNRZAUtA9SvU4tVEBPMFtj4vbtNeG6j7iIG8fu+SN9CPpX/usVudhHG
         90faFkROucGSYAftqdqz1jipFHOZFG+o8VAZDRm/Jo7UklZnQenp4mycxHsoLer497
         xxaJqhb+0gcSkrvvWXRSjHALoZq3IzqGO6NMEZMU=
Date:   Fri, 1 May 2020 11:21:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
Message-ID: <20200501102158.GA5276@sirena.org.uk>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
X-Cookie: Think honk if you're a telepath.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 04:12:05PM +0800, Shengjiu Wang wrote:
> The difference for esai on imx8qm is that DMA device is EDMA.
>=20
> EDMA requires the period size to be multiple of maxburst. Otherwise
> the remaining bytes are not transferred and thus noise is produced.

If this constraint comes from the DMA controller then normally you'd
expect the DMA controller integration to be enforcing this - is there no
information in the DMA API that lets us know that this constraint is
there?

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6r+EIACgkQJNaLcl1U
h9DfFQf/TcF/ZY/a5ix0r9s1n6xwh2QMqCs8szfQsOfEi3yLY75x5EptEuWovv0O
f0qx5o8tPjQNc6Ta+xw5OLLyOOTRSq5Gh703vik1g4SHjBWt6+Yn3SXovi9Y0j4V
ldBR/b2hTetKB3kxy5Ye0zimM1m/ifUuixaPTe5tfugJDWTAFaC2ZWFBlF1mveIb
5elPV0W1IYhCLo73wQa3Y/5evQCBv/uVMjWQAs44wt0LR/IVENEtBx/C4xkjgfrz
97uSY2xEEUsWDP/xi1fLlI5bU24PGepYE0cfN4N8hKNJGuL16WXZxnZRaN4LBk/A
n0v9+0DGJjzdrSsDZq/KxIk0QOQtsQ==
=RLMk
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
