Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5860206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579626420;
	bh=a2HLQ4r+m6XgAaQ7rRdk9QRf1WK+fkPWNFq8ecE1QKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P5vtdmIOvf3euI4xtMcGGCqE8VvNDaeRQfG05JUksarjNoA4l3kTwhGpGncoavFwz
	 WoPJZvN9s/14Vb0EYjjfsRd32VCKa/L3agO+OXsCgUrDe53ZNlCwxISWp5b7Qc4c7E
	 u3sANLUB5tygmXI8VUld1H0lYuXnlqvY4Yjnm0Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAURHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:07:00 -0500
Received: from foss.arm.com ([217.140.110.172]:46040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgAURG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:06:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC40F30E;
        Tue, 21 Jan 2020 09:06:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3190E3F6C4;
        Tue, 21 Jan 2020 09:06:58 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:06:56 +0000
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
Message-ID: <20200121170656.GI4656@sirena.org.uk>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121162157.GD4656@sirena.org.uk>
 <20200121163312.GZ2665@lahna.fi.intel.com>
 <20200121164515.GG4656@sirena.org.uk>
 <20200121170022.GA2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20200121170022.GA2665@lahna.fi.intel.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 07:00:22PM +0200, Mika Westerberg wrote:

> OK, thanks for the clarification. I guess in this case we can probably
> just live without using it, if that's fine for Lee and others. The new
> MFD driver itself is ~500 lines so not sure how much regmap would help
> there, and we only expose two simple functions for the subdevices both
> dealing with 64-bit registers.

The usual motivation is all the diagnostic infrastructure you get with
regmap - tracepoints for I/O and the ability to dump the register map in
debugfs mainly.

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nL7AACgkQJNaLcl1U
h9CYXQf5ARVExYEyXhd/b8vqn9kwQ5n79Izrai7EPKOa/3PxMUBu1546nympiQTk
AyGalWpOBNIMs0/CqVxUcytTvcVSVBJ80dN6XA3ZcYqaYVLB603cgxrXDgarnh6k
TjA/vMZFJklxeOUM4OmTDQHgKKt1gj0v7Bs5mNxUNJbYKfxksrWoM94S/Ywx5nke
A/fmlnV4WkO5x2fVh2A7oHV5HqTuK2+C9bYXsEzSky8Vza88PhTBeBxZ/MXugndy
xOugKpkM04hYZBv/c1/CD86T4fZisCMZeBJ+TIJHE4q7q4PylFJ1ZKZm8lWAnQnC
iHOUsYkSPtNk98Sw4/1cz3UYEe2w8g==
=lI9Q
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
