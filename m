Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61204C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D128206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589451396;
	bh=6Tu3XwoQsW+jvk2j/hmdnVuJyzrVZujLB9szn1NBVnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzMIAEJHyN1eDdyTMIgBkSzBwWetjyy8hGJughoJ00pzfnQykVOBvDs2WxlaHcYem
	 wV72zcqd/ukyd+ej2QIaKLlOVbLD97kU94iJO+jK8XlMrvW5oO1jl32AlWtBItKWcU
	 UMS53WSoQtxCqjimzxHr/KEumYNJsIDrzmeqgCo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENKQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgENKQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:16:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FE42065D;
        Thu, 14 May 2020 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589451394;
        bh=6Tu3XwoQsW+jvk2j/hmdnVuJyzrVZujLB9szn1NBVnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yq7GRQWAZvtUVCiIohiZMr6jTql7w8zDSii/4xvUEmTZ3H2efmW1yveK+lfmm7DVM
         06pgXgfS9fTXpT35jXDiOOmEPhbAQ9HlfZHeePextM6PFVHCuD4XNhWRBSl4NjC6Ln
         fgzMslNOmCj1hoV7529C2qdv7kwG+YZ3HtxdCgWU=
Date:   Thu, 14 May 2020 11:16:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Steve Lee <steves.lee.maxim@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200514101631.GB5127@sirena.org.uk>
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
 <CA+Px+wV7o1P41ZdidpwNFtwWL1-RYcwV3dU9R7PG+66k1L_p_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <CA+Px+wV7o1P41ZdidpwNFtwWL1-RYcwV3dU9R7PG+66k1L_p_A@mail.gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 03:31:52PM +0800, Tzung-Bi Shih wrote:
> On Wed, May 13, 2020 at 3:47 PM Steve Lee <steves.lee.maxim@gmail.com> wr=
ote:
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -0,0 +1,1030 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * max98390.c  --  MAX98390 ALSA Soc Audio driver
> > + *
> > + * Copyright (C) 2020 Maxim Integrated Products
> > + *
> > + */

> My previous comments on Gerrit may confuse you.  Please use C++ style
> comments (i.e. // for all lines) here as the maintainer asked.

> Mark, may I ask why we need to do so?  Is it also applicable to header fi=
les?

It's to make things look neater - having the two comments immediately
next to each other doesn't look intentional.  Header files require a=20
/* */ comment for the SPDX stuff so should do that.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl69Gn8ACgkQJNaLcl1U
h9AqXggAhm3L2eRyNG6E19XxQRco+G0tJt1EnQCWdxI1Pix4/kWDCHbEgxXaVM/S
9wlvtdMtoj8qNEOZbRxXGp+PPc1W6ycRd3e88CEm5do58fsVV+Dt1bHRY99IkdbH
QkYD65uS8mkjpynhTCASvWPD2FnkHDTtp/3WYGQdmT4yUvUc/GPaySbEr7pmij8O
qLLn6Ul+rexrjGs1b7yG+UxwYu76LEHH+Dsp6ZDCHK1EkQXr+r7F95Ha+vJKwOp+
A2prkPEQVFZyQ3hGA8TeHBGfY820SKoBerIHZyav5G59GfUYiGNtnRpgG54YylQ0
dmCDcRL6qUOt21EOH5Y8qQG1vNQwqQ==
=6iKp
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
