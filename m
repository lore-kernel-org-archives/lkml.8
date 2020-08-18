Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D182B20639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597753852;
	bh=eHNv9FdwsK7uVxIPYmdOittfWJ5rJzEkrVPozM1SQu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+uMxj4AikvuG0kxnYrekxYdN0Y907pf00TRXW4TX8bXgsD6M+qR7Mc4975sDzg89
	 41l2aNFYz3MDTKUaFC9OIhuajXnM1EOvzcVjxQdCx/DkVdnK238OR/KP/YElwCifhS
	 8aVNUHVoLHGJEBqAPHOeW0oygcG0B6oeGUr2i0m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHRMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:30:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDD72065D;
        Tue, 18 Aug 2020 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597753846;
        bh=eHNv9FdwsK7uVxIPYmdOittfWJ5rJzEkrVPozM1SQu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKcxKtnJrC7cXoPgNbvfatsTcUqQhXRNKGPXtOc0RgH4w9KY00FBZqzp1j8kQ2QZw
         ZzBaqCkEH4QbKmE2zV4HIk0defjdZ64vYVLhewYYIeqY7p994IAwXa/3ppqOTMNNGd
         nMguyU5y+4CN7DYElJUpDnrUftjA7P8DWV1/7Uv4=
Date:   Tue, 18 Aug 2020 13:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 1/2] ASoC: rockchip-spdif: add description for
 rk3308
Message-ID: <20200818123015.GA5344@sirena.org.uk>
References: <20200815112437.6662-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20200815112437.6662-1-jbx6244@gmail.com>
X-Cookie: Ma Bell is a mean mother!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2020 at 01:24:36PM +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
>=20
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

This doesn't apply against current code, please check and resend.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl87ydcACgkQJNaLcl1U
h9ATqAf+Kw1JpgjNUlPGU5ePMTxIX88Ulj71aDatZmH8W/yzzfj7Lq5d1Rd2SDTC
e7WeRvDuKmtoPbccucFH0aNFO3ev07yvSzgyQEzjlnvEIWiYO7RTxSQaqWfwGYJJ
NgJ22Gfro6WhWVyOE4Wj6SQ9lGk5AkdmBEIiExWBgudwa+m7rwnzY5zM3oaLWCnO
5zvlTV1yglKX5xuYjO38wOmmq2c1ZyWs8qriuXShJGQr9R96wZEvstrJlExGn/V/
gR5Y0HvcEnAkCGWj8vqoeeq+Ot8vwbIkF4LZoAJpKVSDW5NELwr6IX7aww6k9p7+
jsmCl584BsniWd/wfF6j7sQSETp0DA==
=ZzoW
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
