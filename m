Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1DCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E432074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595593311;
	bh=pKwG7sz23Jh8BAXh9JAwkl7Df1oVbQNtNUXu8orqNB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LfHfcCclfWHRkfpxK6KgswmgNeIezcdZ37qn4EurPjVTN7V2ELwpMtx+B19NhH06t
	 b/6ebnpC4bVYHYvBM/T3O2s7vXhZOPMZcLbgVcwXchiuRkF6Zr0qlEGg7QOSW1UhR2
	 VMcKT33zFBYBJkmPOHwtnkdkjuT8ytmk7uchAqEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGXMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXMVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:21:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711D520737;
        Fri, 24 Jul 2020 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595593310;
        bh=pKwG7sz23Jh8BAXh9JAwkl7Df1oVbQNtNUXu8orqNB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGqQpuA/nsqH8Q973vZszR/rnh/Gp5nGlYXQ1nr618nI+UDrFjh+iwCE+FtDhHtRJ
         H67R5n7U58FQi2AGdugQWmDDzk2TcDK2M2m4cyNXW3rxp+zb/RBBASKxXMfWLB7b+v
         6SUBkDL9SMis3R1e/0A2t/1yCCJx3dM7P8ExrEcY=
Date:   Fri, 24 Jul 2020 13:21:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wen Su <wen.su@mediatek.com>
Subject: Re: [PATCH 5/8] regulator: mt6359: Add support for MT6359 regulator
Message-ID: <20200724122134.GD5664@sirena.org.uk>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-6-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <1595509133-5358-6-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 08:58:50PM +0800, Hsin-Hsiung Wang wrote:
> From: Wen Su <wen.su@mediatek.com>
>=20
> The MT6359 is a regulator found on boards based on MediaTek MT6779 and
> probably other SoCs. It is a so called pmic and connects as a slave to
> SoC using SPI, wrapped inside the pmic-wrapper.

Acked-by: Mark Brown <broonie@kernel.org>

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8a0k4ACgkQJNaLcl1U
h9Du2gf/U/MC+yoZc1bEJJ7ZixaCMK6ZSIJlbMh6RlAKO1kQAQhLz9i3yinQPaai
p8cRi3iERLnXzA3RxbvtG/Tq8JOSXZ6PjCVxjHp8OHmc+WMOb63rivRx4fyEzFj3
FzQJWg7RxoBiJOQQm0dx0KPd0Di4ITh6UxA7jSGtQVVdkI24V/D+Hb47KeZGlOxt
6awjyRSsyRgrwh686lJq9hinUieKmcyASf8ZnKuDUzqlI4FMC6xsz86/YGwKB82N
m38XL/zdOMGDDC8yWdAkyn1PWKqgfYa9B3qkAUheivyiXWy1+6sN4UQ59cHoO2+B
Z7DhweBclspPwW6xEE8Ts/MNL/TlvQ==
=pp/5
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
