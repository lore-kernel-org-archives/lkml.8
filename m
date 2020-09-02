Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE002083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599068331;
	bh=892k+dIylN07Z0BoztCYZcV5Ytx97ziH7oUUHRgPXqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z5s4UGLM1XPj+sQfl4GQYsAgG1V08qyPuiZfSJkc+BBxkz6XZtpFGjok+aCI2YY4H
	 sckt5fBvFgFN7A7/Ze20ufMal1NFxmnNVQSvZCtSStPM2MYqloLXNkqeDXol7mgwmO
	 UEZEWhmEXgRffogaNRm1lf0PhDJvbIs6v0Lx7FLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIBRiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBRip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:38:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86587207EA;
        Wed,  2 Sep 2020 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599068324;
        bh=892k+dIylN07Z0BoztCYZcV5Ytx97ziH7oUUHRgPXqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPzU8gtmGBeTUanqpXk7UJRNk6O69/FSTFV8yQVQKfTwJ3X1RGCVRYfU9wkciD2qF
         oYtTBnekZnRir41Ch1d5oIwLQ4e46jxgMlQXFwagw7ttAfw2RxYwtsttkENJr5geDp
         O/e7vzV/ldyN8zGyd0/SMs35pcCpruT4H9gowlpk=
Date:   Wed, 2 Sep 2020 18:38:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 0/3] arm64: Convert to ARCH_STACKWALK
Message-ID: <20200902173803.GE6162@sirena.org.uk>
References: <20200819124913.37261-1-broonie@kernel.org>
 <20200901160626.GE95447@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <20200901160626.GE95447@C02TD0UTHF1T.local>
X-Cookie: Prices higher in Alaska and Hawaii.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 05:06:26PM +0100, Mark Rutland wrote:

> Just to check, has the skipping logic been tested to work equivalently
> to what we had before? By inspection I think it should, but since it
> relies on function call boundaries it always strikes me as fragile.

> If you could confirm that (e.g. with LKDTM perhaps?)=A0that'd be great.
> Assuming that looks right, for the series:

I've tested this with LKDTM and otherwise and didn't spot any issues
(and just did a bit of retesting) but it is a pretty manual process so
it's possible I missed something.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9P2HoACgkQJNaLcl1U
h9BFyAf/WmL+czCJwJk4VCBeI8Qs2/FFr8HfxOjvcihHhHLoo47xrAWoGVeJcoGB
B0KxiGvi/sgW230Q8vgawFwzN5pte2FFt8RoXRKNste1aMWTVp2d66nHXg4T3Xa+
1tzhUh1MBWkQCDW2lKroA6RFs4UIX8b0ulYz26VFwpE/is4vcAv77AnCYNIMfqa1
cC/FbZO4VJfSu5vgdtrMSmt0NAczKRI5OpO056olErHtnSmBxagekOrMyDofUwjz
TKcOHNMwH/BdiQFL7BjqDZykxwV1MKNcaXSEd/HTsnCurMbMTCfAsakolqbDDDiL
DG06jT7beQldWH9+cTAb45lPf08ifQ==
=knFg
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
