Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC8EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCDE20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593020902;
	bh=Rd247W4TlIFIqRUN5CZBQ8pW1nn1BEnuDzx5LIv9uI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mMuZMxsh9K8WF/xZc07OFnlUlc3O0e7tM9uRB7+qIaGqqc3lG78BYhz7RBo/7Ig7N
	 b3LxGQINYqIKpKIETP8hfguDQ0h9bdZxS7goK86exeK1pjIca33C19I6ART9GQEob9
	 kAoz96kvWqKAp+xniVqgmA5Drh7gxhWs7E99LC6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405678AbgFXRsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbgFXRsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF5C2078E;
        Wed, 24 Jun 2020 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593020896;
        bh=Rd247W4TlIFIqRUN5CZBQ8pW1nn1BEnuDzx5LIv9uI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHonIhZpQRO6pS5tR+zcazZe1jOhNFxYvXDk6eAdoTbH3BNsqIIlG+pq1OikN4aPa
         8gmcGODIm7euoJ8SRylxEaugyZ5kTmjfTBt48WqwQqyybdqaYpWCv9jyVlU0zg/1u9
         VTi6n7Jlh2ewFIkm4rfZ2iclpmJiH9IzM/kDnT2w=
Date:   Wed, 24 Jun 2020 18:48:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
Message-ID: <20200624174813.GN5472@sirena.org.uk>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com>
 <20200624162917.GK5472@sirena.org.uk>
 <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
 <370c71e3-731b-3549-adb0-597abb217cfc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gWRamliw218YCZO9"
Content-Disposition: inline
In-Reply-To: <370c71e3-731b-3549-adb0-597abb217cfc@ti.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gWRamliw218YCZO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 12:36:02PM -0500, Dan Murphy wrote:

> Can this patchset get a review as well so I can fix before I post v6?

> Not sure what the current work load is for review or merge.

Well, it's less work to review if it's been fixed...

--gWRamliw218YCZO9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zkd0ACgkQJNaLcl1U
h9AskQf+MHoC8Q+bNQ74k5lFb02jagQQ+UAisttcMWDwOQ808pYGt8LXnHlt5W3u
hO26+agp0uMPxr3pczemvo8mp8Thsk3Skc4xYb7ZsT3oP+QNN/g6/vy54TXhDozo
lGk+SqpHUqm7jFMQV/aGlaghfhDPs24QVlj8ixrTkYevBznFtr23oETtfcd20Twg
2R2P94DZXDLgn8mj8a/djQopE309CxT1BZn36yZZN+GZeVBEPKBlTVLrBa+gVL1q
dy+dWL9mTbauDvH2kZij+wbc4r3PJ55KSGEqSCIFqVmNtkKo2OGt9Bb5TKdOtvLS
YfI8rp7hO+451SN+h5UO+wGpv8CFUA==
=AnCC
-----END PGP SIGNATURE-----

--gWRamliw218YCZO9--
