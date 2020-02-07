Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27176C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E7020720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGNw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:52:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:52:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 0478629567D
Date:   Fri, 7 Feb 2020 08:52:51 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v4 5/7] drm/panfrost: Add support for multiple power
 domains
Message-ID: <20200207135251.GA2952@kevin>
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-6-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20200207052627.130118-6-drinkcat@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> +		if (!pfdev->pm_domain_devs[i])
> +			break;

I'm not totally familiar with this code, but should this be a break or
just a continue?


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl49a6kACgkQ/v5QWgr1
WA1bjxAAnLaxUD3zjRv8cz282ucvOS+zEVrsYCEtVHJXAXsVa6qH9W4rTswmRCnU
0xfwIFqVmUch1QzZgxsqX42RrVZPNU20eN1qspQgEfXnIttVsTSzvgnEwHw22TCn
nr/f+tKDnIRFzz4PZ9ywTyzLBJNYJwR00QoMKTg//184tvoAWDrm0k0h7iVx7X96
mymCuf6jWpfB24TlTTvcXTCDUcoPVWZqJ1rppHtVV10E0a6VRKRURli75q6d4uBU
T4yqc02JSUvyaOm8KF5LNce0FOGeEMiQFfEG4jRP1y5FYVuPOoJciB3Gtv7JSeaa
Tg0PCBs7BYNbIlkLcxYyPjnwD60L5l1IxD5lKzF0DJJucuqoRQP1gpz5kZaLmEOj
kvXi8P0Bx87ZaF2ghgX+l/IKFLiwHpLfE4BzG6VMLUSE/Nher4Tcvz7+3AbsTBhD
pJ5tcommgF4KYUkEZ7rfNDD1G5f6h+c7yNMpeUOIadPyMY47NIpr3TBCpZJGiJ02
nSwt3k/7Y5Hig0OZxypHVgqyBD3FycMPoQpelBC4/gZH4w59DKlE42VBqc8977m/
dv1vv3QPS0w0RNKO4FnH+N63RnHovNNsUbNAsQkS7GldSGnbCQymGHXRniSdO7XT
cbs14xJbzZ09gdyTGmybAsL1RKMT1YqGG1/3RSeS7bSOwyFX8Wg=
=dMt0
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
