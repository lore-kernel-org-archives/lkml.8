Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEEC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A415A24966
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEEPwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:52:31 -0400
Received: from sauhun.de ([88.99.104.3]:34600 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgEEPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:52:30 -0400
Received: from localhost (p54B335A1.dip0.t-ipconnect.de [84.179.53.161])
        by pokefinder.org (Postfix) with ESMTPSA id D61172C0892;
        Tue,  5 May 2020 17:52:28 +0200 (CEST)
Date:   Tue, 5 May 2020 17:52:28 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: at91: support atomic write xfer
Message-ID: <20200505155228.GG2468@ninjato>
References: <55613934b7d14ae4122b648c20351b63b03a1385.1584851536.git.mirq-linux@rere.qmqm.pl>
 <20200322143004.GB1091@ninjato>
 <20200322163013.GA25488@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <20200322163013.GA25488@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I don't expect this to be used for much more than a simple write to PMIC
> to kill the power. So this patch is tailor made for exactly this purpose.

Frankly, I don't like it much. The atomic callbacks are supposed to be
drop-in replacements of the non-atomic contexts. There may be a need to
read a PMIC register before writing something. I considered checking in
the core if we can fall back to non-atomic calls if the the atomic ones
return -EOPNOTSUPP, though,  but I still don't like the idea. I expect
that people send me minimal versions then which are extended over time
by very personal use cases. Having a proper implementation
once-and-for-all (despite bugfixes) sounds much more maintainable to me.

> Though, if you would go for full support of atomic transfers, then
> I would suggest to hack the non-atomic path to be usable in atomic mode
> instead (some I2C drivers do just that, eg. i2c-tegra).

Yes, that is what I am aiming for.

> BTW, I found this comment in i2c-core.h:
>=20
>  * We only allow atomic transfers for very late communication, e.g. to se=
nd
>  * the powerdown command to a PMIC. Atomic transfers are a corner case an=
d not
>  * for generic use!=20
>=20
> I think this covers the idea.

Well, since I implemented the atomic_xfer mechanism, I think I am the
primary authority of what "covers the idea", so I will fix the comment
above :) Note, there is also this comment in the way more user-visible
include/linux/i2c.h:

 509  * @master_xfer_atomic: same as @master_xfer. Yet, only using atomic c=
ontext
 510  *   so e.g. PMICs can be accessed very late before shutdown. Optional.

All the best,

   Wolfram


--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6xi7gACgkQFA3kzBSg
KbZfNg/9GF+sMJvCc3AGGXxn6IpnTj7f9WuZN/dY3+/TrdgV/Co6EUPAWhYWy7Y5
kgzvIGkhW+wSQSJbfqNY4iZU5gDWWE28+8tSFhg+8FnmVFVdbY7qqQ5CpJ3tAD/d
K7YY9iWVNwZmWIkhqj1hyANZjRMnPT09D08I/NQdTF4cXCuKXh9YnCE74Q+Zr+cA
8cqRv7YUHs173+Rm+4FDvZnHRiflc/cg+BeiEiB/JhRfMZqVyTMCi4YOQSRtu+e1
XTLeLcZJR6YbQlM9W9FA/zmYLWAkEaXDzTlC0Sz1No9dxUgm/lHTM+T7p9bVVbRm
n1/2x5ye/7pOMbD5kWzoIQJ6qC57r9rwFkNNAlo4PvR42eo+KZg6KLqznbeKlAfc
/zyKpCEp1TCaM2ke8C79tKVS9Dbgn+Z+zzXdSE6gFBBTazAl0aqZkCsul5i2tgkd
36Gb44YWNEh/DQSCBtleNYXHj1UgOAujXEHa0rn6ck+IfIsq9/gL7Rqusc8G/QbG
7WV3HDJ4L+QgCx1VbAO4Q/zumHcS+0XPT778XYE2DFCC+n98Rxvngi5AL4KAVOe+
lYukdEmofXexVrA/eVN98EYHmxoMg4V8CyW39nwvk+w+qiLq0h57/T/YSkXAqm5K
tclYk++pWXY4jcBUJiHrYZpcOzceTrDsN/WHceCp4n11EAcLJwg=
=RXXd
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
