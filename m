Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE0F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589797726;
	bh=+YGk6dL2hSvWpnBBEFh6HPcR9vkfc40o6qCF3O8vo9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxP2R5kpc9WKjCQ2UWMkB89jARBRb7F5DxG2Fi4Jn+pRSPL4sDMlifBkDm+ysTdDu
	 /P91dRS3vYHoMJJQMEHIZsbINsPCqJEQWv1F0S5QIlPJBKnbK+tTa6Hmn3JpybGFl6
	 AYDfpwvGsaHZ9dx2McazK3PueblVVeSCYyMQpnKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgERK2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERK2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:28:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8280E20657;
        Mon, 18 May 2020 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589797725;
        bh=+YGk6dL2hSvWpnBBEFh6HPcR9vkfc40o6qCF3O8vo9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inV0xw/yP+AYYFdZ1BuuNM7/1VH+Q+dd0QHmLETLqjEVR3ZOPCSjdkiImgkzy2YQk
         jYJB1Kni2sVJL+tHxTLLwKc98SlfKvleHOb3R3VOcJrmEPHIho3npffSmVkV/QT82N
         B7dKaaRPHPwqKogfvK0CYxeErPYq8QQcIbzGOF2Y=
Date:   Mon, 18 May 2020 11:28:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Message-ID: <20200518102842.GB8699@sirena.org.uk>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 07:38:25AM +0000, Vaittinen, Matti wrote:

> What kind of participation would you expect/appreciate from me if I
> added myself in MAINTAINERS for these drivers I authored? Any

Mainly just reviewing patches.

> objections to that? (I don't really know how MAINTAINERs entries should
> be added - and I didn't [easily] find up-to-date explanation to that).

Send a patch, often along with other stuff that's going on.  I'd guess
MFD would be as good a tree as any for it to go via.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CY1kACgkQJNaLcl1U
h9DS5gf/WQjYv1grGtIBYK1rpSs7gXfpleup+UFPEQu4QIzWLAAEETOdXQc6gPR4
c5aF/eCnWBX6G0qiBfVD6jOwSWhCZpQ0AhNeIMI62sneLdHQchxm9in0F6FhiW1i
YOoLt1IHT97bmc/R2vWPAczZGHtkUlRr5nWhI3q+R/Iq+KEDvN/oaqn1ZbX9ttaZ
7YGfPT+3D7f1yZhggGMNGUWzgn49gE6yQxtJOBqZjw1IsaFSmszgs+FTWz7TdFNf
/R3z2BqmYR4EgvWwFfMziRFRzrUkVKBDW+kZLpo1LcO2rJ5ZBE+Se5dmnFmv5kMx
6TJHyLhLLPqoSY6PdpB8qiBes5bByA==
=0Mqj
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
