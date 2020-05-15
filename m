Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8955206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:56:08 -0400
Received: from sauhun.de ([88.99.104.3]:37868 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgEOQ4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:56:08 -0400
Received: from localhost (p5486CC07.dip0.t-ipconnect.de [84.134.204.7])
        by pokefinder.org (Postfix) with ESMTPSA id 1297F2C1F6B;
        Fri, 15 May 2020 18:56:06 +0200 (CEST)
Date:   Fri, 15 May 2020 18:56:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: i2c: Document I2C controller binding
 for MT6797 SoC
Message-ID: <20200515165605.GA19423@ninjato>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
 <20200222162444.11590-2-manivannan.sadhasivam@linaro.org>
 <20200226222330.GA9392@bogus>
 <aa9ea456-dbee-229c-aea0-4860c6eb7adf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <aa9ea456-dbee-229c-aea0-4860c6eb7adf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 04:48:28PM +0200, Matthias Brugger wrote:
> Hi Wolfram,
>=20
> On 26/02/2020 23:23, Rob Herring wrote:
> > On Sat, 22 Feb 2020 21:54:41 +0530, Manivannan Sadhasivam wrote:
> >> I2C controller driver for MT6577 SoC is reused for MT6797 SoC. Hence,
> >> document that in DT binding.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
> >=20
>=20
> Do you want to take this thorough your tree or are you OK if I take it th=
orough
> mine?

The I2C list is neither in the CC field, nor is the patch in patchwork.
I suggest you take it.

Acked-by: Wolfram Sang <wsa@kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6+yaEACgkQFA3kzBSg
KbZzoxAAmChj28HYksgpo/MWV/BUG0pk9pOZqJPw/klKVXwQthuLR5VhB8skNnKX
ZJK0R4lBqOiTUkt9ASzuuXtA3Is/YlvAfyL6Q53pKcuaMJBIEl3xgf+hJxeUv8tv
xKv2nXRtIIcnuVCfK3D6WmxR4De3vVYjZmg4YrCmdl6JUzDc/vXRXCPdeGI3HzXV
S4thVcwulxtW77EVbZtbK7DObPVXQb6CFb8oPYblIBqAQRers0/s+zag9j6suBFF
nRCr9uNrec1IPhnIwqSqe5uPqsr02kEaVFg0DCyXmR+l4FuM3yu19W9e1Jxxp/1Q
RqIJ+OfCgiVgoG5SUHREIkOWbivBgy7sAdQ41PEQ91Wxa4Qjmvk+YhBn7SK/12za
wYfD2FxikaYWlOW2vlMFIlHnXxjXuCQeMZl3BbHejgaNdYtGaxcp1mtFsLsG/acR
a6VMR635bMGETBg4aN/8c0A4KAKDEhzL/ucn/JtKBK6LwGCdmNnIYpi+VOQ9YfVw
8q6gVA88+MMK+pfOtPPLXnv8I9UU08oijKG3W+K1WS/ewL/bOI484C95s3yXg25Q
9gpslUUdYlNy9SQilZ65IjjsjIDmF0v6bbSaygHqw8HWeMaRu4YV6leIOu51+yFK
4OnklpdFEd+YwLSYVUyPZ3IK+4D2heK9etKViSs8HDCpSTBs1Po=
=Vxiu
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
