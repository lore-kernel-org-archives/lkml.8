Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DEEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B642074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591630304;
	bh=ADxBilkyT/EAi/djnjiP2fgYAZUPsNr5v8UV+nTUi7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tr5MVp6Y2JKVwTu4hZW7X5TopXHKUlMuGY+OzYgdUkevaPhp3O07Y5a79BxA1hd+S
	 z3l81uDoy1eC8GCdxf+A11y/tUeohSmWAgkWnd9ATSa0DoP7my+dJ81QoWbCdVBXtP
	 ojduuWgjmEOfplieCJQi8kV1lQwgu444Bl8kQMOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFHPbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbgFHPbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:31:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8750A206D5;
        Mon,  8 Jun 2020 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591630302;
        bh=ADxBilkyT/EAi/djnjiP2fgYAZUPsNr5v8UV+nTUi7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ub15ctup9uAJsdoj9tT8dbeZGUxs/erhZLq8nR6hfpoyfT4EhYRftbZWT7cr4LqJl
         J70OfloxVttWEd00LXh/jwVPRQ2yd+X1T4mrwoovTkLEqim2OEGZkr+gYFxuCeaAfJ
         9MVEQvm29WsRmviuekA1KS1TVvMo4eQbqY4RPi2s=
Date:   Mon, 8 Jun 2020 16:31:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Message-ID: <20200608153139.GI4593@sirena.org.uk>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2020 at 03:08:45PM +0000, Robin Gong wrote:

> > > +	if (transfer->rx_sg.sgl) {
> > > +		struct device *rx_dev = spi->controller->dma_rx->device->dev;
> > > +
> > > +		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
> > > +				       transfer->rx_sg.nents, DMA_TO_DEVICE);
> > > +	}
> > > +

> > This is confusing - why are we DMA mapping to the device after doing a PIO
> > transfer?

> 'transfer->rx_sg.sgl' condition check that's the case fallback PIO after DMA transfer
> failed. But the spi core still think the buffer should be in 'device' while spi driver
> touch it by PIO(CPU), so sync it back to device to ensure all received data flush to DDR.

So we sync it back to the device so that we can then do another sync to
CPU?  TBH I'm a bit surprised that there's a requirement that we
explicitly undo a sync and that a redundant double sync in the same
direction might be an issue but I've not had a need to care so I'm
perfectly prepared to believe there is.

At the very least this needs a comment.

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7eWdsACgkQJNaLcl1U
h9BiKAf/ZmeX9XdQOaPXdXtYXNZ3mBV/poS2CX7LkZVc4oBchvlrK/obnL/5JWU+
2AVuevWzu2fig/gK6UfPOZUU24ZPvfwwo8obnuU7iUFZ7ynpsDOP+v8nLyc6ROe9
WDdp8hQ7ZXTixJ7p+ww5o30bSWOq2dCuguKM83CSvcB60QxRTPW3s7dClj0wRRLW
/YqjHpYK85okEJ7wQk4K+XmgiNOtfGGPImPE6iM7+hVzZORE6j78xFXDRq4XX5TQ
WCbjot+/Pb3lOPrlQQ6THR244JuyC9yx5DVeHV0h5tUWA2LWABEBhTE82aYEy1HM
RSe4uOS1dRQO+DhKwWD7O75Y0oxYow==
=kfaK
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
