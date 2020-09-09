Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7156C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F6422286
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599664750;
	bh=LkadiQCgclxrhojlBp3ZXM5AWwkkDe239xMCm7eedRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PjaTl0sB2OmAQrBqI38axYAgMezj2w2mUvE4STRb6Yhh+QvNV3qmI8zkmg5LC49iq
	 hbBMV/+xIecN8w4L6WXBFPVSIiakykdR4w2FyCvUk2T/mBzoxisy81SbMfxQ5CA8ic
	 dSmOjXexV7+cx9XV4xKJS6Mx274JIE2jtdDeXvNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIIPS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgIILao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C7221582;
        Wed,  9 Sep 2020 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650582;
        bh=LkadiQCgclxrhojlBp3ZXM5AWwkkDe239xMCm7eedRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrrGsOcTrWGEPvnUvln7SG7bMJdZ8HTJlYOThf6sAUD4Tsyc62iZhuN4/kAh2Zodw
         6l6UYCdDFnpiAt9e7kHXzKb1ps6JA3d4pmwjio2Yzbtz0FIfh8vjs3UJXhbNa8/cPw
         r1AD8bDOoFfbRIIic8PEdNoQl6PYUrAmdxQPEjCE=
Date:   Wed, 9 Sep 2020 12:22:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Camel Guo <camelg@axis.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>, Camel Guo <Camel.Guo@axis.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
Message-ID: <20200909112216.GB4926@sirena.org.uk>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <159958562064.16576.7853800514030717096.b4-ty@kernel.org>
 <1e17f203-7b60-bf97-4515-937e722f5ef7@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <1e17f203-7b60-bf97-4515-937e722f5ef7@axis.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 12:06:45PM +0200, Camel Guo wrote:
> On 9/8/20 7:20 PM, Mark Brown wrote:

> > Applied to

> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-n=
ext

> I think it is "ASoC: tlv320adcx140: Wake up codec before register setting"
> that is applied to for next not this one.

As the mail says:

> > [1/1] ASoC: tlv320adcx140: Wake up codec before accessing register
> >  =A0=A0=A0=A0=A0 commit: 1a5ce48fd667128e369fdc7fb87e21539aed21b5

You didn't send a cover letter.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9YuugACgkQJNaLcl1U
h9BzRAf/eej3UqPw1MAjqnCxeGC25+X4SQHNNj9q/MDJxHNi4cmZhw1xymwlhMvH
LzzZuVLNsf+iBGnr+Pb1bFs+gbXPK4R2mes/HOAnfrBtTmQaaVdz7gI6GauLubZl
UhK+XUiP6nLgOw/hQcF0dc9mJzZcL74wixT1Qb4nADxZMIS9NvWsNb9IX7/S4Zi6
6u6In1DZFzMICqDVirAmTNXwDkEuoK+SuFzQqibMIQ/KOKrNuyevcuFbfEETzeNP
lCdyuMyDzJp2oAVSRoos9OUQ9K+9szg74RzZ98yjDwBE/sX17iVPO1exFaNS1IG7
g+jkoNwl+SVDGWK9ouoSKgmmzTUDcQ==
=hYvu
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
