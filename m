Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20F8208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593704534;
	bh=3KFnK04vEi7SoR61rRMArD9b+BR7w1+k2R0YFZiePIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdO4RTAiqBr9jSQkUmBQXfnuyZ4t1ew+4k/0TPeaQ9FAuQO676dsawPfdjET8mgP0
	 5Ru6fOsWrWcBZLKe520hRATczYQb/rP60SFQhTBf7fg/I2kiE5D3sCaBeFo6KJH23j
	 fQQIur3nfmEujMpe4cSIRccdNR66CwUeuK78wHWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgGBPmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgGBPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:42:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6AB208B8;
        Thu,  2 Jul 2020 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593704530;
        bh=3KFnK04vEi7SoR61rRMArD9b+BR7w1+k2R0YFZiePIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXPoXcMNttT4jMn3+4BYmyeU01d4W2Mwcu1xJ7hI/S7P7RDqiNSek7TOZGa01uyLt
         URHmF5er8VNTpSNU52TEL/qkdUTT7kai/UGGQpku5+C/5aqPwntmUilLbQXqKC7Lbx
         PYdK7osKLzpwAWRFGK8g2ISveoUzKfhXMwmkJV8I=
Date:   Thu, 2 Jul 2020 16:42:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: fsl-asoc-card: add new
 compatible for I2S slave
Message-ID: <20200702154207.GK4483@sirena.org.uk>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
 <20200702141114.232688-2-arnaud.ferraris@collabora.com>
 <20200702143145.GG4483@sirena.org.uk>
 <5de5ea5b-0716-8ed1-28b0-9ad3da7a2d47@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
In-Reply-To: <5de5ea5b-0716-8ed1-28b0-9ad3da7a2d47@collabora.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2feizKym29CxAecD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 05:28:03PM +0200, Arnaud Ferraris wrote:
> Le 02/07/2020 =E0 16:31, Mark Brown a =E9crit=A0:

> > Why require that the CODEC be clock master here - why not make this
> > configurable, reusing the properties from the generic and audio graph
> > cards?

> This is partly because I'm not sure how to do it (yet), but mostly
> because I don't have the hardware to test this (the 2 CODECs present on
> my only i.MX6 board are both clock master)

Take a look at what the generic cards are doing, it's a library function=20
asoc_simple_parse_daifmt().  It's not the end of the world if you can't
test it properly - if it turns out it's buggy somehow someone can always
fix the code later but an ABI is an ABI so we can't change it.

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7+AE4ACgkQJNaLcl1U
h9BYwQf+LRu606rmfYnqmbLMDcS82XnfLlMQpCccSxt5qRFkxPvsZqA1zoQUrt0n
o8061rU3fHuwt17/Mp4D0SbC4g9EGRIon64yUii1nqoPIHEgYWVQ+F7sOPTKVKD5
Z3LD+zP06AyjJxRDJ4+4pHRWpzQL2jxziBsxgQdp4W5mfU6fV3x5BvqdN1chcOPa
TmgXdbKXfoR1Q/HIaU0CH2PVjh94BZqRRMPs5++X7xDcCUCsYUY6GW+GS1tEXQPj
IdJ2Rgmt3M0273RzUlFQX8+akH03BBTlIJ8eCUYIp4H8dedN5w/2eXqjIOUIMnsT
zv1pY4Ufcdm6Uzc6A47isxUHlg565Q==
=K6iJ
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
