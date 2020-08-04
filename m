Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7086022BF3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596575627;
	bh=uk5OeUUr1ieBJElxnAxLjVqIv4SwKI9/mcluVt3vAlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i1j32bUy/6H3yHNf7gM3cykOEcj2zUeXe7LembuuZd9LDbVgpZ7HsZWR0a6tJnKKs
	 hvHWyGoBrJ3ACV+UeCHhaVtzDV7KGLg93uk34vCixsF+Wc7/L0dbDnUpu71/uF/A96
	 JBZA2evi+Z4m2+u9rRERocsUpeI9B9XRMKLa20rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHDVNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHDVNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:13:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25C02075A;
        Tue,  4 Aug 2020 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596575625;
        bh=uk5OeUUr1ieBJElxnAxLjVqIv4SwKI9/mcluVt3vAlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obbwlw1Vo4tD8WT5CqWYTHsadkq51Kguo/EfJ45EksZfoBHS0cbeKpHSaVjwpARNU
         tJWIlKzQCIcAuoox7dXePPGUDH3X+rXHyann1Xj43LJX5Nk4ieHMcvJpD5+QYrpyvt
         PV7R8zsWittgGth2N7M/ES8TCcr97jDRpTXcrF6U=
Date:   Tue, 4 Aug 2020 22:13:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Claudiu.Beznea@microchip.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        Ludovic.Desroches@microchip.com, perex@perex.cz
Subject: Re: [PATCH v3 2/2] ASoC: mchp-spdiftx: add driver for S/PDIF TX
 Controller
Message-ID: <20200804211323.GD5249@sirena.org.uk>
References: <20200803081851.102570-1-codrin.ciubotariu@microchip.com>
 <20200803081851.102570-2-codrin.ciubotariu@microchip.com>
 <4d009743-733a-9578-71b2-d320fdca9331@microchip.com>
 <d415817f-d32c-07bb-4d9a-41649290a559@microchip.com>
 <8a0cb78d-d22d-eb29-8650-67c033b57446@microchip.com>
 <d0606eb7-e706-577d-abc4-f994c56a53e9@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <d0606eb7-e706-577d-abc4-f994c56a53e9@microchip.com>
X-Cookie: Every solution breeds new problems.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 04:37:07PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:
> On 03.08.2020 20:11, Claudiu Beznea - M18063 wrote:
> >=20
> >=20
> > On 03.08.2020 19:11, Codrin Ciubotariu - M19940 wrote:
> >> On 03.08.2020 16:06, Claudiu Beznea - M18063 wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8pz3IACgkQJNaLcl1U
h9AN3gf+Im9uNemS0G3msHEIRBtq1WKsAVCYHYB2jwTa3q69/6U09UO5z17KzUj9
O4u1+8m8Ygx9GKcz19npSmeLqSTjwkiluiitkW4kiUxZdCXAyK1XOHeJKnGV+ejA
YSfBcdbXNawuUQ7ndfzNnbFj6roRW2gJ9RtkapHiGJDu5BZRKDB7e+m1MVy2BWQt
P3bsop0ig4nWtUsdv0dbFbL0PQQr10UZxtHVHoEkteA4vP94/o0avMS01aWMkQBp
kvzL20QwB+GKcUzOyqmZtGfoKextK9Aev+bJK9kmBT2+0n34Va30iK+SKZHszZ6A
Mu1bEHxVXF2jCBDPoXRmmRW1ZYsVnA==
=z17q
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
