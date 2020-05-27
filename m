Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54635206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590578883;
	bh=ef/jJPV9ByXtDirUxMky79f/X31SPpgZBquKZf4ExGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Weq48yP6QkuGtyR81uYK8torFScInjDTe4K6oDNSHFnGU0+YMTENyrQvoYHkvCOAd
	 MImYXklgKuTUxHn0q02utbe9fkwy4Se4PjXhfkHVVD1yqGT5ohFmCwgwRkc4LwEuhT
	 hxbrgovMBHNC6cA+LBFaVo+N8bJ0kMVPW+YRMcWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgE0L2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgE0L2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:28:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE186207D3;
        Wed, 27 May 2020 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578881;
        bh=ef/jJPV9ByXtDirUxMky79f/X31SPpgZBquKZf4ExGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJY9LUFfHCypglbuznceow9Hw1fql7iGoKCpk7ydeFGTRHjnp11jxf5g4owd2Cu3g
         itrvhN5P5c8PfdjW2ak56F3khIJ3z4UQGG+M3pUr/L7g6iSO6FfO5WP9i5dUxNfm6W
         IQzLRr9RP7/vfapSeVgVqbwwy2Ix4404Ii47l1IU=
Date:   Wed, 27 May 2020 12:27:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     yuhsuan@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Use mixer control to switch between DMICs
Message-ID: <20200527112758.GE5308@sirena.org.uk>
References: <20200527014023.2781-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <20200527014023.2781-1-akshu.agrawal@amd.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 07:10:16AM +0530, Akshu Agrawal wrote:

> +	SOC_SINGLE_BOOL_EXT("Front Mic", 0, front_mic_get, front_mic_set),

This should probably be a mux with two labelled options, or if it's a
boolean control it should end in Switch.  A mux definitely seems like a
better option though.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OTr4ACgkQJNaLcl1U
h9DRYgf/akrvrra3kUeV1yqD3LwP+z/Awi1I/4x2sgSYHYzVEF60MkdDjY8+nYNZ
YMvWIEcZYxu7AuOR6dKmzK6ogV0E2dTfiy4IaiftYE+FpFjVQSLml2E258WF4Fyl
5Uz7BzoBvRT/t3YseDiZ1MPR/PiA/RbA38oiE//OKqLNQvEo+TZFf6Z/mzh6v7Fy
BhN9D7wbAIWk9LNzvlx/F4w+W9oOc822A573binK00Ye7oTZGz1jr1hZ16nzOTha
BmwljhOAM2VQW9Lly8uz3DfHP/P8z1X/Y09/EoTiEiH83v59zVL3vh3s4GrcFX/m
JUsmP5670wkUeRvmMe4muY+0ReOj7w==
=YKkv
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
