Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D242C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056F720760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591783321;
	bh=78d9bWu90jgVLLl5d0FL3YY9FE7pw79tHayUAi8wc/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IozQKU1hX6NpWZ/2jYZ2Hc1/Vv+Z0qLTcPKipHPzaMabjRKbcOsq43Kc0Gk5FdPuU
	 EebxDzm4W7A9aE8IllTlLF9xlFi1gRuPFpz1UrJb6yOkkjv819yWndP03XefnLNSUT
	 ZYV6iOTmm5iL5lav7ndqfZuCclZLMe726ohKXTVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFJKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJKB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:01:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFBB206F7;
        Wed, 10 Jun 2020 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591783318;
        bh=78d9bWu90jgVLLl5d0FL3YY9FE7pw79tHayUAi8wc/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bqj2LN/U1QyVA5RVjpPoRHnxoIYvOjoaViGkCL/vJ6+p+fF0niOhfL/isATnrbi8k
         5MQOzFLPnA87HzE5vFmB/d+Cd7VL+4CHczzTkap/WT+C+0sfawo/nEYk4beV4I1VpO
         LhAPqug66tzfq95VOAQwJ1VCGgx7QPn11bbwsDh0=
Date:   Wed, 10 Jun 2020 11:01:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: Add driver for cros-ec-regulator
Message-ID: <20200610100155.GB5005@sirena.org.uk>
References: <20200609080001.121499-1-pihsun@chromium.org>
 <20200609080001.121499-3-pihsun@chromium.org>
 <20200609111919.GB4583@sirena.org.uk>
 <CANdKZ0dDHo-bjX2AT0GiTPoDmY2jNNSGkTcGb-f9j1mPoecNkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <CANdKZ0dDHo-bjX2AT0GiTPoDmY2jNNSGkTcGb-f9j1mPoecNkw@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 12:31:53PM +0800, Pi-Hsun Shih wrote:
> On Tue, Jun 9, 2020 at 7:19 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jun 09, 2020 at 03:59:55PM +0800, Pi-Hsun Shih wrote:

> > > +     int min_mV = DIV_ROUND_UP(min_uV, 1000);
> > > +     int max_mV = max_uV / 1000;
> > > +     struct ec_params_regulator_set_voltage cmd = {
> > > +             .index = data->index,
> > > +             .min_mv = min_mV,
> > > +             .max_mv = max_mV,
> > > +     };
> > > +
> > > +     if (min_mV > max_mV)
> > > +             return -EINVAL;

> > The core will do this for you.

> Since I'm doing DIV_ROUND_UP for the min_mV, so this may happen if the
> min_uV~max_uV range given by the core doesn't contain any value that
> can be represented exactly in mV.

This isn't clear from the code - I'd add a comment or move the division
to be next to the check.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7gr5MACgkQJNaLcl1U
h9AolAf/eTZkwPoTpTJOje0SEojJboSMq6jnPBcN1uABzQD2gXGjHQvvU1GhaqB4
S5ohE7KiXR9Vy4wHzuwRevEizFjt7KWXWUMa7r9Mb9h/e47hOAsDLctXSNaSjvw9
SE2h/mAM6Ue8ruHFmvGCxqTMcirlTbe1aLUgv+LhLKl42K+do3s99XulJZJFICdu
Tw3RN8AOIVyxRn9OX5+Q4nMWujsptaZHs+IYwZZr14C/nME0Fd2/vvseyLWOVZE/
RkpdvunHM2MygVFe5SvuC1xS0NW2zir4kjPoTDn5w68ChrqiY+ZL3Gok6R3Dbs+9
s5YQBZasCzIDCe4iAEMkPsCAZ+WI0Q==
=z8Nh
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
