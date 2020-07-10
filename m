Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2035B207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387962;
	bh=LvFpSzqSKplJUBC4M+6P3hI6hqjY33Q33k8lxTdHleU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YFITBJ6bnHjQJmgIC49hCfYUKVCNX6f+LR4bhciGQ7YNeOczDuS5v2aSPQY/zrcQg
	 LBLSjY+L1ltdLhw0V7AHaP0tkMU5dc2A/y2Oz2zgZ2q6Mw0+GH81/ur14M2h+pnNu/
	 vhAFPNa8rBnk82yT7Iedy6bvwndjAU3NqTD8w5bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGJNck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgGJNck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:32:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD1820748;
        Fri, 10 Jul 2020 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387959;
        bh=LvFpSzqSKplJUBC4M+6P3hI6hqjY33Q33k8lxTdHleU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBbOiE5hhOsBivO33CLPtIU5TOtJfk+tBMFKLSF2X16VVkk/+wcPWHpsudr4+EugE
         llAdtz76rk6lGxBV8gi6lc7Dn8xKcXOQca0TwaOCABidwlXXVByqREpv1zqhoIq+k2
         bkljtQSz+u5p9RdemV0/q30rEZRUaG0q92coJ/oU=
Date:   Fri, 10 Jul 2020 14:32:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-ID: <20200710133233.GF5653@sirena.org.uk>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk>
 <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk>
 <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20200710120856.GD5653@sirena.org.uk>
X-Cookie: Use only in a well-ventilated area.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 01:08:56PM +0100, Mark Brown wrote:
> On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:

> > You mean it's being synchronised with git.kernel.org, but not yet contains that
> > patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).

> 5cc2013bfeee756a1ee6da9bfbe42e52b4695035

Oh, I see your patch covered a different bit of code without covering
the stuff in regmap-irq (which I'd just handled when your patch came in)
for some reason so the changelog made it sound like the same code, and
at the time you submitted it the patch was incomplete.


--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IbfEACgkQJNaLcl1U
h9D8IAf/VP45nyPEwll3Z25cy3/wht5HFrNOUs744RQ7vWr9oS+b4vbibjm+WX4t
gFAheMYtBrSnMyxzmloQE5kwkrcxBtnxFMMxjk83LMM4P5N0vxHsF5u5w30Rf7+v
/4qBxTBx/+kPRqoEO4sM/qvUvTmHPRjlKcz7k9r8aM/hYzdflv/YUPQQH0GMZveQ
pljk5YHkLtIfoHbp+B9Zh7+quJvT1msNJuLvoTC+9tDO4ks1HjvdlfssBmqJRQSs
vH8FuRv0Vh9emTW7d+JBhUn4jFtXfxvn3znVf1Y9qIzYU/6avE7AfIx0qeaouL2V
i11CB9utaDLxPDXUGUndr6mnmnKHgg==
=1MOn
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
