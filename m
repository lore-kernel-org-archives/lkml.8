Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7EA206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591183909;
	bh=gM5y3C32ED1XSw4KgaZ6/TuCIlt4f+Y+Lfe6pcm+aas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DmOyuzyvZnOMKQ9ht9/uHxIUp2aEkxJytHK7x73fERJVXZ6lPlfedDnAksXrGEwd+
	 ig4yy4v6RmP92Chuf8tMiNDMkWpsj5f7RrNyfrqEEHcxrrAXAiTcV6tha8+7BL9SWT
	 +vDq0X1YI7rL/62HlAAY3inEisbXlYwprN5THO0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFCLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCLbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:31:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD93C20679;
        Wed,  3 Jun 2020 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591183907;
        bh=gM5y3C32ED1XSw4KgaZ6/TuCIlt4f+Y+Lfe6pcm+aas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9IrNHP1AzzYH1IFahskpuLNaeFg7oWTsN6QM57NRZ1Lpl8Dmr8iQt2UcVkjEeBVA
         pYY8BOpBRBN1rfFZyh8q6WaR/F++FmHyTAzrembzuJUx/8/7b4z/ETXJOfqUofCban
         ixPqDENdgKMszly1ZKo17csizywvQNvhn4+Icjt0=
Date:   Wed, 3 Jun 2020 12:31:45 +0100
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
Subject: Re: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Message-ID: <20200603113145.GC5327@sirena.org.uk>
References: <20200603111819.5824-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20200603111819.5824-1-steves.lee@maximintegrated.com>
X-Cookie: Your supervisor is thinking about you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2020 at 08:18:19PM +0900, Steve Lee wrote:

> +	param_start_addr = (dsm_param[0] & 0xff) | (dsm_param[1] & 0xff) << 8;
> +	param_size = (dsm_param[2] & 0xff) | (dsm_param[3] & 0xff) << 8;
> +	if (param_size > MAX98390_DSM_PARAM_MAX_SIZE ||
> +		param_start_addr < DSM_STBASS_HPF_B0_BYTE0) {
> +		dev_err(component->dev,
> +			"param fw is invalid.\n");
> +		goto err_alloc;
> +	}

This is now reading the size out of the header of the file which is good
but it should also validate that the file is big enough to have this
much data in it, otherwise it's possible to read beyond the end of the
firmware file (eg, if it got truncated somehow).  Previously the code
used the size of the file read from disk so that wasn't an issue.

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7XiiAACgkQJNaLcl1U
h9BWzQf/caANAxCS61zFk2A9ang2ns0xTLILhZ3lBoZYjNRa6FOl5piohx/OBPt7
3qFtraruHxJAimWKqf0ms2LasyxtPhYAUr7NvkTw3eNjVgMIe32eRP8QPY/mJ2D+
7kg4NLYxWgoTUQHPJWc4OJ7jwHAsemal+6l+t+m5ndUZOgDGcFhP82QrSYa4j+A1
YVXt/8Kbh3MUjHp+ydjBpOeEjy9c2AdCCqX0B/Ul3z1OjuS6+20UzlbsUCGw0roP
JUg3e68SzJmRqUroBF/YSRD9skx77tMqvrGTHNKXC/XIO7r0L7IdDgRIjD3ETe7a
zOwynkWzaydw+v4kmWb0sNfBuIGeoA==
=leSn
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
