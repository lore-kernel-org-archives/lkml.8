Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2801C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591973232;
	bh=e2wrmF2r0OcaNhlokIiC2fi/L8XvsTF2HTqhhKNFUqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJtN6gTthAJZHvUuKhz/yzWI993OjjBzzRBqINVpQ+MI7qPyPeT1OqWzIjN1L+tss
	 w4RqDB1ZM6Eje7gKtUgcZkM0sVIyP5aDLZqgIOJ0UNI9XH4S0wug9RYZXin6UTKfS4
	 SQ+M8LxTN2+zeyv+39Stnfc3QXJqqJrEE5W4oeAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgFLOqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:46:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33EF20835;
        Fri, 12 Jun 2020 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591973209;
        bh=e2wrmF2r0OcaNhlokIiC2fi/L8XvsTF2HTqhhKNFUqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3U3jWfswzk6g0JGzBz1qQHIXmOl6/sYnzhA34swZY6Hh5DOUlVgABdri4fTni+iL
         HRuL06R0JHrtIKJKJdyCKk82Swo2LsnhsFCbNyjLeHiAarMuiMzPajQ5/hV6Jkhdqb
         LAu8KwyH1ngCFHOMGzkd9OVV8m3CPqUOjepFzgUM=
Date:   Fri, 12 Jun 2020 15:46:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
Message-ID: <20200612144646.GJ5396@sirena.org.uk>
References: <s5himfxet1c.wl-tiwai@suse.de>
 <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
 <20200612121946.GE5396@sirena.org.uk>
 <7cd79261-6f8d-cad0-c65b-57570a40a6b6@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <7cd79261-6f8d-cad0-c65b-57570a40a6b6@linux.intel.com>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 08:54:11AM -0500, Pierre-Louis Bossart wrote:

> I think that those configuration errors are the problem and should be fixed
> as a prerequisite to the removal of the duplication between
> dpcm_playback/dpcm_capture/playback_only/capture_only. it may be painful and
> generate noise for a while, but if we only throw a warning what are the odds
> all those configuration errors will eventually be fixed?

Yeah, I'm kind of pessimistic about the likelyhood of people paying
attention to warnings.

> If we need more time for validation on all platforms, then maybe we can
> first relax the check for 5.8-rc1 as suggested by John, but re-add the
> -EINVAL on -next to give a target of 5.9 with all configurations fixed?

I can't help feeling that it'd be postponing the inevitable, but perhaps
I'm being overly pessimistic here.  The change did obviously go in quite
late though so it's not the worst idea if you want to send the patch?

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jlVUACgkQJNaLcl1U
h9Drbgf/YOzUpG9GiasbxXlFoCtJxiuv+Ekh55z/P1+oz7I2MZrDRSv5mAm58FnI
BWvduP4pRvf40KI11PT+FAQc3ep02VngltU+ZAxvwPuGtUq3+rZcfU/RwIfrZkf/
BX9z9b8mxWYloF5qMvyswDHSxzZB8Ie777CEIGfpAkYmvGI+mWblSa4JbXVT2jU3
Iou25XVjSyU9f+sgjCMMFlfgmleWRwC+aDqQWhI6FNMPycsiEO0YcKBlh32iF6ku
p+wZIh/eOkDd9gGqN9tUgjl/jIu2cx/LgbYihlDcrpH0DvviY2cwTGFi61ODChTA
/Casiwx2AouvAnawiIxzar0WxH57bw==
=mrUj
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
