Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D1C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745720866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582544221;
	bh=r2PiGWSmrETgWx2LEGxivHnEQxtJCs3wPIZoGPYxoyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1TqoZlIqQRRJUMlP4M2tFtaBxf9v/07QDa+eF27alUg50eGYJSOvZvIndFTS9pVrQ
	 uJnV+jwyDcRpdtoTMB6NiLzUDxtnfBqlJ5lbAD2t6a9kS+Jcl+8X75GqCg9N80vmxa
	 M6hTauldwwjVlCYJguYjln0SIb/8rhhAZQMMU0VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBXLhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:37:00 -0500
Received: from foss.arm.com ([217.140.110.172]:35634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXLg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:36:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1234E30E;
        Mon, 24 Feb 2020 03:36:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897CF3F703;
        Mon, 24 Feb 2020 03:36:58 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:36:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
Message-ID: <20200224113657.GA6215@sirena.org.uk>
References: <20200221222711.15973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 04:27:10PM -0600, Rob Herring wrote:
> Fix all the warnings in the DT binding schema examples when built with
> 'W=1'. This is in preparation to make that the default for examples.

Acked-by: Mark Brown <broonie@kernel.org>

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TtVYACgkQJNaLcl1U
h9CNEAf/eNHuOKO9UX+XLz39Z16Ulv5iko14dyR+Uci0d4nowFtBZ1253dv32wRW
pDpU9iu7Ha04MkvyNDFgz5RsgR/jyLE8/t30zbbaJZWwc6XGVI/KCZkvfdNYrAsq
J4NEjRnt/M+HN0ZUsu30SS95/X50PMTLNJ8gU4OwsohVranbzKRqFcoCbbGvpXUw
yP6W5MiCrd3LpU1sG20gJK1ZJQHPO4R3U/sUwyEbJmhvZYJB+KOC2Jl+paUbHrSO
DLZeZ+w3AOroZ5oxxzPMO5033k7K6NI0mA449VtZ6BXgjGuhlMaQCbJFE8aAGWJi
eajjwC/Ufgc8Il8KswwWGa5j9e6ZZQ==
=f6dA
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
