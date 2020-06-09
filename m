Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6261C207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591723908;
	bh=K0BGTYODR/iV0wXVelqhnKL30cXjlfOcm9U6wurUmVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ux5Fq12IFwFM46mmTtXC9VP4APObsLp6grADjYJ56dwCVhXDr3PrHVEyZW6NhkspT
	 b4gtuvO9+o2sbQV8h2GES3OVw7yAGl0jUSkqJn7R7DSL6ddoiAJnYSEDq7nQ/beQM0
	 eB49zDGs2OEpIP2M2lfWn6Nw5J8I5Q7DRHfkZfqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgFIRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgFIRbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:31:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B35E20774;
        Tue,  9 Jun 2020 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591723905;
        bh=K0BGTYODR/iV0wXVelqhnKL30cXjlfOcm9U6wurUmVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcmALxhAjslUXnR6YC7eg8kryfNAJrhmSweugHk354NYxFsktyjtrsT4HD1rk4dsQ
         3Xegf9abdCNTeo8ST5RgTYxBtK/l7h8TBi7Yc+O2qwb3pwHDDS3Eum+Wgt4XvB4eVk
         w2Ll9jFjOhQHwgavtiCkF4P5PDyOgcBaq8D0Nqjg=
Date:   Tue, 9 Jun 2020 18:31:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200609173143.GN4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline
In-Reply-To: <20200609172841.22541-2-dmurphy@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 12:28:40PM -0500, Dan Murphy wrote:
> Add a property called firmware-name that will be the name of the
> firmware that will reside in the file system or built into the kernel.

Why not just use a standard name for the firmware?  If the firmwares
vary per-board then building it using the machine compatible (or DMI
info) could handle that, with a fallback to a standard name for a
default setup.

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fx34ACgkQJNaLcl1U
h9B4Pgf/ehxijrs0I1XM6a7jjZd7I2o0Qr+iNYOZ2FZzlvfc/ctItyP+oleKNvu0
Z+7bX/9Qz0KlfxABFmoUxik3859oNIASDdnZ9uPC7damLes7HkxLmixASJRcEyJT
cMUPqPVVu2SYP8g5Zl4wDJKFBdg9vpsm7yUT/DJWEgwOS9MRXfM72rnxl5mgqN27
mF77C5XHmIJu/kUg1g+KMjEBpwY7iTBWfDXLecGikn+egcUdRnx2NMDQegDN9AuI
51ClUyGEYBsKX4KN1i4S1VdVA9db0Sd/Bsfkv2AS431i435xbfJSRZ40AUYFyWPJ
kasHwah+rBUXN1Ue9hukXgdCrO3T3w==
=JKgl
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
