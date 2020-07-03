Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05145C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03C7214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593816624;
	bh=++Nj0WS/fbRoG0cYbUYNYqTBhY1hGfBC+wzNoS4TTOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NP2IALDWCfajFJaJB1tbIzESlKRxxrTM+sOl2vzn1UNrFAlbpnXfYLKgA6gToHQYU
	 Pd7z8YMCdg91EqmN73y0bnaM25JFR+98JRvlA/dk5K44OZgcBPYrR1VkgPIEp0eCWC
	 LbXSW5claZEYpybL1dkWTiawmHnDD8U/i1dY4scc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGCWuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgGCWuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:50:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D6C21531;
        Fri,  3 Jul 2020 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593816622;
        bh=++Nj0WS/fbRoG0cYbUYNYqTBhY1hGfBC+wzNoS4TTOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Utl9Q+dLN0qukZp4Udwg5OOtrBeg3UBgS740gFxT4OZF2kru0R8LXQFFef3WW6dKt
         L9wNatfUbwk4cpgbL/HvYjQnJSYg0BQofovZP3vD86gY11OAySg8Ez+DFhZN/2Q4sL
         c05QdOHl8yK5ujur8V5wVvMa2XqgyTprLVSiAVO4=
Date:   Fri, 3 Jul 2020 23:50:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     tiwai@suse.com, festevam@gmail.com, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200703225020.GB29047@sirena.org.uk>
References: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
 <159379581381.55795.16716505708033817338.b4-ty@kernel.org>
 <20200703224656.GA16467@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20200703224656.GA16467@Asurada-Nvidia>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2020 at 03:46:58PM -0700, Nicolin Chen wrote:

> > [1/1] ASoC: fsl_asrc: Add an option to select internal ratio mode
> >       commit: d0250cf4f2abfbea64ed247230f08f5ae23979f0

> You already applied v3 of this change:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/169976.html

> And it's already in linux-next also. Not sure what's happening...

The script can't always tell the difference between versions - it looks
like it's notified for v2 based on seeing v3 in git.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7/tisACgkQJNaLcl1U
h9CDTgf9ElvPFLdEUZthk4VSCqaieXYbsCqPXsP+cbaZLW4aECwO25C2crwaAeLH
cP3VDBeRC1DMrnD5GTM4mqkVBkcfjXWVqVZ2BNkWQ3InpSvBb/ofmZ1fjkpKCdrc
UpSq2wrcMeGWf1/rYlpgXdrzV7a5S/RxLJiLU2ipHvs9ajHWV33bGwvNN8ug4APq
QH9RIhvDpWSM4V/D0eT+eIQtB+qdo3Fv/Db6f4fF9Ugn2pquAqZ4bmzvniqn2Et2
zMDgEDA34cgB4Jm9D2Le7X9ySsROTLwpPv+XbsM8Sl2f/slHeYRHTr3vW4kJFBhG
jkjwRIcv54fqhLCkLPFqhPvLLoMKcg==
=gzcN
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
