Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED5A20727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590164946;
	bh=AZ6aR48aUG//ESbctyBmG+YOjGowh1YxgZdIw6aq6bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JHTVf77l/a+kaCIhriL7xAe22DqwwPjPb+LGgbm1AuIAwzzr4DL9EkXVPExwrzB+5
	 uNpYsDv72igQEURlRdh+9Dt6HKQuvLM7Z+YQZRxO+lGBcxU7ftINPAxOsudlX95K/6
	 hLmtJqFN4q2LuVsYnr8HNgvh7LK2Cusi2U8mAmGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgEVQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbgEVQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:29:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB3720723;
        Fri, 22 May 2020 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590164944;
        bh=AZ6aR48aUG//ESbctyBmG+YOjGowh1YxgZdIw6aq6bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4FsV2uAqu/tX3pg7NewFoApyD7oEoZMnhAmmnKcl+3LRNhjjTs3275VGylctu3f1
         VIIKKiPn2SeIxaQfZeSKskq4enff164K3HACIxgju7ARsCEVTOOkAQ6sTcTGMSy5FX
         F6WMIvtZwCuLj5fXUKnSYt3O04BwosCqqhf4twPs=
Date:   Fri, 22 May 2020 17:29:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
Message-ID: <20200522162901.GP5801@sirena.org.uk>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
 <20200522113634.GE5801@sirena.org.uk>
 <CAL9mu0LAnT+AfjpGs0O-MD2HYrpnQRmrj6qXtJQrJi9kbQLPUw@mail.gmail.com>
 <CAL9mu0JZ4Qy+m2oF9TSTRqA_mM0J89huCt3t_Gs7qHa=3LxhBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Content-Disposition: inline
In-Reply-To: <CAL9mu0JZ4Qy+m2oF9TSTRqA_mM0J89huCt3t_Gs7qHa=3LxhBw@mail.gmail.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 11:59:25PM +0800, dillon min wrote:

> but, after spi-core create a dummy tx_buf or rx_buf, then i can't get
> the correct spi_3wire direction.
> actually, this dummy tx_buf is useless for SPI_3WIRE. it's has meaning
> for SPI_SIMPLE_RX mode,
> simulate SPI_FULL_DUMPLEX

Oh, that's annoying.  I think the fix here is in the core, it should
ignore MUST_TX and MUST_RX in 3WIRE mode since they clearly make no
sense there.

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H/c0ACgkQJNaLcl1U
h9Cejgf9HdcJ4wfZ4TAHuSVLhSZ1f3OnJd4SsU3i35KhZ712W6yrHngXy+nbYV4N
NhjTvvpDmzBo349gEEKpFG3dhTYbtS1kgzaVDbDeHh2B9M5YrRLkIYAjflSzwLeg
Yti6Jgi8Lx7rwmbBx7ACHi/MwbFhTgRxmebmW/EprvqsF+Q1LPKwoqZzgewibxLc
PHCGuWASzrD+VUARI8yApx4c0VvYevsCX3SqhAgEVABuyv5unCyrdK6feQ4pOe6j
AWVdgGrscUVgis28iFGnfmjKc72Ilct0g+jn6CcMAxcNH75lYFazRIihBrGTjh2j
TLYng7hGWV16ZT1d0tdphETvEKKG5A==
=R/O9
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
