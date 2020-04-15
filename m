Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ECC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52843206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894529AbgDOI2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:28:03 -0400
Received: from sauhun.de ([88.99.104.3]:49304 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894461AbgDOI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:27:14 -0400
Received: from localhost (p54B33507.dip0.t-ipconnect.de [84.179.53.7])
        by pokefinder.org (Postfix) with ESMTPSA id 956F72C1F58;
        Wed, 15 Apr 2020 10:27:12 +0200 (CEST)
Date:   Wed, 15 Apr 2020 10:27:12 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-i3c@lists.infradead.org,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] i2c: of: reserve unknown and ancillary
 addresses
Message-ID: <20200415082712.GD1141@ninjato>
References: <20200318150059.21714-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20200318150059.21714-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Status update on this series:

> TODO: make sure there are no concurrency issues in patch 6 when handling
> the struct i2c_client.

This turns out to be annoying. How to make sure that we don't modify the
i2c_client while the adapter it is sitting on just gets removed. AFAICS
we need a new locking scheme just for that and I am not convinced this
is the way forward.

Also, there is still this small room for regressing when there are DTs
having multiple addresses specified in the DT and the drivers use
i2c_new_dummy_client on these addresses. I have verified that no in-tree
users of i2c_new_dummy (and friends) do work on extra addresses but
still I'd like to completely avoid this potential regression.

One solution to both problems would be to unregister the reserved device
when its address is requested. I am working on this prototype currently.
However, I am not sure yet if one issue might make this approach messy:
re-registering the reserved device when the probe of the requested
address fails.

We will see...


--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6WxWAACgkQFA3kzBSg
Kbae9w//RJrz6RPLZSRlLMCbftnMujapFw1Mb4d6vzU283/gdeAkzuz/C38XWPA8
xcUJsFWpHCDYOhaXdav0Jf7UL5KssTT2XdrdWneLKmn/QN/8NdeOkiROzTq2pavX
lcQhC9V9tjGe09MfRlpyg6mZDti/09vxJ6QZbOVpHyJg5chqht1NgwjYtAVCwsby
Fd3ucuyN5r1rPwyRXuVVnXQ0D/itOsacyLzpAfA3BQNlLPWe71fsytlCrlPX31Ys
+yh7z+0BAprWcPNNXLVrOG87+Agi7p426lpV94D5BsoEbSbdMC97vLShzooOVFBS
BXhziJ66I1btW/yaXBYO9RWcm0bPH/yN0NTFE9X3H7OqTcVh9TFin33oGR/PEZF0
gkvDnFLOfCUWLO/697U8x+Km0bN/rsOcdapGkjZaeSxZF/QQ3vWGo4S3AibS9GPA
scR//jSVYL+iphxlOa08YRqSfPd2L32vDirk4iTsKTt45850jzGcilFkrEKx4uUm
UTp5VmQkIoVj0CO+E7ByjkM+5yG2o9CTNZHY5X5kLsaiETjGCD0yH4SNrADpiY4o
F13eHJvBFVGtjR969TuiT4tpAzRh+xKAuJNfC3Z8yRyT/uKSS+RAajfc2SCKoWxC
6iSF2T57Tclts7MFdaBCeYN5f16uSvyQR5UTSFezGHb1qd642wI=
=blKZ
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
