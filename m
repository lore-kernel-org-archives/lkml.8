Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F721927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394328AbgDPOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:38 -0400
Received: from sauhun.de ([88.99.104.3]:43324 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404364AbgDPOLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:11:47 -0400
Received: from localhost (p54B33393.dip0.t-ipconnect.de [84.179.51.147])
        by pokefinder.org (Postfix) with ESMTPSA id C6CFC2C1F4B;
        Thu, 16 Apr 2020 16:11:44 +0200 (CEST)
Date:   Thu, 16 Apr 2020 16:11:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c:imx-lpi2c: Omit superfluous error message in
 lpi2c_imx_probe()
Message-ID: <20200416141144.GB1142@ninjato>
References: <20200416140529.20036-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20200416140529.20036-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 10:05:29PM +0800, Tang Bin wrote:
> In the function lpi2c_imx_probe(), when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant message
> here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Please make only one patch for all the drivers in the i2c subsystem.


--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6YZ6AACgkQFA3kzBSg
KbZ4uA//a/dPITOlzgSHI6tPELR5gpZC0xTGuSky3954hG+aV8ceV2fh0as+wGYJ
MOR4LdDFbHHG7EUGuQvMwjGxKvY/6aeHFQj9okzvc47PQvJeMEHay1PL8qIESUBe
7L2v1LMDIwxK+/ymaYytvFhqwTwEPmmB8n9bB+H04yn67CyXXrpRxm++EsKHZomP
fDtmo0L4Zmp9f5OOHFrPrOepbSJdtAV3nXnqgJDr/WaUxkvcrp9LZOhPDsZL2N9S
mPEFMP41cxemrVms2b1/FlhSMjjKr2bgFv1rj7tjHyVnUrtEsHKPYLCnIk+xr7WO
/FPLMxogTj6g27LPza5BpeFzw9WYW8dM/E9NVMb5K3kpjtlRYBNocH2kfs6E+kBU
H4gs0HS3tpzscRLWyCGZKgQMA3WF+axfH8BK0N0TShLw+9wCoZ0waLWzsyUVBM3G
XpVCjNjpVhIknjePazD94UYFT9Ck+m/s/hZB+GL1AtjW7CA+q63qQ7v6O7oDoOHx
aMBnCJZ1ldAfRovuiaMApNv5Aa2OvajULWNfikviKRJOgsGCTMyxqFqCyWZ7Nxcq
d9idpbEGojF5kzPWApZIxGy4pHZRwYmJ3YYd28Gb5ucEWo+qNZN3xd4byFFiOgUh
p90MnmDjz6hiK/MnmuQtQ2thKAHmuB+CiKrMUCxo5yVuIE12wjI=
=NVdq
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
