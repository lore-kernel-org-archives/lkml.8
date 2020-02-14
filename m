Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71CB222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581686121;
	bh=DXPeRylUuEPDT5DfVJoOGD+lF8Rk72xr3cJvgxehaOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eXVbdGjga1QWc4tlI7bJvPg2pMuHC2WHCjJ1vDQ7++AisVfKQEX+WS38TeT9vq+ul
	 psJqbeYUP3KwmNbU4PLea5ybOU99W8cJmw6JDYc1qPXvehM4GJ0+K6MmVt6zlVVola
	 segW9peBOv5Gxwmi0sdjoVuy8bbxhVXAmmBR79ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgBNNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:15:21 -0500
Received: from foss.arm.com ([217.140.110.172]:32994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgBNNPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:15:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B91F1FB;
        Fri, 14 Feb 2020 05:15:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B304B3F68F;
        Fri, 14 Feb 2020 05:15:19 -0800 (PST)
Date:   Fri, 14 Feb 2020 13:15:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Message-ID: <20200214131518.GJ4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3RkK9jYN81zD2N+"
Content-Disposition: inline
In-Reply-To: <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3RkK9jYN81zD2N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 01:50:44PM +0100, Simon Goldschmidt wrote:

> So please correct me if I'm wrong, but to me it seems like if this driver won't
> work on altera, and after merging it the currently working driver will be
> removed, altera will be broken.

I'm not seeing anything in the driver that removes whatever the current
support is?  Unless it's just adding a duplicate driver for the same
compatible strings which is obviously a bad idea but at least means that
unless people enable the driver there's no risk of it colliding with the
existing one.

--g3RkK9jYN81zD2N+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GnWUACgkQJNaLcl1U
h9Bf0wf+JRM88awtvIQMXfKs1lgxlfllMbkWple5qv/wNTCdOQfaqsYNta9ZBXmW
I5jaATsvd7dyl4UhU8//nUEC/uiqs0wi0Qcz5LplUoA8mX+2DN2OkkywX2pexC+A
FuLWl+mOO2iXYpnz+Yuhc8P5/S9FWS3V/MzII1dxVFfe+dBjHjkVZ+bQeu+VoZtg
n9vCFK9ypKEwT6W7ktYYp6BFXZVkECwmsWUPINA/lpYOMth1GyoNGMUJ6nV7Vbqo
FM5+BfieQSilXzI93+sGTRhfiFWrr6E8Lrms/gr8UExCo3ug6CYeOmLPKTfRc4Pv
ccqVO9SZBPo+cN2rES/CeCUC5WJpAA==
=aZzY
-----END PGP SIGNATURE-----

--g3RkK9jYN81zD2N+--
