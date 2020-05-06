Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84668C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603172070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588780396;
	bh=61SzP6jYuIR+DjFGG/3AzUM3hopX9KA2QA96YzJI/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CsOBCdChGFCIDOMWI5HWVnxCfklKgcJSt4+v9FvOdNQUD+2sRI+0rvhvj35DZuiVR
	 37XEpYjhR8pmsUN7FdvYwxhgcSvpXfhl4FgxBJdhg9YAKB0x1YAOjSfAN4T7815IBE
	 agmeENxQeR+IUuRv/Z203a45nIaOyDo5cKJZOkkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgEFPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgEFPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:53:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF25F20708;
        Wed,  6 May 2020 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588780394;
        bh=61SzP6jYuIR+DjFGG/3AzUM3hopX9KA2QA96YzJI/5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n02M6rTfUPMddeoyC4siuILDTmJjZuaqWDo9upgcwpX6XKADKRGtnaaaFXzg73kw2
         UTXti58uJIzNXeNOa9fT46C9sy4lArpmqerVdZVU4B0zSBh97JZ3U+qADxqYn/HoY0
         v5ePdk+ien+u/L70HvI+C4ynIJEXVFuEBmpFzUxg=
Date:   Wed, 6 May 2020 16:53:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, swarren@nvidia.com,
        linux-kernel@vger.kernel.org, nwartikar@nvidia.com,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, thierry.reding@gmail.com,
        atalambedu@nvidia.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com, rlokhande@nvidia.com, mkumard@nvidia.com,
        dramesh@nvidia.com
Subject: Re: [RFC] DPCM for Tegra
Message-ID: <20200506155311.GG5299@sirena.org.uk>
References: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
 <1jzhalffhh.fsf@starbuckisacylon.baylibre.com>
 <fe842d81-22da-fbbe-b5e2-9872cefb9d8b@nvidia.com>
 <1jwo5pf7de.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <1jwo5pf7de.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Not recommended for children.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2020 at 04:47:09PM +0200, Jerome Brunet wrote:
> On Wed 06 May 2020 at 16:12, Sameer Pujar <spujar@nvidia.com> wrote:

> > XBAR currently exports all routing widgets which can be used to
> > interconnect multiple components and thus implements Mux widgets. Fixing
> > the routing paths in driver would limit anyone to try a different
> > combination as per the need, unless driver is modified.

> I did not mean that you should restrict the routing ability of your SoC,
> quite the opposite actually.

> You should just expose it correctly

Yes, it's going to be less effort in the long run if nothing else.

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6y3WcACgkQJNaLcl1U
h9C+9wf9FhV0+uWoqDcuQBDbDmaqyavUV8uakHgopXF3Q9Ny3WMoj1EBaIpxOOM1
nFLZGkaXGkbOEDxuixc2ptvMvML5c8WccOrS3J9Ux6K16BbXpwjFsqClUrzpix0O
r40xsg0q81/pSxIFOWU0BKmFebz8wLG3NGGV2d7ZMW//kIG7LVAb8oB6epKkeKYY
sACMClQ7QsGOeWqteFWq91phXk4OL9KJ4SileYVgTcMBoeN8xgIytv+v7unCTKhk
aJALdHiBajto60CLYG6UPUoIZ3FRLWEoybSOdI7uQz2MmWctYmzn5OQu3lGGlM4l
XM3B0/3XWGsyGhK+XM1JqWoi9cz1tw==
=tJVE
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
