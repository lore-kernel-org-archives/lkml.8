Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7694207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597865931;
	bh=Lx8A+4JGDQaw7o2vhsJrOmveD7jfN5pP0/WfbZJP56g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vp/usgnytRh5rlIR1+TDz3U14xdScDPQD3PlFOuOpnoZ3gNinx2RWPUWSrtQ0Khhd
	 vvwKd5bm1sSYRPzsTuVCXZe10Bdf3Y8LqIVouYGTalzgB0Tr9fX4mNv7yRWEWMXG03
	 tlwjMIS3V2BI8c0IsdyEag6HcxYje0u83qSwPUig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHSTiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHSTit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:38:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E793B207BB;
        Wed, 19 Aug 2020 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597865928;
        bh=Lx8A+4JGDQaw7o2vhsJrOmveD7jfN5pP0/WfbZJP56g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6hchO+WKQcxzx0U9ePi3GDXU6ZFMdMZsJpIIyqIt7ejyd1S19hVsCjIuTEvqXXbf
         v08ZOCo6eAqhgMXU/8olDYcVYtUKbxzbiGFRTIv7hQgOpLy9KrlNhdE7V18idBK0dk
         feez/vr2kE/bDYZXhuv37SkVIJ4XyouB77/g0++s=
Date:   Wed, 19 Aug 2020 20:38:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Message-ID: <20200819193816.GB38371@sirena.org.uk>
References: <20200819123914.GC18122@kozik-lap>
 <CGME20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52@eucas1p2.samsung.com>
 <dleftjpn7m23j2.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <dleftjpn7m23j2.fsf%l.stelmach@samsung.com>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 03:01:21PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 =C5=9Bro 14:39>, when Krzysztof Kozlowski wrote:

> > There is here no commit msg, no explanation.

> As I wrote in the cover letter, this and previous commits make things
> work on Exynos3250 (ARTIK5 precisely). I can't explain why. I read
> everything I could about this HW and there were no details about
> automatic CS handling other than how to turn it on and off.

What is similar about those other SoCs - could you be more specific
here, or what goes wrong if you don't set this?  The auto mode (or at
least the auto mode that was on the Exynos7) is not compatible with many
SPI devices if the controller chip select is actually in use, the quirk
was added for controllers that just don't have the manual mode.

See also:

  https://lore.kernel.org/linux-spi/CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6e=
dOm6U3bc26_Q@mail.gmail.com/

for an explanation of the quirk.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89f6cACgkQJNaLcl1U
h9Bmfgf/Wm0OF/5d35c0AFf1yO1of1+7rl0W7mzfcaCAgcfAfic1SfJF/XhDfrkK
oCHW2fDnCllISAZFdWGUtkiGEzUP+rVr0IIDpbQv0i4Onwl+hTI1O9ajO5txeGQJ
XrLH+OzcuhOjtDGR+5qi074Yp6r0fGPhtiMn7/HsFkJMhx9XJKM+Rex83iTZyQrP
0lgBARjqXLZGjr66jJEb0FgsqtF+84TBZWv33hz1zserxSyVtYVZa8uBatg25FqM
sbxBnlFL8D/OsyLLUJl+EIGwpqd6+nyTdg4Q+XCM3vw1W3RQqsFntmf64Dk7KRDX
C+mYuD6hIFhPeuO9stuBQmbt4KwHkA==
=rPWW
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
