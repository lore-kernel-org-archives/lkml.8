Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1E0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3019A2065C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597080846;
	bh=abSk/sEsF0Aozi0ycnXmohubobsaNZ5w/hjPUAgaoIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dFVf+itjtey4PZ3GQe91OLswcY4HNjsDGDIywfTCXsLL+0vSzNQ8FurGe73XlqSMp
	 xQ35uhqyK5tpjjT66fHg1yy3kq28+rP9Fp0G+uNwsNIOEGFFRDcWUoDgVF1YUnRMM+
	 mPcP9/gwxc/6/sWWDx5zRecXwris9Q3R8VosL9qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHJReF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbgHJReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:34:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B982083B;
        Mon, 10 Aug 2020 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597080844;
        bh=abSk/sEsF0Aozi0ycnXmohubobsaNZ5w/hjPUAgaoIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuyKEV1U0sWDNb2UllnohYSSRSq32IFhKOrBUuNRjqPVndfLThmZ27jB1Af9QbQwT
         Z8O/4EPwKvvpXXqd/EifwVHHXkflnfQW5jbmxK3JVMz1gPFyI2D/qhfhKEGOsFc5By
         QLdjcoj6BATz4wkZcugyLGucxk2m35fGdB7y5JmY=
Date:   Mon, 10 Aug 2020 18:33:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: fix pointer table overallocation
Message-ID: <20200810173337.GG6438@sirena.org.uk>
References: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
 <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
 <20200810123747.GC6438@sirena.org.uk>
 <20200810162556.GA3394@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20200810162556.GA3394@qmqm.qmqm.pl>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:25:56PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Aug 10, 2020 at 01:37:47PM +0100, Mark Brown wrote:

> > Yeah, this is more a performance improvement than a fix.

> Should I resend without Cc: stable?

I've already queued it to be applied to -next with that removed and an
edited subject line.

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xhPAACgkQJNaLcl1U
h9DbTgf+NHO5s+0mvnSr7RwDrHT7giAUq0OKIezWR/JT318aBGPZ/tuWhCg+FKUl
vPRUkxNZkbqlMX9Mny5TOLeFqfwVOh3czW/ZRNRUvlS94xkkZnDNQOKodhpCoohu
VbORy4CI5E/yma8ggQpAq70ysW4OYQ33bQz+dS3KSP1oiDLjzIzgq4HHWSB7Q/C+
7lzs6QSQMO4yQ5d6IAU+R4C/h3RnGbZgSCmzaKon3H55/RNK/RfD8BgqXHCJI1iv
AQ+UHAsS2VLjqXm7ADCNkNttpX7q9WqrL5O8rLP9ZuD/R3aczbowK1Q2JHXqkoM2
qIgV8Txau6BMZmUINhoCklYEpieDTg==
=fBK+
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
