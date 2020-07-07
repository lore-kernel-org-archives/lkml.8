Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F83E20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594132739;
	bh=r9ttJzbwNMPEIjDSJnzYZR6HKchBlJoonLfgRTvUz5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQW+ejMJcdo8DOnn+OgKSYvzK80JoG/E9zl/wcoVYqe0CxNeCXS+ABHLMGddB4sPZ
	 WyIRW064qMIZA8E7MOm+hBzvmGXOwVafr8cLVO/E2EsQPYiFtMow6MfCC1eaHPPfmX
	 lyRxGexDNU8UM/ZcaYHYNR1XQBAzgydsrPBk5I6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgGGOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgGGOiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E568B20738;
        Tue,  7 Jul 2020 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594132735;
        bh=r9ttJzbwNMPEIjDSJnzYZR6HKchBlJoonLfgRTvUz5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCg+Fw9D/hvKjh1hwMD/KZB3at6oNNLyoEW/JdgW6qiFOtWy0AuscQGvW9q4jN9iU
         Egy3SnMliLCIpIEnWEaGdY5gfwDqjS3+tF+n0uOnIcbSpK1mEImjXB1jDdYKFoJ6Ol
         437oXaFoBQ4u2VC9gNz9/JiyB41Cfr501379Rn9E=
Date:   Tue, 7 Jul 2020 15:38:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 00/28] Clean-up ASoC's W=1 build warnings
Message-ID: <20200707143850.GJ4870@sirena.org.uk>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 03:37:14PM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Copying in Pierre again.

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EiPkACgkQJNaLcl1U
h9C9VQf+LIs1umxkyVoBW+jFn6404dyxCv5nE38FXB5cAIcgv2kCNYf+MyTcPJS9
vUEzFhpgn97z4vNJKls2nG5kmlysLYjdkCBrP7xCzP6VmgjpX4YEYk7HHBhfRDTd
hs2OMuDnAWgHp+oSYDApPDsCJ/t53xLb/+KQa5dN9oN88P9vshP6cI/MqzXuYNZu
hM9eeUHq82iCpRdQ8uejePWUUmEEKLoyVEIrAf9H+dOQZef05gYCnkcex/YmUHTP
8rXGDQ54YqfGM5ftTB7QTEpUiTgG+AipLnXncd79EnUGsOkD3iWVpy8Q3XyZ2Vb+
q+kt3kLOcz7DKiUqDfHyBu/iSymF5Q==
=C0zI
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
