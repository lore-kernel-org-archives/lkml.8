Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9784BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F2A20885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597081876;
	bh=bmuT/NyvwuxtgUoepP2ZZmv7duMQFDd8Zc7Gtm91PYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zy4ffufLHMpivsLzmH8bzvZ3l3fA6fjnZcNrGy+vH52/0qLadUzwg02OBKqzE8eT5
	 aBSSLYEjCT98bukNaxfTr84wtoxKl3fSBRXOKsHZh8/Nal0k8Y+qnLUkK40oIi4yl3
	 G5WOPWDoPHJWA/ervnUfK0PktuPx84d8prpQvPKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgHJRvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHJRvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:51:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7009B208E4;
        Mon, 10 Aug 2020 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597081873;
        bh=bmuT/NyvwuxtgUoepP2ZZmv7duMQFDd8Zc7Gtm91PYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnZThLcV9ybMKidHfYAS6buzhSJPXLkcnTShq76fGB29Z0BXF6GI7aozrgb+jA/gW
         bLOYwYOtjEnoIfdo4c1q4ju3sPxNP9HcgfRCi/9UIja4I8M/TeLMeLwrPSCoMnTgE4
         tmeapfWJF+Y71M5xUQJ4439oBXM87PkuvJeyH6xM=
Date:   Mon, 10 Aug 2020 18:50:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.9
Message-ID: <20200810175047.GH6438@sirena.org.uk>
References: <s5hbljocbxl.wl-tiwai@suse.de>
 <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
 <4f3ead7e-992e-edec-e7b4-31566fc5e583@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <4f3ead7e-992e-edec-e7b4-31566fc5e583@linaro.org>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2020 at 06:06:14PM +0100, Srinivas Kandagatla wrote:

> In q6routing case all the dapm widgets reuse reg field in
> snd_soc_dapm_widget to store offset information or routing table indexs or
> some DSP related id and so on... These are not real registers.

> I think the core is trying to read the state of these widgets during
> startup, Which will fail in qdsp6 case as we do not have any regmap or read
> callback associated with this ASoC component.

Yes, it will try to figure out the current state of things during
startup.

> Previously we never had chance to see these messages so we did not implement
> any dummy read callback.

So I guess this is another instance of the issues with other things,
just having an effect beyond the cosmetic this time :/

> Adding a dummy callback to q6routing and q6afe-dai ASoC component will fix
> this issue at-least in Qualcomm case!

Yes, that's going to be better for robustness regardless of changes in
the core - just pick a default state if the underlying thing is
undefined.

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xiPYACgkQJNaLcl1U
h9ASOQf+P0I9RkrZD5pherwHTBPuwPKgpOiJhjy2VRNfg9VffFQV3CJwL6swiVcz
z+YmANXIecLK6LXnnK7auweUQI957sLJ2a9xe8JTUWGvYKwJQNvfetcMhCMuEBoP
l+jFt4wDZW/yAHVTSALRSxD4UU9OwzUOV+Itw5g5/8bYJpuUhWnMiBe/PPOrdyhq
3NzljK6hs1b8HB0iFyPXgd7n+EXKuh+YBxQBZu4Wj9OTZbAUemFuL9wJhwHsf+Le
3dwQenyhyifeVn3NKSG1BA6a0GDXjjYlm7dFOSOmCa8GcZiXrVAsODhmBcRn+K3Y
Cj9d+0fqSNMMf/N7EKOkT9EZEZlCZw==
=Q++M
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
