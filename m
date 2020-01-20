Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F86C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B420882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579522114;
	bh=BePZeCg7OZsvRd6q920v7eXCwn1x1JNRgLDTWBmbd5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SEf+IAfS9ggtEQp4kDH6M//OlxQ+l9+GgbonftquKZghyV1avyXjRjrcxR3lV9Cmn
	 PcU82sTJ/ksoc2q185PLxp2slsLLU+ymD+eO7oYg29k+YgcEB79bSMKw+wvfG6fuTC
	 2DWGu0MXxrhtLe9uFpV/sYw094W9Bnx84gxzWWpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgATMId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:59176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATMId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:08:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BCC30E;
        Mon, 20 Jan 2020 04:08:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5DA3F68E;
        Mon, 20 Jan 2020 04:08:32 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:08:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        drinkcat@chromium.org, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org
Subject: Re: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage
Message-ID: <20200120120830.GA6852@sirena.org.uk>
References: <20200116094543.2847321-1-enric.balletbo@collabora.com>
 <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 07:28:04PM +0300, Dmitry Osipenko wrote:
> 16.01.2020 12:45, Enric Balletbo i Serra =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > +EXPORT_SYMBOL(regulator_set_voltage_rdev);
> > =20
> >  static int regulator_limit_voltage_step(struct regulator_dev *rdev,
> >  					int *current_uV, int *min_uV)
> > @@ -4034,6 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_d=
ev *rdev)
> >  		return ret;
> >  	return ret - rdev->constraints->uV_offset;
> >  }
> > +EXPORT_SYMBOL(regulator_get_voltage_rdev);

> I think it should be EXPORT_SYMBOL_GPL().

Yes, you're right.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4lmDsACgkQJNaLcl1U
h9Bltwf9HGnzPgngcMKoZu2wwYGXrfv6RVw1AtAY46IGsfTXv6mvGYkpbPO2BBRB
zdiWDNbBgtSiMEA2xGmpqbJa8xDzyQ1hidm/6fI802xtCrwNbkUl+5z+HXx0ZDUj
o8gdgb7KJJWoWrUHJIHS02NBlmoTueMZ1r5yXC3BvZj4S5aWt2K1w3H+/QuF0+JN
hZsy37+1i9ufd6EQQKsZeytpZzrYhewPBespGctNMjvMI9Tvgi2ujPE1sy0eepiT
3CiTk5s1ufPrVm1mvcViNOL/KI8emSDeu383UEyUgu1lgpKhkcoU0+IAMMiwWjZ3
BMHw/ipmZHg5EJ/OKwdjGNi6OU5sQg==
=NyBB
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
