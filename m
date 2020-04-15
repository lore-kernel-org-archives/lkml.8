Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480CC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E666E206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415749AbgDOQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:23:51 -0400
Received: from sauhun.de ([88.99.104.3]:56404 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415722AbgDOQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:23:47 -0400
Received: from localhost (p54B33507.dip0.t-ipconnect.de [84.179.53.7])
        by pokefinder.org (Postfix) with ESMTPSA id 5D6B82C1FF1;
        Wed, 15 Apr 2020 18:23:45 +0200 (CEST)
Date:   Wed, 15 Apr 2020 18:23:45 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] NVIDIA Tegra I2C synchronization correction
Message-ID: <20200415162344.GB2830@ninjato>
References: <20200324191217.1829-1-digetx@gmail.com>
 <20200415114536.GB910@ninjato>
 <87f18a67-5aec-b5df-9d8f-341f03ff3a72@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <87f18a67-5aec-b5df-9d8f-341f03ff3a72@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Patches look good to me. I tend to apply them to for-current instead of
> > for-next because they are fixing issues. Even a stable tag?
> >=20
>=20
> Thank you, yes it should be good to apply this series to 5.7 because the
> Tegra APBDMA driver dependency-patches are already in 5.7.
>=20
> The stable tag shouldn't be needed since this is not a critical bug fix
> and the DMA driver patches are not going into stable. This series should
> be more actual for the upcoming devices, which should be upstreamed in 5.=
8+.

Understood. Thanks for the heads up!


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6XNRAACgkQFA3kzBSg
KbYelg/+JJQUn9SPGjOZhZGQySY5aLk5fsftZTGeXoFtq6B8HNTDzMlwhubFTvHR
D682nxBo65nuktk5sw3X/rpHYMT9H1mRdkBgurNWHH9ZIEUpq+qSr0/ZMNmVs0i2
t8YXR15fi0gw0Es74oGUpo3zhrHY73gBLXOog8M/EBiLEBrsYCW/gtyu99swD2nG
80MVj5FTGJ0Y+qAHbpo14CX6ofQgDjj8nSbdrYFvzF9QupsyNOZMuTzvoL1AQ2CI
Ky22W5M/YK1+MWdlIyEPoPmYL7q/PW2yRPbVmDeatx7uIZBvbQvw68mFdH12BQT5
JdDb3b1UQvf5646S7J8li78hVGyyA86Am5UfDSZLgBopF6xbBUdhEM5nd6mBmjbJ
OHTd0sZSHbr3PG9VGvL15qnyJiFhzBmjigMLs8dYFHOCMQwRYvgnBoow14BdsToM
Z49HsvXoFiVQTURQSPGAKqwrwbp1LvGcQ5FYhrhBbIJD9lJZU+lIzViW1Thl5WGt
7Ax7KX6BF4fBGzexPfOm8ldnv+kIBTeW8cauWLDs6H+6CMISbnHPcioVySFcJu/L
806eM3+OO4aiiIp1hp0hyFTbvYBJMrvuQkCxpkZz5nF5t/E4w3dYyYuZlou4Gb+F
L36qGctOsCHcIo/Ia7wPVscBkshBxVSiC3sWrTh8TBbAoVzPKZ4=
=84CU
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
