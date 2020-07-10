Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25084C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50D520748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594382945;
	bh=C6ZrFNaSgsStk6Vp4QuuZS4cHOzAtYmi7kHPu0LQ2dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p7UomkUf6qLDb0dM59wiACSwv9RLZmU4CvvO+DyGUCGebX8SinVdFjoSvVcS6Z1JG
	 158x6cRmIqriY1Iy12dJsbyVTTYAXbkprNH4YCNU4TURO2m3itLFymTZsHTZedAQ+9
	 8hNgZvbhJFy2ywOP43yVCcOqJgIbcl3W1lJ7XEYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgGJMJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:09:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73D820748;
        Fri, 10 Jul 2020 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594382942;
        bh=C6ZrFNaSgsStk6Vp4QuuZS4cHOzAtYmi7kHPu0LQ2dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zEIlI/nG1fAyNQ9z/oMsdrcXmpExPGJwsmAUSAldCzMxRvg47aKJAIQQZM2rmpvQH
         g7ZzOl/jmJQnvPlWiKsoMC+NluW2L80OUensyQt9ClqkU8uexr7U7u/u3m2EjKqDUY
         /vVda5f6nap9xY9p3kaTxMRnwLIDru7mG5a5l7UQ=
Date:   Fri, 10 Jul 2020 13:08:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710120856.GD5653@sirena.org.uk>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk>
 <20200710114622.GJ3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20200710114622.GJ3703480@smile.fi.intel.com>
X-Cookie: Use only in a well-ventilated area.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:

> You mean it's being synchronised with git.kernel.org, but not yet contains that
> patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).

5cc2013bfeee756a1ee6da9bfbe42e52b4695035

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IWlcACgkQJNaLcl1U
h9B4ogf/TR7eSMOw53H7tkoNjFNyQl2ypT8fAdYrxWEXTmohVGy31YaprJmWu4bk
kr4rK3xlAnRNtnh8GCEvoeSCzBnW2S+0tug5kpydkLfkgSVPo/BjYzMTnjCwSs1C
/xpqJ893N8TY6Vfyl9Vjb8icB17uPG3ele1gQAxDCxV9CFbWpvl5B48xXpsdCnXE
Z0xvV0/z8qEXzMSrxWMO4wgYV+yRNfnZ52nIJSRrFNYOHWPp7u1QxkJSi3xAF9NY
rClsWskXhfLTAXcF81wgH7bhyOVqO0r6IFBPkoBo+PU9aG6FdrqrD4o+mPhT8pvu
DgujO9jG7VNvmlERCJrEYDoCr6QowQ==
=NjL8
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
