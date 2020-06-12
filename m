Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485CC2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591965359;
	bh=dvfhF03OLy1cljerZ+W0XOM0w/Imr2u1Tdky5STILqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PO+aARGYBy8UnCi1goxKt5M8CAYlfQNPcXYxsrJPiolh45QpDUN4fUHc+sXvGSB12
	 IG+aHUYtTKSEGa0FLGjCauGfIDT/Kib2Cdb0FB9T71VivyPQtMs0oa1gGUEiWACCaH
	 u7GRstjucc163rr6+wbIRtH91bp1zS4sN9o4kXF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLMf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLMfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:35:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58192074B;
        Fri, 12 Jun 2020 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591965354;
        bh=dvfhF03OLy1cljerZ+W0XOM0w/Imr2u1Tdky5STILqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKeJQH1kcC96YrGTLhYXgewLXWelLvsG7j3SNGm/XZREhYaeNOFPUXw4BE5PMKZmZ
         rnZ51aHrKhe1QIDhCma/khU6XqQlj0w2cRIztwr1zJiVJwSKpQ9uU4vC6Y8TCn4l+Q
         vLrmJeGAcrV5vM0RpKDCIeMtCom94g7tok802qtg=
Date:   Fri, 12 Jun 2020 13:35:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
Message-ID: <20200612123551.GG5396@sirena.org.uk>
References: <s5himfxet1c.wl-tiwai@suse.de>
 <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
 <4d692acd-6fe8-7a5f-34d5-78a4d6dd03cf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <4d692acd-6fe8-7a5f-34d5-78a4d6dd03cf@linaro.org>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 12:41:59PM +0100, Srinivas Kandagatla wrote:

> Can you please try these two patches, I think the problem is that FE
> dailinks are always set to bidirectional, this two patches should fix it.

> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=bb7ce65a0ca1640cd9ff301c885f56ce00519834

> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=9b568e491f0410b453aaf5a147b75252a6943ffd

> Once you confirm I can send them to list as fixes.

These seem sensible to me, probably worth submitting them even if more
investigation is needed on the original issue.

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jdqYACgkQJNaLcl1U
h9BcHggAhw+IjXtENGgS/PkLO+DIlqb7o4HGG6VP1fwBdJnviYllEpRAAdFGQqwp
vkLQE89dayJM9tZlpfXHEBZccHwP+UQuG0w7SuoM/mrWNgqZhZ+rd25w72oOeJTy
ftwaXJT9AXz/PWMNOf3VmoX0t3lWcZ9sPvts/766O7eqAiVEoM0phfYDDdq42E0i
eBFdSpiDV/QX8FH9rRJSJgZguKwXNwfG/sdr+u59/2sV9M8XCmwt5+dRqU7sliQI
bev+u7+EVVMY29z/fbhcTXMREgwcffudgzZIGrAWUcNKgws3Ynfww9LklX6hiDNc
rkGo8WbaF1XKDHliJHkbH/nR/XKvbg==
=BRMX
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
