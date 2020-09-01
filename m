Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CCC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44BE207EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598958365;
	bh=1N5PyhS/BGmBx0JVBHF8LvbFm146xKOPgQ9iDyG+GRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TPYTI/zIxqpibuhTm1Fhk1YHEHeP+zRa8k+KzGkZ22Fy2yrwnuVi9lQ/QUZKzvh/d
	 m7MioMHjLojQfmZxaZtgLfRoisc8P+MJQ4kz3S/txUmH3MiaPE3273GW5DSLOIcxOp
	 3lLKxtu+Nw9AM7AVEKkA8ue4YyJ30lVq+dK9AYtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIALEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgIALC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:02:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49511207BC;
        Tue,  1 Sep 2020 11:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958178;
        bh=1N5PyhS/BGmBx0JVBHF8LvbFm146xKOPgQ9iDyG+GRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vc83uoqyyYpxRXnZZUNdhPSjgXFp3bmeg0HH91zalFcOkes6cpjHR86F2AUiZz5FD
         HcMMll5sC76UJLCgtJB1US8Luvp5+D4tD7U6RVEZXs4/yWpsZGT1R1f/C2eRNpeu7r
         4onqUOEFmyEZYEkJdoM6vqlwv+qeWRpwJomWiRdU=
Date:   Tue, 1 Sep 2020 12:02:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 06/10] dt-bindings: sound: samsung-i2s: Use
 unevaluatedProperties
Message-ID: <20200901110219.GB6262@sirena.org.uk>
References: <20200829142501.31478-1-krzk@kernel.org>
 <20200829142501.31478-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-6-krzk@kernel.org>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 29, 2020 at 04:24:57PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. power-domains) so use
> unevaluatedProperties to fix dtbs_check warnings like:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9OKjoACgkQJNaLcl1U
h9AQ3wf+PZ7EGqA0jy8GWulN+OYy/3M5viE3hsFSmvsxU6gKIElo5Yp2d+q/tEKE
mY+huCPYgKRGZqeCspctFfblzr1P+IpvZVnBZYqUGey6GbrfX+3dB0VcIC83wrDu
jIgbmH9ulAuvwJbEbREZwppvlEta7EuUSGXgW5WxLoroXxrIwaRik6n1yNKTGOkD
Pd9Kldslbup1tA58JcajT+CTEnZ1tqunjbbTbXBcrLdqD6c9r+9JoPmGPHk+DtjR
Vs6qrJu07VpQiXkerzeabkqDg2RGK5w61vu+omdj83xmjMXVShEyBUHyjLRZLOgS
LzSfzV0ezqWLFBoNYJLctbW5mvzD4A==
=rivD
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
