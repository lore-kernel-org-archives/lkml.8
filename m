Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE746206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584106171;
	bh=Yk7j8SGTHpI98xhCrvImzIZgEyhQTKp3t8s3+e2xBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BZCHU0k4wprh3dA/YPc7TvLdRQD3WtWPBowiVybGx9E1YGUcuEl2K2Oityvy4W5lD
	 9ELjw6YXmkwY/hWG/Rh5x4h+pEwJxM8D3Q2KJgiQmaGVA4acMEMTQDjoT8iwo6mcwD
	 9FIwy8yZ9n/dnV7HBQSWJL0VFGaK4VzIDr8tW5Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCMN3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:29:30 -0400
Received: from foss.arm.com ([217.140.110.172]:55308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgCMN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:29:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D3530E;
        Fri, 13 Mar 2020 06:29:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DE53F67D;
        Fri, 13 Mar 2020 06:29:29 -0700 (PDT)
Date:   Fri, 13 Mar 2020 13:29:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200313132927.GH5528@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
 <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk>
 <20200312150330.GH14625@b29397-desktop>
 <20200312150710.GG4038@sirena.org.uk>
 <20200313030851.GI14625@b29397-desktop>
 <20200313121103.GD5528@sirena.org.uk>
 <20200313131635.GA28281@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <20200313131635.GA28281@b29397-desktop>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 01:16:31PM +0000, Peter Chen wrote:

> Most of pins for controlling fixed regulator on or off is GPIO, but how
> GPIO driver handles this? We usually configure pin as GPIO function at
> its user's node (Eg, reset pin for most drivers), but not GPIO node,

The GPIO driver knows what signals it's supposed to be generating, it
should be able to configure pins for this.  Setting the pinctrl stuff on
the consumer seems like for example setting the pinctrl for a SPI
controller on the SPI device rather than the controller device which
would be a bit weird.

> GPIO node is usually per SoC, not per board level.

Sure, and it's totally normal for boards to add configuration to nodes
that are part of the SoC.  Again I'm a bit confused about why GPIOs are
expected to be different here.

> So, I am wondering why fixed regulator can't have a pin in pinctrl.
> If you grep the dts, there are already several fixed regulator has
> pinctrl.

Obviously those pinctrl settings currently don't actually do anything...

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rirYACgkQJNaLcl1U
h9BWMgf+KO8LRDX1+oCXN2eOj1Pe7eWX9uuZQ/JLPi2Vyrv1xIsMXcHbf3p+ZjMT
Mm8e0a7B2ohAGHBBRWY76qRRoWsuSGqMHl9NkezUQr1XQdSUiFJ4XTdzBIU/auC8
Cb3xsnDn7XOqgft3aCBv9nNP/sNxesWDMwjXaytgytnFtBwW1NZLvckk7PS95KpQ
gXfGCPT68VEJwXEHzomCRx8BwmgEXN8Yxe9H1IfZ8Au28Hl6BUk10PSkoiyI7SPi
MlOGy/dZQ1mc0B3MCeS86/xINpEewq27tuYYDuxIsatmPclYIrfQjgGdBaTR88pM
AyxZ/JpAWWjLr6fG+vfVZ2Zhd6fSng==
=o51x
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
