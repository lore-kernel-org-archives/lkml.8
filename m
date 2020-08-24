Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30CFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D242074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598268350;
	bh=7GIaKetwytFVVmGuqF6J4EWX1T8qm6Wcdr0mF9j04Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Go1xB7OPbJRsZS8j1qlU8F4oLQMOrwWc3KTdFT2iBHRAyyBivYhkRWaXwbs5LlmMq
	 MwgGFOQ6TCFc0WaKvOdSGMH+tEO+IGHfyiFC/XsczGOVlSe3k2sbNxbSWMK6K8QX2a
	 E4qchvq5d31arBcLN+BwdNMmj93OIRjgLboh2byA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHXLZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXLZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:25:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159412074D;
        Mon, 24 Aug 2020 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598268339;
        bh=7GIaKetwytFVVmGuqF6J4EWX1T8qm6Wcdr0mF9j04Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOZuujobGhwvWq01HJ+H0LzcafLeyO6owoL6H/+IFI8PIwGNOnIBXJEYDWjQqvW7k
         5stVhA1JHelmI3dKgmIkXPpvpdqCeNQ8SHdzFBUEE7s0ZF0jfGiFVRYj/pFtMbQjYA
         OzozzQ4bKX8ySmmFfQ33dcD4xQ+vj+tmzDjiGWn0=
Date:   Mon, 24 Aug 2020 12:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200824112505.GD4676@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20200822152118.rlwbcgfk4abjldtg@skbuf>
X-Cookie: Weekend, where are you?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 22, 2020 at 06:21:18PM +0300, Vladimir Oltean wrote:
> On Sat, Aug 22, 2020 at 07:37:25PM +0530, Kuldip Dwivedi wrote:

> > > The whole point with the device property API is that it works with
> > > both DT and ACPI without needing separate parsing, though in this
> > > case I'm wondering why we'd need to specify this in an ACPI system
> > > at all?

> > Understood. Will take care in v2 PATCH

> IMO there is zero reason for the existence of the "spi-num-chipselects"
> property even for DT. We should deprecate it (start ignoring it in
> existing device tree deployments) and populate struct
> fsl_dspi_devtype_data with that info based on SoC compatible string.

Yes, it's a legacy from bad board file conversions and shouldn't be used
at all.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Do5AACgkQJNaLcl1U
h9A8PQf/cEQl3VktlE6c6lvsovpm3nRjF6qrRNor+1Py6I3IJ+oNYlQjbyPbSY1f
s8SEca4akE5en6X7+xDjSSVVML1D3ztxlmfQLYk2qb+k3YZEYxIAIrN7O0/4dFAn
3kat8f7Zzmh8m1fCvX+z48aJ1cqUhi0pYknPO7yndjrBBM4Y6M8yjlctThXc7vLA
rd+iOr4geg9teG4z8N60LBeMpHUJetUJEC3S7ZN22TiecSaQbKeppjsmbKfroQp3
52wGck6h7k6mQXtSicZg2OdEyyNMjy6dKx1qxkbUL0aHr10Boao+iX865bDqrAGU
NVsNfIiTRLTYJ/6mcnBDmK+gWqNe+g==
=KhPu
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
