Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3102C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C23B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594398148;
	bh=1XNuBmtatVFdJajAkzZdySbHShh+fThdHL/X4gq5HqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLyami1gPPrveTrRPpmHxON2MXdCXGDPfBnpwckIFdohNNN3AjO7XNe/PVJYveiZq
	 R6AHY0r//o8jBUeAFB9B8twFVA97vsh+Wj/wQFRDYFwWfCYVqwLa+eDmvVWQ8SscsQ
	 b5QgDzyOGkDBrwCcv+yIImXd20+uYeGTbSdj51TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGJQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgGJQW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:22:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE3E20657;
        Fri, 10 Jul 2020 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594398146;
        bh=1XNuBmtatVFdJajAkzZdySbHShh+fThdHL/X4gq5HqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfqS1HFcaTtm55A5zoUsX3H/kWNgDJJ0VWcZKae0GswlscA45cMofXoEV+7X7tsjv
         y4QR9vT5bVUAVIna8MSoiE7QU5LemLiU45CJkYMLm53y/I/ydHjFciu7n2qKVtT6kw
         UevlGvnvtBwR7MI7mM7J/UmLuqtZN7cdxCY0NKR8=
Date:   Fri, 10 Jul 2020 17:22:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710162220.GG5653@sirena.org.uk>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk>
 <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk>
 <20200710133233.GF5653@sirena.org.uk>
 <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
X-Cookie: Use only in a well-ventilated area.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 05:13:06PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 10, 2020 at 4:36 PM Mark Brown <broonie@kernel.org> wrote:

> > Oh, I see your patch covered a different bit of code without covering
> > the stuff in regmap-irq (which I'd just handled when your patch came in)
> > for some reason so the changelog made it sound like the same code, and
> > at the time you submitted it the patch was incomplete.

> Should I do anything to improve it?

Ideally the changelog should have been more clear that it was a partial
conversion (and which bits of the code it was covering), that'd have
made it more obvious that it was covering more/different stuff to the
other patch.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IlbsACgkQJNaLcl1U
h9CQFQf9EqazUYL1zhrN8XX736svJCWmzPNJtjb6lr7wwRqs7zINMrRuL8NdJa3x
it1Z1YSPWR6GsQBm+L4AV2n0YJEtq2phb4sGlFtXJcWK07uBPDQmwL6REqzhOJw+
753L67sHZO2Ypf+pR6TDe5eZckhHmsGh8a60sE2yuEcNp580jk4OwouPCRv4AAVh
GmGfZF5aokOWWWhJ46w4iOpdnVn6D4V4vJtDVv+y0Va5OQdTHRUhc9k+abAuvJjM
VGtFkrYwBm7vZYBwlP8YBtFQMjLMWlH927UJ24ye74q4lzGnIrx8tkeQi1beZ4PD
s19DG2sypPMHRcAZR7p0UCa+sLQTZQ==
=3D/W
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
