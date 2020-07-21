Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D59208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595324054;
	bh=wRyOkf5BPZx5EhcERYgIJKjB6OMOn8b6JxT3/6io1uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vxYrZFeFlY13RhUAJNLPJ+bEh34BGwUr36465kODvhmfdKL8TmieHrPLACfCPMweN
	 v7qXhnZ74frY0cpule/9YCkyq4BkuRRrH5ArPeUGy1CaBOj9UM1+BYInuWbUC9hZaA
	 S4MDsOXIZmpEG01F7hZ+jVpDmpFthIL9jxfUQfTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGUJeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:34:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 826942070A;
        Tue, 21 Jul 2020 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595324052;
        bh=wRyOkf5BPZx5EhcERYgIJKjB6OMOn8b6JxT3/6io1uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUwFh+akV6bxsDn1GyNoMZEn5p+yDLf684CgGe64T4TJEu3GBLxg5yF/U6lpq/WaL
         GQLmWOpZNlWyaNxTNb5pzRNCM4xaf1PoLs8EXchYcY2Vf3N1gibdrtQ6s4beURmhaj
         tFa6EcHUBwm2QtdO6rG3ewL86ougrM7mBa6nSOls=
Date:   Tue, 21 Jul 2020 10:33:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to
 yaml
Message-ID: <20200721093358.GA4845@sirena.org.uk>
References: <20200720181202.31000-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20200720181202.31000-1-dmurphy@ti.com>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2020 at 01:12:01PM -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.

What's new about this version?

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8WtoYACgkQJNaLcl1U
h9DBiwf/VkRD3CE9qEXZu/H6d/cKccK78cdx+xjg+aPRtBQUNd1d0VuGIfe0j6MQ
Prpam9rnYKQkVwea4g84t9758PLwMQquSokeMUBhOEAF4a1opT33TKEZxIe9LR2V
43HK6V5NZX/ybjlw3Oeos7OWvJmMfpACqL5C4ceQQ2phEPGpe3TuAKx2+o/Dnk0Y
7EHHI+RqWZB82rpeOCngyKUWjxaetSBt+k9k8QxvP9ubgbQzXvn40rJt0VivIuna
uBqdWKRTHHaev3IGr+cpBRRiH/TTZzZroQhVN7ydhYdtXsikuGBKg2/Xd9OJ+L/J
3vTgCaWBlVkpMLU6PaREZwy7rvUS3g==
=LJIg
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
