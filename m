Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B471BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579D6221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599819299;
	bh=OSLR7WKpAsGFlS6cyFXhE4P0iBeRMG6g97ZnysjYs9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Er7l8o8DsVE93l/fdPwNzriU6yKLAdln6QNNq6scPJn9/zFxtKzfmDCmf1F+hEmmh
	 dLby5EmvkooH4lhSLGFsl6IBwB7sb7RNfhjQ8I701rnW0954csjyMBfclIfUjr7eHM
	 Hr+lCk2ho5Nci+zyVssHZChocOtMautX8avrI3Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIKKO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgIKKOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:14:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF95221E5;
        Fri, 11 Sep 2020 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599819290;
        bh=OSLR7WKpAsGFlS6cyFXhE4P0iBeRMG6g97ZnysjYs9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIhtv5TmIdUsva4pkKFlcwwY9QQNLFFp5BsYD0SGKi3zGarqbRxQoOojXs5tIkGc1
         2txw19EnpMJOLh0o7h4uiZcOkeQM4/znc+DWUQEfKIsiUJwuuelh3ws6bS0uU0kepB
         72C8S/34jXvvHX+CVpIgjs0PrHcQXpZqcyUUUop4=
Date:   Fri, 11 Sep 2020 11:14:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        linux-mediatek@lists.infradead.org,
        ranjani.sridharan@linux.intel.com, matthias.bgg@gmail.com,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH] ASoC: core: Optionaly add the component driver name to
 the component name
Message-ID: <20200911101404.GB4895@sirena.org.uk>
References: <20200910200308.9125-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200910200308.9125-1-dafna.hirschfeld@collabora.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2020 at 10:03:08PM +0200, Dafna Hirschfeld wrote:

> The ASoC platform driver for Mediatek MT8173 registers
> several components with identical name. This cause an

Why is one driver registering multiple components for a single
underlying device in the first place?

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bTesACgkQJNaLcl1U
h9C04gf7BZZwKrvOB5Cwa45nlXvWKuAww5NnRsik9jaFHToimYmlsocC/X6dQxkK
GbNBq3MLq4jn+v+S/A4B+rIRc7DOJr1pkgCmQJNKFbhvPIw+SxSiaBF6Plq6hXpE
GzCYiys6uXGG0XM128wHwPyBMxK/hy7hcTBtIFoSC2N/srTNCuYlkWK7FE6QFTnk
EuGkVWt4Hxg4io0Z9v8eDeBvSn5NfXjA48A3ekBbGpacSh1/B7heZ4aj7bUWWnTJ
hjGUuRopKXa9XiRXii6zh5f89qiAN7Vqo0oLv+G05eZO5SFNGr7z/fT4Fw24RCNj
tdlYwU70jcs993mUwt4ezK2UMrpKbQ==
=T1Tz
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
