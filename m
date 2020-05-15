Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21373C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBC320767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589545793;
	bh=TSw0eQ4WFON1EfGnsaXykmfInnksvvWfn5CeBUYDKZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AA3lmJyYZwn81QIqlrdprKW6TIzthHWarmSVGbBwkMoIWouvY2udW14tYmx5/4XLk
	 1XC9pYcu82XcfEI6nwGsbLWx5oqzvMx/Qflfyn7sCYLPfoKrnTS/Nb6M0HzpWYEgkp
	 GIwy7/qpnk8C96yIhlxAD5HgDYJFA6IBU4A6A0LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgEOM3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:29:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F1C20709;
        Fri, 15 May 2020 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589545791;
        bh=TSw0eQ4WFON1EfGnsaXykmfInnksvvWfn5CeBUYDKZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0zrjkXD5prKmI21EFxcPboIH8No7ixNf15Rsmdnc2qtfHdsB/Hp0ApaqPdfJYJi81
         6dNOLkRVMEi53mRtc+X0lelK5wpjUInjMNu6VJS3Sypur771BaG9XXE6emWPQfPcM3
         Dvh1O3AFYAGqoE+WXqTPU6yT1aYhcQjX8HFTzhVc=
Date:   Fri, 15 May 2020 13:29:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Steve Lee <steves.lee.maxim@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        dmurphy@ti.com, jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com
Subject: Re: [V5 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200515122948.GD5066@sirena.org.uk>
References: <20200515070742.14151-1-steves.lee@maximintegrated.com>
 <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 10:42:24AM +0200, Krzysztof Kozlowski wrote:

> Your "From" address still does not match the Signed-off-by. Set the
> author of commit to the signed-off person.

git commit --amend --author='foo <foo@example.com>'

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+izwACgkQJNaLcl1U
h9CR8gf+O5UGnkbhnV4MHHRYgchqTnJBXc/DysgCP0lEx+qj2ycTVhqvpCK0662l
RTBrIQ7JkSbGhHji7PzXkwjd/R8mr9eFuyxA7SkHzzR3q+cdChWg8kkKthwpp0FT
3LZItFkIDVziTwPVtZH0WYQLbAeesYTeGHg46c6WiZScn0IOUclODGkOs6lhXVBT
HctDZoXRtP8muMUOwEmaprVOdJXM6rlJNUS1uYJVBSSuN7gvyKhkmDkX0En/l0IC
u5UJacONloOu5ZYcutPJM/oqanR7dLkRX34VKru20jaXUYXvrO+P1lwtcfFeT10D
rvWdiGqqPMdak6i5Ej4HnPpXNvup1w==
=UNQm
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
