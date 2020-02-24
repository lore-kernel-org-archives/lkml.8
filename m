Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A2C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D562072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582547487;
	bh=/dNA8kAzClaavMgj21dSpT8ieHWkrIRvjA5TOlTc28o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xE3DENr8l7ID8hsi2whZW4aqj2mZrM3udalxFqG2xl0+va/drn3guhCyuqSwGjWXy
	 0L2jVo8NNB7po0CSRZ8IaXTq+Eku7QKvggTSeoK/fIGheczMd4Q0yZKJ3NYZS7U/r4
	 XdSIOGpsAjAsycuDecaxFTNCVPrNfa8nM2f1u+CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBXMbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:31:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXMbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:31:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B8A30E;
        Mon, 24 Feb 2020 04:31:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B2C93F534;
        Mon, 24 Feb 2020 04:31:24 -0800 (PST)
Date:   Mon, 24 Feb 2020 12:31:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        contact@paulk.fr, GNUtoo@cyberdimension.org, josua.mayer@jm0.eu,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages e.g.
 in EPD PMICs
Message-ID: <20200224123122.GH6215@sirena.org.uk>
References: <20200223153502.15306-1-andreas@kemnade.info>
 <20200224120512.GG6215@sirena.org.uk>
 <1548203B-9D64-4128-9BED-D3BC30F9DC49@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <1548203B-9D64-4128-9BED-D3BC30F9DC49@goldelico.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 01:22:21PM +0100, H. Nikolaus Schaller wrote:
> > Am 24.02.2020 um 13:05 schrieb Mark Brown <broonie@kernel.org>:

> > This is what'd be needed, your approach here is a bit of a hack and
> > leaves some values unrepresentable if they overlap with errnos which
> > obviously has issues if someone has a need for those values.

> Negative ERRNOs have BIT(31) set.

This code is working with the numberic representation, not with the
bitwise representation - it's using -MAX_ERRNO. =20

> But then it seems to be a little inconsistent that the voltage
> parameters of regulator_set_voltage_unlocked() are signed integers
> and not unsigned.

> So shouldn't that be protected against attempting to set negative voltage=
s?

Or just convert it to unsigned, I don't recall there being any
particular reason why it's signed.

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5TwhoACgkQJNaLcl1U
h9B1IAf/bzn84Uy6Bu9ClVtEYIjBmXCGq7OXxfeMu26eU/ISxWvDeS+0uCXCuCR1
2MmGJxh0llTRdUsDFbuwe+OT5UcKwqmo4sihpXPPn35v9VsiBsIu4hIBu4foFuQh
a5vNLVGJ1wx0KHiwFrn/8hqFYZ2JGmOBVF6SWxhCMlvsr3Cuw+QGAM0//38Prrwl
oXTzv48sWaFCFs6829R99KbSykCnvTTa5zsNS683vLEcxpTb7jbL5r1ylTcC1PcK
7zJjYTgiMw87uSeEoc3nvR9lpP0FNga4yKoABbv+y8Oiyc5r7bJpCgzGTqvlsHON
LA04m9mKcjXyBzj0Et2Tk+qj+CElOQ==
=Izqs
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
