Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD936C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9939420767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592845170;
	bh=iHVIGWwZ7iCmJ0kpqwmqira3sl8mshmr1Tv09brXRRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SvLmP59lJ8z3ysAj4aopUiYi1NqGsw2Iek/VTXd/ryBudpipHx5SuNmjgBqH58NRu
	 L0IS2wuDDlcfqeauZokgAMQD0ZMye5caWizvXG9Mcu9q47RM2J0DhRc9mkNwXp7vds
	 Ga+mGVSKYLEoqqxB0ZhpDySV4b3Goeal4hOh3vr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgFVQ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgFVQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:59:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2058720767;
        Mon, 22 Jun 2020 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592845168;
        bh=iHVIGWwZ7iCmJ0kpqwmqira3sl8mshmr1Tv09brXRRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvuU7bpPPM1WeIUKGL3DNrXKcSvDMj3FgWWxcSP2i46wr9gyQhX/e/gqnWJesG8WX
         zSp3mwAJlpIBxYUk2w/9pgzrKFfAgHuYRohTuS3h7XlGlrc0HL82IxIwJ9plwzSXd0
         pqsTz3oOemw2cp8if/IjP3i8XA7GHybNSnNfoTU0=
Date:   Mon, 22 Jun 2020 17:59:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] regmap fixes for v5.8-rc2
Message-ID: <20200622165926.GN4560@sirena.org.uk>
References: <20200622114015.60DD1206BE@mail.kernel.org>
 <20200622120905.GE4560@sirena.org.uk>
 <CAHk-=wg1YafzVFcCAe52cG+gHuaJBGORGb3mZ+-9QqZ2LOmzag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1YafzVFcCAe52cG+gHuaJBGORGb3mZ+-9QqZ2LOmzag@mail.gmail.com>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2020 at 09:46:24AM -0700, Linus Torvalds wrote:

> That said, automating the mailing is *not* incompatible with having a
> real name in the "From" line. Can you please make your scripting at
> least say "Mark Brown <broonie@kernel.org>" rather than just
> "broonie@kernel.org".

Sure, will do - my MTA fills it in on one machine and not the other it
seems and I tested on the wrong one.

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7w420ACgkQJNaLcl1U
h9D1TQf7B9y80G/x+UG0+uXWlOEA/9MoQY2/K6Rfby74+QCwXvbVM+L16b0HaY5f
EVJYTfKZht6KxJHVJsStvLpz7nLBcsjBDfKa1cihoD8Z8Z0eJ3Ss8s8V/v7WBTcS
gRUC/i31J4hDQwEtX7rKlfyYGrrrQ88jGPIf4/YEtMT9duNumAtZ51EUUWU4hn/6
Cfgevbn44GlYFxO0oKgd87KLYuLvsbHF4HjsfigaiJcaynZn6ptQZzfwzU8j3tB+
jkgBUMYwUEwS7uKhKu+CtUkP7o+YigoV4+f76KrVUvV0zLcKtcT04a3xY0zV9nyy
1ZJkjl/gTeVxWfBH6cNopbtJF1b3+Q==
=59KW
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
