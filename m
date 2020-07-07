Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85011C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57872206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594114612;
	bh=BMltbbwQtCu5hpMlykt8gJ7hZRG+849B8kBALrx2NlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Em85BhKoI4y9vL2jDr4oYrgbQKCnhnJURDEGbKV+PqWxmGWZFixSHCMc/xL9rp6h0
	 gQH+FfiPg9jcGwuZP6fbGrG6KHk8Itn6KQGczlxpa9/jhrEteZdJwSKGsaMh91sO4Q
	 bs82eD8pVwUtGRpiirB0iRKuU62TE9zQ+uzqfzcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGGJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:36:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B822065F;
        Tue,  7 Jul 2020 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594114610;
        bh=BMltbbwQtCu5hpMlykt8gJ7hZRG+849B8kBALrx2NlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ6PLdcgMFrNLsfyX7lSwTPi+XIgiKoNmzgWX08QvO+z8F01ZTHfRnlVKyVSxC5f8
         9ToiffMUS1HvOVn+mkAuJrIlRCebg19FM/od9Ug3CG+gpVNep6fT+YE4LfTGA3mGfN
         w0FN8m7sz0evJgGp/KaI5WTIufluInGG9NWHxgA8=
Date:   Tue, 7 Jul 2020 10:36:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200707093645.GA4870@sirena.org.uk>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200706191555.GD6176@sirena.org.uk>
 <CAPcyv4iiVvJHPTmgssTvp=jsFCs2r068mPtZ9s0qXfEKFNdVBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <CAPcyv4iiVvJHPTmgssTvp=jsFCs2r068mPtZ9s0qXfEKFNdVBw@mail.gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2020 at 09:08:57PM -0700, Dan Williams wrote:
> On Mon, Jul 6, 2020 at 12:16 PM Mark Brown <broonie@kernel.org> wrote:

> > This, especially the bit about "revelation of 2020", sounds a little
> > off to me - I think it's that it's worryingly close to the frequently
> > derided pattern where people recognise a problem that other people have
> > been talking about for a while and treat it as something new.  Perhaps a
> > more neutrally worded reference to current events and/or our desire to
> > improve instead?

> I'd just as soon let this commentary live in the archives if people
> need some more background. It's not like we have companion essays on
> the other recommendations in coding-style, and we seem to be
> converging on just amending coding-style.

That's even better from my point of view.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EQioACgkQJNaLcl1U
h9DXsAf+Ixl3NaYK0JFA8SARde57YtdMm0jI29+4yhgy2x5Mz7JNSIcLoBqODnUv
GxDzz4Xy5u5YSDT0Okvxp50pMurC0ALBt+d6TAw7oCwpTw/46JkCGJBCaFd0w6aB
LtWa9zqMK6ZTNUZLl65hnksBJmrR9OrIzbqkFuO42S+1nzgscno/mOK8qzTdqMJl
7vPkg/1yy7F59jCvBawdXJgxEcd6GAQlB/SRq0pDOgh4pMoOUz0dQtS517id72Dp
996WK3ZSWZ4wrQR+UXkiHTQdXWETPF/ZTB8JjGA87QabYxB9FUaox/SUpqKAlvl2
pa6mhDPrq7D9I7A8wpN+B4DOD9s6jg==
=PT9R
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
