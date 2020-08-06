Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AA6206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596736602;
	bh=Go2sWZfxTTzTPYGn6XoCJvsRXRnN2EaJUECx0AoDb7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kp13ITPRVd2fmTyaLVVJG0KIdNryQuO2ywactDIa/3fTIC2UJW/e5XYw7o889c8Re
	 lm6WHMyxRHmW6rABpzJQHlS+FSMM6XjoflN6Wirhmvvz6oNaGksfKmvDQwjeRB5Gtg
	 24lUTE5UiBJjnaHVwMusMi0T44m/gI1RIdndRZe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHFR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60833206C3;
        Thu,  6 Aug 2020 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596730581;
        bh=Go2sWZfxTTzTPYGn6XoCJvsRXRnN2EaJUECx0AoDb7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLqr1QNn3UVaZB4dJw58Fzn6f2R9YD+QKzUF/5/drVhZa8T/Y8WslRwpZNZdUKsPO
         s/lgGMSEo5Als7HXZZn4/gdR4PiUdvdcVkQIBin6HT7NvdwPOPbwcvPByzN4vTcAc3
         EjLhMSIM2VzPJKC4VF+W4jAwH1BwzJQvLsOj2Ofk=
Date:   Thu, 6 Aug 2020 17:15:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Do not print error on probe deferral
Message-ID: <20200806161557.GD6442@sirena.org.uk>
References: <20200806155515.3936329-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20200806155515.3936329-1-thierry.reding@gmail.com>
X-Cookie: Hedonist for hire... no job too easy!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 05:55:15PM +0200, Thierry Reding wrote:

>  	if (IS_ERR(drvdata->enb_gpio)) {
>  		ret = PTR_ERR(drvdata->enb_gpio);
> -		dev_err(&pdev->dev, "Failed to get enable GPIO: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get enable GPIO: %d\n", ret);

This will not provide any diagnostics if there's an issue with probe
deferral it'll be hard for people to figure out what's going on.  At
most lower the severity to dev_dbg() but don't totally remove the
logging.

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8sLL0ACgkQJNaLcl1U
h9A+ZQf+JLu+ogtTHXQeHNP5UIbUOInHJJyLt6Pw17nALqc/IYVP6qs1dR+rJ0Pg
LG2Qhmo2tb1cMQAGQXVrdjHgCECdZ3vh+F39ZICxm8FQX/NCaQ8bTQeQ8sdf+qX/
fjpUXQ+FCRMLX7m40nMqygI6RAj+32/HVEvJBTL6V90Pv417kyWz3exmhm7hPR4c
sNxfROheDoBFwGoe3sGYB4AhUTCGYHhifHS3Ue/oBfAz/sHcfJurVK02+R5UC/zU
ZZLMmuMJtJf3CcTa0dI0fTIlijYIl0Lt/IZ2bLJjXyblhSe+tSmaH0+yrM8PNjNz
GRZOnZu99eSBQAFKFLzhTaTg1KkH8A==
=R5xO
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
