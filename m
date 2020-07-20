Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00620C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD86207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595248466;
	bh=hzeVc/gxIpFnmrFKoc8d5uPMWXQwJhcaHk2T74oAuKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F7Tci9rAgu3M2w11gIPVbfL0LFgjNHv4a7H3swrcmh7I4loK27W7xUR92VKvZ7RYU
	 HTM1rzeXm+mlcG5ZfcfIWPwO3daU0p8FswvwRyJxoGvVzgz33jYVurcCZ1Ro3mWP+K
	 iNNTH0S0j6b0AdK1QwPs4hPhU4/0PRvdcb17yWWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgGTMe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgGTMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:34:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDEB20729;
        Mon, 20 Jul 2020 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595248465;
        bh=hzeVc/gxIpFnmrFKoc8d5uPMWXQwJhcaHk2T74oAuKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNIQRNLUeaOm242lCQ//ekAiVmUhx4VAmkq9bfkDhwmtF0S5WvuZ7aj/k/7l0pIYm
         Kl3c32NGAgK1v7AzJwyojQKwjnmuiMusPRlZ6xsKLLu9Z/6QRuS+AgmtiYfue2k4GK
         Uy/0r56WaWZ3EszQWp+HLQodDw9hsf97KxBsOaG0=
Date:   Mon, 20 Jul 2020 13:34:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com, nwartikar@nvidia.com,
        swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v5 01/11] ASoC: dt-bindings: tegra: Add DT bindings for
 Tegra210
Message-ID: <20200720123412.GD4601@sirena.org.uk>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
 <1595134890-16470-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <1595134890-16470-2-git-send-email-spujar@nvidia.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 19, 2020 at 10:31:20AM +0530, Sameer Pujar wrote:

>  * DSPK
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
> 	t=1595134894; bh=DX96zRQRNplPikN828HbAfbjGumAn9IgtktrsenKjgk=;
> 	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> 	 Content-Type;
> 	b=IhfGFjMxsnRHso1Ku2GEGC+mtLCy3AbRKPfgTS56XGqEWquUr/1s8n9tFpriqF7a+
> 	 tJGrTN9mKhRQGrwdey/AHsMY4Tbm4fKEWxIASgAV/lFPCfgP3BnVjEdHclc7FdBaB0
> 	 Qvd3zs8HFsgoIzksLrtHNMrUepkeZajn0/XnC7nghGDRim4+6Hauupr5kj/KVlihsS
> 	 KS1YQ2Zz9TZzLaC5QXALiHj3ATLvBFrmIf6Vj19q7hePt0menTZVzQNy+y3h4xZfLH
> 	 +OvBCsLgHGGhq+iM9rm64D+S5Op2vCslwq3Q/42TnYZ0vDbD7aA9nTAQzfYeI6HK6b
> 	 vi7eYbryzCTSg==

You appear to have a bit of mail header in here.

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Vj0QACgkQJNaLcl1U
h9Cb+Af+OINXrdCpdw+ER9s3wYRO8uormKGyLZ3qGxOVdkNfbg3pIVwmGiNxWjbo
vjrchHQ4sQKrmvZOHal6nz2Wy3rqifGaSiahI+K4RzmwFWphmnn44nDRVEr2DUfh
fuZkL5bBbAOkg28gsOsxgkQ5PIXvuegd+KCCgf7HyU1G6qLABL0N4fCIf1ozPQuZ
XgLXm9YwnEtl/mi7wTjywScrnkiq60Q9aij06zBPfhzKKnmNmxZPpPwi/ENZEmoZ
rkplukCeIK4k+uXl4mttEzUjt9YcWKRa5t1fS/8SYkG8Z2Fu8ixFTQhC36V9JLQG
VcFXVBJqQJ7bisywwAvne+poBEpP2g==
=2HYu
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
