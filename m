Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD2D2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579780089;
	bh=Bvgq0JhAgoUJS0nomXwyMXg27FoYj7htys3bPp7ECgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jguvZmOvYLbwhuZhANtESC7QhMfrQ7Km6MiPBA/pJumqCnON/QeV4zr15v2k5VTYJ
	 qkmDmvU2h7Vzr54gsQNUby5zw1nGnnRgcOrgQjdfm80vvpO0tDhCiFnL2xRMZUmzBP
	 9qJUSP/IKPnPFLz8lazviCkSdHSpp+MrssVuswRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWLsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:48:08 -0500
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgAWLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:48:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0FC328;
        Thu, 23 Jan 2020 03:48:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DBF13F6C4;
        Thu, 23 Jan 2020 03:48:07 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:48:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123114805.GA5440@sirena.org.uk>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200123092639.GC4098@ediswmail.ad.cirrus.com>
X-Cookie: ((lambda (foo) (bar foo)) (baz))
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2020 at 09:26:39AM +0000, Charles Keepax wrote:

> 3) We could look at doing something in regmap IRQ to change when
> it does PM runtime calls, it is regmap doing runtime gets when
> drivers remove IRQs that causes the issue. But my accessment was
> that what regmap is doing makes perfect sense, so I don't think
> this is a good approach.

Why do you even care about the errors?  It's not like this device is
going to get removed in a production system and the primary IRQ will be
disabled when the core is removed, this is just something that happens
during development isn't it?

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ph/IACgkQJNaLcl1U
h9Arnwf9Fajpy9ImwxaVzbe5ya64UjdSTAQpKU/CPvVZiEmGWUpiiG030wtRUV4E
+bxPoRUMTwnre4Q9HVA9hEaHCtLkq7kEqQczdaonVBIg39nZ+rx0HlF7VvHbYiJU
JFhoM/LCeWioxrvUjh7+fTKIfSGRYiO7k/Rb51kC3wekFwytP1Xz+eOR2ToNymDb
P2v70shC5dCVY/QR527BK2hTxUk41Z8fAgCS/fq0rWHdR+HU8uRCeWMJKVAVokKU
q34spGxN2pzlDlBXOdd06VyQlMP3I1UGYpyOytMctKivuNa0Krl0YXNuNnemiu4v
qKFiTEbWbLrQqrTvFGMYMfKzWBk4mQ==
=9spY
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
