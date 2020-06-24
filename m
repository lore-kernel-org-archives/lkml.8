Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA0CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593012492;
	bh=gYYRwt6GotEmTxPBlpzCjJGMURjga0QZ2WSAw4yPjpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oMw+2VQZRmp2yIhMTN2ibMnJu9SOibO6k5I/0EzNREK+zDXUM7N606UDPXeCDYp3A
	 HZfm4GHCMK9g4U8QjAazgTOgCgTnYJZrBZmB7I7FJ8OW7XA318EM6XWfszwYfvpbe5
	 NbXihIpivKRbFQkTs+HQ4vG+jRaBF4M/Rnn7MJq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbgFXP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403781AbgFXP2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:28:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE59B2078A;
        Wed, 24 Jun 2020 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593012490;
        bh=gYYRwt6GotEmTxPBlpzCjJGMURjga0QZ2WSAw4yPjpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dy2fAdxt4yd6pYZmlrrQjI6l5D1uUGKsD8D57+NhVw3pmC/B/A6vCnnYEMWXXbsvz
         JgBv5Z2rCPEFAYp03qCmNSUoR+4FMh9xAFnx8xeOUT2HK/tuSmfvSUJWSRH61fVh91
         BhophuIwMxaADBgyPRuYeQ9J8G++Q3L4CQnXhzcA=
Date:   Wed, 24 Jun 2020 16:28:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
Message-ID: <20200624152808.GI5472@sirena.org.uk>
References: <20200624114127.3016-1-a.hajda@samsung.com>
 <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
 <20200624114127.3016-2-a.hajda@samsung.com>
 <20200624132714.GD5472@sirena.org.uk>
 <CAHp75Ve9V1Vyxe3bEeHJ9H2J900wUXHMmXFJt-dn9sO5OMejHA@mail.gmail.com>
 <20200624140207.GE5472@sirena.org.uk>
 <6373a4eb-2f1b-b56f-48a8-ae97b4e4476a@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <6373a4eb-2f1b-b56f-48a8-ae97b4e4476a@arm.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 04:00:34PM +0100, Robin Murphy wrote:

> Be thankful... And count me in as one of those miserable users; here's one
> of mine being bad enough without even printing any specific messages about
> deferring ;)

> [robin@weasel-cheese ~]$ dmesg | grep dwmmc
> [    3.046297] dwmmc_rockchip ff0c0000.mmc: IDMAC supports 32-bit address mode.
> [    3.054312] dwmmc_rockchip ff0c0000.mmc: Using internal DMA controller.
> [    3.061774] dwmmc_rockchip ff0c0000.mmc: Version ID is 270a
> [    3.068101] dwmmc_rockchip ff0c0000.mmc: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

Looking at that driver it's going to have lots of problems whatever
happens - it's printing out a huge amount of stuff before it's finished
acquiring resources.

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zcQcACgkQJNaLcl1U
h9Cxggf/XCM1wfeUvaPwZWSZFgtAlPut0w2X9xlNsnHazAVjkdM2s7WvZKGWOene
pK9xzo21jPp/35tOSgtNySQGd489Jpb8haEPfW7znU+TsVdJVGI3tO2KpXRN1ueM
5uWopW7g/6uV6ArccbT+z49GyqeAMbAWXsarVUx21IAJlmcmKpbqFrxifmu+DHVN
FXKi6h9nEEa9OtF3lMTtv/dttM0QFXjGQeVMXmO26oJ2r6wykKLxkChaeJ5ItE6y
fRDFM+QKKrfYpZJDOyYo2hV3wbFnh7Ee0u1r+pzLGiD0/oNHDHgOpc1wmuu36Niz
mIr4ohC8aXHMeOohqmFMcjdwjVubPQ==
=egLK
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
