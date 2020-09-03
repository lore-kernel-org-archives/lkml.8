Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39A52072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599154050;
	bh=t7zI8sJOTQOeS2rxXIac2iDol/sgkY7O7+T2zmbo2EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O1qmPeX5KACwGlebGQxk00pnVDuwgz2JhAXm2JVTiopIxz56ltq8zfXNUTv9fsgjT
	 358vEW/TfxFjzb8UPPuubXj0rH+3k5thln570dYRgxmcLwSZPVH+PJ49D2V8ViYeKs
	 y1fPNwk8+lclOI2KmyzJWHTz29SXc7Ux60paAOVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgICR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICR11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:27:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3EB20716;
        Thu,  3 Sep 2020 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599154047;
        bh=t7zI8sJOTQOeS2rxXIac2iDol/sgkY7O7+T2zmbo2EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5hpYffGkuaMwxeTg9w9yZBkfc5QohnUY1fywyCxQFvedeIfmMNVy6dlYf+KeHGgf
         RAuk19dUK92EJE+p+Rqp6q1j86iOxf7p12QqYEo89f+4JtAJ5qiiZjpx/k67B4110u
         yXa1mNMsIMsAwr7FfApwH5UHFeS3Kym9lSfm7s1Y=
Date:   Thu, 3 Sep 2020 18:26:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200903172645.GC4771@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
 <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
 <20200903164738.GA2929052@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20200903164738.GA2929052@bogus>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2020 at 10:47:38AM -0600, Rob Herring wrote:

> > [2/2] ASoC: odroid: Use unevaluatedProperties
> >       commit: a57307ca6b661e16f9435a25f376ac277c3de697

> This one should be reverted/dropped too. Patch 1 is fine.

There are others?  What's the issue with them?  It'd be easiest if you
could send patches doing whatever reverts you're looking for.

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9RJ1UACgkQJNaLcl1U
h9CFKQf+M6HSYRnla25/KN5u8rIphL3ZtnOOib9oxzgBC9uVZRtuYXAlFG8B5xt8
olwrYznTD37kK/648QMGn2O+Y9ajhunKSoNMkOb6MmUc124BVRO+2+R+46nmzNRC
XG0lzmhsGxrv2ECStqXP0fQKQLF4AwxUwo/Hsn+P+lusvTTA4zmHJxMpYDj+1QkX
5n71UCRjRztsHXoO2kLTYlrtJmasMeMerrojLo92V4IvhBWc0z7cqr5aDqJVPG9l
swgffAEkPJCqdm6cIckr4r40p59mOELz0eokuujYvdXlhkWgEvOjsPdxv8VpwsYj
KNOdRpg8ssqWMoQQ/rccJO4wIKe4xA==
=/qnV
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
