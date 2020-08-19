Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26654C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007BE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597835805;
	bh=7W9fpcvvq7j01lnjxB+ot2Sjfmr0kSAadp/9/zh9zI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iJlF6se7Qpbpd7x4U9sR4YooGNWGm+XIYrjf3YKuYPXdbYuX1GqBY2cPOSRZ+uEAm
	 M5gZR25epg5Q9lMlNf1hTofk7ucL5Hd3gjmqMQmytExrhpH/pWDI+IpHXz7TqNcwCF
	 f9A6lVJA325R3bA0f+nyUMHQ9vazQQkxz2JsodGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHSLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgHSLQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:16:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5684C206DA;
        Wed, 19 Aug 2020 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597835796;
        bh=7W9fpcvvq7j01lnjxB+ot2Sjfmr0kSAadp/9/zh9zI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYFycYPrBmWJam7NZKlptYCrkATXPMfUZP8OeD/6IsUDDnwM3EZ+M8LtZo3dxa5MM
         o/70hVNLqh/t6/PFzXCYwmcyA3H0CDzXRx746GYHbFq1+Abwss1s56TFmWKJCwjlzU
         AkugyyZ82ocFQMeBShPmU03BW3dtBoaed886yk5U=
Date:   Wed, 19 Aug 2020 12:16:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Allen Pais <allen.cryptic@gmail.com>,
        perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, Kees Cook <keescook@chromium.org>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
Message-ID: <20200819111605.GC5441@sirena.org.uk>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de>
 <20200818104432.GB5337@sirena.org.uk>
 <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 04:21:58PM +0530, Allen wrote:

> > These patches which I wasn't CCed on and which need their subject lines
> > fixing :( .  With the subject lines fixed I guess so so

> Extremely sorry. I thought I had it covered. How would you like it
> worded?

ASoC:

In general you should try to follow the style for the code you're
modifying, this applies to things like commit logs as well as the code
itself.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89CfQACgkQJNaLcl1U
h9Cifwf+ImKkN4bcgAsq1FQIuFfGzOK1C2rJvwO1FF9QMBqoSLWbU+XXMm8B+dmp
BUuRn3yv2s26q5SMpU1EvotzyTnEdeAhS8rvA+hpUMw7E+lz9v2qz/2m553Hap6U
R1REKNzVtqstijAyYycjHID0ZsOPK+T5wBISb2fY38cJlgGRMQXh0ZgvHq54sfVK
aLts4u4J72HMFLuxPbgTfiO8CX46MjLoH0eoRzPu7R44dvzqUfzdu5B/7Fp5amcC
Sd6731MDQYarYhge1gBJ84arpbSB6Qsr1LQNh8hh2q0cXEpwNcXjnDMsYKjcoxPl
D2VS/Gxp0eqmBwQXcSE5+AGsdYKdOQ==
=XARi
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
