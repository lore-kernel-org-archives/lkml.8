Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591979666;
	bh=L/66D9w5PWgrjPupjgMN8jneXeXB+Jo5RE3BP+FQTTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wtl53KTn39tuYn635y6j9aeD7KDdF8Rn3jdOF2I3xsh0pzhpK0JDwJQ/BzC+eQImW
	 IpnH20VMsUPDELZzhVvHnv6ZPMrdHvaQGMO8Db4B1RxtZwnwkUpihI3SZ/lFXofunJ
	 UHSEikMbqHAEAQE3jyxdZT79Ea7baBbngpDBq1lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLQeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:34:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5755207ED;
        Fri, 12 Jun 2020 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591979664;
        bh=L/66D9w5PWgrjPupjgMN8jneXeXB+Jo5RE3BP+FQTTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2WB72oxsVSbKDCYu9szi+iBvsuMz8j9lFjkRzEYleNJjnccD5AFohXTqE0cMMpqPq
         aDFFGi5io14zkc6qyt9VAhp8AwJCi3qrQ2iSUFZvlvDNsyR19anip0937+UR/+14Xv
         LT+ugjdMZIUPmTCjKKGUFfgz8Bkcf3GMLxpU6eyA=
Date:   Fri, 12 Jun 2020 17:34:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     yuhsuan@chromium.org, albertchen@realtek.com,
        derek.fang@realtek.com, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5682: Register clocks even when mclk is NULL
Message-ID: <20200612163421.GO5396@sirena.org.uk>
References: <20200612163111.11730-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <20200612163111.11730-1-akshu.agrawal@amd.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 10:01:11PM +0530, Akshu Agrawal wrote:
> Fixes kernel crash on platforms which do not have mclk exposed
> in CCF framework. For these platforms have mclk as NULL and
> continue to register clocks.

Derek already submitted this:

    https://lore.kernel.org/alsa-devel/1591938925-1070-5-git-send-email-derek.fang@realtek.com/T/#u

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jrowACgkQJNaLcl1U
h9DhtQf/W6wAWiy0Be5YPFAbq8u/x9HyjuNGc0oFVWM19OqtJzFCw4L+1oUe6oD+
uensM/lznoIPZTPdaey8niws1eRHFedflX4yhd2nHptRAswaFstK01FqZmQTXtca
ktWQeC+OIJvAwL3JUU7W8SI5hMWdeHfikrOI35wrmefjp7jW69orxHiBbKX5PdlQ
bIeudAohj8PyAx/IonmaieZNW+Vw4UvZ7UUk7Yuztk8rmIomzxW/pSSjIgSVbJmt
gVeNgRx/G2ivUsXbmSG0aC3CwMwV9Al+PSASLmhO5Rk8L2mIb6lglHd5UlrXV4mV
bRpOPPlyhG3LifoCx9EZmjnijdFEcw==
=jECX
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
