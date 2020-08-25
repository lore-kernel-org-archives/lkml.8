Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F7E207F7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598369853;
	bh=Ax1keoZOXJyKLpCuadTSZZAlgawNptGR18bz0sLj4W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JAI8YgRE2w3y41NnzW0YdZZrLTRAh9uZrQY9OVa0upVZU7/4vTy/vEeCGgOpumsxr
	 yjM5WigwbX5pl8Ri2vlMTWgF7sFY+PLxcHHerndb7E3ktjNvtwTC/IqYdfKIdlzynm
	 +5qZPEFjbSN1lXaiNLJAuSbi/SjQM3X7xpZY5ZMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHYPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgHYPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:37:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D327B207DF;
        Tue, 25 Aug 2020 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598369848;
        bh=Ax1keoZOXJyKLpCuadTSZZAlgawNptGR18bz0sLj4W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVAKxQ8Bq9JnGqLUhblEQ/Yd4eZ31GQZ5vWvwRhs9iGwLEO58toJk8luL6rNKxhS7
         TGOhpmFAXoEt8oPW70f7/eRjT3GWkpYHvtwfP9BVZRsJc4DpQLitmuaJ2iufQjlKWh
         hFIic9cuzZ5wYI7If9oLIrvhSmc+NjBYY7nHo/yY=
Date:   Tue, 25 Aug 2020 16:36:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/7] Allwinner A64 digital audio codec fixes
Message-ID: <20200825153652.GG5379@sirena.org.uk>
References: <20200726012557.38282-1-samuel@sholland.org>
 <159776961932.56094.2705667823777375165.b4-ty@kernel.org>
 <20200824140334.6gflonflqju6g5ea@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <20200824140334.6gflonflqju6g5ea@gilmour.lan>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2020 at 04:03:34PM +0200, Maxime Ripard wrote:

> > [5/7] ARM: dts: sun8i: a33: Update codec widget names
> >       (no commit info)
> > [6/7] arm64: dts: allwinner: a64: Update codec widget names
> >       (no commit info)
> > [7/7] arm64: dts: allwinner: a64: Update the audio codec compatible
> >       (no commit info)

> Ideally we should get the DT patches through arm-soc, can you drop the
> patches 5 to 7?

When it says "no commit info" that means the patch wasn't applied.

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9FMBMACgkQJNaLcl1U
h9CGrAf/YXOychvfLSo+ENlHR7yzKuh19qnN87y2Lr7ovM8T9KEI/c3beLUcDACp
J72jJsGTMJGt/fwCnwcTC/jy0rwD8eLuGuPI6KntFg/RjJ8QK41qoGw3GN55y2vg
N9Ifs2Hrwxg7sjiz587HR4+eY5xQ43elWgqmZhVAQ7fkKv+q8ZuCCvYDaA8Nh7vw
VxDutIQayldOP6Esdfc9BT2emqj7qN+WYJbjFW3Ex2uI+FunwnkdyhXanmfBd2S6
GIAuhhaGwET+OQZDVqjeF3K5M5Y5Na+2t2ZWAIB0jYuKi4U3ubb/KUP35mulEIRS
vJrbLkHUlnCT5Lg/yUpppEoEXh/hDw==
=Bh2t
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
