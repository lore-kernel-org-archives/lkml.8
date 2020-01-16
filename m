Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C5FC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBE2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579177788;
	bh=OQ4DvKQn6DjynjxFZnipVci0kmylwgCgywja2qyJZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dUUuaTAmUIzypZbBsPUazPz6KPZhYRNYmV/YqAVVyFOYR3PtGqToVkAcekZ88HHRe
	 qWuRMQdJeIXIXf12To+uq9EptCLNd8hvvzNuHmJewOkqwhXgM322fpdshdfo4alOHf
	 /mHeRqs0tvh4uH0TXBFHa1fMx6hPtzdxh2JfxECc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPM3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPM3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:29:47 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28C920748;
        Thu, 16 Jan 2020 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579177786;
        bh=OQ4DvKQn6DjynjxFZnipVci0kmylwgCgywja2qyJZxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntTCbNMnfeBHi5RrLmh3GPZkvANG1wbsNq75B4fnIRDNgkfMySdY39omZChm7UVe0
         i6i5P58QzLTITyoQ5x9gkWNb6cSeyFp4PV8SOsE96Joou2XwMInUXCCOF1reMe4KnG
         UR1WqhPpp1J8bfFV7eWFUl4yAXHRQiozBinvApj0=
Date:   Thu, 16 Jan 2020 13:29:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
Message-ID: <20200116122944.sgl2fgxf5mrg6i52@gilmour.lan>
References: <20200115194216.173117-1-jernej.skrabec@siol.net>
 <20200115194216.173117-2-jernej.skrabec@siol.net>
 <CAL_JsqK-KBd9PF7nKK976vVYjRwfm-ZxJSnEbhiWC=X3AnvpeA@mail.gmail.com>
 <4200557.LvFx2qVVIh@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z3e6p5ezhmthrhbl"
Content-Disposition: inline
In-Reply-To: <4200557.LvFx2qVVIh@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z3e6p5ezhmthrhbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 12:10:58AM +0100, Jernej =C5=A0krabec wrote:
> Hi!
>
> Dne sreda, 15. januar 2020 ob 22:57:31 CET je Rob Herring napisal(a):
> > On Wed, Jan 15, 2020 at 1:42 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > OrangePi 3 can optionally have eMMC. Add a compatible for it.
> >
> > Is this just a population option or a different board layout? If the
> > former, I don't think you need a new compatible, just add/enable a
> > node for the eMMC.
>
> I have only board with eMMC but I imagine it's the former. Even so, curre=
nt
> approach with Allwinner boards is to have two different board DT files, o=
ne for
> each variant. This can be seen from Documentation/devicetree/bindings/arm/
> sunxi.yaml which has a lot of compatibles ending with "-emmc". I guess re=
ason
> for that is to avoid having MMC controller being powered on for no reason.

The main reason for that is that those populating options can be
conflicting. For example, last week we discussed an issue about the
eMMC being on the same pin set than an SPI flash, both options being
available.

The solution Andre suggested then was to let the eMMC be disabled, and
have the bootloader probe the emmc, and if found, enable
it. Otherwise, it means that you have a SPI flash (and enable it).

I guess a similar solution would apply here.

Maxime

--z3e6p5ezhmthrhbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiBXNwAKCRDj7w1vZxhR
xSiCAQC3vqoZktCtBHtvXsgBmpAOofLKQpEHTDgn3BB1dlUTvQD/SVxXyY+qZTZi
JO/lb9XHuZfUdVTYe5uE19i8KbsfrQM=
=/A2H
-----END PGP SIGNATURE-----

--z3e6p5ezhmthrhbl--
