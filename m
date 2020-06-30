Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0420760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593531310;
	bh=hbapiSFW66hXpzycU06z2LcbaJeuNN3dsr4X1PHfJVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kaPsnbzvecIKtBvZn2i97tyFrnOWpS3rNnOAIccaLxFB259ZyNAqSZI/Yys38BjjP
	 eGVROVCp9ihwsNUTlYKnLIKTZoxyWn/FUYvOMSdu58r2jeHFwXa0tolYw0dmfDURjD
	 DARp+Eb7Stk4oxH8VyUnob4dhCv0UrS9G1JR+ErI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbgF3PfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgF3PfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:35:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8862074F;
        Tue, 30 Jun 2020 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593531307;
        bh=hbapiSFW66hXpzycU06z2LcbaJeuNN3dsr4X1PHfJVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PM1OchYCo5d7s/0dHTzAp4CR34sFUpC/KwQRFA1wf5y3DgJ2TDfgOnlwhKQSjt68Y
         hGrO/f+IG48lqXSwCdDKdqlNMgvJstS2UzryEls8XBeYvuq0lwKeyFxIeHZy8y9h6y
         nIaWMRzoHl88lgYKQ8prc/16WQ2SfzW9DP0I5b3w=
Date:   Tue, 30 Jun 2020 16:35:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 1/4] driver core: add device probe log helper
Message-ID: <20200630153505.GM5272@sirena.org.uk>
References: <20200629112242.18380-1-a.hajda@samsung.com>
 <CGME20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9@eucas1p1.samsung.com>
 <20200629112242.18380-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Content-Disposition: inline
In-Reply-To: <20200629112242.18380-2-a.hajda@samsung.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2020 at 01:22:39PM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for
> error printk some message if it is not -EPROBE_DEFER and return the error.
> This pattern is simple but requires adding few lines after any resource
> acquisition code, as a result it is often omitted or implemented only
> partially.

Reviewed-by: Mark Brown <broonie@kernel.org>

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77W6gACgkQJNaLcl1U
h9BzwQf+JzNlmtiYmNXjlnt8XG+LzxdVCambFM2BriTiK4kqcAHo44/jTnkfgO/7
uc78IN9CohQgalmFe21k1ST2/FBz5Iy6HgnDbPiakilZHPLqNjS9NaEzo7w2tumc
Ntr1S9+KjvSYaosJdrhbr+OAKPWEVyt5yZ2wGVwoPNgKu3txHYCXFXNJtLsXcg0b
82yJY6BXSpzj26nm02UwZ/eDDtfQaoNDhcrAh9JmmZd/DytsbC2fBayDqrhmF2PS
4vRHYPFIArvxTGY/4RQjw9AWYy+Q7Ns+nYDbzxKBfIMremBWu8E9mr741PkPdKVV
LXVRLnx3tFUTwOl7loakReFTTCRx2w==
=yPu7
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--
