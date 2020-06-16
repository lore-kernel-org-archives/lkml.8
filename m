Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109412074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592303247;
	bh=h+uJjTNyXThELVktOw4GwJ+7MZ17efhM9W2zSlxhrfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i8eVw/cKDof1XxXa5zTzzHFwEpWzaOQudXQAMQwK7x7puiVg6mfxu56P+FITaV36A
	 FUYemFgf4micsslG22nipnKXuTea2mtjojLy8q+JlpfCBW9kEuvu41oOGAON7IrPi7
	 Skd+Jl5nTRZoF/yVJnrzD4gRI1aJ97tXE9Q1gvhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgFPK1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgFPK1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:27:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D932074D;
        Tue, 16 Jun 2020 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592303221;
        bh=h+uJjTNyXThELVktOw4GwJ+7MZ17efhM9W2zSlxhrfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6bU3A0EaWVwqB76C7G7Q8IPA9+8NDlndx78P4FO5p55YBIboAQ+ng5RuIHbh7arj
         cDq2IabAY/pe4YgW8N+oycWxtz82vqVOx9X8cA2CW3t6pe1ufX8DiWIRg6MbpwFL4a
         4lfwdoblwodIxGq5kz8hB3BKYLT1P24WTfkeaTDQ=
Date:   Tue, 16 Jun 2020 11:26:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200616102659.GK4447@sirena.org.uk>
References: <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
 <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615145556.GY4447@sirena.org.uk>
 <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200616095948.GJ4447@sirena.org.uk>
 <VE1PR04MB66387499F9AF80A68F720529899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qE0/TkNoJLLGUzs4"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66387499F9AF80A68F720529899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qE0/TkNoJLLGUzs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 10:13:08AM +0000, Robin Gong wrote:
> On 2020/06/16 Mark Brown <broonie@kernel.org> wrote:

> > I'd just make this a generic flag for failures before we start interacting with the
> > hardware rather than specifically this one error case.  Otherwise this looks
> > fine.

> So rename to SPI_TRANS_DMA_FAIL? I think at least DMA is MUST for fallback
> case...

This is not purely for DMA, it's just about the failure having occurred
before the transfer started.  How about _FAIL_NO_START?

--qE0/TkNoJLLGUzs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7onnIACgkQJNaLcl1U
h9Cs0Qf8CdBZ6A+/Gn/ijwLKgPntYUIu7iNkeoHkhYqOXmt1S4e0m5GoT+ROMOLV
k1elBNRfWqVdKJfHMzmk5wANM+F5XqTCOpWx0SErZRiSHMFb5V8gClcNBYTNL/eU
3A/I62fz09JL/onIv3qEkUTsWvL3Rq7VG0mAsJvL27oMRecxS0EwEGW33kaY9axI
59Irl+2GcI/oQchTMzeHBdBMd5bqdGjDvI2xSrqnbyip+/G1p6xHPmYRyypcl+AZ
X976ervmpNe4o3XKh80pDajyx5aKgyQxgtB7cjE2UPSKXAgVhG+N8LWRwoAw03+y
1fXXMrymNw+yvlVU0QNEuMOYGRjTFg==
=9EtT
-----END PGP SIGNATURE-----

--qE0/TkNoJLLGUzs4--
