Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D924C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A6B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584125759;
	bh=UlTaerllM47iYcjXS8C5PL2oou6TgOmYUpkeKI2kt/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v3DkwdbeiNybB4YLdv1eZqwNnChCmhn6/5c5FGXMh7aMItJQ+iQ/bPslWwv6u3/QB
	 F4GL8vQmjCTty2QvB3fSDKRg1ouM2yoMFmnAYDlmsW/x40QWj+bFsUVr+82B/aMnLf
	 VDhWijR3p6FW/501dAnBH29EQi5gyStkvEHgi5Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCMSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:55:58 -0400
Received: from foss.arm.com ([217.140.110.172]:34896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:55:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2D431B;
        Fri, 13 Mar 2020 11:55:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967893F534;
        Fri, 13 Mar 2020 11:55:56 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:55:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc
 warnings in example
Message-ID: <20200313185555.GM5528@sirena.org.uk>
References: <20200313180543.20497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Content-Disposition: inline
In-Reply-To: <20200313180543.20497-1-robh@kernel.org>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 01:05:43PM -0500, Rob Herring wrote:
> Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> when building the binding examples. These were fixed treewide in
> 5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
> warnings:

v1 got applied, could you send an incremental diff please?

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5r1zoACgkQJNaLcl1U
h9A9xQf8D4qo5BE4kR0B6Xezo7p/pdK91FrKE6y5FfQTFK+hVGgN3ysMlWcUxwsR
hB1NLaFz/0f4w9iHu+vqbd3kZVt6WleRvq/MLJEVI+JHQEIKLfr+XGch+30iPwM7
lKwLR6O4N0XXDzXAQfXtsM/mP2NQo5iyEtlXIVAn7FI04zuzIuYu+TvU8XxhWn1P
OTg9c/D0/5P3fakLSPHFFVRTRnNBqgVrI+zh4P+Be4JNjRniOnUBLooa5hu0pWWE
+FyalDVC07RI/LTubgW+S2fkxk5HVjNIgrgOwYkd9sCFvshCO+3D/J8bYRnnRNub
Uxrn3/ec7Vd/yXBu2B0gpAQyqI8K5Q==
=pQ/m
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--
