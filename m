Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02612067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594225286;
	bh=GX2wqJmosd0wbTbZfK+foBUGHH0+2I7ION5P2mNGYYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JXLQkqqQ0mOz83p/hzJxQTMlGuf/UwlWbZ+ulfM1H1PSo9jWbTQZrbSWtQwvZOECR
	 3LsWWS6prxU0nAL/XvdnT5uFE62dljXotlqktFZJyutXZ61cRZ47Q1idbxwBZjLOhX
	 //NGtc0lAjSs6c1IggiyQjfQWIc4VAf03kjeSmY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgGHQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgGHQVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:21:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390972067D;
        Wed,  8 Jul 2020 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594225282;
        bh=GX2wqJmosd0wbTbZfK+foBUGHH0+2I7ION5P2mNGYYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNM1ckoHull2UkSYu7WEiJPimacbxrksOlmj4bKTDsKN50btX5ANrqKSCzO+ybKVs
         8i0QZSzm6WUuT5Kf83W1UzBjl4df6JKKJpKWkBg1ZEJx8sKvvT/a2gKSgG9yQeH/VW
         HjB0VsQGflYHGVovhlJOcod2Xxi1H9uqsE2WuFxw=
Date:   Wed, 8 Jul 2020 17:21:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200708162117.GV4655@sirena.org.uk>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+OVWeTxrbAwQuiek"
Content-Disposition: inline
In-Reply-To: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+OVWeTxrbAwQuiek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 07:12:32PM +0300, Andy Shevchenko wrote:
> Make regmap firmware node type agnostic by switching it to use fwnode.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is a duplicate of a patch already applied.

--+OVWeTxrbAwQuiek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F8nwACgkQJNaLcl1U
h9BHpwf/WN9obtRdMOdbS3PfGZbFq2Ov6tOoNlvu0ZThvecAW9+jzPqlIiutwSvG
UaPCoy8SNrNpiKim6+8kazC7biunG6lE6OiWQKaZSnKdbcv+j7NrdZagu68uoK4L
/pD59rCp0OlDXgd8TDgsSsvkQNEwuKGZWbowRb70ZnqtZtejI82ffeK3jeoUjld1
8ViCPhvwcw7NOnZ/qySAYjRgji2k62sKhacTd+rILfVKACUGLJ34to9h0woE4wXY
EKXtJwECqb92XMJOkO2snQoorMr1uJ9FO70xryQ3q8Au/jTgycEWncYiNiZpq5l2
oj2HIVNT1ZWdUbHzqG5Wb38ydR/lfA==
=6hb2
-----END PGP SIGNATURE-----

--+OVWeTxrbAwQuiek--
