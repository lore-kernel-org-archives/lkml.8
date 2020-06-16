Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCE3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5A220786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592296823;
	bh=D1KwiAUn88OiFtooJuIFB9Zn8vRKLnDTMmkrIkmjR68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oSyBbtm6j7D6DCpt1Q2e35HpnHkVIvOm2K780sf59+/OGd2Q5IuD8HXmdKfI1gFpb
	 G/48LiWsoDDzga/Jgrv49YLVYlHaBgydjOPg1pEW+7vpTUjPC8JIZlxqS/HHBhjLlI
	 vw6nX9YB79c3HxvAP74eOcRdPYHXZDgLT9WNUM0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFPIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPIkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:40:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E192420644;
        Tue, 16 Jun 2020 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592296820;
        bh=D1KwiAUn88OiFtooJuIFB9Zn8vRKLnDTMmkrIkmjR68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HazHfm8g0gLHALwKVq750TzWuy7RqLiX0smxtYtjtVfko6XGESlHQCoOs8goiDKkq
         EpoRnJTVHsSxL6L1H2MaeEjfekr5wZaV9oTu+/w+FeM/yaswesWBB4Yix1DGvFvpKZ
         9+Xle8tSpVtpevk2sfkSO859zMKwJpPGKpXNMTzA=
Date:   Tue, 16 Jun 2020 09:40:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
Message-ID: <20200616084018.GG4447@sirena.org.uk>
References: <20200616063417.110263-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pVF9EYSGkiif4dMH"
Content-Disposition: inline
In-Reply-To: <20200616063417.110263-1-john.stultz@linaro.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pVF9EYSGkiif4dMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 06:34:17AM +0000, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--pVF9EYSGkiif4dMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ohXEACgkQJNaLcl1U
h9CG/Af/ceDDlITCWmAjvFYAY2eZevnFHCVPhH4Dw7Thfl049807+vh11NAvv2+F
2gcw0B2MUXD57nlvkIYGpJp/MbrUj05+jYjHCifVcLDOVDWgaVUTnqKOCN2t7wmT
Sri8WAslYCAw37pUN1++DMpYII8v8ROfqO0MhKsq3dgqiWGkEIyZuaJAeH0q/u4P
d1/C6JiRSxjx+7KidvRfkAu8eov4fCZUxqn6XMuvvMcTJTqVuWnjqHmEpZw5s8Jd
Er4RwfxpT95g+wGjdAdGMWJCdm1GRkcPus0zlExMHwQDZMESKcdq3jPxV5H8fVh9
Ccl1xk7tkLSC5p/mnsXeulMh0M2g/g==
=Gwvo
-----END PGP SIGNATURE-----

--pVF9EYSGkiif4dMH--
