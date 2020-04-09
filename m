Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07521C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C020A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586429150;
	bh=Bj4KCi4Ibg5oo9TbDcevGuX/4djzmyiF0/NqHpujLqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RiR9qqGObFuCfDLeT4SK/FokTfJl3OCz8PSOiAN3FuPrfJju5+E7HW7LRLksCxwyZ
	 Sh9MbHBORCdbeyAFH3XLtsa/LWFIx0OfGBPh95O46Xx+IotpuhjNkVnDQ+i2mnM9GH
	 Cgh2fI+v/op5GQ5GjAwChq8KvWpvwGvAO9gw7Sjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDIKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIKps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:45:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73EC820857;
        Thu,  9 Apr 2020 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586429149;
        bh=Bj4KCi4Ibg5oo9TbDcevGuX/4djzmyiF0/NqHpujLqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNFrHuPszFFuiny384iC1PwRmTLzv4HQZNyo/jrxoac4fWOVWAPGFo/+wZOT2LuKu
         X97cz7kC1A/dUII7JG5bbJ5LASWAjI/vznxf653JbVBgn+4Euav7vLeb9o4kKJ8U8G
         8l+vYYuekSh6cJ94lnWD1cjCmvRDjvfGUmtJbGmY=
Date:   Thu, 9 Apr 2020 11:45:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     lee.jones@linaro.org, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] regmap: Add reg_update_bits() support
Message-ID: <20200409104546.GA5399@sirena.org.uk>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
 <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2020 at 04:57:58PM +0800, Baolin Wang wrote:
> Add reg_update_bits() support in case some platforms use a special method
> to update bits of registers.
>=20
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/base/regmap/regmap-mmio.c | 29 ++++++++++++++++++++++++++++-
>  drivers/base/regmap/regmap.c      |  1 +

MMIO devices clearly don't physically have an update_bits() operation so
this should be implemented further up the stack where it applies to all
buses without physical support.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6O/NcACgkQJNaLcl1U
h9DjRgf+IP/u9nUEoNtZLGYFiBKynZ6dn873JFvLn2vt0eHtxyyxscgijvgMfV/K
DeVYVYmwbnc2/YVjVbNWna7fhvNgjVxWx23JH1AyUCGBJm58a5QVht3k0SJaWx6/
wUDpjGNzdJbyZfMo+ifhzr6/4gqnoylniIAVntbuFoPkHoCg5F5QGdVmje7YwC3z
VaMLNNxKW1egPjy7JZ7f+K/08yjKURsMkZ6793ebYl00s9Xf49JSse/0szNilBjj
2r7Te/+wHtBYmFRe2dP0jwqQLE89KmSuHy7ONHuaLSdVkyiD1UVVLS2EsFwMF4Dk
IxzikTfhuUw5IT02gSckH9+KCxC2Dw==
=Kfcm
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
