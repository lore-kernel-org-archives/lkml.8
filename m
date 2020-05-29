Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAA620776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590744907;
	bh=QAGM17q25jdznqfG57f6WsEbjdirWE3/v6uR6xZIyOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F04ac+gooSJNuK8wseJKNjNKwDcCgJZN47kdlAlTCJIrhbfH98+oQ6GmNWQtjkxDm
	 pYNPgKpy3TH1dsZE4lEskhqVc1Px4iNc1W0YamUP63xRIOyBjRoLWqHcQcNmoPtjqn
	 su4Im13GrUEln8BQ+C+rHp1ktkcHLWl4ULX2HoT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2JfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2JfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:35:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22972074D;
        Fri, 29 May 2020 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590744906;
        bh=QAGM17q25jdznqfG57f6WsEbjdirWE3/v6uR6xZIyOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sdqin9fvcAIdjhXJ3j9o7aHJiJjxpPqYGIrs0fE0920khxyeoJgzm0MUF/V/jgcCd
         Z2Y4WExdoK0Rcji0sf2rH9oK9aziOX/ZhaCeuPsqKrbmByP8UcOPdnl+lIBwOBiCfI
         5EOgPqt6MuO1Fu9HRau4Y0ooqlB96yRkxTKkfZkU=
Date:   Fri, 29 May 2020 10:35:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     Steve Lee <steves.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Subject: Re: [V6 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200529093502.GA4610@sirena.org.uk>
References: <20200528103942.17432-1-steves.lee@maximintegrated.com>
 <20200528115408.GA15800@sirena.org.uk>
 <CABff4NSc6oW9dt-2VbdKUnk=+8Tc52m8f2irr1P4_cGyXNq41A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <CABff4NSc6oW9dt-2VbdKUnk=+8Tc52m8f2irr1P4_cGyXNq41A@mail.gmail.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 05:04:36PM +0900, Steve Lee wrote:
> On Thu, May 28, 2020 at 8:54 PM Mark Brown <broonie@kernel.org> wrote:

> > > Reported-by: kbuild test robot <lkp@intel.com>

> > Don't think the lkp bot asked for this driver! :P

>   Thanks, I will send split patch for this.

No, just don't add the line when it's a new driver.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q10MACgkQJNaLcl1U
h9B/Mgf/Y4jlBsGTeWfaJs2t7T3Lu7AXT7PuHgmifzYCl2GJ9lJ93OBdV353D+dT
g1AmR8FetIEQICND9qh8CYsMVQK7QCIDORenKsqC36XWMbGNn7Bde11Mev3xE0+r
4ttOzAk1UNt5iW2iNzmkz40WN7tmhDkjqEW9+KZ8mQ4YzJ12XPcf4ZT1Zqlt3zi+
mVeH90cBIJQWKGq/zrs3TLc/IuuqaxOOjBKJkKVSEbsZgwZ3W7EM53HNlf9/tpjm
2eo0/q6puVpUWOkfI5N7CDSqnUwB6eYXCSaEO5WT0mXdXOk/6YSZpajZW7XXgnAm
udaLl5zvnCkHFpffFyIf2LDcyZFvIg==
=0HNV
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
