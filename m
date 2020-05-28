Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF402C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813EE20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590673697;
	bh=hCc/4WkpOoMnYzAs7vLH2tpFPjfk82hCbKAhbeXkNI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MjgSROpPXIdKTI63wrTnbHSkjXsj2ebkTXI+we8tvmjxdypbrxabph8dvCsLGDKRc
	 eN2g8R3pTeT98mOGHXBMdL40BVu257dovBpRyt0za/pWRuGLn09QZoDjTeYISn94Xf
	 mhqwbfZq51Qqu+MF5yBJ9OASS2r28TxyF2cDl9Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbgE1NsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390486AbgE1NsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:48:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900B4207D3;
        Thu, 28 May 2020 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590673685;
        bh=hCc/4WkpOoMnYzAs7vLH2tpFPjfk82hCbKAhbeXkNI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4k39ZFaQ41ExRlY1FpyEQJR61aEW8XCAqj3dq0dkZ3PCbvGQ8q/L0EwtUR+BdXqt
         b+coz6x9QHt1uSD8fvSAyy9Ku/2ke4nRaAGrNDGhCFHwPI7+CSialN6cbAZJ9geC2r
         dKuhxH11yqWoiaq+GxLW8DRut8Peg/xIRNbM6Fpw=
Date:   Thu, 28 May 2020 14:48:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] regmap: provide helpers for simple bit operations
Message-ID: <20200528134802.GE3606@sirena.org.uk>
References: <20200528123459.21168-1-brgl@bgdev.pl>
 <20200528123459.21168-2-brgl@bgdev.pl>
 <20200528132938.GC3606@sirena.org.uk>
 <CAMRc=MejeXv6vd5iRW_EB3XqBtdCWDcV=4BOCDDFd4D0-y9LUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <CAMRc=MejeXv6vd5iRW_EB3XqBtdCWDcV=4BOCDDFd4D0-y9LUA@mail.gmail.com>
X-Cookie: Small is beautiful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 03:32:40PM +0200, Bartosz Golaszewski wrote:
> czw., 28 maj 2020 o 15:29 Mark Brown <broonie@kernel.org> napisa=C5=82(a):

> > Why macros and not static inlines?

> The existing regmap_update_bits_*() helpers are macros too, so I tried
> to stay consistent. Any reason why they are macros and not static
> inlines? If there's none, then why not convert them too? Otherwise
> we'd have a static inline expanding a macro which in turn is calling a
> function (regmap_update_bits_base()).

Not really, I think it was just that they're argument tables.  It'd be
good to convert them.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7PwREACgkQJNaLcl1U
h9BZlQf/Rnk3QvRXUU9UWRrY62o3tOtAkM+YDOn1qkCahCNlR3xn6spu/jZ2xpm8
wtG0/ml9T9EeXbWZU0n2vWYQowTecwv3zFcQgHRtEaN+Q0F1pZeBoGo7Hazyp47Y
2UI0x5pTwKgEs6xwxQ9hDWy9KhGgLODt7MWUQv8T8m7XxDRmoCh9MbMAiEm2GPLb
Vt5FGW0iBTVJh/h0J84HpA1BY1bXPFBwICbqISunBPso9Gj7D5YzmK9iKvz4qW+g
eCfgV0eYbRbMCcL7UG9jOWOZxuznG+BfLNmzOLl/eydOppXcHVWhah9Q8Q8xsdqG
+R17K+lbB6MGwp7pU0Fr2sp98g43Cw==
=Zc21
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
