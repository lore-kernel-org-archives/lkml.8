Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF93DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE52067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584025634;
	bh=uPjFqZx/6I5Qs44mY7asg2IZtVGs/xJSbZwp2GMuxw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B+aZ/s5iexqsKIIgVZW1wAw02uRReN/hKHajNoyTLuQfzpaQdVWSlxmxAzWtK1Y4Z
	 XxJOmltFh+3LugllrAHUKQ8Ht42Wdbfxwpwjh3lTd/X+nVlA/Q3nhoeaa4JNTqIKYG
	 8Y9bmKuxuMmwa9GPo83WZF4Kc7O4JsPpSpRi8bv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCLPHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:07:13 -0400
Received: from foss.arm.com ([217.140.110.172]:36456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbgCLPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:07:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D273B30E;
        Thu, 12 Mar 2020 08:07:12 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5667F3F534;
        Thu, 12 Mar 2020 08:07:12 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:07:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Message-ID: <20200312150710.GG4038@sirena.org.uk>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
 <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk>
 <20200312150330.GH14625@b29397-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
In-Reply-To: <20200312150330.GH14625@b29397-desktop>
X-Cookie: Security check:  =?ISO-8859-1?Q?=20=07=07=07INTRUDER?= ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 03:03:26PM +0000, Peter Chen wrote:
> On 20-03-12 14:37:23, Mark Brown wrote:

> > Surely it's the GPIO controller that needs pinctrl support then?

> But the pinctrl register value for this gpio will be cleared after
> suspend, we need to restore it, otherwise, the function will be not
> gpio. See below patch:

I'd expect that this would be handled by the GPIO driver, the user
shouldn't need to care.

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qUB4ACgkQJNaLcl1U
h9A2lwf+KwAx2wKqIxrmgCUh4bwdLI99EGL396CbJ3ww5s7DbJ3LQ8xCoIWyeUj1
3QDZPb1D+ssHLm8NHd38ENdymLKODxBec7oCgPCb+V95fCY9K9VEVuMEutldZK3C
UUn5NjE7VU7lI0ccfW1xWR/36bPOJVVizpNymH3HqffLnJT0yU0OQJnmyoGEi2Xo
QQg0s4ewdf6Tq6VddR457VMUk2B9uCmKBtOeMB2RarLj+KlamJQHwht7W4R1d1qI
NQTntqip/UGSt/SSHci3T+XgNG6Ic1ko+/mHnyrQcKohA4UzsaSz8BK/batfhEqL
HxELrI/BPZLg15ZQ7rSO31bh1Nedwg==
=4ZCB
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
