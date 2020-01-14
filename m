Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F43C24680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579015014;
	bh=ltE4O5Iv8exH9g/sXCtdOGBiwtglhDk3vn+1JHo2VB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bwt+vo8CC/i2i3rJbGLGXw0rNckT5MfU+exXzbQpDcbMBydztgaZQVp9d22/6cWxZ
	 khZhrHZZgFzUOwiRJcxrm9yCyd9AErY7ue0vQdZgCR1T0eBA6EB7PxK+umnS+jaN+0
	 txBCAIGcN1v9OPXS1tdgjsCVLFBbaVNV3FU9O38E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgANPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:16:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33484 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K15TeIKz2iH2yNBaQfbFQ/2HZ43ycaI2mrMgjoB89W8=; b=eqqWHZPhE1xW0gJlR8rUqsdv+
        14x7EIh3mp7KCevqvc2W/P5xWtIynG2LI174Hi1s+Cl5gRYWHvrPZXBPtnxUpvTNSMeUEAtZCYsrU
        RXg2EFs3MZ+EQLZGh170vi1j1eAEhv9Ac9eR8jghkcbjKtQ4zgx89uVywSYcPvGB1uMW0=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irNvv-00004y-E7; Tue, 14 Jan 2020 15:16:43 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 22C3ED04DF5; Tue, 14 Jan 2020 15:16:43 +0000 (GMT)
Date:   Tue, 14 Jan 2020 15:16:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: Re: [PATCH v3 4/7] drm/panfrost: Add support for multiple regulators
Message-ID: <20200114151643.GW3897@sirena.org.uk>
References: <20200114071602.47627-1-drinkcat@chromium.org>
 <20200114071602.47627-5-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Content-Disposition: inline
In-Reply-To: <20200114071602.47627-5-drinkcat@chromium.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 03:15:59PM +0800, Nicolas Boichat wrote:

>  - I couldn't find a way to detect the number of regulators in the
>    device tree, if we wanted to refuse to probe the device if there
>    are too many regulators, which might be required for safety, see
>    the thread on v2 [1].

You'd need to enumerate all the properties of the device and look
for things matching *-supply.

Reviewed-by: Mark Brown <broonie@kernel.org>

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d21oACgkQJNaLcl1U
h9CCOwf+K6UJ3dhSHND3Fpdx/IUgRmsJiK2V3jATceFWHdf8/BMeiNDYwD2U7i1q
3086jl6AsX+YoSVr7Y1z7U+i8sHs2E/x/bP9LjOzRAXLya+5rdefN2ngQZq1Deex
AUlEQpjAk186CwzKC1OWLLmbBYRbo/avge9LcYp3eAFfUbv2kjv2QRPII2EspHzi
Zs3Y57WJlZ7STEyx7rHHXWYqEv7IqhlIo1f2xZobE7MFBmsYCjYy9GMMexe6H2z4
zMbp8clRBhJ/+CeT06cbMK5/gPb1biOaPeFndjeQOSbO3hmvfi2F2w32lJZsad4x
qAImcHOYwKX7KXoR1RoiFJO5kVdyaw==
=l7/J
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
