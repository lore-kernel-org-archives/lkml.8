Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E924C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A472073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579522942;
	bh=9FYBXUbbY494YSG06ymhSLcgIMR6szP5kH1Vrw9G5no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xrUx7sbM5GgThSSZ4TiAVTr0VrPTB+FKSI42a2RR6ohuRoD2L/n2aq6EezDV37v6d
	 42uTPYC9na45VnZ1EqjM4APlbbird9wm1apZKvEsXaj9AlQsK67PUQwJ+kDNpSg1Wa
	 8g4ZM2MOIabSkdbDidKsp+O3E45NvAP9moFJki7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgATMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:22:21 -0500
Received: from foss.arm.com ([217.140.110.172]:59452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:22:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6580730E;
        Mon, 20 Jan 2020 04:22:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3AA73F68E;
        Mon, 20 Jan 2020 04:22:19 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:22:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        drinkcat@chromium.org, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org
Subject: Re: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage
Message-ID: <20200120122218.GC6852@sirena.org.uk>
References: <20200116094543.2847321-1-enric.balletbo@collabora.com>
 <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
 <20200120120830.GA6852@sirena.org.uk>
 <73a24487-d9ff-88c3-2516-69ae89915c88@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <73a24487-d9ff-88c3-2516-69ae89915c88@collabora.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 01:10:18PM +0100, Enric Balletbo i Serra wrote:
> On 20/1/20 13:08, Mark Brown wrote:

> > Yes, you're right.

> Oops, right, Mark do you want me to send a follow-up patch, a second version or
> you can just apply a fix?

If you send a patch before I get round to writing one myself I'll apply
it.

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4lm3kACgkQJNaLcl1U
h9CQUAf/efsDEbcnnk5BetvKzz/QA1IVZVudBFNlB/IWqG7fpYtpSYX7d8nY2Azl
EA155XqmZKER5AgjeJECocwdiWPCVY+QLWNn3qLTQUGjgnkptF8VHgnidKwCBDTr
M9iAobouq35k1gwV9/Kk53goXywRYdJcLXbZjf35pxRoXqDE/wM5vCfBnEI8Tt5o
gbYMrZPBV+KAEfVgD5rFNKqCw7W51mNik7VUNH6lJYPDysv+IYw8yvM5+rzfWdur
u+JnthUrENxCVHD6qw7Pvuqz6wsfh6eK46b9edAMp2iDQMz+KE9twKIge+RghnlK
2hjL0mYRVz7Cw9R3uNoEtTLOIXQFGA==
=SHV2
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
