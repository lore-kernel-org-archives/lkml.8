Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C08C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6252469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582821906;
	bh=zKpeguCmT9CVXzzpXINUwJXlEpMfRH/QuXQb8Bd23pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KQBTyD/O7cFQhSfdwXkPFd6pwzLFLB+h/0SrJS99ZvmK2BbUiy3T7PfOcGOgEJ+A6
	 3hHHX6Fv360gHGS5BGHb3bV5CkOfjGdJgiiygPiPkCQoG1cU+/Q2yZvhMMMh6YrAkE
	 zPGoRVh6UoazSYHyeWwj+tKQ7Fd1HydfyDxC9/Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgB0QpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:45:05 -0500
Received: from foss.arm.com ([217.140.110.172]:54668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgB0QpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:45:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026B41FB;
        Thu, 27 Feb 2020 08:45:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE113F7B4;
        Thu, 27 Feb 2020 08:45:03 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:45:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20200227164501.GG4062@sirena.org.uk>
References: <20200226114740.GA17426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20200226114740.GA17426@localhost.localdomain>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 01:47:40PM +0200, Matti Vaittinen wrote:
> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own documents for BD71837
> and BD71847) as they have different amount of regulators. This way we can
> better enforce the node name check for regulators. ROHM is also providing

Acked-by: Mark Brown <broonie@kernel.org>

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X8gwACgkQJNaLcl1U
h9BQxQf/dkMJywfZLpENv0wkVka+E4/0fGjbXabjur2aSCNXYju7kX0AAI+s+pjR
frhd0Sw1k/PMwGXvsO9ZiQs7631hRzA5a12/1/1wtw4L6A7IxKN866VJwlpMXmj4
EeFFOqyzhlL661aHZB6runAuvQb/oC6fnoiT2HRyt+Srkj3pFF72d09TrieV/MV1
nYc8bIbgpz0Tgk6cACNdT8lgC8I5fGBl7pPZw7AY2r4brDqw3Y2WvwYNrXXGBZxx
lsatLhbzaCfYTwiKkbAra67tfhnYZlnIndD+cEbx9u8Xrz/eUeDxY5rPLM5ivXEX
HwijcbyrVpBgUhXxZhJgjS6AhMuc+Q==
=8Hrz
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
