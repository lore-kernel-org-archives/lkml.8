Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E09F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581437949;
	bh=DJ6QV8YLyZxuW3E/cT0MJ4RayyjEKxsoicU1NXkweyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G6YVaEpPW0wPyE48Li7Xf/G/WG7kIZP9r9Ca3UN7peBYI37xfiH76mXFgQY0frV7B
	 Ggp5T3UsObOEIQpvpv/dTmylgCGX/OI0BPWVaneEtY3005Zdj4o29kw+UTBqh9+ndH
	 Nz4iUHvBdR48v152UDphvj42p+KEcRnstM+vBtdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgBKQTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:19:08 -0500
Received: from foss.arm.com ([217.140.110.172]:49324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgBKQTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:19:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6478830E;
        Tue, 11 Feb 2020 08:19:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDA833F68E;
        Tue, 11 Feb 2020 08:19:06 -0800 (PST)
Date:   Tue, 11 Feb 2020 16:19:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] ASoC: Use imply for SND_SOC_ALL_CODECS
Message-ID: <20200211161905.GM4543@sirena.org.uk>
References: <20200207091351.18133-1-geert@linux-m68k.org>
 <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 01:09:30AM +0900, Masahiro Yamada wrote:

> Why does SND_SOC_ALL_CODECS exist in the first place?
> Is this compile-test or run-test?

It's for compile coverage.

> If it is the former, allyesconfig / allmodconfig
> covers all of them.

No it doesn't.  Those only enable user selectable options, many CODEC
drivers don't have user selectable options as they are selected by
machine drivers some of which either have more platform specific
dependencies that the CODEC drivers or aren't upstream.

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5C0/gACgkQJNaLcl1U
h9DTdQf9Gk62wuqjst/9b6n+rQ0tlvq5rLi2q9impw+CjR2IVskAK4uCiioeMyQr
XiKWja8Ip1YsZT5ZPBJLSrti3pphLOQCn52hL8FsJiOrlvork/ZdOP3ebEJnE038
1ASs3ReEJ90eNmA54QJQaC1ufL9CyxJ023osbd9dZTEJ6UNSfEEPxCBnNznINYHw
KGxkJyxzCKpyDi1Ri1VBCuIgt0phvhXeYlQDn071epm/w6RQbOknmJnHK8DKrkTh
N26AF0h8JXdOKEKalEcVgVbjNf/ZZDaWWiRh+KmmYdVCkMbtzlUP3uTMLrDTF3Vw
TD0x1ByKAWkdsVxKpKH8jw/3BfGpYQ==
=uTKZ
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
