Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22138C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25B322CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597089111;
	bh=Oxvqo0C4dim/TUDFmwjOe0OlvSDaU8EwjsPWYqAIGMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aRWRNhl9JstQWy8Q5sVQeEYRf5HFCvSK7Jz7axZJ53B3b+sn4oFHNpdFGANQN+upp
	 rtj2aAICnEFXFKwt8JDUo5Y0GsgjBF4Kifwh4B7T6YY+kxryoJ1AWaDvXQKM7Dx185
	 pxouy7YV8rsF4v1LAZvNyp7ikfP8mlQ/dvN+0CcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHJTvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgHJTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:51:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4604122BF3;
        Mon, 10 Aug 2020 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597089109;
        bh=Oxvqo0C4dim/TUDFmwjOe0OlvSDaU8EwjsPWYqAIGMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4ZsGq0CeXGvLPRmD3sm8FYUbNW5Z6q1/31zmtdBPWwgsnvbEz3Urr0LT2MbNY+g9
         xAy/Rne6kwSGWz3O52JiLjmjaHd4C23vnZVG1fVIECEb9vF6C6RaM98Dx/tuwEePjd
         2LBwKBCSwx66B5E0R+/mYoyS+P7JDF4kJsCHH4Wk=
Date:   Mon, 10 Aug 2020 20:51:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810195123.GJ6438@sirena.org.uk>
References: <20200809222537.GA5522@qmqm.qmqm.pl>
 <20200810153928.GD6438@sirena.org.uk>
 <20200810160936.GA1100@qmqm.qmqm.pl>
 <20200810173136.GF6438@sirena.org.uk>
 <20200810192547.GB26750@qmqm.qmqm.pl>
 <08f030a2-3a6f-3ab4-1855-3016884db79d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <08f030a2-3a6f-3ab4-1855-3016884db79d@gmail.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 10:41:54PM +0300, Dmitry Osipenko wrote:
> 10.08.2020 22:25, Micha=C5=82 Miros=C5=82aw =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:

> >> The initialization cases that are the trigger are only done for coupled
> >> regulators though AFAICT, otherwise we're not doing allocations with t=
he
> >> lock held and should be able to progress.

> > I caught a few lockdep complaints that suggest otherwise, but I'm still
> > looking into that.

> The problem looks obvious to me. The regulator_init_coupling() is
> protected with the list_mutex, the regulator_lock_dependent() also
> protected with the list_mutex. Hence if offending reclaim happens from
> init_coupling(), then there is a lockup.

We may also have problems if I/O triggers allocations for some reason,
though that's also going to be a limited set of cases.  Might be what
lockdep was showing though.

> It should be enough just to keep the regulator_find_coupler() under
> lock, or even completely remove the locking around init_coupling(). I
> think it should be better to keep the find_coupler() protected.

> Micha=C5=82, does this fix yours problem?

That was the sort of thing I was thinking about here - it should at
least be an improvement if nothing else.

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xpTsACgkQJNaLcl1U
h9Cg7wf+PFkzrTKbtll3cKOaWOTkFxw6f2I6TBK6QL7OOiDhn6QbcLgbXsV7RTA6
zxjnrw8Na5eSlet9SaNadsNCvOUI2twObgm/RR+pNi9i9fj2nVHiKGHyiM2Rz9mz
Ev7tJMxcsCum5lPUcvunq0Ab/zlsYunjySul69YqCRce3ra9fZgKaQvxGhIoezt9
JoESuOC/Eq2IxaWBmRUCgzVouZLYSoqkw8c3CIhdK2JXZNAhgb7Di1zh/uXjjtjo
LAMzrbeCUAuH9+FlqndmuPVMFh/fGcoHMaSYZQoWq23WQ19ieNOccM8UjhPbPDUr
mRTFJb8RqvTIHRENzBAicZGOmOZozA==
=2izx
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
