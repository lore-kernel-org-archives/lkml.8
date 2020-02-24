Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A2C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7020838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GMyh9RnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBXSqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:46:50 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:47116 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C4dVosEU3F7BoLRq5O+/VX+N7XKbd4pkBYvAJk3Mjnc=; b=GMyh9RnXpJcSYq2R1vd8fr9tv
        W6Uwa2wtZ7DwDmuN46H0PibD4AsX6hBEC3RMf/zDg6dnYRxbNsYSng7A/4iQ0yibdorSmSI9fbw8d
        x2T2QSS0/4YyIhFVQvHfkbSPWgd6QFSwnaIH2/XcoRTNf1WurPOiZPOoFtyhmOcu9AWt0=;
Received: from p200300ccff096700e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:6700:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j6Ike-0002MW-4k; Mon, 24 Feb 2020 19:46:44 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j6Ikd-00044D-FY; Mon, 24 Feb 2020 19:46:43 +0100
Date:   Mon, 24 Feb 2020 19:46:25 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     hns@goldelico.com, j.neuschaefer@gmx.net, contact@paulk.fr,
        GNUtoo@cyberdimension.org, josua.mayer@jm0.eu, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages
 e.g. in EPD PMICs
Message-ID: <20200224194625.20078cf2@kemnade.info>
In-Reply-To: <20200224120512.GG6215@sirena.org.uk>
References: <20200223153502.15306-1-andreas@kemnade.info>
        <20200224120512.GG6215@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yAS+qN3RrSi7FCLSBI+4oPT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yAS+qN3RrSi7FCLSBI+4oPT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 24 Feb 2020 12:05:12 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sun, Feb 23, 2020 at 04:35:01PM +0100, Andreas Kemnade wrote:
>=20
> > An alternative would be to handle voltages as absolute values.
> > There are probably no regulators with support both negative
> > and positive output. =20
>=20
> This is what'd be needed, your approach here is a bit of a hack and
> leaves some values unrepresentable if they overlap with errnos which
> obviously has issues if someone has a need for those values.  Ground is
> to a large extent somewhat arbatrary anyway and some systems do just
> redefine it as part of their normal operation (eg, VMID based audio
> systems) so this wouldn't be a huge departure.

Thanks for clarification, outputs from 0mV to -4mV would not be be
representable. I am now converting stuff to think positive ;-) That
is good to decide early before pushing my huge pile of things needed
for EPD support on top of mainline somewhere.
Parallel I am evaluating upstreaming of the tps65181 driver which
probably ends up in a rewrite...

Regards,
Andreas

--Sig_/yAS+qN3RrSi7FCLSBI+4oPT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5UGgEACgkQl4jFM1s/
ye8NuQ//RdQehffxhOSuj+PHQgq4NpL4ccPSLPtD+D9UW22DlfO7HuDP8yrXQ9Ow
3iChwKXzbBeIjAFb+IrAV8qy84WUa7pVPtSM6WA1h5fTsOd6sVXrQ3ZX6QOTwzER
mIoBHNyPswapHec0ny1HfuQWKrr9ECxjipLUqmNNpO5rusdmhPn8mHbdAgZ+B77l
LR5mmYV2Js2dLyTgzIDN55umXwi9YdjeKkMUhOL8U9ku1XYhxhz+qIgiDGMv/eSW
CfL+scau18aVCVOi+RuMvcFDNmva+69TjZzs/Fx0hZua40hiM9XmMqg8mCNRYYLr
/ob/tBsS3JLyVM/apNTNvGfL7FcWRo8EnovOh38BwZ+FuKsN4VAFctWF5anuXn5T
KQuDuDuIgTew5Nd/okloyhjT0HA6sKCQEVXm6vgH15FHpj5PM6tJmHzjaGje8v2x
k1rmSodveqiJzFZgkF+Dp4175Q4RMbPCI6iKpTNDT7k5AwbkQ01Zu1t1XVcucL+b
PDcpPOyGhuzgfZqlkagEnPJZZZn/2RiMRoPNa8D+a0BkipOax2VKXwzFazpxE0Hc
liYkB4//RjmzAN5yqo5TvNk74M1gMolcBNVkRM5AdpW5VtOiqbyHEMwH5h8pMOev
7L01Af4hdDHgW0y2LJ2f/wpuMy3kKNddl4x4uT+Y9WQL4J4cc3w=
=BW7X
-----END PGP SIGNATURE-----

--Sig_/yAS+qN3RrSi7FCLSBI+4oPT--
