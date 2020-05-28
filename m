Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53096C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D33E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590666854;
	bh=Jq88qShvPLUl1jSHeV+HkTpQ/DEqP0CcIR4U0/qY5Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dp6+rtjSfxT7OcvsCL7e3Rr12Hw+56Q1bg8nYbwBfBCqd0W7vUseX9joJr14eJsu/
	 mGEIyRTaiYapiIh37OS2tlA84/5GugE95dFheLA2m8lxH5mLaKgAHKUiyAsSRuk2uF
	 pbBznipePdqWxxmJTDO/k5kmWvP6FW8xRhvIW4QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgE1LyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388480AbgE1LyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:54:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19208207D3;
        Thu, 28 May 2020 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666851;
        bh=Jq88qShvPLUl1jSHeV+HkTpQ/DEqP0CcIR4U0/qY5Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSCuC/GdyC1xvDEeZtfH+KztwBTdusP9Jn9Qo081KnVeRTifE5bbwKgpfgvzGSOJB
         f8Wwi4S/afpXabkNBcAdx3VHGl6PyOmuz8dIWERfvBq/PiUr32VXziW9Ur6rgCOUcG
         +ZxAYFkTLlaMc9+RxpO/60q0FEId87wu16JU96Do=
Date:   Thu, 28 May 2020 12:54:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com
Subject: Re: [V6 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200528115408.GA15800@sirena.org.uk>
References: <20200528103942.17432-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200528103942.17432-1-steves.lee@maximintegrated.com>
X-Cookie: It is your destiny.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 07:39:42PM +0900, Steve Lee wrote:
> This is the initial amplifier driver for max98390.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

> Reported-by: kbuild test robot <lkp@intel.com>

Don't think the lkp bot asked for this driver! :P

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Ppl8ACgkQJNaLcl1U
h9D2Cwf/Qy+1GYjYeCfDvjmqMPaI3X7St5/fWnywllbLp9VBVpQfpvVVblIm5kSv
ar+TVL9TRPLG0Za0y2udP4JxjHivDO+BJRInFTtl+8E2sP81BF+iz0nAjO073vFR
9+zoiZK+Y0XqH6j7cjFw0XRjkBduft6iQ/X9oeCT6Bhe5o0XTJz9yQO5GVgNvl3g
hDj5sh+bwDgGblV+LfavnqbzYe1jchiqa9kwFokig7mE6AURsV0XmPgxKig3gCvC
fXxEwkORlUh3VFAIoSmT7FEI2qqECkrvpPY4KiVuxIlbzJmkJgPwwzgI4n2AcBRu
VcM7W+rLl8wX4LwTvE6YjNvXWGxssQ==
=ieAp
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
