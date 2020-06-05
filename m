Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22113C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C2020810
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591359617;
	bh=KHgU9gQNGmS9ENzYT2OcSwC8jcaAyRj+0szieFBm/MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UtLxZF8mt1KltC6g4RTHNrJ5CImrXTt0Qp2sFgwYl7b8NYr0c4IpH22fZDO4nVwK/
	 8PFboXs9nTYBanufrZX6sDZtrbFAhnh74WskKtFlmDLf9Vrl0NUrrkYm3X5e8pOb87
	 duiq0qdI2AWGm7qZH8GByYc46vKpKlrDTVq5+Ixk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgFEMUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgFEMUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:20:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0929A206E6;
        Fri,  5 Jun 2020 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359613;
        bh=KHgU9gQNGmS9ENzYT2OcSwC8jcaAyRj+0szieFBm/MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7HiUbfcvb0StZuS2lIwExfDAeA+hHJRiZSidGl9IeepTcJnjlDohww2tCHsRtmUk
         DjVSbl40pifhG50UOtQP2yXBLfMqWz36ZlTudKsivI9dcQQaT1WNxhGJI/dmqryczN
         rJWRk69aEXZG13/1PXbHdr5EoseClfWb/YvsOjN8=
Date:   Fri, 5 Jun 2020 13:20:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        lukas@wunner.de, Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605122010.GA15570@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <159135564425.14579.13716287498736798458.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <159135564425.14579.13716287498736798458.b4-ty@kernel.org>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 12:14:07PM +0100, Mark Brown wrote:

> [1/1] spi: bcm2835: Enable shared interrupt support
>       commit: ecfbd3cf3b8bb73ac6a80ddf430b5912fd4402a6

Eh, sorry - this was me fat fingering another fix.  At the very least
this needs to wait for the end of the merge window.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aOHkACgkQJNaLcl1U
h9AxvAf/SfJ41hWzufGG1Rj3/WXQjmpYsJIB/fpu3B8+iaiLofTNVVA6VPberNFn
ANEsddsQQG90zBMoJDC9l+r71xLdWTJn8OonfVC4cz4NRsWcK4A7kC7ity+jn6Bm
1l8yy8wiGZx9bPX0dDjggJUsBaXymOt5eyCzxh7I95Wa3icM/jyhLWIyVDgneefA
VvBIkbiaaroVuq0mVWi0SiHZEzo1KGNxpSahl5RrlaU5Koknf50yJtGE5DWF6C6G
iKy2AtJgDOnQC6vdlXpHaZNGNfX8yMlUbPMtvtyWALzGpKsX/anstISNooENydUA
UPjFlOOj96lzDD5ZDev5sBr6QVpvQQ==
=lLik
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
