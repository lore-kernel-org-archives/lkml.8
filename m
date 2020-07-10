Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C962078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594378900;
	bh=t2OkFWpO6Dj6L1WHZfyWTIVo/zLKergBnvDDiPfcHZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GdfEtbvPgooVpR9DSnALBwJwh35O1p28zc3YLWBjUEXj2hVTfUOYtZJii6h6RefrZ
	 JAYuC/kSxJP7+o9Us+/e0gK+zf1znvIdb1XR0lQFrW5NHoBQB7XDSILMaJFoHqFc4a
	 0AR3K69weoP6TKkLXgfNO/fbAPhrQ9CbedtmJqlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJLBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:01:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3231220748;
        Fri, 10 Jul 2020 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594378898;
        bh=t2OkFWpO6Dj6L1WHZfyWTIVo/zLKergBnvDDiPfcHZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bH/y4h3ub/d4lR4r9H7Xc2aAo3TViXaIR38OXT8RJIAIyaKuzrBHj6ZwEzYvmwBXl
         1DLzsEK72m5k3oGgHB6rc8kYTp76SxYKgnYoJJNk7S3QwgGSZz39roZscRm6M6x7QP
         MQXXC2AQaSWpQYcPhSqtNMf5LbJisNuURy0vVRrY=
Date:   Fri, 10 Jul 2020 12:01:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710110132.GA5653@sirena.org.uk>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20200710100558.GI3703480@smile.fi.intel.com>
X-Cookie: Use only in a well-ventilated area.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 01:05:58PM +0300, Andy Shevchenko wrote:

> Hmm... Can you point out to where is it? I have rebased my branches on top of
> Linux Next daily and my patch still valid.

It's in the regmap tree, -next only gets built once per day so you might
not see something in there for two days.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ISokACgkQJNaLcl1U
h9BM2gf+PjNZjQnuSKv0LdMCCvSgolet2/go8QsLi2mqTvyJUeSkdHxvOskWNaQS
+MhT6TWoc8eUdvAPa8PFFGE4w1trYDXFHMKh5gm6VjjOTACo0kIOJlecJ8nGGPv2
aOyETI3hGC/FK9F0ypczuYAK5EMQ6tgJTqFzkwfUJMZ97ZSJqtuzasCyaQjr/H3x
Eojt9YUNYsqmPsDNCi+4Z2tUaUpc6BqLD6aOlbSejGdmp/2Xxi/FBIt0Pdaz6fgl
fLNB3dcPc6NBTo3JTYZ8eEjJgfZCRldcaEJXXviTmxHNxTBjCPpw+BlFlUbz7nM1
j3vy6bOtb5aflpnnMGTFIZ9GIr81YQ==
=pDOC
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
