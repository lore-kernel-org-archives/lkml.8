Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B83C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6617B21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583152594;
	bh=80IAKKurJipGulBY6qxmnAmtFvPSGi71jpYvqjCAfTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e9NXxWAcUJ4vkjv39ERgb22X121ZoVVmllIbOcB46m8eGHXU9edWa04UZ7vVxMVrL
	 T9dfM3oNM0KUPvaB1cv+mGyidg2bMxzappplGI572wxpKEcpNAx4W1irMe7TcH2GOI
	 5GcYQS0iR7U9xV6bZyaotSGzALefzCXb/qMHaJqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCBMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:36:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgCBMgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5453C2F;
        Mon,  2 Mar 2020 04:36:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAB243F534;
        Mon,  2 Mar 2020 04:36:31 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:36:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Applied "regulator: mt6359: Add support for MT6359 regulator" to
 the regulator tree
Message-ID: <20200302123630.GB4166@sirena.org.uk>
References: <20200226114706.GE4136@sirena.org.uk>
 <1583128432.18202.3.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1583128432.18202.3.camel@mtkswgap22>
X-Cookie: Whistler's mother is off her rocker.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 01:53:52PM +0800, Wen Su wrote:
> On Wed, 2020-02-26 at 11:47 +0000, Mark Brown wrote:

> > ...and dropped because the MFD dependency isn't on a newly added driver
> > like it appeared.

> I am sorry to bother you. How should I proceed for this patch set which
> including regulator driver and MFD header file ? Please give advice.

It should be fine as is once the MFD bits are figured out.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5c/c0ACgkQJNaLcl1U
h9BcJwf/XJDjZQSsmGlG/Lu26eX7KcXXJnlMCF2ky0Y78TBxx6kwwWXCDrf/wbRU
b5xFLQVZeFjfVi7TB7QaWrlXQT58SaxznkbRaQnOl+UbqnhWeMBCQb5HtRAAicsy
zNCgd14C/YSeR8GfzEAulauMaITxBtSSYeANDBU5r7a/Vgxafb5sUyS8wlGBYf+X
CRz7e8h28Q3PjezthC4l8mETSyKU0XYP3GCf8GIPoagDpRnxTI0FulifHS4iaDz4
bT8kJwFnBR1Y+ynuAEoEbkfExesTzpmQANv1+Uyi7pcbEtviTVa9kntmBmRcB++S
xEqCpWNPNM37q+Pb2PGzi4YM2vPFYw==
=4c4P
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
