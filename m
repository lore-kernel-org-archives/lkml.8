Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1138C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46B12084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582563545;
	bh=cueoM+ovsMPLeotpoauxh/vLT17vn9Wv8o2BDJ65f8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eobfI/I3rEbg9doJcN9IU/17dl90ZrDH416POfT6WH5676Al2YGSqEOmCmqIK2twX
	 HBJhW2EMXYx7XrCN77duoEsmvG14qDRP1rYrH0juJfFwIa4gqZVyBQuEUPboXL3rS3
	 wgx+SCCxQPNqR+GE2n6BZ+C6pA4JxwbDNqdqersk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgBXQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:59:04 -0500
Received: from foss.arm.com ([217.140.110.172]:39880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgBXQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:59:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEC791FB;
        Mon, 24 Feb 2020 08:59:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71D7A3F703;
        Mon, 24 Feb 2020 08:59:01 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:58:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200224165859.GJ6215@sirena.org.uk>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20200224144048.6587-1-jonathanh@nvidia.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_pwm_get(). Given
> that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.

>  		ret = PTR_ERR(drvdata->pwm);
> -		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);

This then means that there's no way for users to determine why the
driver has failed to instantiate which can be frustrating.  It'd be
better to at least have some dev_dbg() output when deferring so that
there's something for people to go on without having to instrument the
code.

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5UANMACgkQJNaLcl1U
h9BiGAf/ZAVaOOpbqGhitjs7tP8A/g9x/elIDmribdXRTC809OYbjyWsgBPgUqJE
E8WSPABeY9t3f9Ie+fcrkidjuUShoOf7CUoWTRS7dba/BICLSFBo2NWcwBwk56gg
qLeEVL37SL4BkipNJeBSh5pXW4oPqyytURkDPK2+7qz0myDw5DkptO3+2F9LNZuI
Ywl4BGnW3pgSHBU6jgHwTQHvvRZDSjixeIuwuNu/3FkLL3O9HceuSZ3LumxXxP2j
N5EUom2pp9dGhkzMZbw/nS0bZqTrlDKOBNIRdKHtYrglPiHKj8P4w4sEzhNYLgtI
bfK6L0eKoKsFz9d5ju7xTBL7e77/yA==
=uw3Q
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
