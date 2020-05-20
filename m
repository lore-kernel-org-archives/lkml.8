Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EABC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557BB207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589978342;
	bh=g7mq7A46A2rwnilYsWelJzFIzIUJhVoiPiT9cEmHRqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uJD7qFBRF7oj1Uf/vrR6BQ8wQWxgIFQN5PA55sWG876x8S+0CqWVEK1V+NpxjnfU0
	 CEUDYZx9Y/JCRZ0RexZvuMS70SodH1kB3/xGK5vB/LfS650TBQLbq5ajJ4kWNFuje0
	 JVDNz4YRCLX3dQfJ/SttQG5CpEOyW3/1umHq/XuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgETMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETMix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16B320758;
        Wed, 20 May 2020 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589978332;
        bh=g7mq7A46A2rwnilYsWelJzFIzIUJhVoiPiT9cEmHRqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y05unyyJD7TNaV987OdTJu89O1CnVTvMOJXBtUxxhoRdPpPwrGFOLAsPQdIHmglCZ
         /TdnyHJTd4wnRuuEc9rHwD1xbrOzJV3PPWqVGYYRc76P5MIZ6Tiib5JDErJJuforA+
         evfuyTPGebwbAc8o+UKJkiW+ST3XQhvcR1GdBas8=
Date:   Wed, 20 May 2020 13:38:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        sumit.semwal@linaro.org, Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in
 probe
Message-ID: <20200520123850.GE4823@sirena.org.uk>
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com>
 <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
 <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 07:22:19PM +0800, Shengjiu Wang wrote:

> I see some driver also request dma channel in open() or hw_params().
> how can they avoid the defer probe issue?
> for example=EF=BC=9A
> sound/arm/pxa2xx-pcm-lib.c
> sound/soc/sprd/sprd-pcm-dma.c

Other drivers having problems means those drivers should be fixed, not
that we should copy the problems.  In the case of the PXA driver that's
very old code which predates deferred probe by I'd guess a decade.

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FJNkACgkQJNaLcl1U
h9CQxAf/XWB/BDAkTjyNyif7eAXkZvu58koo16rODvQZScO1qMJDv7rgM7PAY3cp
oA8PM6mc2y9ilW+8iJcaRBUazw743WsZy4B8+4zgZ4S+16WavSbW/TcgoP1XHKmn
45dF0NFIESHhxVhwdmHAhRrolV6ukd4taibnCUbPFBbG3AgT7XjvOl8gQmwY5Xbr
4WC83n6SHn8es9HF2g733RvA8jAFMr+biVQ7FnsyxEhi3oMgOYF7LOQ+ZrBM69xC
49iQbno7b5fQ8cPQLKmdt5mzBp0n5anoHWFvvk1zi1RPqM+7gGMv/DBvAB8u7o+F
l8Qr1SUzhOsG/j0FDFUIriQktZ4TEw==
=CLfU
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
