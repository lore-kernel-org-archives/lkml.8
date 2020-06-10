Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169A420734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591799296;
	bh=SssoMY0PrbC8NZYL8hnhXQqlnOAu8G3HtlO7aJa2fL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yE2m1hXnXUGnGfLghSm60Mbp/Wn3jnKwkqUFQhhC0rTXmZrIpD8iQVE5djzE166tq
	 Bf/fm1ZT6TiW5dYQzLFujVATjUbdeGRFon6qp35vJrK3v6imNW6jt9vnRnhQrdo4jd
	 qGzDpgp1Qo8cnDiwt7TsCc//4JCWHljzLjjtx/0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgFJO2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:28:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE302067B;
        Wed, 10 Jun 2020 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591799293;
        bh=SssoMY0PrbC8NZYL8hnhXQqlnOAu8G3HtlO7aJa2fL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTCwi9MCuyazL5XefSTUHGnMKhLIwl80cvs11td6qe8C3D69DMBkyrYGat8L5dWY9
         Fa+c8YpHEFZk2f1Dd/kgwiPGzNU4MgYhyISpk8hS8R2+XSwvmAzOLEGjUwXsJyA6DQ
         2DYELyD9AyVfw1fvQXLrj7qo1gDxAP9j9S2TdN9k=
Date:   Wed, 10 Jun 2020 15:28:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200610142811.GH5005@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
 <20200610102920.GC5005@sirena.org.uk>
 <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 09:12:15AM -0500, Dan Murphy wrote:
> On 6/10/20 5:29 AM, Mark Brown wrote:

> > I'm not *completely* opposed to having the ability to suggest a name in
> > firmware, the big problem is making use of the DSP completely dependent
> > on having a DT property or doing some non-standard dance in userspace.

> Well from what I see we have 4 options.

These are not mutually exclusive approaches.

> 1.=A0 We can have a DT node like RFC'd (Need Rob's comments here)

This is compatible with any hardcoding option.

> 2.=A0 We can have a defconfig flag that hard codes the name (This will
> probably be met with some resistance if not some really bad reactions and=
 I
> don't prefer to do it this way)

This is even worse than the ALSA control suggestion.

> 3.=A0 We can hard code the name of the firmware in the c file.

> 4.=A0 Dynamically derive a file name based on the I2C bus-address-device =
so it
> would be expected to be "2_4c_tas2563.bin".=A0 Just need to figure out ho=
w to
> get the bus number.

> Again only option 1 allows us to have different firmware binaries per IC
> instance and also denotes the use of the DSP.=A0 The DSP is not programmed

No, this is not the case at all - a per-device generated file allows
this just as well.

> So special audio handling is very explicit in the user space.=A0 More then
> likely most standard distributions will not even use the DSP for this dev=
ice
> it is more of a specialized use case for each product.

People do things like make AOSP derived distributions for phones.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7g7foACgkQJNaLcl1U
h9DkTwf/dnxODE9jlK7rqZaP9/fgmsXcrTn+c5SE7VmNv+ButQXrB22OYVH1AJiv
p2l0ucEqZtrVD/GJGGgjgkfLgwZxx5byaSfBjyszg80Zgpsc16g1YU9xDAoI0pmv
rkGPrh9WXHB746szBsc2PA46wKtjSgnRkq6cOvxGciuysAdxagYyKvyVgzFopAO+
O9ZVXw//Yg0jf9atCfpXWA+0Z4Mza0UitJBP7ydpG0siJzXW5qY5dExlM/jromgk
Wl5Y3oBYKl04j6Y4Yh3ZG/DbLVTsyHMGoD3lYgm6zp4HFxlKcpzcMS6Mdvh1uny1
dX3NZZwyD4qjL9eOc/p3x08Dreii9A==
=Iqc2
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
