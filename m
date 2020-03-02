Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183A821D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583152744;
	bh=C7a6EUgZA8cgtVm5DXvgq0axiDNM2HTgCWAAXg+n4w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Idj5n+D9R9+1zW/ePxlmRIJAKIHKwVt4s8gKdfBC+9Ffl/jDUU47el19ZEMth8lE
	 1Tj3zjjpdIK5Ke4vKGbp+yGr60nMHIvMgacBQytPG8fZ/XCZMz75zU0XBOHAZeju+Q
	 UpoiNxaxoDL1bJcfUpF9AJxCxjoM0MjKzsxHdc00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgCBMjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:39:02 -0500
Received: from foss.arm.com ([217.140.110.172]:60334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCBMjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:39:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F172F;
        Mon,  2 Mar 2020 04:39:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 444823F534;
        Mon,  2 Mar 2020 04:39:01 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:38:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jonas.gorski@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: bcm63xx-hsspi: Really keep pll clk enabled
Message-ID: <20200302123859.GC4166@sirena.org.uk>
References: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
X-Cookie: Whistler's mother is off her rocker.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2020 at 10:38:38PM +0100, Christophe JAILLET wrote:

> To be honest, I don't see why we need to keep pll clk, or hsspi clk
> enabled during the lifetime of the driver. My understanding of the code is
> that it is only used to get the 'speed_hz' value in the probe function.
> This value is never refreshed afterwards.
> I don't see the point in enabling/disabling the clks. I think that they
> both could be disabled in the probe function, without the need to keep
> track in the bcm63xx_hsspi structure, neither during pm cycles or the
> remove fucntion.

If the device has a clock there's a good chance it's needed for the
device to operate and that disabling it will save a little power when
the device isn't doing anything.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5c/mMACgkQJNaLcl1U
h9Cwewf+LaiDuAFWakLpTKZ/xUwqWqdMeVhPJMgEYCToIfMYYsMsBLLvE57s71+Z
Se4OYGwCbmz75sJq7KZTHEt7TStQ0Wfwtb2VTQ6e1nhoT0q6Vh/p0Xos0dapsFkw
sERlnAbZzf0t9rrXQB6yLjBPnU9X8iS/tatAOYylTZb3g2KO31ZxT1/jg6op1+us
bK4fcoLF+8W2G5leWAr9rn0YOTycey9CtBLnsyB6YUWGkUBx7rGhdW6sO2VWFcpy
WkrryYV+AudPf1OU0PEtdS8acdzB6QCxIzTjyXwZXDyDlcYF9VVMrAuvMZy/XoPn
rb3dzStyqbqmU+y0ZF4jWo+HDIeKig==
=mNDy
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
