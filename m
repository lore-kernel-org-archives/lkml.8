Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DC32074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590776172;
	bh=GH7xgOfWGLC1xYWHZL51BlZXClwRjmPTGXTEkgGZCAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A533eYlXb8oKsqU0WKWdhSAethKHgZpDpkziVE80GJKcQoyqI58BSkXQbvNfYTLL5
	 af6IAZvgQ3GP28EzSNMpbXk4iiNFaSa7kLLJM9Bv1xh5okl5jX1S3X0TaBU+fcbWQw
	 rj87T+yCv16ICvPo8GHn0JNgDhLhMq+7mWA5sJWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2SQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2SQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:16:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96E3206A4;
        Fri, 29 May 2020 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590776170;
        bh=GH7xgOfWGLC1xYWHZL51BlZXClwRjmPTGXTEkgGZCAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rs/5+UaBczGURiLrYQDpbv1FEsswVSL+V7v/G+hW1TcMvv846K+Vqn5aLBaf0Zth3
         fKZGLUa+ZDpzeu3pWLeubWt+46pbK9QSLhmRNRxYJwAmddJfx/XAE+WX2bhO/qkD1V
         RDEIci3V4TGyCD05zXZeC4PH9tOmCjRw2P5giNv4=
Date:   Fri, 29 May 2020 19:16:06 +0100
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
Message-ID: <20200529181606.GU4610@sirena.org.uk>
References: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
 <20200529110915.GH4610@sirena.org.uk>
 <CA+Px+wVSwJK-=75chKLjSEe3bPRtV2wD95W5D_pdR0Pw0G470A@mail.gmail.com>
 <20200529130539.GK4610@sirena.org.uk>
 <CA+Px+wVhXoU=BdBmMW0sdPtUrnQH+Kn6dkFdW-n67qEDGceCEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oP9at/Ymg5VWhwKB"
Content-Disposition: inline
In-Reply-To: <CA+Px+wVhXoU=BdBmMW0sdPtUrnQH+Kn6dkFdW-n67qEDGceCEQ@mail.gmail.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oP9at/Ymg5VWhwKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 30, 2020 at 01:26:20AM +0800, Tzung-Bi Shih wrote:
> On Fri, May 29, 2020 at 9:05 PM Mark Brown <broonie@kernel.org> wrote:

> > I thought that was normal for DMICs - is this selecting between left and
> > right or something?

> Not sure what is the common name but use the same context here.

> MT6358 accepts up to 2 PDM wires for 2 DMICs.
> If one wire mode is on, MT6358 only accepts 1 PDM wire.
> If one wire mode is off, MT6358 merges L/R from 2 PDM wires into 1
> I2S-like to SoC.

Oh, interesting - so it's essentially a mixer?  Not seen that before but
makes sense.  In any case this definitely seems like a good fit for a DT
property.

--oP9at/Ymg5VWhwKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RUWYACgkQJNaLcl1U
h9DzCAf/eSG8ftQqt2zLUXgVK2VdTkdi/4wwtHrEUTnLh92NVK3qVJo7AlDSmwxK
nq/ophHJqVsYmeXUCott6BaJKspd6r+KnrnyJRupzBixtLTx573x7VdREPful5eW
6cVUHkoI0quLHqspblBrZFW0kvt6iwuol2dK0pIORn6rRiaaQlzB9kTmE1BI5Clt
GZrYuFcCzsW7IHYLPWD3Mbl9IsTFius8mjWym4jiglkPFu+8c8bgXRLJE7wGgoGz
x60eHOnNmXwuzOBkrao6njQPWLX+/jtRU5aw4mQ5csVzf662KRmsciNScxyWLHMV
v00PW1FlfI9AGrtQdlSKb1UMyO+Rpg==
=ODhy
-----END PGP SIGNATURE-----

--oP9at/Ymg5VWhwKB--
