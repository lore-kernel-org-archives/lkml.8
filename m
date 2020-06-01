Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8115B2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591008592;
	bh=/4UH/y1h8L0fXxRduGokjIWQiSlIStmygs+RLToQ9nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dY0mS1vXcvKGp5UZi3rhxZyeTYBbrUKb0N7jKHaLsotBlEq71p3Uu0e1sLVkoh50c
	 AJusqb4hUrFnAZYLUTZK7Z9kgohpFCuC+b6mrFv4w/ZSqHpt76wD84kWYK04HGaV9H
	 N1Ysr/f8+9fOznrdWasdmcVaSFuXqGLDquu2vfBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFAKtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAKtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:49:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E566620772;
        Mon,  1 Jun 2020 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591008586;
        bh=/4UH/y1h8L0fXxRduGokjIWQiSlIStmygs+RLToQ9nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dv0KRd8sOXNK00jnPGPKUnPhwV0SkcpfCdRhVl6r61B6ZW8j5mgNxxasx/Ds7zqOc
         TT1g/yXaLhY4uUrtoJv8w4NX0TxzW/1czv6ByKLVIiMV1+vyFQMJu/S/WFxYV4AuRT
         rsmUoIMPYd+QNja8j+k0Z7NeXpgI1J6+HERvpg/8=
Date:   Mon, 1 Jun 2020 11:49:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC][PATCH] ASoC: qcom: q6asm-dai: kCFI fix
Message-ID: <20200601104944.GA5234@sirena.org.uk>
References: <20200529213823.98812-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20200529213823.98812-1-john.stultz@linaro.org>
X-Cookie: hangover, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 09:38:23PM +0000, John Stultz wrote:

> [   82.585661] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000001
> [   82.595387] Mem abort info:
> [   82.599463]   ESR = 0x96000005
> [   82.602658]   EC = 0x25: DABT (current EL), IL = 32 bits

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7U3UcACgkQJNaLcl1U
h9BhEAf+Pt/dDyPB3Af0xeDBSv6zsEDpdm3K9d1LJUNB2NUjzgwHgD7cFASZD8wt
L/+xGLg8auxCC5t+QhOECKSk/ovv4FiLcWSv0MSBlCX2X7HCgIWP+UjBFKG9a9Do
m6onms+z024kXU1yfZDA3h7zeIT2w4rZ5j5c7SfVbpuaI5KT+xbw5EiDQCht6OlB
LM12/hlKCjEjQ2U4r62JRYgYwMnPKwmp4OcWH99anZPopnjsDO2i5E0ENxtDx4JU
O2s/WRp5PQXDaG9wRXhn9HBGDfckQsUUjMlxJRHa5RLIqvwGWja79ihQx5S5brFb
XX81ZEOmGuzWoi8UZ6ivB6NHSJq52Q==
=WMyj
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
