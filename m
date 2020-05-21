Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD3C20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590063639;
	bh=ibFoIIyMF1Cq5K82d+d9TeF08+OR/OuKj6IPDBv1eCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQmfh4sQj6z8F5rXlj7M/pAMubaj5Nc0d6Gh3ky+Tw4GbOu1X8Bgzdu+5eAr4lo6H
	 Zap/aaZl/rhvHhtzNlBAwXDOa/VdoobYA2+W5gUTPXc8UG1CYCUTh6atTOrBPPaNDe
	 +j/m3dSvpZZV0MsInVy5SQYGx5Ap0wbtr0eAS2zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgEUMUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgEUMUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:20:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5702070A;
        Thu, 21 May 2020 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590063638;
        bh=ibFoIIyMF1Cq5K82d+d9TeF08+OR/OuKj6IPDBv1eCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6sdA04cTnvXYoly+hZLJSJzYe2wasbfZ02IuM3wTto6o/oXeugLu+X+5sUrImmdA
         +XeyGwWZyprjvvHR395Cpu/yvFuSgjMoJiwts0sj7M+0lU9rLk07V8SXNnJG7k6UHK
         9eXkLBREWeFM4y3W5VdZgw4K19OjDmMvaAfJULZ8=
Date:   Thu, 21 May 2020 13:20:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200521122035.GB4770@sirena.org.uk>
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
 <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
 <20200521105646.GA4770@sirena.org.uk>
 <24b0297c-5c33-f690-9514-68b76fc2c9ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <24b0297c-5c33-f690-9514-68b76fc2c9ea@linux.intel.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 08:14:04PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 21/5/2020 6:56 pm, Mark Brown wrote:

> > That doesn't address either of the issues.  The removal of the old
> > bindings and addition of the YAML ones needs to be in a single patch
> > doing that conversion.  What I'm suggesting should be done separately is
> > whatever changes to the semantics of the bindings you are (according to
> > your changelog) doing.

> You mean semantics of the binding as a single patch you are suggesting me,
> right? , Thanks!

I mean that any changes to the bindings ought to be split out into
separate patches, if there's multiple changes it may make sense for
there to be multiple patches.

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7GchIACgkQJNaLcl1U
h9BBmwf/TAx18MCyJnkJz/cUdXiSZ/+3KxoqHwPbafjuXp6qJnMplcEAKFr4GKRQ
PTqDr6x+1BLU9teHxr+zvvTjM291hIaF9Nvrf/UxkM3IpOAmBUSzPV1frd0hN2sZ
eGhxkeI9d/+Vke4/koh+o4e89xis1Rk197LwrBSCBqS17mnXXu9CcJxxCOAmGlQn
0PPfp8vz+tLT400Cf9QaP5U4cpKom24uz5GbjmOaq7mIHs+U+PZdjFJJ6gxKxV3K
uUsaW2MnVnkPmgQlC0jMdaOYvxwduiCYCH4nT1zLLs+iSqJkoOiB4uMI0/QuFm4c
kPWfhUXiqDm2eSA4sTcD4e/5YvDhfg==
=I4eQ
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
