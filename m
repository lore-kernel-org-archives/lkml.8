Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F512C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC8207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590757545;
	bh=iujYvPFgp+kMyGs/HHL6d27m94u1qo0gtVVFdFB0M/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OIsmtrkb85Y020GEneSWUVIIBifL3gPNFzXiOzePBLqYn7IZvUITKZzauH4A2DiVZ
	 Jfal5CAmQ1vByLVZjOwaFyQ5UL+VIgNPCxGu9eWLATU5h0Z2YI854QeksTSdLJT8+l
	 /lfyZMR7P0XfOc1pY94ZGabpbQ79kPbf8+yxwbrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE2NFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgE2NFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:05:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B714E206B6;
        Fri, 29 May 2020 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757543;
        bh=iujYvPFgp+kMyGs/HHL6d27m94u1qo0gtVVFdFB0M/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2sCbN+iq+BEr27d1TkCSeB+hJjmmTUlzYgQtmKUT88ehDy9jx8UgGGIPErHPLR54
         C/vcqmkGF5HZUV/dHn3msmqyvaFSHcBlTibGinAm7Kw+KMrh27uciL4Etw9ZyxZ5Pv
         HrKoTIT7/v9KH+mx6J/GeAsPi6tuIjURhuo22PFY=
Date:   Fri, 29 May 2020 14:05:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        howie.huang@mediatek.com
Subject: Re: [PATCH] ASoC: mediatek: mt6358: support DMIC one-wire mode
Message-ID: <20200529130539.GK4610@sirena.org.uk>
References: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
 <20200529110915.GH4610@sirena.org.uk>
 <CA+Px+wVSwJK-=75chKLjSEe3bPRtV2wD95W5D_pdR0Pw0G470A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
In-Reply-To: <CA+Px+wVSwJK-=75chKLjSEe3bPRtV2wD95W5D_pdR0Pw0G470A@mail.gmail.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 07:22:43PM +0800, Tzung-Bi Shih wrote:
> On Fri, May 29, 2020 at 7:09 PM Mark Brown <broonie@kernel.org> wrote:

> > What is DMIC one wire mode?  This doesn't sound like something I'd
> > expect to vary at runtime.

> It means: 1 PDM data wire carries 2 channel data (rising edge for left
> and falling edge for right).

I thought that was normal for DMICs - is this selecting between left and
right or something?

> The setting shouldn't and won't change at runtime.  Would you suggest
> putting it into DTS binding?

Yes.

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RCKMACgkQJNaLcl1U
h9Dt/gf/avkSzsxeit+z9NWHGp2tenf6Da8cB10e6pe1usBAJnkn+iqx1Si29kpO
V/fPJbNJY31D3PVd9dnyKQs4ASO+IbdUS2URSUDI795vnUy+fZ+5gu7CWoTc9LVy
PvRBFNaVmKrSxHTR3dgeFs3Ehf1cTKnxhL3wXnqg0WrN5tXSzChYnsjz7vHs2aqo
Rt6eiUaP3GKEyOLUeI/ND7iucB6eWqh/1RcDuGobJNZkhaVnh4Vk2RbbbJoREPki
ni2aN+zVokiZj+JywoG5DP7488T3JdEjWJ84dHAAtb9QhQoZwwO75nHWXhPvRr0q
ATS32LCIvu4eZCYa7kNcUqItzPKNDA==
=TM61
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
