Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42402C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443224125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579625120;
	bh=Ik/CK88mI9tbtiS8Bb4Hwl6DxsH/4wSaOKq9CVJU2cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gOisSV2rgEBB1Nx217D0DadAq9Se6fZVqSaTeP5XLu1cJ3G6H13f6fVc5uQXRtt0g
	 +xR5sjU3B+6olu/zhdPbEBIDreCIir9DZJJddkEBcLYukUGSdSWy8zbqeL5VCPKsRP
	 usYIs1MMZfBXjYNc3eBu/qR/GDqOG7cY1GIm/ulg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAUQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:45:19 -0500
Received: from foss.arm.com ([217.140.110.172]:45716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgAUQpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:45:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B28328;
        Tue, 21 Jan 2020 08:45:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53C623F68E;
        Tue, 21 Jan 2020 08:45:17 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:45:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/38] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200121164515.GG4656@sirena.org.uk>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121162157.GD4656@sirena.org.uk>
 <20200121163312.GZ2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20200121163312.GZ2665@lahna.fi.intel.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 06:33:12PM +0200, Mika Westerberg wrote:

> Sorry about that. I included you because there was suggestion from Lee
> to convert the MFD driver in patch 37 to use regmap but the registers
> are all 64-bit and it was not clear whether regmap supports that:

>   https://www.spinics.net/lists/platform-driver-x86/msg20652.html

> Looking at the regmap API it seems to deal mostly with "unsigned int"
> which does not work well with the 64-bit MMIO registers but I may be
> missing something.

It should work fine on architectures with 64 bit ints but otherwise it's
not supported (and doing so would hurt the API pretty badly so I'm not
sure it would make sense but patches welcome).

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nKpsACgkQJNaLcl1U
h9Bt5Af/QyzVXCniWdmBKvrgQk57SA0AWT37A8AaOWRRAWBF5VU7EHCMfBJDto54
CtZB00hbRMlbyw+NHfCmKRXaWp2KAqxaUJWA3gIDZj7CSKlDZdX7OukBTBahWKxB
nRKOlNV81hPjFaxcOyrBuPux5XPcnXV0MiUJTJpu8GNIZmqX2aVGLFpVbjBRgo7p
Ncau9lZpCbuf95g4AeAXQ9XD53fxscYLgzK+DARcHzduLLqfbszJZKkU4kocdxVc
j8INw6jUPr8ZpvB73D42GqI/eUMYmLd3QHJRU/eLMQCD351ngFM5nftFeYmZos7i
LUr1CryLRKePqnHZS0ULQRj+8tBZwA==
=+u+6
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
