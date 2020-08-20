Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D893208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597943570;
	bh=TWFYgtbiHr4WZeikmQlbfNtYZdL7B4da1I3CvP17wlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FPzLkfdO+OWlhoUEiTX3E8snmiyXE8VSwnnfRp3g8EmOnZCbIlpaadXRd5R32f+OK
	 19mFW5dOv+dsoDQ5JOQ2u8sV7TozfIOJ7N6anl5sjBheBMgB37wsxKNR5b9ckt2Jjo
	 L9Fk8011P7V7EudYt9xT91Lew25RwP9wcAqq8dR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgHTRMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgHTRLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:11:42 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEC8208B3;
        Thu, 20 Aug 2020 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597943497;
        bh=TWFYgtbiHr4WZeikmQlbfNtYZdL7B4da1I3CvP17wlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSoVV8pEwqiufJ71uZvSRh+RYp13PgnO8rOsQlYr4kSfdMd2m7nT8+YgsQhQn0jWJ
         HRbjGjNClKVb4oah16Zjzql2kBR7Us5ZZspl/STRzdQpRxybTFkJU1eZWC6EZgIs8w
         DFRVJy0bIOm1jyMm3+vy8tgKNDZK78wtgaRejDK4=
Date:   Thu, 20 Aug 2020 18:11:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: add of_match_full_name boolean flag
Message-ID: <20200820171104.GF5854@sirena.org.uk>
References: <20200819140448.51373-1-cristian.marussi@arm.com>
 <20200819182245.GE5441@sirena.org.uk>
 <20200820163844.GA7292@e119603-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <20200820163844.GA7292@e119603-lin.cambridge.arm.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 05:38:44PM +0100, Cristian Marussi wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> On Wed, Aug 19, 2020 at 07:22:45PM +0100, Mark Brown wrote:
> > On Wed, Aug 19, 2020 at 03:04:48PM +0100, Cristian Marussi wrote:

> > > In this case the above matching mechanism based on the simple (common) name
> > > will fail and the only viable alternative would be to properly define the
> > > deprecrated 'regulator-compatible' property equal to the full name
> > > <common-name>@<unit>.

> > This seems like a massive jump.  You appear to be saying that the reg
> > property is unusable which doesn't seem right to me?

> The 'issue' I observed while working on another series was that with the
> following example DT:

...

> the regulator framework standard initialization routines were able to match univocally the
> first two regulators above (and parse autonomously the constraints without me explicitly
> calling of_get_regulator_init_data() as in a previous version of the series), but got fooled

My point is that your jump to "this is the only possible approach" seems
to suggest we can't involve the reg property in the matching which like
I say doesn't seem right.

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+rqcACgkQJNaLcl1U
h9BGTgf/Y93MlfoBYU7ahS/kgsW6nK+0AAQK4bC4f8UtGJz9OH8+VjZzWrZfYN6j
iF5SBuVWSv6UQcW8gX9D54ncB0V/O5NEngMuC1yYV+m3cVCv9O/M8A20Kc827tk1
E1lh1IhRMO+IN3/bfZ4fBV0gCvxKgiN6oyIbPm89sj/XShLUNjqtv7QJvm63rBTa
QjOTJDYDVVaF4id8GdpHXFCZMzNoY6nDgemzQ9XFG8GuQj40hfbpQiWPj0tZP41a
YYkwYhWLL7lws6o0nnNL9qfmp8/7dk8sVjzRT4fyS0zR8ewMmDAw283dQeD9r1jb
0h7VBzR1vnzP2yVF9vz0hKc77G3lXg==
=UkqN
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
